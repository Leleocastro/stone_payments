package dev.ltag.stone_payments

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import dev.ltag.stone_payments.usecases.ActivateUsecase
import dev.ltag.stone_payments.usecases.PaymentUsecase
import dev.ltag.stone_payments.usecases.PrinterUsecase

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import stone.database.transaction.TransactionObject
import io.flutter.plugin.common.MethodChannel.Result as Res

/** StonePaymentsPlugin */
class StonePaymentsPlugin : FlutterPlugin, MethodCallHandler, Activity() {
    private lateinit var channel: MethodChannel
    var context: Context = this;
    var transactionObject = TransactionObject()
    var paymentUsecase: PaymentUsecase? = null
    var printerUsecase: PrinterUsecase? = null

    companion object {
        var flutterBinaryMessenger: BinaryMessenger? = null
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        flutterBinaryMessenger = flutterPluginBinding.binaryMessenger;
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "stone_payments")
        channel.setMethodCallHandler(this)
        // Inicialize as propriedades aqui
        paymentUsecase = PaymentUsecase(this)
        printerUsecase = PrinterUsecase(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Res) {
        val activateUsecase: ActivateUsecase? = ActivateUsecase(context)
        when (call.method) {
            "activateStone" -> {
                try {
                    activateUsecase!!.doActivate(
                        call.argument("appName")!!,
                        call.argument("stoneCode")!!,
                        call.argument("qrCodeProviderId"),
                        call.argument("qrCodeAuthorization")
                    ) { resp ->
                        when (resp) {
                            is Result.Success<Boolean> -> result.success(
                                "Ativado"
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "payment" -> {
                try {
                    paymentUsecase!!.doPayment(
                        call.argument("value")!!,
                        call.argument("typeTransaction")!!,
                        call.argument("installment")!!,
                        call.argument("printReceipt"),
                    ) { resp ->
                        when (resp) {
                            is Result.Success<Boolean> -> result.success(
                                resp.data
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "transaction" -> {
                try {
                    paymentUsecase!!.doTransaction(
                        call.argument("value")!!,
                        call.argument("typeTransaction")!!,
                        call.argument("installment")!!,
                        call.argument("printReceipt"),
                    ) { resp ->
                        when (resp) {
                            is Result.Success<String> -> result.success(
                                resp.data
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "print" -> {
                try {
                    printerUsecase!!.print(
                        call.argument("items")!!,
                    ) { resp ->
                        when (resp) {
                            is Result.Success<Boolean> -> result.success(
                                "Impresso"
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "printReceipt" -> {
                try {
                    printerUsecase!!.printReceipt(
                        call.argument("type")!!,
                    ) { resp ->
                        when (resp) {
                            is Result.Success<Boolean> -> result.success(
                                "Via Impressa"
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "abortPayment" -> {
                try {
                    paymentUsecase!!.doAbort() { resp ->
                        when (resp) {
                            is Result.Success<String> -> result.success(
                                resp.data
                            )
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot Activate", e.toString())
                }
            }
            "cancelPayment" -> {
                try {
                    paymentUsecase!!.doCancelWithITK(
                       call.argument("initiatorTransactionKey")!!,
                       call.argument("printReceipt"),
                   ) { resp ->
                        when (resp) {
                            is Result.Success<*> -> result.success(resp.data.toString())
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot cancel", e.toString())
                }
            }
            // "cancelPaymentWithATK" -> {
            //     try {
            //         paymentUsecase!!.doCancelWithITK(
            //            call.argument("acquirerTransactionKey")!!,
            //            call.argument("printReceipt"),
            //        ) { resp ->
            //             when (resp) {
            //                 is Result.Success<*> -> result.success(resp.data.toString())
            //                 else -> result.error("Error", resp.toString(), resp.toString())
            //             }
            //         }
            //     } catch (e: Exception) {
            //         result.error("UNAVAILABLE", "Cannot cancel", e.toString())
            //     }
            // }
            "cancelPaymentWithAuthorizationCode" -> {
                try {
                    paymentUsecase!!.doCancelWithAuthorizationCode(
                       call.argument("authorizationCode")!!,
                       call.argument("printReceipt"),
                   ) { resp ->
                        when (resp) {
                            is Result.Success<*> -> result.success(resp.data.toString())
                            else -> result.error("Error", resp.toString(), resp.toString())
                        }
                    }
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Cannot cancel", e.toString())
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
