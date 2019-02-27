
--В этом файле вынесена реализация всех вспомогательных функций, используемых в модели




--функция транскрипции пользовательского ввода в номер массива

local function localpositiontranscription(x,y)
  local position = 0

  if x == nil or y == nil then
    return position
  end

  if y == 0 then
    position = x + 1
  else
    position = y * 10 + x + 1
  end
  return position
end

--функция для проверки корректности ввода, и возможности вообще передвижения
local function localinputtest(x,y,d)

  if x == '0' and d == "l" then
    return false
  elseif x == '9' and d == "r" then
    return false
  elseif y == '0' and d == "u" then
    return false
  elseif y == '9' and d == "d" then
    return false
  end

  --проверка нужна в случае некоректного ввода данных, координаты получают nil
  --если данные неверны, возвращаем true, так как она не пройдёт проверку всё равно
  local position
  if positiontranscription(x,y) ~= 0 then
     position = positiontranscription(x,y)
  else
    return false
  end


end

--функция, проверяющая количество возможных троек в матрице
local function localmixcheck(matr)
  local k = 0
  for i=1, 100 do

    --перебираем все возможные тройки

    -- right
      if string.match(i, '[10,20,30,40,50,60,70,80,90]') == nil and (matr[i] == matr[i-9] and matr[i] == matr[i+11]) or (matr[i] == matr[i+11] and matr[i] == matr[i+21]) or (matr[i] == matr[i-9] and matr[i] == matr[i-19]) then
        --  -: r
        --  `= r
        --  _= r
        k = k + 1
      end

      --  - -- r
      if (string.match(i, '[8,9,10,18,19,20,28,29,30,38,39,40,48,49,50,58,59,60,68,69,70,78,79,80,88,89,90]') == nil) and (matr[i] == matr[i+2] and matr[i] == matr[i+3]) then
        k = k + 1
      end

    -- left
      if string.match(i, '[1,11,21,31,41,51,61,71,81,91]') == nil and (matr[i] == matr[i-11] and matr[i] == matr[i+9]) or (matr[i] == matr[i-11] and matr[i] == matr[i-21]) or (matr[i] == matr[i+9] and matr[i] == matr[i+19]) then
        --  :- l
        --  =_l
        --  =` l
        k = k + 1
      end

      --  -- - l
      if (string.match(i, '[11,12,13,21,22,23,31,32,33,41,42,43,51,52,53,61,62,63,71,72,73,81,82,83,91,92,93]') == nil) and (matr[i] == matr[i-2] and matr[i] == matr[i-3]) then
        k = k + 1
      end


    -- up
      if string.match(i, '[1-9]') == nil then

        --  -_- u
        if (string.match(i, '[21,31,41,51,61,71,81,91,20,30,40,50,60,70,80,90]') == nil) and (matr[i] == matr[i-9] and matr[i] == matr[i-11]) then
          k = k + 1
        end
        --  --. u
        if (string.match(i, '[21,22,31,32,41,42,51,52,61,62,71,72,81,82,91,92]') == nil) and (matr[i] == matr[i-11] and matr[i] == matr[i-12]) then
          k = k + 1
        end


        --  .-- u
        if (string.match(i, '[19,20,29,30,39,40,49,50,59,60,69,70,79,80,89,90,100]') == nil) and (matr[i] == matr[i-8] and matr[i] == matr[i-9]) then
          k = k + 1
        end

        --  = u
        --  -
        if (matr[i] == matr[i-20] and matr[i] == matr[i-30]) then
          k = k + 1
        end
      end

    -- down
      if string.match(i, '[91-100]') == nil then
        --  - d
        --  =
        if (matr[i] == matr[i+20] and matr[i] == matr[i+30]) then
          k = k + 1
        end

        --  _-_ d
        if (string.match(i, '[1,11,21,31,41,51,61,71,81,10,20,30,40,50,60,70,80,90]') == nil) and (matr[i] == matr[i+9] and matr[i] == matr[i+11]) then
          k = k + 1
        end

        --  ..- d
        if (string.match(i, '[1,2,11,12,21,22,31,32,41,42,51,52,61,62,71,72,81,82]') == nil) and (matr[i] == matr[i+8] and matr[i] == matr[i+9]) then
          k = k + 1
        end

        --  -.. d
        if (string.match(i, '[9,10,19,20,29,30,39,40,49,50,59,60,69,70,79,80]') == nil) and (matr[i] == matr[i+11] and matr[i] == matr[i+12]) then
          k = k + 1
        end
      end



  end

  return k

end



--TODO самая важная функция, которую надо доделать
--преобразуем массив в единичный массив
--а дальше убираем совпадения и убираем всё лишнее

--функция для проверки комбо и их удаления после каждого тика
local function localcombomixer(matr)

  local checkedmatr = {}
  for i=0,9 do
    for j=0,9 do

      local position = positiontranscription(i, j)
      local k = position
      --первый проход, выявляем все горизонтальные совпадения
      while matr[position] == matr[k] do


        if matr[k] == matr[k+1] and matr[k] == matr[k+2] and string.match(k, '[9,10,19,20,29,30,39,40,49,50,59,60,69,70,79,80,89,90,99,100]') == nil then
          if checkedmatr[k] == nil then
            checkedmatr[position] = 1
            checkedmatr[k+1] = 1
          end
        else
          if checkedmatr[k] == nil then
            checkedmatr[position] = 0
          end
        end

        k = k + 1

      end
    end
  end

  return checkedmatr{}

end




function combomixer(matr)
  return localcombomixer(matr)
end

function inputtest(x, y, d)
  return localinputtest(x, y, d)
end

function mixcheck(matr)
  return localmixcheck(matr)
end

function positiontranscription(x, y)
  return localpositiontranscription(x, y)
end
