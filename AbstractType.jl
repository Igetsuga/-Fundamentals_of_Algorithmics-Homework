

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
    



