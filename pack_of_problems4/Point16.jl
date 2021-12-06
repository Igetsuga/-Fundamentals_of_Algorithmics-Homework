"""
Все клеткт поля должны быть промаркерованы
"""

using HorizonSideRobots
originRobot = Robot(animate = false, "23example.sit")
include("../AbstractType.jl")
include("../functions.jl")

function mod_moveLikeSnake!(robot::Robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
    flag = true
    while flag
        for side in moveSides
            while try_move!(robot, side) 
                putmarker!(robot)
            end
            if !(isborder(robot, borderSide))
                move!(robot, borderSide)
                putmarker!(robot)
            else
                flag = false
            end
        end
    end    
end

function master!(robot)::Nothing
    backPath = moving_in_angle!(robot, West, Sud)

    putmarker!(robot)

    mod_moveLikeSnake!(robot, (Ost, West), Nord)

    moving_in_angle!(robot, West, Sud)

    moving_back_to_start!(robot, backPath)
end

master!(originRobot)
show!(originRobot)
