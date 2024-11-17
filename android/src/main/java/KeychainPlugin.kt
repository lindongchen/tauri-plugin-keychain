package com.plugin.keychain

import android.app.Activity
import android.content.Intent
import androidx.core.content.FileProvider
import java.io.File
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.JSObject
import app.tauri.plugin.JSArray
import app.tauri.plugin.Plugin
import app.tauri.plugin.Invoke
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import org.json.JSONArray

@InvokeArg
class KeychainOptions {
    var key: String = ""
    var password: String = ""
}

@TauriPlugin
class KeychainPlugin(private val activity: Activity): Plugin(activity) {

	@Command
	fun getItem(invoke: Invoke) {
		val args = invoke.parseArgs(KeychainOptions::class.java)

		val context = activity.applicationContext
	 
		val file = File(args.key)
		
	}
	
	@Command
	fun saveItem(invoke: Invoke) {
		val args = invoke.parseArgs(KeychainOptions::class.java)
	
		val context = activity.applicationContext
	 
		val file = File(args.key)
		
	}
	
	@Command
	fun removeItem(invoke: Invoke) {
		val args = invoke.parseArgs(KeychainOptions::class.java)

		val context = activity.applicationContext
	 
		val file = File(args.key)
		
	}

}
