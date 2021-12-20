"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, 
за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
"""

using HorizonSideRobots
originRobot = Robot(5,7,animate = false)
include("../functions.jl")


# get_back_smpl возвращает робота к стене обратно заданному направлению, если на пути нет перегородок
function get_back_smpl!(robot::Robot, side::HorizonSide)::Nothing
    while (!(isborder(robot,side)))
        move!(robot,side)
    end
end

function liner!(robot, moveSide, upSide)

    steps = 0
    isBorder = false

    while !isborder(robot, moveSide)
        move!(robot, moveSide)
        steps += 1
        putmarker!(robot)
    end 
    get_back_smpl!(robot, anti_side(moveSide))
    
    if !isborder(robot, upSide)
        move!(robot, upSide)
    else
        isBorder = true
    end

    while !isBorder && steps > 0
        steps -= 1
        putmarker!(robot)
        for _ in 1:steps
            move!(robot, moveSide)
            putmarker!(robot)
        end

        get_back_smpl!(robot, anti_side(moveSide))

        if !isborder(robot, upSide)
            move!(robot, upSide)
        else
            isBorder = true
            break
        end
    end
end

# master4! 
function master4!(robot::Robot)::Nothing
    back_path = moving_in_angle!(robot)
    putmarker!(robot)
    
    liner!(robot, Ost, Nord)

    moving_in_angle!(robot)
    # moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
    moving_back_to_start!(robot, back_path)
end

master4!(originRobot)
show!(originRobot)



    

        