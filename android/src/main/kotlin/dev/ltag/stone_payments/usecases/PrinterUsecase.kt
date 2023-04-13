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

    fun printFile(imgBase64: String, callback: (Result<Boolean>) -> Unit) {
        try {
            val posPrintProvider = PosPrintProvider(context)
            posPrintProvider.addBase64Image(imgBase64)

            posPrintProvider.execute()
            callback(Result.Success(true))
        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e))
        }

    }

    fun printLineToLine(lines: List<String>, callback: (Result<Boolean>) -> Unit) {
        try {
            val customPosPrintProvider = PosPrintProvider(context)
            for (line in lines) {
                // Adicione cada linha de texto à impressora
                customPosPrintProvider.addLine(line)
            }
            customPosPrintProvider.connectionCallback = object : StoneCallbackInterface {
                override fun onSuccess() {
                    callback(Result.Success(true))
                }
    
                override fun onError() {
                    callback(Result.Error(Exception("Erro ao imprimir")))
                }
            }
            customPosPrintProvider.execute()
        } catch (e: Exception) {
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