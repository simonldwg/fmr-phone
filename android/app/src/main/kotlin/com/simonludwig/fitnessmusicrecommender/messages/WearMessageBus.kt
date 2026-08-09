package com.simonludwig.fitnessmusicrecommender.messages

import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.asSharedFlow

object WearMessageBus {
    private val _messages = MutableSharedFlow<Map<String, Any>>()
    val messages: SharedFlow<Map<String, Any>> = _messages.asSharedFlow()

    suspend fun emit(map: Map<String, Any>) = _messages.emit(map)
}
