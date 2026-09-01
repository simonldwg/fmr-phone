package com.simonludwig.fitnessmusicrecommender.util

import java.time.ZoneId
import kotlin.time.ExperimentalTime
import kotlin.time.Instant
import kotlin.time.toJavaInstant

@OptIn(ExperimentalTime::class)
fun Instant.toLocalString(): String =
    toJavaInstant()
        .atZone(ZoneId.systemDefault())
        .toOffsetDateTime()
        .toString()