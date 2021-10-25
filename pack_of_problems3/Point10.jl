```

ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров

РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток

```

using HorizonSideRobots
r = Robot(animate = true)
include("../cheatRobot.jl")

# isMark определяет жесть ли в клетке маркер, если да, то добавляет к answer температуру и увеличивает счетчик
function isMark(r::Robot)::Nothing
    if (ismarker(r))
        answer[1] += temperature(r)
        answer[2] += 1
    end
end

# змейка с try_move! и isMark 
function move_like_snake!(r::Robot)
    while !(isborder(r,Ost))
        for side in [Nord, Sud]
            while !isborder(r,side)
                try_move!(r,side)
                isMark(r)
            end
            if !isborder(r,Ost)
                try_move!(r,Ost)
                isMark(r)
            else
                continue
            end
        end
    end
end


# master главная функция программа
function Point10_master!(r::Robot)::Integer
    global answer = [0,0]
    isMark(r)
    move_like_snake!(r)
    return ( answer[1] / answer[2] )
end


