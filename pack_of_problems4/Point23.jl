"""

Подсчитать число и прямоугольных и прямолинейных (вертикальных и горизонтальных)

"""

using HorizonSideRobots
originRobot = Robot(animate = false, "23example.sit")
include("../AbstractType.jl")
include("../functions.jl")



function mod_moveToBorder!(robot::Robot, moveSide::HorizonSide, borderSide::HorizonSide, condition)
    bordersInLine = 0
    state = 0
    while (true)
        if  (!isborder(robot, moveSide))
            move!(robot, moveSide)
        else
            if try_move!(robot, moveSide)
            else 
                #println("break")
                break
            end
        end
        if condition
            if ( isborder(robot, borderSide) )
                #println("iam here")
                if (square(robot, anti_side(borderSide)) == 0)
                    bordersInLine += 1
                    #println("there2")
                end
                while isborder(robot, borderSide)
                    move!(robot, moveSide)
                end
            end
        else
            if !isborder(robot, borderSide)
                if state == 1
                    state = 0
                    bordersInLine += 1
                    #println("there1")
                end
            else 
                state = 1
            end
        end
    end
    return bordersInLine 
end

function mod_moveLikeSnake!(robot::Robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide, condition)::Integer
    bordersInLine = 0
    for side in moveSides
        bordersInLine += mod_moveToBorder!(robot, side, borderSide, condition)
        if !(isborder(robot, borderSide))
            move!(robot, borderSide)
            if isangle!(robot)
                return bordersInLine
            end
        else
            break
        end 
    end
    return bordersInLine
end

function master23!(robot)

    moving_in_angle!(robot, West, Sud)

    numberOfBorders = 0

    while !isborder(robot, Nord)
        numberOfBorders += mod_moveLikeSnake!(robot, (Ost, West), Nord, false)
    end

    moving_in_angle!(robot, West, Nord)

    while !isborder(robot, Ost)
        
        numberOfBorders += mod_moveLikeSnake!(robot, (Sud, Nord), Ost, true)
    end
    show!(originRobot)
    return numberOfBorders
end

master23!(originRobot)


