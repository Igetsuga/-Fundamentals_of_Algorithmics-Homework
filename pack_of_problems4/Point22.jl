using HorizonSideRobots
include("../functions.jl")
originRobot = Robot(animate = false, "22example.sit")

function mod_moveToBorder!(robot::Robot, moveSide::HorizonSide, borderSide::HorizonSide)
    bordersInLine = 0
    state = 0
    while (true)
        if  (!isborder(robot, moveSide))
            move!(robot, moveSide)
        elseif (try_move!(robot, moveSide))
        else
            break
        end
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

function mod_moveLikeSnake!(robot::Robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)
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

function master22!(robot::Robot)
    numberOfBorders = 0

    while !isborder(robot, Nord)
        numberOfBorders += mod_moveLikeSnake!(robot, (Ost, West), Nord)
    end

    return numberOfBorders
end
show!(originRobot)
master22!(originRobot)