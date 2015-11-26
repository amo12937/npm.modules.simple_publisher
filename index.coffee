"use strict"

class SimplePublisher
  constructor: ->
    @_listeners = {}
    @_publishing = {}

  register: (ev, listener) ->
    @_listeners[ev] ?= []
    return if listener in @_listeners[ev]
    @_listeners[ev].push listener
    self = @
    return ->
      i = self._listeners[ev].indexOf listener
      self._listeners[ev].splice i, 1 if i>= 0

  publish: (ev, args...) ->
    return if @_publishing[ev]
    @_publishing[ev] = true
    listener.apply undefined, args for listener in @_listeners[ev] or []
    @_publishing[ev] = false

SimplePublisher.create = -> new SimplePublisher

module.exports = SimplePublisher

