file = {
  loadmap = function(f)
    f = f..'.map'
    while #tile > 0 do
      table.remove(tile)
    end
    while #switch > 0 do
      table.remove(switch)
    end
    player.v.x = 0
    player.v.y = 0
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
  findmaps = function()
    if not love.filesystem.exists("default.map") and not love.filesystem.exists("/maps/default.map") then
      f = "0,0,0,red"
      love.filesystem.createDirectory("maps")
      love.filesystem.write("default.map", f)
    end
    local dir = "/maps/"
    --assuming that our path is full of lovely files (it should at least contain main.lua in this case)
    local files = love.filesystem.getDirectoryItems(dir)
    for k, file in ipairs(files) do
      --table.insert(maps, string.sub(file, 1, string.find(file, '.')))
      if string.find(file, '.map') then
        table.insert(maps, string.sub(file, 1, string.find(file, '.map')-1))
      end
    end
    dir = ""
    local files = love.filesystem.getDirectoryItems(dir)
    for k, file in ipairs(files) do
      --table.insert(maps, string.sub(file, 1, string.find(file, '.')))
      if string.find(file, '.map') then
        table.insert(maps, string.sub(file, 1, string.find(file, '.map')-1))
      end
    end

    for i, k in pairs(maps) do
      if i ~= 1 and k == 'default' then
        table.remove(maps, i)
      end
    end

  end,
  drawmaps = function()
    for i = 1, #maps do
      if i == currentmap then
        c = "green"
      else
        x, y = love.mouse.getPosition()
        if util.within(x, y, 20, (i - 1) * 30 + 30, 90, 25) then
          c = "blue"
        else
          c = "red"
        end
      end
      love.graphics.setColor(colors[c].r - 20, colors[c].g - 20, colors[c].b - 20)
      love.graphics.rectangle("fill", 20, (i - 1) * 30 + 30, 90, 25)

      love.graphics.setColor(colors[c].r, colors[c].g, colors[c].b)
      love.graphics.rectangle("fill", 20 + 5, (i - 1) * 30 + 30 + 5, 80, 15)


      str = maps[i]
      str = str:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

      love.graphics.setColor(0,0,0)
      love.graphics.print(str, 26, (i - 1) * 30 + 30 + 5)
    end
  end,
  newmap = function(name)
    if not love.filesystem.exists(name..'.map') then
      f = "0,0,0,red"
      love.filesystem.write(name..'.map', f)
      table.insert(maps, name)
      currentmap = #maps
      file.loadmap(maps[currentmap])
      camera.instantfocus(player.x + player.width/2, player.y + player.height/2)
      sm_g = 10
      sm_o = time
    end
  end,
}
