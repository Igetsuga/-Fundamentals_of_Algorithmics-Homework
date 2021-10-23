#struct CheatRobot
#    robot::Robot
    
function anti_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end
# по часовой 
function next_side(side::HorizonSide)
    return anti_side(HorizonSide((Int(side) + 1) % 4))
end
# против часовой
function next_side_pr(side::HorizonSide)
    return HorizonSide((Int(side) + 1) % 4)
end
# -----------------------------------------------------------------------------------------------------
function move_for!(robot,side::HorizonSide,steps)
    for step in 1:steps
        move!(robot,side)
    end
end
# -----------------------------------------------------------------------------------------------------
function try_move_var2!(robot, side)
    steps = 0
    nextside = next_side_pr(side)
    while isborder(robot, side)
        if !isborder(robot, nextside)
            move!(robot, nextside)
            steps += 1
        else
            for j in 1:steps
                move!(robot, anti_side(nextside))
            end
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
# -----------------------------------------------------------------------------------------------------
function try_move!(robot, side)
    flag = true
    steps = 0
    nextside = next_side(side)
    while isborder(robot, side)
        if !isborder(robot, nextside)
            move!(robot, nextside)
            steps += 1
        else
            for j in 1:steps
                move!(robot, anti_side(nextside))
            end
            flag = false
            try_move_var2!(r,side)
        end
    end
    if (flag) 
        move!(robot, side)
        while isborder(robot, anti_side(nextside))
            move!(robot, side)
        end

        move_for!(robot, anti_side(nextside), steps)
        return true
    end
end
# -----------------------------------------------------------------------------------------------------
# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot)
    back_path = []
    while (!(isborder(robot, West)) || !(isborder(robot, Sud)))
        for side in (Sud, West)
            steps = 0
            while (!(isborder(robot,side)))
                move!(robot,side)
                steps += 1
            end
            push!(back_path, steps)
        end
    end
    return reverse!(back_path)
end
# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Robot, back_path::Vector)
    for (index,value) in enumerate(back_path)
        for step in 1:value
            move!(robot, HorizonSide((((index + 1)% 2) + 3) % 4))
        end
    end
end
# -----------------------------------------------------------------------------------------------------
#    CheatRobot = new(Robot)
#end



