package dev.ltag.stone_payments.core

import android.graphics.Bitmap
import android.util.Base64
import java.io.ByteArrayOutputStream

class Helper {
   fun convertBitmapToString(value: Bitmap):String {
        val byteArrayOutputStream =  ByteArrayOutputStream()
        value.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
        val byteArray = byteArrayOutputStream.toByteArray();
        return Base64.encodeToString(byteArray, Base64.DEFAULT);
    }
}