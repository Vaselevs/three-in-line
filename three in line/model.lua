
--[[В этом файле реализованны 5 функций модели:
    init - инициирует инициализацию первоночального массив и выводит его на экран
    mix  - инициализирует новый массив, без троек
    tick - отвечает за получение ввода от пользователя, а так же за обработку этого ввода
    dump - выводит массива
    move - меняет местами позиции в массиве
]]

require('vision')
require('suppfunc')

math.randomseed(os.time())

--инициализируем основную матрицу с которой будем работать
local matr = {}



--если возможных перемещений - нет, то перемешиваем кристаллы (mix) чтобы
--возникли новые варианты перемещений - но не возникло новых готовых троек
local function mixmodel()

  for i=0,9 do
    for j=0,9 do
      while true do
        local tmp = math.random(6)
        --перебираем все возможные условия, при которых мы можем разместить букву. Если не можем, делаем снова рандом
        if (matr[#matr-19] ~= tmp) then
          if (matr[#matr-1] ~= tmp) or ((matr[#matr] == tmp) and (j == 10 or j == 1)) then
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
  io.write("Ждём ввода от пользователя: ")
  --получаем ввод пользователя
  reader = io.read()
  local coordinates = {}
  local quit

  --проверяем полученный ввод на корректнность
  if string.match(reader, 'm [0-9] [0-9] [l,r,u,d]')  then
    coordinates.x, coordinates.y, coordinates.d = string.match(reader, "(%d) (%d) ([l,r,u,d])")

    --проверяем возможность составления тройки, если возможно, меняем позиции кристалов в массиве
    if inputtest(coordinates.x, coordinates.y, coordinates.d) then
      --переводим пользовтельский ввод в позицию массива
      local position = positiontranscription(coordinates.x, coordinates.y)

      --TODO потом удалить везде функцию check
      local function check()
        transform = tramsformmatr(matr)
        for i=0,9 do
          for j=0,9 do
            if j == 0 then
              io.write('    ')
            end
            local position = positiontranscription(j,i)
            io.write(transform[position]..' ')
          end
          io.write('\n')
        end
      end

      --по направлению меняем положение кристалла, если это приведёт к 3+
      if coordinates.d == 'l' then
        movemodel(position, position-1)
        if not combochecker(matr) then
          movemodel(position-1, position)
          io.write("Сюда нельзя передвинуть!\n")
        else
        --  check()
          combomixer(matr)

        end
      elseif coordinates.d == 'r' then
        movemodel(position, position+1)
        if not combochecker(matr) then
          movemodel(position+1, position)
          io.write("Сюда нельзя передвинуть!\n")
        else
      --    check()
          combomixer(matr)

        end
      elseif coordinates.d == 'u' then
        movemodel(position, position-10)
        if not combochecker(matr) then
          movemodel(position-10, position)
          io.write("Сюда нельзя передвинуть!\n")
        else
        --  check()
          combomixer(matr)

        end
      elseif coordinates.d == 'd' then
        movemodel(position, position+10)
        if not combochecker(matr) then
          movemodel(position+10, position)
          io.write("Сюда нельзя передвинуть!\n")
        else
      --    check()
          combomixer(matr)
        end
      end

    end

  elseif reader == "q" then
    io.write("Спасибо за игру! \n")
    --возвращаем ключ выхода из игры
    quit = 'q'
  else
    io.write("Неверный формат!\n")
    io.write("Повторите ввод: ")
  end

  return quit
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
