require '../Pegex'

global.Pegex.Receiver = exports.Receiver = class Receiver
  constructor: ->
    @parser
    @data
    @wrap = no
