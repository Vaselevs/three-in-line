
--[[В этом файле реализованны 5 функций модели:
    mixmodel - заполняет



]]

require('vision')
require('suppfunc')

math.randomseed(os.time())

--инициализируем основную матрицу с которой будем работать
local matr = {}



--если возможных перемещений - нет, то перемешиваем кристаллы (mix) чтобы
--возникли новые варианты перемещений - но не возникло новых готовых троек
local function mixmodel()

  for i=1,10 do
    for j=1,10 do
      while true do
        local tmp = math.random(6)
        --перебираем все возможные условия, при которых мы можем разместить букву. Если не можем, делаем снова рандом
        if (matr[#matr-19] ~= tmp) then
          if (matr[#matr-1] ~= tmp) or ((matr[#matr-1] == tmp) and (j == 10 or j == 1)) then
            matr[#matr+1] = tmp
            break
          else
            tmp = math.random(6)
          end
        else
          tmp = math.random(6)
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




--ждем ввода от пользователя и move перемещает один кристалл
local function movemodel(from, to)
  local tmp
  tmp = matr[to]
  matr[to] = matr[from]
  matr[from] = tmp
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
