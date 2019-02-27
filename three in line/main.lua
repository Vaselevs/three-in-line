
require('model')

init()
--[[
while quit ~= 'q' do
  while quit ~= 'r' and quit ~= 'q' do
    io.write("Ждём ввода от пользователя: ")
    quit = tick()
  end


  if quit ~= 'q' then
    dump()
  end

end
]]



--tick()
--dump()
