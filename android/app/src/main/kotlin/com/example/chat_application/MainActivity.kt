package com.example.chat_application

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/encryption"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "encrypt" -> {
                    val data = call.argument<String>("data")
                    val encryptedData = encrypt(data ?: "")
                    result.success(encryptedData)
                }
                "decrypt" -> {
                    val data = call.argument<String>("data")
                    val decryptedData = decrypt(data ?: "")
                    result.success(decryptedData)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun encrypt(data: String): String {
        val alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        val key = "!@#$%^&*()qwertyuiopasdfgh.+-/_;,'{}[]<>`~MNBVCXZLKJ1234567890"
        val encryptedMessage = StringBuilder()

        for (c in data) {
            val position = alphabet.indexOf(c)
            if (position == -1) {
                encryptedMessage.append(c) // Append non-alphabetic characters as is
            } else {
                encryptedMessage.append(key[position]) // Replace with corresponding character in key
            }
        }

        return encryptedMessage.toString()
    }

    private fun decrypt(encryptedMessage: String): String {
        val alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        val key = "!@#$%^&*()qwertyuiopasdfgh.+-/_;,'{}[]<>`~MNBVCXZLKJ1234567890"
        val decryptedMessage = StringBuilder()

        for (c in encryptedMessage) {
            val position = key.indexOf(c)
            if (position == -1) {
                decryptedMessage.append(c) // Append non-key characters as is
            } else {
                decryptedMessage.append(alphabet[position]) // Replace with corresponding character in alphabet
            }
        }

        return decryptedMessage.toString()
    }
}
