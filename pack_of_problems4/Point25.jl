using HorizonSideRobots
originRobot = Robot(animate = false, "24example.sit")
include("../AbstractType.jl")
include("../functions.jl")

function AverangeTemperature(robot::Robot, moveSide::HorizonSide)::Real
    averageTemperature = 0
    numOfsquares = 0
    height = 0
    stepsToBack = 0
    tempBorderSide = anti_side(moveSide)
    for _ in 1:4
        while isborder(robot, tempBorderSide)
            if (isborder(robot, tempBorderSide))
                numOfsquares += 1
                averageTemperature =+ temperature(robot)
                if (tempBorderSide == next_side_pr(next_side_pr(anti_side(moveSide))))
                    height += 1 
                elseif (tempBorderSide == anti_side(moveSide))
                    stepsToBack += 1
                end
            end
            move!(robot, next_side(tempBorderSide))
        end
        move!(robot, tempBorderSide)
        tempBorderSide = next_side_pr(tempBorderSide)
    end
    for _ in 1:(height - stepsToBack)
        move!(robot, next_side_pr(moveSide))
        numOfsquares += 1
        averageTemperature =+ temperature(robot)
    end
    averageTemperature = ( averageTemperature - temperature(robot) ) / (numOfsquares - 1)
    return averageTemperature
end

function master!(robot::Robot)::Real
    maxAverageTemperature = 0
    tempAvetageTemperature = 0
    while !(isborder(robot, Nord))
        for side in [Ost, West]
            while true
                if isborder(robot, side)
                    if try_move!(robot, side)
                        tempAvetageTemperature = AverangeTemperature(robot, side)
                        if tempAvetageTemperature > maxAverageTemperature 
                            maxAverageTemperature = tempAvetageTemperature
                            # можно написать очень похожую на square функцию, которая бы ещё и обвела этит прямоугольник
                        end
                    else
                        break
                    end
                else
                    move!(robot, side)
                end
            end
            if !(isborder(robot, Nord))
                move!(robot, Nord)
            end
        end
    end
    return maxAverageTemperature
end

master!(originRobot)
show!(originRobot)