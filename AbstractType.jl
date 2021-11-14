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
    if (ismarker(robot))
        robot.counter += 1
    end
end

function master(CmR::CountmarkersRobot)::Integer
    while !(isborder(CmR,Nord))
        move!(CmR, Nord)
    end
    return CmR.counter
end