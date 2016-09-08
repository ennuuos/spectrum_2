camera = {
  x = 0,
  y = 0,
  fx = 0,
  fy = 0,
  smoothing = 5,
  push = function()
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
  end,
  pop = function()
    love.graphics.pop()
  end,
  revert = function(x, y)
    return x + camera.x, y + camera.y
  end,
  focus = function(x, y)
    camera.fx = x - screen.width/2
    camera.fy = y - screen.height/2
  end,
  update = function(dt)
    camera.x = camera.x + ((camera.fx - camera.x)*camera.smoothing) * dt
    camera.y = camera.y + ((camera.fy - camera.y)*camera.smoothing) * dt
  end,
}
