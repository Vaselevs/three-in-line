require('vision')

math.randomseed(os.time())

--инициализируем основную матрицу с которой будем работать
local matr = {}



--функция транскрипции пользовательского ввода в номер массива
local function positiontranscription(x,y)
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
local function inputtest(x,y,d)

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

  --описываем все возможные тройки
--[[
  if d == u and ()

  end
]]
end

--функция, проверяющая количество возможных троек в матрице
local function mixcheck(matr)
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



--ждем ввода от пользователя и move перемещает один кристалл
local function movemodel(from, to)
  local tmp
  tmp = matr[to]
  matr[to] = matr[from]
  matr[from] = tmp
end

--функция для проверки комбо и их удаления после каждого тика
local function checkforcombo(matr)

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



--tick дальше тикают пока происходит хоть одно изменение на поле
--ждем ввода от пользователя и move перемещает один кристалл
--ввод от пользователя - m x y d
--x,у координаты (0-9)
--d - направление одной буквой (lrud - left, right, up, down)
--или q - выход из игры
local function tickmodel()

  --получаем ввод пользователя
  reader = io.read()
  local coordinates = {}

  --проверяем полученный ввод на корректнность
  if string.match(reader, 'm [0-9] [0-9] [l,r,u,d]')  then
    coordinates.x, coordinates.y, coordinates.d = string.match(reader, "(%d) (%d) ([l,r,u,d])")
  elseif reader == "q" then
    io.write("Спасибо за игру!\n")
    --возвращаем ключ выхода из игры
    return 'q'
  else
    io.write("Неверный формат!\n")
    io.write("Повторите ввод: ")
  end


  --проверяем возможность составления тройки, если возможно, меняем позиции кристалов в массиве
  if inputtest(coordinates.x, coordinates.y, coordinates.d) then

    --переводим пользовтельский ввод в позицию массива
    local position
    if positiontranscription(coordinates.x, coordinates.y) ~= 0 then
      position = positiontranscription(coordinates.x, coordinates.y)

      --по направлению меняем положение кристалла
      if coordinates.d == l then
        movemodel(position, position-1)
      elseif coordinates.d == r then
        movemodel(position, position+1)
      elseif coordinates.d == u then
        movemodel(position, position-10)
      else
        movemodel(position, position+10)
      end

      local checkedmatr = checkforcombo(matr)

      for i=0,9 do
        for j=0,9 do
          io.write(checkedmatr[positiontranscription(i, j)])
        end
      end


    end


  elseif positiontranscription(coordinates.x, coordinates.y) ~= 0 then
    io.write("Тут нет тройки! \n")
    io.write("Повторите ввод: \n")
  else
    io.write("Не удалось получить координаты, повторите ввод: \n")
  end


end



--если возможных перемещений - нет, то перемешиваем кристаллы (mix) чтобы
--возникли новые варианты перемещений - но не возникло новых готовых троек
local function mixmodel()

  for i=1,10 do
    for j=1,10 do
      local tmp = math.random(6)
      while true do
        if ((matr[#matr] == tmp) and (matr[#matr-1] == tmp)) or ((matr[#matr-9] == tmp) and (matr[#matr-19] == tmp)) then
          tmp = math.random(6)
        else
          matr[#matr+1] = tmp
          break
        end
      end
    end
  end

  print(mixcheck(matr))
--если 0 возможных троек, миксуем ещё раз
  if mixcheck(matr) == 0 then
    mixmodel()
  end

end



--перемещение
function move(from, to)
  movemodel(from, to)
end

--фунция перемешивает кристалы, создавая хотя бы одну тройку
function mix()
  mixmodel()
end

--после каждого тика визуализируем поле (dump())
function dump()
  vision(matr)
end

--в тике идёт обработка пользовательского ввода и его проверка
function tick()
  return tickmodel()
end

-- init заполняет поле (рандом)
function init()
  mixmodel()
  dump(matr)
end
