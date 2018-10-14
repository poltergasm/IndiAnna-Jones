screen_height = 768
screen_width  = 768
colors = {
  {0, 0, 0}, -- (1) black
  {0.11372549019, 0.16862745098, 0.32549019607}, -- (2) dark blue
  {0.49411764705, 0.14509803921, 0.32549019607}, -- (3) Violet
  {0, 0.5294117647, 0.31764705882}, -- (4) Dark Green
  {0.67058823529, 0.32156862745, 0.21176470588}, -- (5) brown
  {0.3725490196, 0.34117647058, 0.30980392156}, -- (6) dark gray
  {0.76078431372, 0.76470588235, 0.78039215686}, -- (7) light gray
  {1, 0.94509803921, 0.90980392156}, -- (8) white
  {1, 0, 0.30196078431}, -- (9) red
  {1, 0.63921568627, 0}, -- (10) orange
  {1, 0.92549019607, 0.15294117647}, -- (11) yellow
  {0, 0.89411764705, 0.21176470588}, -- (12) green
  {0.16078431372, 0.67843137254, 1}, -- (13) blue
  {0.51372549019, 0.46274509803, 0.61176470588}, -- (14) indigo
  {1, 0.46666666666, 0.65882352941}, -- (15) pink
  {1, 0.8, 0.66666666666} -- (16) peach
}

canvas = love.graphics.newCanvas(128, 128)
font   = love.graphics.newFont("assets/fonts/p8monoupper.ttf", 5)
atlas  = nil
sprites = {}
chunks = {}

-- local functions

local function _generate_chunks()
  local y = 0
  local x = 0
  local w,h = atlas:getDimensions()
  local cols = (w / 8)+1
  local rows = (h / 8)
  for y = 1, rows do
    for x = 0, cols do
      local off_x = 8 * x
      local off_y = 8 * y
      chunks[#chunks+1] = love.graphics.newQuad(off_x, off_y, 8, 8, w, h)
    end
  end
end

local function _animate(sp)
    if sp.anim ~= nil then
    sp.tick=(sp.tick+1)%sp.step
    if (sp.tick == 0) then
      sp.frame = sp.frame%#sp.anim[sp.state]+1
      sp.chunk = sp.anim[sp.state][sp.frame]
    end
  end
end

function love.load()
  local atlas_path = "assets/tiles.png"
  if love.filesystem.getInfo(atlas_path) then
    atlas = love.graphics.newImage(atlas_path)
  end
  love.window.setTitle("P8 Demo")
  love.window.setMode(screen_width, screen_height)
  canvas:setFilter("nearest", "nearest")
  love.graphics.setFont(font)
  _generate_chunks()
  if _init then _init() end
end

function love.update(dt)
  sm:update(dt)
  -- update sprites
  for _,sp in pairs(sprites) do
    _animate(sp)
  end
end

function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  sm:draw()
  love.graphics.setCanvas()

  local scale = love.graphics.getWidth() / canvas:getWidth()
  love.graphics.draw(canvas, 0, 0, 0, scale, scale)
end

-- p8 functions

local p8 = {}

function p8.print(str, x, y, col)
  love.graphics.setColor(colors[col])
  love.graphics.print(str, x, y)
  love.graphics.setColor(1, 1, 1)
end

function p8.get_chunk(n)
  n = n - 1
  local w,h = atlas:getDimensions()
  local cols = w / 8
  local offset_x = (8 * (n % (cols)))
  local offset_y = (8 * (math.floor(n / cols)))
  return love.graphics.newQuad(offset_x, offset_y, 8, 8, w, h)
end

function p8.spr(n, x, y, sx, sy, fx, fy)
  love.graphics.draw(atlas, chunks[n], x, y)
end

return p8