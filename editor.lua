editor = {



  --[[
  draw = function()
    mx, my = love.mouse.getPosition()
    mx, my = camera.revert(mx, my)
    love.graphics.setColor(colors[editColor].r, colors[editColor].g, colors[editColor].b)
    love.graphics.rectangle("fill", mx - mx % 50 + 19, my - my % 50 + 19, 12, 12)
    cx = mx - mx % 50
    cy = my - my % 50
    if mx % 50 + my % 50 > 50 then
      if my % 50 > mx % 50 then
        cx = cx + 25
        cy = cy + 50
      else
        cx = cx + 50
        cy = cy + 25
      end
    else

      if my % 50 > mx % 50 then
        cy = cy + 25
      else
        cx = cx + 25
      end
    end
    love.graphics.line(cx, cy, mx - mx % 50 + 25, my - my % 50 + 25)
  end,]]

  draw = function()
    mx, my = love.mouse.getPosition()
    mx, my = camera.revert(mx, my)
    love.graphics.setColor(colors[editColor].r - 10, colors[editColor].g - 10, colors[editColor].b - 10)
    love.graphics.rectangle("fill", mx - mx % 50 + 19, my - my % 50 + 19, 12, 12)

    a = util.boolToInt(mx % grid.size > my % grid.size)
    b = util.boolToInt(mx % grid.size + my % grid.size > grid.size)

    ox = mx - mx % 50 + (a + b) * grid.size / 2
    oy = my - my % 50 + (b + math.abs(a - 1)) * grid.size / 2

    love.graphics.line(ox, oy, mx - mx % 50 + 25, my - my % 50 + 25)
  end,



  keypressed = function(key)
    if key == "p" then
      mx, my = love.mouse.getPosition()
      mx = mx - screen.width/2 + player.x
      my = my - screen.height/2 + player.y
      player.x = mx - mx % 50
      player.y = my - my % 50
    end
    if key == 'e' then
      editColor = cycle[editColor]
    end
    if key == 'q' then
      for i, v in pairs(cycle) do
        if v == editColor then
          editColor = i
          break
        end
      end
    end
  end,
  mousepressed = function(x, y, button)
    x, y = camera.revert(x, y)
    if button == 1 then
			index = #tile + 1
			for i = 1, #tile do
				if tile[i].x == x - x % 50 and tile[i].y == y - y % 50 then
					index = i
					break
				end
			end
      if love.keyboard.isDown('lshift') then
        if tile[index] then
          table.remove(tile, index)
        end
      else
  			tile[index] = {
  				x = x - x % 50,
  				y = y - y % 50,
  				width = 50,
  				height = 50,
  				color = editColor,
  			}
      end
		else
			cx = x - x % 50
			cy = y - y % 50
			if x % 50 + y % 50 > 50 then
				if y % 50 > x % 50 then
					cx = cx + 25
					cy = cy + 50
				else
					cx = cx + 50
					cy = cy + 25
				end
			else
				if y % 50 > x % 50 then
					cy = cy + 25
				else
					cx = cx + 25
				end
			end
      cx = cx - 8
      cy = cy - 8
      index = #switch + 1
      for i = 1, #switch do
        if switch[i].x == cx and switch[i].y == cy then
          index = i
          break
        end
      end
      if love.keyboard.isDown('lshift') then
        if switch[index] then
          table.remove(switch, index)
        end
      else
  			switch[index] = {
  				x = cx,
  				y = cy,
  				width = 20,
  				height = 20,
  				color = editColor,
  			}
      end
    end
  end,
}
