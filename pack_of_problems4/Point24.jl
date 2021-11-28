using HorizonSideRobots
originRobot = Robot(animate = false, "24example.sit")
show!(originRobot)
include("../AbstractType.jl")
include("../functions.jl")

function square(robot::Robot, moveSide::HorizonSide)::Integer
    square = 0
    height = 0
    width = 0
    stepsToBack = 0
    reqBorder = anti_side(moveSide)
    # можно было через while сделать: задать итератор = 4, и при каждом проходе по циклу менять значение side на next_side_pr(side)
    for side in [reqBorder, next_side_pr(reqBorder), next_side_pr(next_side_pr(reqBorder)), anti_side(next_side_pr(reqBorder))]
        while isborder(robot, side)
            if (side == next_side_pr(reqBorder))
                width += 1
            elseif (side == next_side_pr(next_side_pr(reqBorder)))
                height += 1
            elseif (side == reqBorder)
                stepsToBack += 1
            end
            move!(robot, next_side(side))
        end
        move!(robot, side)
    end
    for _ in 1:(height - stepsToBack)
        move!(robot, next_side_pr(moveSide))
    end
    return height * width
end

function master!(robot::Robot)::Integer
    maxSquare = 0
    tempReqSquare = 0
    while !(isborder(robot, Nord))
        for side in [Ost, West]
            while true
                if isborder(robot, side)
                    if try_move!(robot, side)
                        tempReqSquare = square(robot, side)
                        if tempReqSquare > maxSquare 
                            maxSquare = tempReqSquare
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
    return maxSquare
end

master!(originRobot)