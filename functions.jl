function isangle!(robot)::Bool end 

#------------------------------------------------------------------------------------------------------------------------------#

function anti_side(side::HorizonSide)::HorizonSide end
function next_side(side::HorizonSide)::HorizonSide end
function next_side_pr(side::HorizonSide)::HorizonSide end

#------------------------------------------------------------------------------------------------------------------------------#

function moving_defsteps!(robot, side::HorizonSide, steps::Integer)::Nothing end

#------------------------------------------------------------------------------------------------------------------------------#

function moveToBorder!(robot, side)::Nothing end

#------------------------------------------------------------------------------------------------------------------------------#

function moveLikeSnake!(robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing end

#------------------------------------------------------------------------------------------------------------------------------#

function get_back!(robot, path::Vector{Int}) end

#------------------------------------------------------------------------------------------------------------------------------#

function square(robot, moveSide::HorizonSide)::Integer end
function AverangeTemperature(robot, moveSide::HorizonSide)::Real end

#------------------------------------------------------------------------------------------------------------------------------#

function moving_in_angle!(robot)::Vector{Int} end
function moving_in_angle!(robot, side1::HorizonSide, side2::HorizonSide)::Vector{Int} end
function moving_back_to_start!(robot, back_path::Vector)::Nothing end

#------------------------------------------------------------------------------------------------------------------------------#

function try_move_var2!(robot, side::HorizonSide)::Bool end
function try_move!(robot, side::HorizonSide)::Bool end

#------------------------------------------------------------------------------------------------------------------------------#

ost(side::HorizonSide) = Ost 
west(side::HorizonSide) = West 
sud(side::HorizonSide) = Sud 
nord(side::HorizonSide) = Nord 

#------------------------------------------------------------------------------------------------------------------------------#

function isangle!(robot)::Bool
    if isborder(robot, Nord) || isborder(robot, Sud)
        if isborder(robot, Ost) || isborder(robot, West)
            return true
        else
            return false
        end
    else
        return false
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function anti_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end


# по часовой 
function next_side(side::HorizonSide)::HorizonSide
    return anti_side(HorizonSide((Int(side) + 1) % 4))
end


# против часовой
function next_side_pr(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 1) % 4)
end

#------------------------------------------------------------------------------------------------------------------------------#

function moving_defsteps!(robot, side::HorizonSide, steps::Integer)::Nothing
    for step in 1:steps
        move!(robot, side)
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function moveToBorder!(robot, side)::Nothing
    while (!isborder(robot, side))
        move!(robot, side)
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function moveLikeSnake!(robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
    while !(isborder(robot, borderSide))
        for side in moveSides
            moveToBorder!(robot, side)
            if !(isborder(robot, borderSide))
                move!(robot, borderSide)
            else
                break
            end
        end
    end    
end

#------------------------------------------------------------------------------------------------------------------------------#

function get_back!(robot, path::Vector{Any})
    for i in 1:length(path)
        move!(robot, anti_side(HorizonSide(path[ length(path) - i + 1 ])))
    end
    empty!(path)
end

#------------------------------------------------------------------------------------------------------------------------------#

# вычислит площадь перегородки в направлении движения робота и обойдет её
function square(robot, moveSide::HorizonSide)::Integer
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


function AverangeTemperature(robot, moveSide::HorizonSide)::Real
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
#------------------------------------------------------------------------------------------------------------------------------#

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot)::Vector{Int}
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
function moving_in_angle!(robot, side1::HorizonSide, side2::HorizonSide)::Vector{Int}
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
function moving_back_to_start!(robot, back_path::Vector)::Nothing
    for i in 1:length(back_path)
        move!(robot, anti_side(HorizonSide(back_path[i])))
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

function try_move_var2!(robot, side::HorizonSide)::Bool
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



function try_move!(robot, side::HorizonSide)::Bool

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

