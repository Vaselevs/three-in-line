--[[
  Это основной файл запуска.
  Для старта игры запустите lua main.lua
]]


require('model')

init()

repeat
  local quit = tick()
until quit == 'q'
