"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
"""


# moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
function moving_in_angle!(robot::Robot)
    back_path = []
    while (!(isborder(robot, West)) || !(isborder(robot, Sud)))
        for side in (Sud, West)
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
function moving_back_to_start!(robot::Robot, back_path::Vector)::Nothing
    for (index,value) in enumerate(back_path)
        for step in 1:value
            move!(robot, HorizonSide((((index + 1)% 2) + 3) % 4))
        end
    end
end
# get_lines промаркирует всё поле змейкой
function get_lines!(robot::Robot)
    while (!(isborder(robot,Ost)))
        for side in [Nord,Sud]
            putmarker!(robot)
            while (!(isborder(robot,side)))
                move!(robot, side)
                putmarker!(robot)
            end
            if (!(isborder(robot,Ost)))
                move!(robot,Ost)
            end
        end
    end
end

# Point3_master! главная функция программы
function Point3_master!(robot::Robot)
    # moving_in_angle! передвинет робота в Юго-Западный угол поля и вернёт в переменную back_bath ОБРАТНЫЙ путь робота
    back_path = moving_in_angle!(robot)
    
    putmarker!(robot)
    # get_lines промаркирует всё поле змейкой
    get_lines!(robot)
    
    for side in [Sud,West]
        while (!(isborder(robot,side)))
            move!(robot,side)
        end
    end
    
    # moving_back_to_start! вернёт робота в начальное положение через обратный путь робота
    moving_back_to_start!(robot, back_path)

end