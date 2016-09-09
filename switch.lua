switch = {
	drawAll = function()
		for i = 1, #switch do
			switch.draw(i)
		end
	end,
	draw = function(index)
		love.graphics.setColor(colors[switch[index].color].r -20, colors[switch[index].color].g -20, colors[switch[index].color].b -20)
    love.graphics.circle("fill", switch[index].x + switch[index].width/2, switch[index].y + switch[index].height/2, 14, 4)
		love.graphics.setColor(colors[switch[index].color].r, colors[switch[index].color].g, colors[switch[index].color].b)
    love.graphics.circle("fill", switch[index].x + switch[index].width/2, switch[index].y + switch[index].height/2, 11, 4)
  end,
}
