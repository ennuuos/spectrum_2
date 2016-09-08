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
