global Steps = []
global Sides = []

function move_back!(robot::Robot, Steps::Vector, Sides::Vector)
    for i in 1:length(Steps)
        for step in 1:Steps[i]
            move!(robot,anti_side(HorizonSide(Sides[i])))
        end
    end
    empty!(Steps)
    empty!(Sides)
end

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
function move_steps!(robot,side::HorizonSide,steps)
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

    move_steps!(robot, anti_side(nextside), steps)
    move!(r,side)
    return true
end
# -----------------------------------------------------------------------------------------------------
function try_move!(robot, side)
    if isborder(r,side)
        flag_nextside = true
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

                flag_nextside = false

                return try_move_var2!(r,side)
            end
        end
        if (flag_nextside) 
            move!(robot, side)
            while isborder(robot, anti_side(nextside))
                move!(robot, side)
            end
            move_steps!(robot, anti_side(nextside), steps)

            return true
        end
    else
        move!(r,side)

        return true
    end
end
