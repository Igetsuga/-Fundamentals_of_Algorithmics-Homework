```
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника.
Робот - в произвольной клетке поля между внешней и внутренней перегородками. 

РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
```

using HorizonSideRobots
r = Robot(animate=true)
include("../cheatRobot.jl")

# perimeteroid! двигает робота по переметру квадрата и проставляет маркеры
function perimeteroid!(r::Robot)::Nothing
    for side in [Nord, Ost, Sud, West]
        while (!(isborder(r,side)))
            putmarker!(r)
            move!(r,side)
        end
    end
end


# master! главная функция программы
function Point6_master!(r::Robot)::Nothing
    back_path = moving_in_angle!(r)
    perimeteroid!(r)
    moving_back_to_start!(r, back_path)
end