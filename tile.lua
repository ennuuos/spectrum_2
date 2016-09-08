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
