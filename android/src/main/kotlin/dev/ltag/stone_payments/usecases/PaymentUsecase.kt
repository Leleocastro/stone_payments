package dev.ltag.stone_payments.usecases

import android.os.Handler
import android.os.Looper
import android.util.Log
import com.google.gson.Gson
import br.com.stone.posandroid.providers.PosPrintReceiptProvider
import br.com.stone.posandroid.providers.PosTransactionProvider

import dev.ltag.stone_payments.Result
import dev.ltag.stone_payments.StonePaymentsPlugin
import dev.ltag.stone_payments.core.Helper
import dev.ltag.stone_payments.core.SerializableTransactionObject
import io.flutter.plugin.common.MethodChannel
import stone.application.enums.Action
import stone.application.enums.EntryMode
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
    private val context = stonePayments.context
    lateinit var provider: PosTransactionProvider

    fun doPayment(
        value: Double,
        type: Int,
        installment: Int,
        print: Boolean?,
        callback: (Result<Boolean>) -> Unit,
    ) {
        try {
            stonePayments.transactionObject = TransactionObject()

            val transactionObject = stonePayments.transactionObject

            transactionObject.instalmentTransaction =
                InstalmentTransactionEnum.getAt(installment - 1)
            transactionObject.typeOfTransaction = TypeOfTransactionEnum.values()[type]

            transactionObject.isCapture = true
            val newValue: Int = (value * 100).toInt()
            transactionObject.amount = newValue.toString()

            provider = PosTransactionProvider(
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
                                    )

                                posPrintReceiptProvider.connectionCallback = object :
                                    StoneCallbackInterface {

                                    override fun onSuccess() {

                                        Log.d("SUCCESS", transactionObject.toString())
                                    }

                                    override fun onError() {
                                        Log.d("ERROR", transactionObject.toString())

                                    }
                                }

                                posPrintReceiptProvider.execute()

                            }
                            sendAMessage("APPROVED")

                            callback(Result.Success(true))
                        }
                        TransactionStatusEnum.DECLINED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "DECLINED")
                            callback(Result.Success(false))
                        }
                        TransactionStatusEnum.REJECTED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "REJECTED")
                            callback(Result.Success(false))
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

                    callback(Result.Error(Exception("ERROR")))
                }

                override fun onStatusChanged(p0: Action?) {
                    sendAMessage(p0?.name!!)
                }
            })

            provider.execute()


        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e))
        }

    }

    fun doTransaction(
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
                InstalmentTransactionEnum.getAt(installment - 1)
            transactionObject.typeOfTransaction = TypeOfTransactionEnum.values()[type]

            transactionObject.isCapture = true
            val newValue: Int = (value * 100).toInt()
            transactionObject.amount = newValue.toString()

            provider = PosTransactionProvider(
                context,
                transactionObject,
                Stone.getUserModel(0),
            )

            provider.setConnectionCallback(object : StoneActionCallback {

                override fun onSuccess() {
                    when (val status = provider.transactionStatus) {
                        TransactionStatusEnum.APPROVED -> {
                            if (print == true) {
                                val posPrintReceiptProvider =
                                    PosPrintReceiptProvider(
                                        context, transactionObject,
                                        ReceiptType.MERCHANT,
                                    )

                                posPrintReceiptProvider.connectionCallback = object :
                                    StoneCallbackInterface {

                                    override fun onSuccess() {

                                        Log.d("SUCCESS", transactionObject.toString())
                                    }

                                    override fun onError() {
                                        Log.d("ERROR", transactionObject.toString())

                                    }
                                }

                                posPrintReceiptProvider.execute()

                            }
                            sendAMessage("APPROVED")
                        }
                        TransactionStatusEnum.DECLINED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "DECLINED")
                        }
                        TransactionStatusEnum.REJECTED -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: "REJECTED")
                        }
                        else -> {
                            val message = provider.messageFromAuthorize
                            sendAMessage(message ?: status.name)
                        }
                    }

                    val serializableTransaction = SerializableTransactionObject.from(transactionObject)

                    val jsonString = Gson().toJson(serializableTransaction)
                    callback(Result.Success(jsonString))
                }

                override fun onError() {

                    Log.d("RESULT", "ERROR")

                    sendAMessage(provider.transactionStatus?.name ?: "ERROR")

                    callback(Result.Error(Exception("ERROR")))
                }

                override fun onStatusChanged(action: Action?) {
                    if (action == Action.TRANSACTION_WAITING_QRCODE_SCAN) {
                        sendQrCode(Helper().convertBitmapToString(transactionObject.qrCode))
                    }
                    sendAMessage(action?.name!!)
                }
            })

            provider.execute()


        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e))
        }

    }

    fun doAbort(callback: (Result<String>) -> Unit,
    ) {
        try {
            val transactionObject = stonePayments.transactionObject

            if(provider == null){
                return
            }

            provider.abortPayment()
        } catch (e: Exception) {
            Log.d("ERROR", e.toString())
            callback(Result.Error(e))
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

    private fun sendQrCode(qrCode: String) {
        Handler(Looper.getMainLooper()).post {
            val channel = MethodChannel(
                StonePaymentsPlugin.flutterBinaryMessenger!!,
                "stone_payments",
            )
            channel.invokeMethod("pixQrCode", qrCode)
        }
    }
}