--[[В этом файле реализована красивая отрисовка основного массива.
    Дополнительной маркировкой 7+ можно реализовать любые бонусные камни
]]


--фунция в качестве параметра принимает массив из 100 элементов
--создаёт на основе него новый массив, заменяя числа на буквы(камни)
--и после этого отрисоввывает его
local function localvision(matr)

--меняем цыфры масива на буквы при визуализации, при этом не затрагивается основной логический массив
  local visionmatr = {}

  local k = 1
  for i=0,9 do
    for j=0,9 do
      if matr[k] == 1 then
        visionmatr[k] = 'A'
      elseif matr[k] == 2 then
        visionmatr[k] = 'B'
      elseif matr[k] == 3 then
        visionmatr[k] = 'C'
      elseif matr[k] == 4 then
        visionmatr[k] = 'D'
      elseif matr[k] == 5 then
        visionmatr[k] = 'E'
--[[  elseif matr[k] == 7 then
        visionmatr[k] = 'BONUS'
      end
]]
      else
        visionmatr[k] = 'F'
      end
      k = k + 1
    end
  end


--отрисвовываем массив

  io.write('    0 1 2 3 4 5 6 7 8 9\n')
  io.write('   --------------------\n')
  k = 1
  for i=0,9 do
    for j=0,9 do
      if j == 0 then
        io.write(i .. ' | ')
      end
        io.write(visionmatr[k] .. ' ')
      k = k + 1
    end
    io.write('\n')
  end

end

--интерфейс функции
function vision(matr)
  localvision(matr)
end
