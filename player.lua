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
	s = {
		x = 0,
		y = 0,
		c = "red"
	},
	reset = function()
		player.x = player.s.x
		player.y = player.s.y
		player.color = player.s.c
		player.v.x = 0
		player.v.y = 0
	end,
	update = function(dt)
		player.v.y = player.v.y + gravity * dt
		player.x = player.x + player.v.x * dt
		player.y = player.y + player.v.y * dt
		player.bCanjump = false
		player.collide_tiles()
		player.collide_switches()
		player.v.x = 0
		if love.keyboard.isDown('d') then
			player.v.x = player.v.x + speed
		end
		if love.keyboard.isDown('a') then
			player.v.x = player.v.x - speed
		end
		if love.keyboard.isDown("space") or love.keyboard.isDown('w') then
			if player.bCanjump then
					player.v.y = -jumpV
				end
		end

	end,

	draw = function()
		love.graphics.setColor(colors[player.color].r+30, colors[player.color].g+30, colors[player.color].b+30)
		--love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
		--love.graphics.setColor(200, 200, 200)
		if bitimg[bitmask] then
				love.graphics.draw(bitimg[bitmask], player.x, player.y)
		end
		--love.graphics.rectangle("fill", player.x + 5, player.y + 5, player.width-10, player.height-10)
	end,

	drawSpawn = function()
		love.graphics.setColor(colors[player.s.c].r -20, colors[player.s.c].g -20, colors[player.s.c].b -20)
	    love.graphics.circle("fill", player.s.x + 14/2, player.s.y + 14/2, 14, 3)
		love.graphics.setColor(colors[player.s.c].r, colors[player.s.c].g, colors[player.s.c].b)
	    love.graphics.circle("fill", player.s.x + 14/2, player.s.y + 14/2, 11, 3)
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
		--TODO: Fix this stuff. The jumping is acting weird
		colliders = {}
		for i = 1, #tile do
			if tile[i].color ~= player.color then
				player.x, player.y, dir = util.collide(player.x, player.y, player.width, player.height, tile[i].x, tile[i].y, tile[i].width, tile[i].height)
				table.insert(colliders, {i, dir})
			end
		end
		bitmask = 15
		for _, col in pairs(colliders) do
			i = col[1]
			dir = col[2]
			if dir == 1 then
				bitmask = bitmask - 4
			end
			if dir == 2 then
				bitmask = bitmask - 2
			end
			if dir == 3 then
				bitmask = bitmask - 8
			end
			if dir == 4 then
				--bitmask = bitmask - 1
			end
			if dir == 3 or dir == 4 then
				if tile[i].x + grid.buffer < player.x + player.width and tile[i].x + tile[i].width - grid.buffer > player.x then
					if dir == 3 then
						player.bCanjump = true
					end
					player.v.y = 0
				end
			end
		end
	end,
	collide_switches = function()
		for i = 1, #switch do
			if switch[i].color ~= player.color then
				if util.intersect(player.x, player.y, player.width, player.height, switch[i].x, switch[i].y, switch[i].width, switch[i].height) then
					player.color = switch[i].color
					sm_o = time
					psystem:setColors(colors[cycle[player.color]].r, colors[cycle[player.color]].g, colors[cycle[player.color]].b, 255, 200, 200, 200, 0) -- Fade to transparency.

				end
			end
		end
	end,
}
