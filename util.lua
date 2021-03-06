util = {
	boolToInt = function(bool)
		if bool then
			return 1
		else
			return 0
		end
	end,


	intersect = function(ax, ay, aw, ah, bx, by, bw, bh)
		return ax + aw > bx and ax < bx + bw and ay + ah > by and ay < by + bh
	end,

	within = function(ax, ay, bx, by, bw, bh)
		return ax > bx and ax < bx + bw and ay > by and ay < by + bh
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
	drawTable = function(table)
		y = 0
		for i, v in ipairs(table) do
			love.graphics.print(i..", "..v, 20, y)
			y = y + 14
		end
	end,
}
