package com.omaressam.filerole_landing_app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry

import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin

class Application() : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun registerWith(registry: PluginRegistry?) {
        val key: String? = FlutterFirebaseMessagingPlugin::class.java.canonicalName
        if (!registry?.hasPlugin(key)!!) {
            FlutterFirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin"));
        }
    }
}