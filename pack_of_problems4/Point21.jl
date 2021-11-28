"""

Подсчитать число и вертикальных и горизонтальных прямолинейных перегородок, где прямоугольных - нет

"""

using HorizonSideRobots
originRobot = Robot(animate = false, "21example.sit")
show!(originRobot)
include("../AbstractType.jl")
include("../functions.jl")


function mod_moveToBorder!(robot::Robot, moveSide::HorizonSide, borderSide::HorizonSide)::Integer
    bordersInLine = 0
    state = 0
    while (try_move!(robot, moveSide))
        if !isborder(robot, borderSide)
            if state == 1
                state = 0
                bordersInLine += 1
            end
        else 
            state = 1
        end
    end
    return bordersInLine 
end

function mod_moveLikeSnake!(robot::Robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Integer
    bordersInLine = 0
    for side in moveSides
        bordersInLine += mod_moveToBorder!(robot, side, borderSide)
        if !(isborder(robot, borderSide))
            move!(robot, borderSide)
        else
            break
        end 
    end
    return bordersInLine
end

function master!(robot::Robot)
    numberOfBorders = 0
    backPath = moving_in_angle!(robot, West, Sud)
    while !isborder(robot, Nord)
        numberOfBorders += mod_moveLikeSnake!(robot, (Ost, West), Nord)
        #println(numberOfBorders)
    end
    

    moving_in_angle!(robot, West, Sud)

    while !isborder(robot, Ost)
        numberOfBorders += mod_moveLikeSnake!(robot, (Nord, Sud), Ost)
        #println(numberOfBorders)
    end

    moving_in_angle!(robot, West, Sud)

    moving_back_to_start!(robot, backPath)
    
    return numberOfBorders
end

master!(originRobot)

