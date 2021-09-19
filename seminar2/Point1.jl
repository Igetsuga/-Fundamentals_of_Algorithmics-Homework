# PATH это массив, который хранит путь из левой нижней клетки в начальную.
PATH = []
# path(x,y) это массив, который хранит начальные коррдинаты робота.  
path = [0, 0]

# movements_in_angle двигает робота из начальной клетки в левую нижнюю.
function moving_in_angle!(r)::Vector{<:Integer}
    while not(isborder(r,Sud) && isborder(r,West)) 
        for side in (West, Sud)
            steps = 0
            while not(isborder(r,side))
                move!(r,side)
                steps += 1
            push!(PATH, steps)
        end
    end
    return reverse!(PATH)
end

# pathXY складывает все соответсвтеные координаты пути, записанного в PATH и получает начальные координаты робота.
function pathXY()::Vector{<:Integer}
    for i in lenght(PATH)
        path[2 - (i%2)] += PATH[i]*(i%2==0) + PATH[i]*(i%2!=0) 
    end
end

# moving_back_to_start двигает робота из нижней левой клетки в начальную по обратному пути из массива PATH
function moving_back_to_start!(r)::Nothing
    for i in lenght(PATH)
        for a in PATH[i]
            move!(r, HorizonSide((i+2)%4))
        end
    end
end

# tuda_suda делает туда-сюда
function tuda_suda(side)::Integer
    steps = 0
    while not(isborder(side))
        move!(r,side)
        steps += 1
    while not(ismarked(HorizonSide((Int(side)+2)%4))
        move!(r,HorizonSide((Int(side)+2)%4))
    return steps
end

# moving_around двигает робота по внутренним сторанам квадрата
function moving_around!(r)::Nothing
    steps_to_marker = [0,0]

    for steps in path[2]
        move!(r,Nord)
        steps_to_marker[1] += 1 
    end
    putmarker!(r)
    while (not(isborder(Nord)))
        move!(r,Nord)
    end

    for steps in path[1]
        move!(r,Ost)
        steps_to_marker[2] += 1 
    end
    putmarker!(r)
    while (not(isborder(Ost)))
        move!(r,Ost)
    end   

    for steps in steps_to_marker[1]
        move!(r,Sud)
    end
    putmarker!(r)
    while (not(isborder(Sud)))
        move!(r,Sud)
    end 

    for steps in steps_to_marker[2]
        move!(r,West) 
    end
    putmarker!(r)
    while (not(isborder(West)))
        move!(r,West)
    end 
end
# master! главная функция программы
function master(r)::Nothing
    moving_in_angle!(r)
    moving_around!(r)
    moving_back_to_start!(r)
end
