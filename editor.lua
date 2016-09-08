editor = {
  draw = function()
    mx, my = love.mouse.getPosition()
    mx = mx - screen.width/2 + player.x
    my = my - screen.height/2 + player.y
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
    love.graphics.circle("fill", cx, cy, 12, 5)
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
      editColor = cycle[editColor]
      editColor = cycle[editColor]
    end
  end,
  mousepressed = function(x, y, button)
    x = x - screen.width/2 + player.x
    y = y - screen.height/2 + player.y
    if button == 1 then
			index = #tile + 1
			for i = 1, #tile do
				if tile[i].x == x - x % 50 and tile[i].y == y - y % 50 then
					index = i
					break
				end
			end
			tile[index] = {
				x = x - x % 50,
				y = y - y % 50,
				width = 50,
				height = 50,
				color = editColor,
			}
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
			table.insert(switch, {
				x = cx - 7,
				y = cy - 7,
				width = 20,
				height = 20,
				color = editColor,
			})
    end
  end,
}
