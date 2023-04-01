package dev.ltag.stone_payments.usecases

import android.content.Context
import android.util.Log
import dev.ltag.stone_payments.Result
import br.com.stone.posandroid.providers.PosPrintProvider

class PrinterUsecase(private val context: Context,) {

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
}