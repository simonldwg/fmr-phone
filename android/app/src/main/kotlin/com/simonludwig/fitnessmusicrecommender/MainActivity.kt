package com.simonludwig.fitnessmusicrecommender

import com.simonludwig.fitnessmusicrecommender.messages.WearMessageManager
import com.simonludwig.fitnessmusicrecommender.di.JsonModule
import com.simonludwig.fitnessmusicrecommender.messages.ReceiveChannelHandler
import com.simonludwig.fitnessmusicrecommender.messages.SendChannelHandler
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel

class MainActivity : FlutterFragmentActivity() {

    private val ioScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    private lateinit var sendChannelHandler: SendChannelHandler
    private lateinit var receiveChannelHandler: ReceiveChannelHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger
        val json = JsonModule.provideJson()
        val wearMessageManager = WearMessageManager(applicationContext, json)

        sendChannelHandler = SendChannelHandler(messenger, wearMessageManager, ioScope).also { it.register() }
        receiveChannelHandler = ReceiveChannelHandler(messenger).also { it.register() }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        sendChannelHandler.unregister()
        receiveChannelHandler.unregister()
        ioScope.cancel()
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
