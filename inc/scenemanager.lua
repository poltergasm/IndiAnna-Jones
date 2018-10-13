local sm = {
  current = nil,
  scenes  = {}
}

function sm:add(scenes)
  for k,v in pairs(scenes) do
    self.scenes[k] = v
    if v.load then v:load() end
  end
end

function sm:switch(scene)
  self.current = self.scenes[scene]
  if self.current.on_enter then self.current:on_enter() end
end

function sm:update(dt) self.current:update(dt) end

function sm:draw() self.current:draw() end

return sm