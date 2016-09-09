
require('settings')
require('util')
require('player')
require('tile')
require('switch')

require('editor')

require('camera')
require('file')
require('shader')

maps = {
}
currentmap = 1

function love.load()
	debug = {}
	canvas = love.graphics.newCanvas(screen.width, screen.height)
	sm_g = 10
	sm_o = time
	file.findmaps()
	if maps[currentmap] then
		file.loadmap(maps[currentmap])
	end
	camera.instantfocus(player.x + player.width/2, player.y + player.height/2)
	local img = love.graphics.newImage('particle.png')
	psystem = love.graphics.newParticleSystem(img, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(100)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-10, -10, 10, 10) -- Random movement in all directions.
	psystem:setColors(colors[cycle[player.color]].r, colors[cycle[player.color]].g, colors[cycle[player.color]].b, 255, 200, 200, 200, 0) -- Fade to transparency.
	psystem:setSpin(0, 5)
	psystem:setTangentialAcceleration(600, 1000)
	psystem:setRadialAcceleration(100, 100)
	psystem:setBufferSize(500)
	psystem:setSizes(1, 0)

end
time = 0
switchmag = 0
function love.update(dt)
	psystem:update(dt)
	time = time + dt
	camera.update(dt)
	camera.focus(player.x + player.width/2, player.y + player.height/2)
	updateswitchmag(dt)
	if bEditing then
	else
		player.update(dt)
	end
end

sm_o = 0
sm_l = 0.15
sm_m = 0.005
sm_g = 1
function updateswitchmag(dt)
		table.remove(debug)
		table.insert(debug, switchmag)
	if time - sm_o < sm_l * 3.14 then
		switchmag = math.cos((time-sm_o)/(sm_l*2)) * sm_m * sm_g
	else
		switchmag = 0
		sm_g = 1
	end
end

function love.draw()
	love.graphics.setShader()
	love.graphics.setCanvas(canvas)
	camera.push()
	if bEditing then
		love.graphics.clear(200, 200, 200)
	else
		love.graphics.clear(colors[player.color].r, colors[player.color].g, colors[player.color].b)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(psystem, player.x + player.width/2, player.y + player.height/2)

	tile.drawAll()
	player.drawSpawn()
	switch.drawAll()
	player.draw()
	if bEditing then
		editor.draw()
	end
	camera.pop()
	shader.abberation:send('magnitude', switchmag)
	shader.abberation:send('evolution', time * 10)
	love.graphics.setShader(shader.abberation)
	love.graphics.setCanvas()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(canvas)


	x, y = love.mouse.getPosition()
	love.graphics.setColor(0,0,0)
	util.drawTable(debug)
	file.drawmaps()
	if util.within(x, y, screen.width - 5 - 30, 5, 30, 30) then
		c = 'green'
	else
		c = 'blue'
	end
	love.graphics.setColor(colors[c].r-20, colors[c].g-20, colors[c].b-20)
	love.graphics.rectangle("fill", screen.width - 5 - 30, 5, 30, 30)
	love.graphics.setColor(colors[c].r, colors[c].g, colors[c].b)
	love.graphics.rectangle("fill", screen.width - 5 - 30 + 5, 5 + 5, 30 - 10, 30 - 10)


end

function love.keypressed( key )
	if key == "`" then
  	bEditing = not bEditing
		if bEditing then
			psystem:pause( )
		end
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
			camera.instantfocus(player.x + player.width/2, player.y + player.height/2)
			sm_g = 10
			sm_o = time
		end
 	else
    if key == "space" or key == 'w' then
    	if player.bCanjump then
    	  	player.v.y = -jumpV
      	end
    end
 end
		if key == 'r' then
			sm_g = 10
			sm_o = time
			player.reset()
		end
		if key == "n" then
			file.newmap("test")
		end
end



function love.mousepressed(x, y, button)
	overUI = false
	x, y = love.mouse.getPosition()
	for i = 1, #maps do
		if util.within(x, y, 20, (i - 1) * 30 + 30, 90, 25) then
			overUI = true
			currentmap = i
			file.loadmap(maps[currentmap])
			camera.instantfocus(player.x + player.width/2, player.y + player.height/2)
			sm_g = 10
			sm_o = time
			break
		end
	end

	if util.within(x, y, screen.width - 5 - 30, 5, 30, 30) then
		file.savemap(maps[currentmap])
		overUI = true
	end

	if bEditing and not overUI then
		editor.mousepressed(x, y, button)
	end
end
