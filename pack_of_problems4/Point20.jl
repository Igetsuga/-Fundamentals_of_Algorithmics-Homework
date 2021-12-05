"""

Посчитать число всех горизонтальных прямолинейных перегородок (вертикальных - нет)


"""
#= пока нет границы сверху
    пока нет границы на Ost
        пока сверху перегородка 
            идти на Ost
        перегородка += 1
        пока сверху нет перегородки 
        идти на Ost

    идти на Nord
    повторить для West
=#

using HorizonSideRobots
originRobot = Robot(animate = true, "20example.sit")
include("../AbstractType.jl")
include("../functions.jl")


function mod_moveToBorder!(robot::Robot, moveSide::HorizonSide, borderSide::HorizonSide)::Integer
    bordersInLine = 0
    state = 0
    while (!isborder(robot, moveSide))
        move!(robot, moveSide)
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
        println(bordersInLine)
        if !(isborder(robot, borderSide))
            move!(robot, borderSide)
        else
            break
        end 
    end
    return bordersInLine
end

function master20!(robot::Robot)
    numberOfBorders = 0
    backPath = moving_in_angle!(robot, West, Sud)
    while !isborder(robot, Nord)
        numberOfBorders += mod_moveLikeSnake!(robot, (Ost, West), Nord)
    end

    moving_in_angle!(robot, West, Sud)
    moving_back_to_start!(robot, backPath)
    
    return numberOfBorders
end

master20!(originRobot)

