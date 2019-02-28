
require('model')

init()

repeat

  local quit = tick()
  if quit ~= 'q' then
    dump()
  end

until quit == 'q'


--tick()
--dump()
