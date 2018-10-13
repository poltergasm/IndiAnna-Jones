actors = require "inc/actors"

game = require "inc/game"

function _init()
  sm:add({ game = game })
  sm:switch("game")
end
