function try_move!(r, side)
    n = 0;
    ort_side = next_side(side)
    while isborder(r, side)
        if !isborder(r, ort_side)
            move!(r, ort_side)
            n+=1
        else
            return false
        endt
    end

    move!(r, side)
    while isborder(r, opposite_side(side))
        move!(r, side)
    end
    move_for!(r, opposite_side(side), n)
    return true
end




abstract type AbstractRobot 
end

import HorizonSideRobots

move!(robot::AbstractRobot, side::HorizonSide) = HorizonSideRobots.move!(get(robot), side)
isborder(robot::AbstractRobot,  side::HorizonSide) = HorizonSideRobots.isborder(get(robot), side)
putmarker!(robot::AbstractRobot) = HorizonSideRobots.putmarker!(get(robot))
ismarker(robot::AbstractRobot) = HorizonSideRobots.ismarker(get(robot))
temperature(robot::AbstractRobot) = HorizonSideRobots.temperature(get(robot))

get(robot::AbstractRobot) = robot

abstract type AbstractBorderRobot<:AbstractRobot
end

#movements! идет до упора и возвращает число шагов или делает заданное число шагов в заданном направлении
movements!(robot::AbstractBorderRobot, side::HorizonSideRobots)
movements!(robot::AbstractBorderRobot, side::HorizonSideRobots, steps::Integer)

function movements!(robot::AbstractBorderRobot,side::HorizonSide)::Integer
    n = 0 
    while try_move!(get(robot),side)
        n += 1
    end
    return n
end
    
function snake(robot::AbstractRobot)::Nothing    # function snake(robot::Union{AbstractRobot,Robot}::Nothing
    side = Ost
    movements!(robot,side)
    while (!isborder(robot,Nord))
        move!(robot, Nord)
        side = anti_side(side)
        movements!(robot,side)
    end
end


struct PutMerkersBorder<:AbstractBorderRobot
    robot::Robot
end

function try_move!(robot::AbstractBorderRobot,side::HorizonSide)
    try_move!(get(robot),side)
    putmarker!(r)
end
function PutMarkersBorder()
    putmarker!(robot)
    new(robot)
end


function mark_field!(robot::Robot)
    robot = PutMarkersBorder
    snake(robot)
end




