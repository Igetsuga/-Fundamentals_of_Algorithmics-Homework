path = []
# movements_in_angle двигает робота из начальной клетки в левую нижнюю с ставит в ней маркер
function move_in_angle!(r::Robot)::Vector(<:Integer)
    for side in [Sud,West]
        steps = 0
        while (not(isborder(r,side)))
            move!(r,side)
            steps += 1
        end
        push!(path,steps)
    end 
    putmarker!(r)
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
# x содержит длинну поля
function steps_x!(r::Robot)::Integer
        steps = 0
        while not(isborder(r,Ost))
            move!(r,Ost)
            steps +=1
        end
        for i in steps
            move!(r,West)
        end
        x = steps
    return x 
end
# marktaker_3000! рисует горизонтальные маркированные линии
function marktaker_3000!(r::Robot)::Nothing
    while (not(isborder(r,Nord)))
        for j in x:1
            move!(r,Ost)
            putmarker!(r)
        end
    end
end
# главная функция программы
function master!(r::Robot)::Nothing
    move_in_angle!(r)
    steps_x!(r)
    marktaker_3000!(r)
    moving_back_to_start!(r)
end
