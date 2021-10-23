"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
"""


using HorizonSideRobots
r = Robot(animate=true)
include("../cheatRobot.jl")

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot, sides)
    back_path = []
    while (!(isborder(robot, sides[1])) || !(isborder(robot, sides[2])))
        for side in (sides[1], sides[2])
            steps = 0
            while (!(isborder(robot,side)))
                move!(robot,side)
                steps += 1
            end
            push!(back_path, steps)
        end
    end
    return reverse!(back_path)
end

# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Robot,sides,back_path::Vector)
    for (index,value) in enumerate(back_path)
        if (index % 2 == 1)
            for step in 1:value
                move!(robot, anti_side(sides[2]))
            end
        else
            for step in 1:value
                move!(robot, anti_side(sides[1]))
            end 
        end
    end
end

function Point5_master!(robot::Robot)::Nothing
    for sides in [(West,Sud), (West,Nord), (Ost,Sud), (Ost,Nord)]
        back_path = moving_in_angle!(robot,sides)
        putmarker!(robot)
        moving_back_to_start!(robot,sides,back_path)
    end
end
