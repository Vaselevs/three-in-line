
--реализуем отрисовку

local function visionmodel(matr)

--меняем цыфры масива на буквы при визуализации, при этом не затрагивается основной логический массив
  local visionmatr = {}

  local k = 1
  for i=1,10 do
    for j=1,10 do
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
      else
        visionmatr[k] = 'F'
      end
      k = k + 1
    end
  end

  io.write('    0 1 2 3 4 5 6 7 8 9\n')
  io.write('   --------------------\n')
  k = 1
  for i=0,9 do
    for j=1,10 do
      if j == 1 then
        io.write(i .. ' | ')
      end
        io.write(visionmatr[k] .. ' ')
      k = k + 1
    end
    io.write('\n')
  end

end

function vision(matr)
  visionmodel(matr)
end
