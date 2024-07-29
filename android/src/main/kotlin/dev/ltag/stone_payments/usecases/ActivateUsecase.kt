package dev.ltag.stone_payments.usecases

import android.content.Context
import android.util.Log
import dev.ltag.stone_payments.Result
import stone.application.StoneStart
import stone.application.interfaces.StoneCallbackInterface
import stone.providers.ActiveApplicationProvider
import stone.user.UserModel
import stone.utils.Stone
import java.lang.Exception

class ActivateUsecase(
    private val context: Context,
) {
    fun doActivate(appName: String, stoneCode: String, callback: (Result<Boolean>) -> Unit) {
        Stone.setAppName(appName);
        val userList: List<UserModel>? = StoneStart.init(context)

        if (userList == null) {
            val activeApplicationProvider = ActiveApplicationProvider(context)
            activeApplicationProvider.dialogMessage = "Ativando o Stone Code"
            activeApplicationProvider.dialogTitle = "Aguarde"
            activeApplicationProvider.connectionCallback = object : StoneCallbackInterface {

                override fun onSuccess() {
                    // SDK ativado com sucesso

                    callback(Result.Success(true))
                    Log.d("SUCESSO", "SUCESSO")
                }

                override fun onError() {
                    // Ocorreu algum erro na ativação

                    Log.d("ERROR", "ERRO")
                    callback(Result.Error(Exception("Erro ao Ativar")))
                }
            }
            activeApplicationProvider.activate(stoneCode)
        } else {
            // O SDK já foi ativado.

            callback(Result.Success(true))
        }
    }
}