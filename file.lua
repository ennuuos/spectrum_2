file = {
  loadmap = function(f)
    f = f..'.map'
    while #tile > 0 do
      table.remove(tile)
    end
    while #switch > 0 do
      table.remove(switch)
    end

    if love.filesystem.exists(f) then
      for line in love.filesystem.lines(f) do
        if string.sub(line, 1, 1) == '0' then
          x1 = string.find(line, ',') + 1
          y1 = string.find(line, ',', x1) + 1
          c1 = string.find(line, ',', y1) + 1
          player.x = tonumber(string.sub(line, x1, y1 - 2))
          player.y = tonumber(string.sub(line, y1, c1 - 2))
          player.color = string.sub(line, c1)
          player.s.x = player.x
          player.s.y = player.y
          player.s.c = player.color
        end
        if string.sub(line, 1, 1) == '1' then
          x1 = string.find(line, ',') + 1
          y1 = string.find(line, ',', x1) + 1
          c1 = string.find(line, ',', y1) + 1
          table.insert(tile, {
            x = tonumber(string.sub(line, x1, y1 - 2)),
            y = tonumber(string.sub(line, y1, c1 - 2)),
            width = 50,
            height = 50,
            color = string.sub(line, c1),
          })
        end
        if string.sub(line, 1, 1) == '2' then
          x1 = string.find(line, ',') + 1
          y1 = string.find(line, ',', x1) + 1
          c1 = string.find(line, ',', y1) + 1
          table.insert(switch, {
            x = tonumber(string.sub(line, x1, y1 - 2)),
            y = tonumber(string.sub(line, y1, c1 - 2)),
            width = 20,
            height = 20,
            color = string.sub(line, c1),
          })
        end
      end
    end
  end,
  savemap = function(map)
    map = map..'.map'
    f = "0,"..player.x..','..player.y..','..player.color
    first = true
    for i, v in ipairs(tile) do
      f = f..'\n1,'..v.x..','..v.y..','..v.color
    end
    for i, v in ipairs(switch) do
      f = f..'\n2,'..v.x..','..v.y..','..v.color
    end
    love.filesystem.write(map, f)
  end,
}
