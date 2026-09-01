package com.simonludwig.fitnessmusicrecommender.messages

import com.simonludwig.fitnessmusicrecommender.util.toLocalString
import io.flutter.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlin.time.ExperimentalTime

class PhoneListenerService : BaseListenerService() {

    private val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    @OptIn(ExperimentalTime::class)
    override fun processMessage(message: WearMessage) {
        val map: Map<String, Any> = when (message) {
            is WearMessage.HeartRate        -> mapOf("type" to "HeartRate", "bpm" to message.bpm)
            is WearMessage.ExerciseStarted  -> mapOf("type" to "ExerciseStarted")
            is WearMessage.StopExercise     -> mapOf("type" to "StopExercise")
            is WearMessage.ExerciseStopped  -> mapOf("type" to "ExerciseStopped")
            is WearMessage.PlayPause        -> mapOf("type" to "PlayPause")
            is WearMessage.NextSong         -> mapOf("type" to "NextSong")
            is WearMessage.StepsPerMinute   -> mapOf(
                "type" to "StepsPerMinute",
                "steps" to message.steps
            )
            is WearMessage.StepsPerMinuteStats -> mapOf(
                "type" to "StepsPerMinuteStats",
                "min" to message.min,
                "max" to message.max,
                "average" to message.average,
                // the phone expects local ISO strings, but the watch sends UTC strings
                "startTime" to message.startTime.toLocalString(),
                "endTime" to message.endTime.toLocalString()
            )
            is WearMessage.RunningStepsTotal -> mapOf(
                "type" to "RunningStepsTotal",
                "steps" to message.steps
            )
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
