local game = {}

function game:load()
  actors:add(actors.player)
end

function game:update(dt)
end

function game:draw()
  p8.spr(actors.player.chunk, 16, 16)
  p8.print("Welcome to p8", 30, 30, 12)
end

return game