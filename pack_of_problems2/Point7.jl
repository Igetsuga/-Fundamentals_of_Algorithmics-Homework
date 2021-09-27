# ставим маркер в начальной точке робота.
putmarker!(r)

# path -- путь, который робот проделал из начальной точки в правую нижнюю.
path = []
# movements_in_angle! двигает робота из начальной клетки в правую нижнюю.
function move_in_angle!(r::Robot)::Vector(<:Integer)
    for side in [Sud,Ost]
        steps = 0
        while (not(isborder(r,side)))
            move!(r,side)
            steps += 1
        end
        push!(path,steps)
    end 
    return reverse!(path)
end

# глобальная переменная counter, чтобы всем функция она была видна и доступна для изменения.
counter = 0

# markerovshik! ставит маркер под роботом на каждом четном шагу.
function markerovshik!(r::Robot, side::HorizonSide, counter::Integer)::Nothing
    while (not(isborder(r,side)))
        if (counter%2==0)
            putmarker!(r)
        end
        move!(side)
        counter += 1
    end
end

# Go_right_down! вернет робота в правую нижнюю клетку
function Go_right_down!(r::Robot)::Nothing
    for side in [West,Sud]
        while (not(isborder(r,side)))
            move!(r)
        end
    end
end

# moving_back_to_start! возвращает робота в начальную точку из правой нижней.
function moving_back_to_start!(r, path::Vector)::Nothing
    for i in lenght(path)
        for a in path[i]
            move!(r, HorizonSide((i+2)%4))
        end
    end
end

# master! главная функция программы.
function master!(r::Robot)::Nothing
    move_in_angle!(r)
    while (not(isborder(r,Ost)))
        for side in [Nord,Sud]
            while (not(isborder(r,side)))
                markerovshik!(r,side,counter)
            end
            move!(r,Ost)
            counter+=1
        end
    end
    Go_right_down!(r)
    moving_back_to_start!(r, path)
end 
