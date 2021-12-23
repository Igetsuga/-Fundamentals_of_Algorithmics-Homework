```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок

РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке

```

using HorizonSideRobots
originRobot = Robot(10,7,animate = false)
include("../functions.jl")

function mod_moveToBorder!(robot::Robot, side::HorizonSide, counter::Integer)
    while true
        if !isborder(robot, side)
            move!(robot, side)
            if (counter % 2 == 0)
                putmarker!(robot)
            end
            counter += 1
            println(counter)
        else
            break
        end
    end
    return counter
end

function mod_moveLikeSnake!(robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
    border_borderSide = false
    counter = 0
    while !border_borderSide
        for side in moveSides
            counter = mod_moveToBorder!(robot, side, counter)
            if !(isborder(robot, borderSide))
                move!(robot, borderSide)
                if (counter % 2 == 0)
                    putmarker!(robot)
                end 
                counter += 1
                println(counter)
            else
                border_borderSide = true
                break
            end
        end
    end    
end

#=function get_one_marked_line!(robot::Robot, side, counter::Integer)::Nothing
    while (!(isborder(robot,side)))
        if (counter % 2 == 1)
            putmarker!(robot)
            move!(robot,side)
        else
            move!(robot,side)
        end
        counter += 1
    end
end=#


# master! главная функция программы.
function master7!(robot::Robot)::Nothing
    back_path = moving_in_angle!(robot)

    mod_moveLikeSnake!(robot, (Nord, Sud), Ost)
    
        
    moving_back_to_start!(robot, back_path)
end 

master7!(originRobot)
show!(originRobot)
