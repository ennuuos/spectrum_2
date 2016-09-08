
require('settings')
require('util')
require('player')
require('tile')
require('switch')

require('editor')



function love.load()
end

function love.update(dt)
	if bEditing then
	else
		player.update(dt)
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(-player.x + screen.width/2, -player.y + screen.height/2)

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
	love.graphics.pop()
end

function love.keypressed( key )
	if key == "`" then
    	bEditing = not bEditing
   	end
   	if bEditing then
			editor.keypressed(key)
   	else
	    if key == "space" or key == 'w' then
	    	if player.bCanjump then
	    	  	player.v.y = -123
	      	end
	    end
   end
end



function love.mousepressed(x, y, button)
	mx, my = love.mouse.getPosition()

	if bEditing then
		editor.mousepressed(x, y, button)
	end
end
