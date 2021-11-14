using HorizonSideRobots
originRobot = Robot(animate = true)

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


