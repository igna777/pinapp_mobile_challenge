package com.example.pin_app_challenge

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import org.json.JSONArray
import org.json.JSONException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "comments"
    private val coroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob()) // 🔹 Evita memory leaks

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("NativeBridge", "⚡ FlutterEngine configurado, esperando llamadas de Flutter...")

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getComments" -> {
                    val postId = call.argument<Int>("postId") ?: -1
                    Log.d("NativeBridge", "📩 Recibida solicitud getComments para postId: $postId")

                    if (postId > 0) {
                        fetchComments(postId, result)
                    } else {
                        Log.e("NativeBridge", "❌ ERROR: postId inválido o negativo")
                        result.error("INVALID_ID", "El postId es inválido o negativo", null)
                    }
                }
                else -> {
                    Log.w("NativeBridge", "⚠️ Método no implementado: ${call.method}")
                    result.notImplemented()
                }
            }
        }
    }

    private fun fetchComments(postId: Int, result: MethodChannel.Result) {
        coroutineScope.launch {
            try {
                val apiUrl = "https://jsonplaceholder.typicode.com/comments?postId=$postId"
                Log.d("NativeBridge", "🌍 Haciendo petición GET a: $apiUrl")

                val url = URL(apiUrl)
                val connection = url.openConnection() as HttpURLConnection
                connection.apply {
                    requestMethod = "GET"
                    connectTimeout = 5000 // ⏳ Tiempo máximo de espera
                    readTimeout = 5000
                    doInput = true
                    connect()
                }

                val responseCode = connection.responseCode
                Log.d("NativeBridge", "📡 Código de respuesta HTTP: $responseCode")

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    val response = BufferedReader(InputStreamReader(connection.inputStream)).use { it.readText() }
                    val jsonArray = JSONArray(response)
                    val comments = mutableListOf<Map<String, String>>()

                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        comments.add(
                            mapOf(
                                "name" to obj.optString("name", "Sin nombre"),
                                "email" to obj.optString("email", "Sin email"),
                                "body" to obj.optString("body", "Sin comentario")
                            )
                        )
                    }

                    Log.d("NativeBridge", "✅ Comentarios obtenidos con éxito: $comments")

                    withContext(Dispatchers.Main) {
                        result.success(comments)
                    }
                } else {
                    Log.e("NativeBridge", "❌ HTTP_ERROR: Código de respuesta: $responseCode")
                    withContext(Dispatchers.Main) {
                        result.error("HTTP_ERROR", "Código de respuesta: $responseCode", null)
                    }
                }
            } catch (e: JSONException) {
                Log.e("NativeBridge", "❌ JSON_ERROR: ${e.message}")
                withContext(Dispatchers.Main) {
                    result.error("JSON_ERROR", "Error al parsear JSON: ${e.message}", null)
                }
            } catch (e: Exception) {
                Log.e("NativeBridge", "❌ NETWORK_ERROR: ${e.message}")
                withContext(Dispatchers.Main) {
                    result.error("NETWORK_ERROR", "Error de red: ${e.message}", null)
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("NativeBridge", "🛑 Cancelando corrutinas en onDestroy...")
        coroutineScope.cancel() // 🔹 Cancela todas las tareas en caso de que la app se cierre
    }
}
