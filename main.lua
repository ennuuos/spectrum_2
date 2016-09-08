
colors = {
	['red'] = {
		r = 200,
		g = 50,
		b = 50,
	},
	['green'] = {
		r = 50,
		g = 200,
		b = 50,
	},
	['blue'] = {
		r = 50,
		g = 50,
		b = 200,
	},
}

gravity = 98

bEditing = true
editColor = 'blue'

cycle = {
	['red'] = 'green', 
	['green'] = 'blue', 
	['blue'] = 'red',
}

player = {
	x = 0,
	y = 0,
	width = 50,
	height = 50,
	v = {
		x = 0,
		y = 0,
	},
	color = 'red',

	update = function(dt)
		player.v.y = player.v.y + gravity * dt
		player.x = player.x + player.v.x * dt
		player.y = player.y + player.v.y * dt
		player.bCanjump = false
		player.collide_tiles()
		player.collide_switches()
		player.v.x = 0
		if love.keyboard.isDown('d') then
			player.v.x = player.v.x + 70
		end
		if love.keyboard.isDown('a') then
			player.v.x = player.v.x - 70
		end

	end,

	draw = function()
		love.graphics.setColor(colors[player.color].r-20, colors[player.color].g-20, colors[player.color].b-20)
		love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
		love.graphics.setColor(200, 200, 200)
		love.graphics.rectangle("fill", player.x + 5, player.y + 5, player.width-10, player.height-10)
	end,

	cycleColor = function(reverse)
		if reverse then
			player.color = cycle[player.color]
			player.color = cycle[player.color]
		else
			player.color = cycle[player.color]
		end

	end,
	collide_tiles = function()
		for i = 1, #tile do
			if tile[i].color ~= player.color then
				player.x, player.y, dir = util.collide(player.x, player.y, player.width, player.height, tile[i].x, tile[i].y, tile[i].width, tile[i].height)
				if dir == 3 or dir == 4 then
					player.v.y = 0
				end
				if dir == 3 then
					player.bCanjump = true
				end
			end
		end
	end,
	collide_switches = function()
		for i = 1, #switch do
			if switch[i].color ~= player.color then
				if util.intersect(player.x, player.y, player.width, player.height, switch[i].x, switch[i].y, switch[i].width, switch[i].height) then
					player.color = switch[i].color
				end
			end
		end
	end,
}

tile = {
	drawAll = function()
		for i = 1, #tile do
			tile.draw(i)
		end
	end,
	draw = function(index)
		love.graphics.setColor(colors[tile[index].color].r - 20, colors[tile[index].color].g - 20, colors[tile[index].color].b - 20)
		love.graphics.rectangle("fill", tile[index].x, tile[index].y, tile[index].width, tile[index].height)

		love.graphics.setColor(colors[tile[index].color].r, colors[tile[index].color].g, colors[tile[index].color].b)
		love.graphics.rectangle("fill", tile[index].x + 5, tile[index].y + 5, tile[index].width - 10, tile[index].height - 10)
	end,
}

switch = {
	drawAll = function()
		for i = 1, #switch do
			switch.draw(i)
		end
	end,
	draw = function(index)
		love.graphics.setColor(
			colors[
			switch[
			index
			].color
			].r -20,
			 colors[switch[index].color].g -20, colors[switch[index].color].b -20)
    	love.graphics.circle("fill", switch[index].x + switch[index].width/2, switch[index].y + switch[index].height/2, 14, 5)
		love.graphics.setColor(colors[switch[index].color].r, colors[switch[index].color].g, colors[switch[index].color].b)
    	love.graphics.circle("fill", switch[index].x + switch[index].width/2, switch[index].y + switch[index].height/2, 11, 5)
    end,
}



function love.load()
end

function love.update(dt)
	if bEditing then
	else
		player.update(dt)
	end
end

function love.draw()
	if bEditing then
		mx, my = love.mouse.getPosition()
		love.graphics.clear(200, 200, 200)
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
	else
		love.graphics.clear(colors[player.color].r, colors[player.color].g, colors[player.color].b)
	end
	tile.drawAll()
	switch.drawAll()
	player.draw()
end

function love.keypressed( key )
	if key == "`" then
    	bEditing = not bEditing
   	end
   	if bEditing then
   		if key == "p" then
			mx, my = love.mouse.getPosition()
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
   	else
	    if key == "space" or key == 'w' then
	    	if player.bCanjump then
	    	  	player.v.y = -123
	      	end
	    end
   end
end

util = {
	intersect = function(ax, ay, aw, ah, bx, by, bw, bh)
		return ax + aw > bx and ax < bx + bw and ay + ah > by and ay < by + bh
	end,

	smallest_intersect = function(ax, ay, aw, ah, bx, by, bw, bh)
		intersects = {
			ax + aw - bx,
			bx + bw - ax,
			ay + ah - by,
			by + bh - ay,
		}
		smallest_i = 1
		for i = 2, 4 do
			if intersects[smallest_i] > intersects[i] then
				smallest_i = i
			end
		end
		return smallest_i
	end,

	collide = function(ax, ay, aw, ah, bx, by, bw, bh)
		if util.intersect(ax, ay, aw, ah, bx, by, bw, bh) then
			offsets = {
				{bx - aw, nil},
				{bx + bw, nil},
				{nil, by - ah},
				{nil, by + bh}
			}
			si = util.smallest_intersect(ax, ay, aw, ah, bx, by, bw, bh)
			return offsets[si][1] or ax, offsets[si][2] or ay, si
		else
			return ax, ay, 0
		end
	end,
}

function love.mousepressed(x, y, button)
	mx, my = love.mouse.getPosition()
	if bEditing then
		if button == 1 then
			index = #tile + 1
			for i = 1, #tile do
				if tile[i].x == mx - mx % 50 and tile[i].y == my - my % 50 then
					index = i
					break
				end
			end
			tile[index] = {
				x = mx - mx % 50,
				y = my - my % 50,
				width = 50,
				height = 50,
				color = editColor,
			}
		else
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
			table.insert(switch, {
				x = cx - 7,
				y = cy - 7,
				width = 20,
				height = 20,
				color = editColor,
			})
		end
	end
end