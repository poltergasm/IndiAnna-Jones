local actors = {}

actors.player = {
  tick  = 0,
  frame = 1,
  step  = 2,
  state = "walk",
  chunk = 25,
  anim  = {
    idle = {25},
    jump = {30},
    walk = {26, 27, 28, 29}
  }
}

actors.blob = {
  tick  = 0,
  frame = 1,
  step  = 4,
  state = "walk",
  chunk = 31,
  anim  = {
    walk = {33, 34}
  }
}

function actors:add(o)
  sprites[#sprites+1] = o
end

return actors