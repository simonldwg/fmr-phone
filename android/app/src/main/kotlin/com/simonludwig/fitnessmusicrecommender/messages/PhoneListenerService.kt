package com.simonludwig.fitnessmusicrecommender.messages

import io.flutter.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

class PhoneListenerService : BaseListenerService() {

    private val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    override fun processMessage(message: WearMessage) {

        val map: Map<String, Any> = when (message) {
            is WearMessage.HeartRate        -> mapOf("type" to "HeartRate", "bpm" to message.bpm)
            is WearMessage.ExerciseStarted  -> mapOf("type" to "ExerciseStarted")
            is WearMessage.StopExercise     -> mapOf("type" to "StopExercise")
            is WearMessage.ExerciseStopped  -> mapOf("type" to "ExerciseStopped")
            is WearMessage.PlayPause        -> mapOf("type" to "PlayPause")
            is WearMessage.NextSong         -> mapOf("type" to "NextSong")
            else -> {
                Log.e(LOG_TAG, "Message type not implemented: $message")
                return
            }
        }

        scope.launch {
            WearMessageBus.emit(map)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        scope.cancel()
    }

    companion object {
        const val LOG_TAG = "PhoneListenerService"
    }
}
