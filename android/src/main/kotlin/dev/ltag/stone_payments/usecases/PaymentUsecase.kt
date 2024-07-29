package dev.ltag.stone_payments.usecases

import android.os.Handler
import android.os.Looper
import android.util.Log
import br.com.stone.posandroid.providers.PosPrintReceiptProvider
import br.com.stone.posandroid.providers.PosTransactionProvider
import dev.ltag.stone_payments.Result
import dev.ltag.stone_payments.StonePaymentsPlugin
import io.flutter.plugin.common.MethodChannel
import stone.application.enums.Action
import stone.application.enums.InstalmentTransactionEnum
import stone.application.enums.ReceiptType
import stone.application.enums.TransactionStatusEnum
import stone.application.enums.TypeOfTransactionEnum
import stone.application.interfaces.StoneActionCallback
import stone.application.interfaces.StoneCallbackInterface
import stone.database.transaction.TransactionObject
import stone.utils.Stone

class PaymentUsecase(
    private val stonePayments: StonePaymentsPlugin,
) {
    private val context = stonePayments.context;

    fun doPayment(
        value: Double,
        type: Int,
        installment: Int,
        print: Boolean?,
        callback: (Result<String>) -> Unit,
    ) {
        try {
            stonePayments.transactionObject = TransactionObject()

            val transactionObject = stonePayments.transactionObject

            transactionObject.instalmentTransaction =
                InstalmentTransactionEnum.getAt(installment - 1);
            transactionObject.typeOfTransaction =
                if (type == 1) TypeOfTransactionEnum.CREDIT else TypeOfTransactionEnum.DEBIT;
            transactionObject.isCapture = true;
            val newValue: Int = (value * 100).toInt();
            transactionObject.amount = newValue.toString();

            val provider = PosTransactionProvider(
                context,
                transactionObject,
                Stone.getUserModel(0),
            )

            provider.setConnectionCallback(object : StoneActionCallback {

                override fun onSuccess() {

                    when (val status = provider.transactionStatus) {
                        TransactionStatusEnum.APPROVED -> {


                            Log.d("SUCCESS", transactionObject.toString())
                            if (print == true) {
                                val posPrintReceiptProvider =
                                    PosPrintReceiptProvider(
                                        context, transactionObject,
                                        ReceiptType.MERCHANT,
                                    );

                                posPrintReceiptProvider.connectionCallback = object :
                                    StoneCallbackInterface {

                                    override fun onSuccess() {

                                        Log.d("SUCCESS", transactionObject.toString())
                                    }

                                    override fun onError() {
                                        Log.d("ERRORPRINT", transactionObject.toString())

                                    }
                                }

                                posPrintReceiptProvider.execute()

                            }
                            sendAMessage("APPROVED")

//                            val serializableTransaction = convertToSerializable(transactionObject);
//
//                            val jsonString = Json.encodeToString(serializableTransaction)
                            callback(Result.Success(""))
                        }
                        TransactionStatusEnum.DECLINED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "DECLINED")
                            callback(Result.Success(""))
                        }
                        TransactionStatusEnum.REJECTED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "REJECTED")
                            callback(Result.Success(""))
                        }
                        else -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: status.name)
                        }
                    }

                }

                override fun onError() {

                    Log.d("RESULT", "ERROR")

                    sendAMessage(provider.transactionStatus?.name ?: "ERROR")

                    callback(Result.Error(Exception("ERROR")));
                }

                override fun onStatusChanged(p0: Action?) {
                    sendAMessage(p0?.name!!)
                }
            })

            provider.execute()


        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e));
        }

    }

    private fun sendAMessage(message: String) {
        Handler(Looper.getMainLooper()).post {
            val channel = MethodChannel(
                StonePaymentsPlugin.flutterBinaryMessenger!!,
                "stone_payments",
            )
            channel.invokeMethod("message", message)
        }
    }
}