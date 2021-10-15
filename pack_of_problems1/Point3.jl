```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
```

using HorizonSideRobots
# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
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
function moving_back_to_start!(robor::Robot, back_path::Vector{<:Integer})::Nothing
    for (index,value) in enumerate(back_path)
        for step in value
            move!(robor, HorizonSide((index + 1) % 2))
        end
    end
end
# get_lines промаркирует всё поле змейкой
function get_lines!(robot::Robot)::Nothing
    while (not(isborder(robot,West)))
        for side in [Nord,Sud]
            putmarker!(robot)
            while (not(isborder(robot,side)))
                move!(robot, side)
                putmarker!(robot)
            end
            if (not(isborder(robot,West)))
                move!(robot,West)
            end
        end
    end
end

# Point3_master! главная функция программы
function Point3_master!(robot::Robot)::Nothing
    # moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
    back_bath = moving_in_angle!(robot)
    putmarker!(robot)
    # get_lines промаркирует всё поле змейкой
    get_lines!(robot)
    # moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
    moving_back_to_start!(robot, back_path)

end