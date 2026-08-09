package com.simonludwig.fitnessmusicrecommender.messages

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class ReceiveChannelHandler(
    private val messenger: BinaryMessenger
) {
    companion object {
        private const val CHANNEL = "com.simonludwig.fitnessmusicrecommender/receive_message"
    }

    private var channel: EventChannel? = null

    fun register() {
        channel = EventChannel(messenger, CHANNEL).also {
            it.setStreamHandler(WearMessageStreamHandler())
        }
    }

    fun unregister() {
        channel?.setStreamHandler(null)
        channel = null
    }

    private class WearMessageStreamHandler : EventChannel.StreamHandler {
        private var collectJob: Job? = null

        override fun onListen(arguments: Any?, sink: EventChannel.EventSink) {
            collectJob = CoroutineScope(Dispatchers.Main).launch {
                WearMessageBus.messages.collect { map ->
                    sink.success(map)
                }
            }
        }

        override fun onCancel(arguments: Any?) {
            collectJob?.cancel()
            collectJob = null
        }
    }
}
