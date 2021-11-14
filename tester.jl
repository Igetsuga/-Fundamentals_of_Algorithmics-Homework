include("AbstractType.jl")
include("functions.jl")


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

function master(robot::Beta)
    while !ismarker(robot.beta)

        try_move!(robot, Nord)
    end
    get_back!(robot)
end

