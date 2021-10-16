function anti_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end
# по часовой 
function next_side(side::HorizonSide)
    return anti_side(HorizonSide((Int(side) + 1) % 4))
end

function next_side_pr(side::HorizonSide)
    return HorizonSide((Int(side) + 1) % 4)
end

function move_for!(robot::Robot,side::HorizonSide,steps)
    for step in 1:steps
        move!(robot,side)
    end
end

function try_move!(robot, side)
    steps = 0
    nextside = next_side(side)
    while isborder(robot, side)
        if !isborder(robot, nextside)
            move!(robot, nextside)
            steps += 1
        else
            return false
        end
    end

    move!(robot, side)
    while isborder(robot, anti_side(nextside))
        move!(robot, side)
    end

    move_for!(robot, anti_side(nextside), steps)
    return true
end

