#=
anti_side
next_side
next_side_pr

moving_defsteps!

move_back!

moving_in_angle!(robot::Robot)
moving_in_angle!(robot::Robot, side1::HorizonSide, side2::HorizonSide)
moving_back_to_start!


try_move_var2!
try_move!

=#
#------------------------------------------------------------------------------------------------------------------------------#

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

#------------------------------------------------------------------------------------------------------------------------------#

function moving_defsteps!(robot::Robot, side::HorizonSide, steps::Integer)::Nothing
    for step in 1:steps
        move!(robot, side)
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function get_back!(robot::Robot, path::Vector{Int})
    for i in 1:length(path)
        move!(robot, anti_side(HorizonSide(path[ length(path) - i + 1 ])))
    end
    empty!(path)
end

#------------------------------------------------------------------------------------------------------------------------------#

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot)::Vector{Int}
    back_path = []
    while (!(isborder(robot, West)) || !(isborder(robot, Sud)))
        for side in (Sud, West)
            while (!(isborder(robot,side)))
                move!(robot,side)
                push!(back_path, Int(side))
            end
        end
    end
    return reverse!(back_path)
end

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot, side1::HorizonSide, side2::HorizonSide)::Vector{Int}
    back_path = []
    while (!(isborder(robot, side1)) || !(isborder(robot, side2)))
        for side in (side1, side2)
            while (!(isborder(robot,side)))
                move!(robot,side)
                push!(back_path, Int(side))
            end
        end
    end
    return reverse!(back_path)
end

# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Robot, back_path::Vector)::Nothing
    for i in 1:length(back_path)
        move!(robot, anti_side(HorizonSide(back_path[i])))
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function try_move_var2!(robot::Robot, side::HorizonSide)::Bool
    steps = 0
    nextside = next_side_pr(side)
    # робот пытается обойти перегодку со стороны противоположной часовой стрелке
    while isborder(robot, side)
        if !isborder(robot, nextside)
            move!(robot, nextside)
            steps += 1
        else
            # если обойти невозможно вернется на исходное место
            for j in 1:steps
                move!(robot, anti_side(nextside))
            end
            # обойти прегородку невозможно
            return false
        end
    end

    # обход перегородки в ширину
    move!(robot, side)
    while isborder(robot, anti_side(nextside))
        move!(robot, side)
    end

    moving_defsteps!(robot, anti_side(nextside), steps)
    move!(robot,side)
    return true
end



function try_move!(robot::Robot, side::HorizonSide)::Bool

    # если перед роботом есть перегородка, он начнет выполнять действия, чтобы попытаться её обойти, иначе просто пройдет в заданном направлении
    if isborder(robot,side)
        flag_nextside = true
        steps = 0
        nextside = next_side(side)
        # сначала робот пытается обойти перегородку со строны, которая следует за заданной по часовой стрелке
        while isborder(robot, side)
            if !isborder(robot, nextside)
                move!(robot, nextside)
                steps += 1
            else
                # срабатывает, когда робот уперся в угол. Он возвращается в то место, с которого начал попытку обойти по часовой стороне
                for j in 1:steps
                    move!(robot, anti_side(nextside))
                end

                flag_nextside = false

                # робот попытается обойти перегородку со сторны противоположной часовой стрелке
                return try_move_var2!(robot,side)
            end
        end

        # если у робота получилось обойти перегородку с первого раза, будет выполнено слудущее:
        if (flag_nextside) 
            move!(robot, side)
            while isborder(robot, anti_side(nextside))
                move!(robot, side)
            end
            moving_defsteps!(robot, anti_side(nextside), steps)

            return true
        end
    else

        # перегородки не было, робот прошел в заданном направлении
        move!(robot,side)
        return true
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

