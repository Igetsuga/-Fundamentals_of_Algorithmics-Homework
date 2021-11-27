```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок

РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке

```

using HorizonSideRobots
r = Robot(animate=false)
include("../functions.jl")

function mod_moveToBorder!(robot::Robot, side::HorizonSide, counter::Integer)
    while (!isborder(robot, side))
        move!(robot, side)
        if (counter % 2 == 0)
            putmarker!(robot)
        end
    end
    counter += 1
end

function mod_moveLikeSnake!(robot::Robot, sides::NTuple{2,HorizonSide}, side::HorizonSide, counter::Integer)
    if (isborder(robot, sides[1]))
        mod_moveToBorder!(robot, sides[2], counter)
        if (!isborder(robot, side))
            move!(robot, side)
            counter += 1
        end
    else
        mod_moveToBorder!(robot, sides[1], counter)
        if (!isborder(robot, side))
            move!(robot, side)
            counter += 1
        end
    end
end

function get_one_marked_line!(robot::Robot, side, counter::Integer)::Nothing
    while (!(isborder(robot,side)))
        if (counter % 2 == 1)
            putmarker!(robot)
            move!(robot,side)
        else
            move!(robot,side)
        end
        counter += 1
    end
end


# master! главная функция программы.
function master!(robot::Robot)::Nothing
    back_path = moving_in_angle!(robot)

    counter = 0
    
    while !isborder(robot, Ost)
        mod_moveLikeSnake!(robot, (Nord, Sud), Ost, counter)
    end

    moving_in_angle!(robot)
        
    moving_back_to_start!(robot, back_path)
end 
