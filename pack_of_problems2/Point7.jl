```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок

РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке

```

using HorizonSideRobots
r = Robot(animate=false)
include("../cheatRobot.jl")

function get_one_marked_line!(robot::Robot, side, counter::Integer)
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
    while ( !(isborder(robot,Ost)) )
        for side in [Nord,Sud]
            get_one_marked_line!(robot,side,counter)
            if ( !(isborder(robot, Ost)) )
                move!(robot, Ost)
                counter += 1 
            else
                continue
            end
        end
    end

    if ( isborder(robot, Nord) )
        for side in [Sud, West]
            while (!isborder(robot, side))
                move!(robot, side)
            end
        end
    else
        while (!isborder(robot, West))
            move!(robot, West)
        end
    end
        
    moving_back_to_start!(robot, back_path)
end 
