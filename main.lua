
require('settings')
require('util')
require('player')
require('tile')
require('switch')

require('editor')

require('camera')
require('file')

maps = {
	'map',
	'maptwo'
}
currentmap = 1

function love.load()
	debug = {}
	file.loadmap(maps[currentmap])
end

function love.update(dt)
	camera.update(dt)
	if bEditing then
	else
		player.update(dt)
	end
	--files = love.filesystem.getDirectoryItems("")
end

function love.draw()

	camera.focus(player.x, player.y)
	camera.push()
	if bEditing then
		love.graphics.clear(200, 200, 200)
	else
		love.graphics.clear(colors[player.color].r, colors[player.color].g, colors[player.color].b)
	end
	tile.drawAll()
	switch.drawAll()
	player.draw()
	if bEditing then
		editor.draw()
	end
	camera.pop()
	mx, my = love.mouse.getPosition()
	love.graphics.print(mx, 100, 100)
	mx, _ = camera.revert(mx, my)
	love.graphics.print(mx, 150, 100)
	love.graphics.setColor(0,0,0)
	util.drawTable(debug)
end

function love.keypressed( key )
	if key == "`" then
  	bEditing = not bEditing
 	end
 	if bEditing then
		editor.keypressed(key)
		if key == 'i' then
			file.loadmap(maps[currentmap])
		end
		if key == 'o' then
			file.savemap(maps[currentmap])
		end
		if key == 'u' then
			currentmap = (currentmap) % #maps + 1
			file.loadmap(maps[currentmap])

		end
		if key == "y" then
			debug = {}
			for i = 1, #switch do
				table.insert(debug, switch[i].x)
			end
		end
 	else
    if key == "space" or key == 'w' then
    	if player.bCanjump then
    	  	player.v.y = -jumpV
      	end
    end
 end
end



function love.mousepressed(x, y, button)


	if bEditing then
		editor.mousepressed(x, y, button)
	end
end
