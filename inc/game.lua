local game = {}

function game:load()
  actors:add(actors.player)
  actors:add(actors.blob)
end

function game:update(dt)
end

function game:draw()
  p8.spr(actors.player.chunk, 16, 16)
  p8.spr(actors.blob.chunk, 32, 32)
end

return game