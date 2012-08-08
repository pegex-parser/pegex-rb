###
name:      Pegex
abstract:  Pegex - Acmeist Parsing Framework
author:    Ingy döt Net <ingy@ingy.net>
license:   MIT
copyright: 2011
###

global.Pegex = exports.Pegex = class Pegex
  VERSION: '0.0.1'

exports.pegex = (grammar, options) ->
  require './Pegex/Grammar'
  require './Pegex/Receiver'

  options ?= {}
  wrap = options.wrap ? true
  receiver = options.receiver ? new Pegex.Receiver(wrap)
  new Pegex.Grammar(grammar, receiver)
