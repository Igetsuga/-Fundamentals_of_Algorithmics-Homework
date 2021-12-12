"""

ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

(Подсказка: решение будет подобно решению задачи 1, если направление премещения Робота задавать кортежами пары значений типа HorizonSide)

"""

using HorizonSideRobots
originRobot = Robot(animate = true, "13example.sit")
#show!(originRobot)
include("../AbstractType.jl")
include("../functions.jl")


function get_line_of_cross!(robot::Robot, sides)
    path = []
    while ! ( isborder(robot,sides[1]) || isborder(robot, sides[2]) )
        for side in sides
            if (!isborder(robot,side))
                move!(robot, side)
                push!(path,Int(side))
            else
                continue
            end
        end
        putmarker!(robot)
    end
    get_back!(robot, path)
end


function master13!(robot::Robot)::Nothing

    for sides in [ [West,Sud], [West,Nord], [Ost,Sud], [Ost,Nord] ]
        get_line_of_cross!(robot, sides)
    end

    putmarker!(robot)
end

master13!(originRobot)

