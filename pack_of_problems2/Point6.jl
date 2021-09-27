# path -- путь, который робот проделал из начальной точки в правую нижнюю
path = []

# movements_in_angle двигает робота из начальной клетки в правую нижнюю.
function move_in_angle!(r::Robot)::Vector(<:Integer)
    
    # добавляется цикл while, который заставляет цикл for работать, пока робот не окажется в углу
    while (not(isborder(r,Sud) and isborder(r,West)))
        for side in [Sud,Ost]
            steps = 0
            while (not(isborder(r,side)))
                move!(r,side)
                steps += 1
            end
            push!(path,steps)
        end 
    end
    return reverse!(path)
end

# perimeteroid! двигает робота по переметру квадрата и проставляет маркеры
function perimeteroid!(r::Robot)::Nothing
    for side in HorizonSide
        while (not(isborder(r,side)))
            putmarker!(r)
            move!(r,side)
        end
    end
end

# moving_back_to_start! возвращает робота в начальную точку из правой нижней
function moving_back_to_start!(r)::Nothing
    for i in lenght(PATH)
        for a in PATH[i]
            move!(r, HorizonSide((i+2)%4))
        end
    end
end

# master! главная функция программы
function master!(r::Robot)::Nothing
    move_in_angle!(r)
    perimeteroid!(r)
    moving_back_to_start!(r)
end