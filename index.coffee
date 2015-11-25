"use strict"

exports.create =
  listeners = {}
  publishing = {}

  register: (ev, listener) ->
    listeners[ev] ?= []
    return if listener in listeners[ev]
    listeners[ev].push listener
    return ->
      i = listeners[ev].indexOf listener
      listeners[ev].splice i, 1 if i >= 0
  publish: (ev, args...) ->
    return if publishing[ev]
    publishing[ev] = true
    listener.apply undefined, args for listener in listeners[ev] or []
    publishing[ev] = false

