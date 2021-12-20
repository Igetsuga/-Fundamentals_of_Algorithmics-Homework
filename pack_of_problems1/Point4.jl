"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, 
за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
"""

using HorizonSideRobots
originRobot = Robot(animate = true)
include("../functions.jl")

# get_back_smpl возвращает робота к стене обратно заданному направлению, если на пути нет перегородок
get_back_smpl!(robot::Robot,side::HorizonSide)::Nothing
    while (!(isborder(robot,side)))
        move!(robot,side)
    end
end

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
#=
function moving_in_angle!(robot::Robot)::Vector{<:Integer}
    back_path = []
    while (not(isborder(robot, West)) and not(isborder(robot, Sud)))
        for side in [Sud, Ost]
            steps = 0
            while (not(isborder(robot,side)))
                move!(robot,side)
                steps += 1
            end
            push!(back_path, steps)
        end
    end
    return reverse!(back_path)
end
# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Robot, back_path::Vector{<:Integer})::Nothing
    for (index,value) in enumerate(back_path)
        for step in value
            move!(robot, HorizonSide((index + 1) % 2))
        end
    end
end
=#

# get_horizontal_lines промаркирует необходимые клетки
function get_horizontal_lines!(robot::Robot)::Nothing
    steps = 0
    putmarker!(robot)
    while (not(isborder(robot, West)))
        move!(robot,West)
        putmarker!(robot)
        steps += 1
    end
    get_back_smpl!(robot,side)
    steps -= 1

    while (not(isborder(robot,Nord)) and steps > 1)
        move!(r,Nord)
        putmarker!(robot)
        for step in steps 
            move!(robot, West)
            putmarker!(robot)
        end
        steps -= 1
    end
end

# Point4_master! 
function master4!(r::Robot)::Nothing
    back_bath = moving_in_angle!(robot)
    putmarker!(robot)
    
    get_horizontal_lines!(robot)
    
    for side in [Sud,West]
        while (not(isboerder(robot,side)))
            move!(robot,side)
        end
    end
    
    # moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
    moving_back_to_start!(robot, back_path)
end

steps = 0
while !isborder(robot, moveSide)
    move!(robot, moveSide)
    steps += 1
    putmarker!(robot)
end
get_back_smpl!(robot, anti_side(moveSide))
if !isborder(robot, upSide)
    move!(robot, upSide)
else
    break
end
isborder = false
while !isborder && steps > 0
    steps -= 1
    putmarker!(robot)
    for _ in 1:steps
        move!(robot, moveSide)
        putmarker!(robot)
    end
    get_back_smpl!(robot, anti_side(moveSide))
    if !isborder(robot, upSide)
        move!(robot, upSide)
    else
        isborder = true
        break
    end
end


    

        