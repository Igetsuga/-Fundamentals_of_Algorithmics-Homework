# path -- путь, который робот проделал из начальной точки в правую нижнюю
path = []
# movements_in_angle двигает робота из начальной клетки в правую нижнюю.
function move_in_angle_1!(r::Robot)::Vector(<:Integer)
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
# moving_back_to_start! возвращает робота в начальную точку из правой нижней
function moving_back_to_start!(r::Robot)::Nothing
    for i in lenght(PATH)
        for a in PATH[i]
            move!(r, HorizonSide((i+2)%4))
        end
    end
end
# markeroid_2000! маркерует все клетки поля
function markeroid_2000!(r::Robot)::Nothing
    while (not(isborder(r,Wets)))
        for side in [Nord,Sud]
            while (not(isborder(r,side)))
                putmarker!(r)
                move!(r,side)
            end
        end
        move!(r,West)
    end
end
# возвращает робота в правую нижнюю клетку из левой нижней
function move_in_angle_2!(r::Robot)::Nothing
    while (not(isborder(r,Ost)))
        move!(r,Ost)
    end
end
# главная функция программы
function master!(r::Robot)::Nothing
    move_in_angle!(r)
    markeroid_2000!(r)
    move_in_angle_2!(r)
    moving_back_to_start!(r)
end