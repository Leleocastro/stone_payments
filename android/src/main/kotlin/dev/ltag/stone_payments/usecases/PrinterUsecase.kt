package dev.ltag.stone_payments.usecases

import android.content.Context
import android.util.Log
import dev.ltag.stone_payments.Result
import br.com.stone.posandroid.providers.PosPrintProvider
import br.com.stone.posandroid.providers.PosPrintReceiptProvider
import dev.ltag.stone_payments.StonePaymentsPlugin
import stone.application.enums.ReceiptType
import stone.application.enums.TypeOfTransactionEnum
import stone.application.interfaces.StoneCallbackInterface
import stone.database.transaction.TransactionObject

class PrinterUsecase(
    private val stonePayments: StonePaymentsPlugin,
) {
    private val context = stonePayments.context

    fun print(items: List<Map<String, Any>>, callback: (Result<Boolean>) -> Unit) {
        try {
            val posPrintProvider = PosPrintProvider(context)
            for (item in items) {
                if (item["type"] == 0) {
                    posPrintProvider.addLine(item["data"].toString())
                } else {
                    posPrintProvider.addBase64Image(item["data"].toString())
                }
            }

            posPrintProvider.execute()
            callback(Result.Success(true))
        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e))
        }

    }

    fun printReceipt(type: Int, callback: (Result<Boolean>) -> Unit) {

        val transactionObject = stonePayments.transactionObject

        if (transactionObject.amount == null) {
            callback(Result.Error(Exception("Sem transação")))
            return
        }
        val posPrintReceiptProvider =
            PosPrintReceiptProvider(
                context,
                transactionObject,
                if (type == 1) ReceiptType.MERCHANT else ReceiptType.CLIENT,
            );

        posPrintReceiptProvider.connectionCallback = object :
            StoneCallbackInterface {

            override fun onSuccess() {

                Log.d("SUCCESS", transactionObject.toString())
                callback(Result.Success(true))
            }

            override fun onError() {
                val e = "Erro ao imprimir"
                Log.d("ERRORPRINT", transactionObject.toString())
                callback(Result.Error(Exception(e)))

            }
        }

        posPrintReceiptProvider.execute()

    }
}