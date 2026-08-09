package com.simonludwig.fitnessmusicrecommender.messages

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class SendChannelHandler(
    private val messenger: BinaryMessenger,
    private val wearMessageManager: WearMessageManager,
    private val ioScope: CoroutineScope
) {
    companion object {
        private const val CHANNEL = "com.simonludwig.fitnessmusicrecommender/send_message"
    }

    private var channel: MethodChannel? = null

    fun register() {
        channel = MethodChannel(messenger, CHANNEL).also {
            it.setMethodCallHandler(::handleCall)
        }
    }

    fun unregister() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    private fun handleCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startExercise" -> {
                val useBasicExerciseScreen = call.argument<Boolean>("useBasicExerciseScreen") ?: false
                ioScope.launch {
                    wearMessageManager.sendWearableMessage(WearMessage.StartExercise(useBasicExerciseScreen))
                }
            }
            "stopExercise" -> {
                ioScope.launch {
                    wearMessageManager.sendWearableMessage(WearMessage.StopExercise)
                }
            }
            "updateCurrentSong" -> {
                val title = call.argument<String>("title")
                    ?: return result.error("INVALID_ARGS", "title must not be null", null)
                val artist = call.argument<String>("artist")
                    ?: return result.error("INVALID_ARGS", "artist must not be null", null)
                ioScope.launch {
                    wearMessageManager.sendWearableMessage(WearMessage.CurrentSong(title, artist))
                }
            }
            else -> result.notImplemented()
        }
    }
}
