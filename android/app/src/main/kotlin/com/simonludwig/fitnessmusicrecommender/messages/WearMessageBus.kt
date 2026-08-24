package com.simonludwig.fitnessmusicrecommender.messages

import kotlinx.coroutines.channels.BufferOverflow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.asSharedFlow

object WearMessageBus {
    private val _messages = MutableSharedFlow<Map<String, Any>>(replay = 0, extraBufferCapacity = 4, onBufferOverflow = BufferOverflow.DROP_OLDEST)
    val messages: SharedFlow<Map<String, Any>> = _messages.asSharedFlow()

    suspend fun emit(map: Map<String, Any>) = _messages.emit(map)
}
