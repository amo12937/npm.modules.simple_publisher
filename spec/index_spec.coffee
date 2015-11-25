"use strict"

chai = require "chai"
expect = chai.expect
sinon = require "sinon"
sinonChai = require "sinon-chai"
chai.use sinonChai

SimplePublisher = require "index"

describe "SimplePublisher", ->
  it "should have create property", ->
    expect(SimplePublisher).to.have.property "create"

  describe "its instance", ->
    obj = null
    beforeEach ->
      obj = SimplePublisher.create()

    it "should have register property", ->
      expect(obj).to.have.property "register"

    it "should have publish property", ->
      expect(obj).to.have.property "publish"

    describe "register", ->
      ev = null
      arg1 = null
      arg2 = null

      beforeEach ->
        ev = "event"
        arg1 = "hoge"
        arg2 = "fuga"

      it "should add event listener", ->
        browser = sinon.spy()
        obj.register ev, browser
        obj.publish ev, arg1, arg2
        expect(browser).to.have.been.calledWith arg1, arg2

      it "should return unregister listener", ->
        browser = sinon.spy()
        unregister = obj.register ev, browser
        unregister()
        obj.publish ev, arg1, arg2
        expect(browser).not.to.have.been.called

      it "should not be called when it is publishing", ->
        counter = 0
        obj.register ev, ->
          counter += 1
          obj.publish ev
        obj.publish ev
        expect(counter).to.be.equal 1

      it "should be called when it is not publishing", ->
        counter = 0
        obj.register ev, ->
          counter += 1
        obj.publish ev
        obj.publish ev
        expect(counter).to.be.equal 2

      it "should not be called by another event publishing", ->
        browser = sinon.spy()
        anotherEv = "another event"
        obj.register ev, browser
        obj.publish anotherEv
        expect(browser).not.to.have.been.called

      it "should return undefined when it's registerd by same listener", ->
        listener = -> undefined
        obj.register ev, listener
        expect(obj.register ev, listener).to.be.equal undefined

