"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
"""
flag = true

function anti_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end

# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot, sides)::Vector{<:Integer}
    back_path = []
    while (!(isborder(robot, sides[1])) && !(isborder(robot, sides[2])))
        for side in [sides[1],sides[2]]
            steps = 0
            while (not(isborder(robot,side)))
                move!(robot,side)
                steps += 1
            end
            push!(back_path, steps)
        end
        if (isborder(robot,sides[1] && isborder[robot,sides[2]]))
            if (side == sides[1])
                flag = true
            else
                flag = false
            end
        end
    end
    return reverse!(back_path)
end

# moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
function moving_back_to_start!(robot::Robot, sides, back_path::Vector{<:Integer})::Nothing
    if (flag)
        for (index,value) in enumerate(back_path)
            for step in value
                if (index % 2 == 1)
                    move!(robot, anti_side(sides[1]))
                else
                    move!(robot, anti_side(sides[2]))
                end
            end
        end
    else
        for (index,value) in enumerate(back_path)
            for step in value
                if (index % 2 == 1)
                    move!(robot, anti_side(sides[2]))
                else
                    move!(robot, anti_side(sides[1]))
                end
            end
        end
    end
    flag = true
end

function Point5_master!(robot::Robot)::Nothing
    for sides in [(West,Sud), (West,Nord), (Ost,Sud), (Ost,Nord)]
        back_path = moving_in_angle!(robot,sides)
        moving_back_to_start!(robot,sides,back_path)
    end
end
