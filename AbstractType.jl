

#------------------------------------------------------------------------------------------------------------------------------#

abstract type AbstractRobot end

import HorizonSideRobots: move!, isborder, putmarker!, ismarker, temperature

get(robot::AbstractRobot) = robot::Robot

move!(robot::AbstractRobot, side) = move!(get(robot), side)
isborder(robot::AbstractRobot, side) = isborder(get(robot), side)
putmarker!(robot::AbstractRobot) = putmarker!(get(robot))
ismarker(robot::AbstractRobot) = ismarker(get(robot))
temperature(robot::AbstractRobot) = temperature(get(robot))

#------------------------------------------------------------------------------------------------------------------------------#

mutable struct CountmarkersRobot <: AbstractRobot
    CmR::Robot
    counter::Integer
end

CmR = CountmarkersRobot(originRobot,0)

get(robot::CountmarkersRobot) = robot.CmR

function move!(robot::CountmarkersRobot, side::HorizonSide)
    move!(robot.CmR, side) # move!(get(CmR), side)
    if (ismarker(robot.CmR))
        robot.counter += 1
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

mutable struct CoordsRobot <: AbstractRobot
    coordsrobot::Robot
    x::Int
    y::Int
end

coordsrobot = CoordsRobot(originRobot, 0, 0)

get(robot::CoordsRobot) = robot.coordsrobot

function move!(robot::CoordsRobot, side::HorizonSide)
    if side == Nord
        robot.y += 1
    elseif side == Sud
        robot.y -= 1
    elseif side == Ost
        robot.x += 1
    else 
        robot.x -= 1
    end
    move!(robot.coordsrobot, side)
end

get_coords(robot::CoordsRobot) = (robot.x , robot.y)

#------------------------------------------------------------------------------------------------------------------------------#

mutable struct Beta <: AbstractRobot
    beta::Robot
    path::Vector
end

beta = Beta(originRobot, [])

get(robot::Beta) = robot.beta


function move!(robot::Beta, side::HorizonSide)
    push!(robot.path, Int(side))
    move!(robot.beta, side)
end

function get_back!(robot::Beta)
    for i in 1:length(robot.path)
        move!(robot.beta, anti_side(HorizonSide(robot.path[ length(robot.path) - i + 1 ])))
    end
    empty!(robot.path)
end

function try_move!(robot::Beta, side::HorizonSide)::Bool

    # если перед роботом есть перегородка, он начнет выполнять действия, чтобы попытаться её обойти, иначе просто пройдет в заданном направлении
    if isborder(robot.beta, side)
        steps = 0
        nextside = next_side(side)
        # робот пытается обойти перегородку со строны, которая следует за заданной по часовой стрелке
        while isborder(robot.beta, side)
            if !isborder(robot.beta, nextside)
                move!(robot, nextside)
                steps += 1
            else
                # срабатывает, когда робот уперся в угол. Он возвращается в то место, с которого начал попытку обойти по часовой стороне
                for j in 1:steps
                    move!(robot, anti_side(nextside))
                end
                return false
            end
        end

        # если у робота получилось обойти перегородку с первого раза, будет выполнено слудущее:
        move!(robot, side)
        while isborder(robot.beta, anti_side(nextside))
            move!(robot, side)
        end

        for j in 1:steps
            move!(robot, anti_side(nextside))
        end
        return true
        
    else
        # перегородки не было, робот прошел в заданном направлении
        move!(robot, side)
        return true
    end
end

#------------------------------------------------------------------------------------------------------------------------------#
    
mutable struct Gamma <: AbstractRobot
    gamma::Robot
end

gamma = Gamma(originRobot)

get(robot::Gamma) = robot.gamma




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

function move!(robot::Gamma, side::HorizonSide)
    # если перед роботом есть перегородка, он начнет выполнять действия, чтобы попытаться её обойти, иначе просто пройдет в заданном направлении
    if isborder(robot.gamma, side)
        flag_nextside = true
        steps = 0
        nextside = next_side(side)
        # сначала робот пытается обойти перегородку со строны, которая следует за заданной по часовой стрелке
        while isborder(robot.gamma, side)
            if !isborder(robot.gamma, nextside)
                move!(robot.gamma, nextside)
                steps += 1
            else
                # срабатывает, когда робот уперся в угол. Он возвращается в то место, с которого начал попытку обойти по часовой стороне
                for j in 1:steps
                    move!(robot.gamma, anti_side(nextside))
                end

                flag_nextside = false

                # робот попытается обойти перегородку со сторны противоположной часовой стрелке
                return try_move_var2!(robot.gamma, side)
            end
        end

        # если у робота получилось обойти перегородку с первого раза, будет выполнено слудущее:
        if (flag_nextside) 
            move!(robot.gamma, side)
            while isborder(robot.gamma, anti_side(nextside))
                move!(robot.gamma, side)
            end
            moving_defsteps!(robot.gamma, anti_side(nextside), steps)

            return true
        end
    else

        # перегородки не было, робот прошел в заданном направлении
        move!(robot.gamma,side)
        return true
    end
end
    
# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Gamma)::Vector{Int}
    back_path = []
    while (!(isborder(robot.gamma, West)) || !(isborder(robot.gamma, Sud)))
        for side in (Sud, West)
            while (!(isborder(robot.gamma,side)))
                move!(robot,side)
                push!(back_path, Int(side))
            end
        end
    end
    return reverse!(back_path)
end

# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Gamma, back_path::Vector)::Nothing
    for i in 1:length(back_path)
        move!(robot, anti_side(HorizonSide(back_path[i])))
    end
end

#------------------------------------------------------------------------------------------------------------------------------#

