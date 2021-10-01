

# movements_in_angle! двигает робота из начальной клетки в правую нижнюю.
function move_in_angle!(r::Robot)
    path=[]
    while (isborder(r,West) && isborder(r,Sud))
        for side in [Sud,Ost]
            steps = 0
            while (not(isborder(r,side)))
                move!(r,side)
                steps += 1
            end
            push!(path,steps)
        end 
        reverse!(path)
        return path
    end
end

# moving_back_to_start! вернет робота в начальную клетку.
function move_back_to_start!(r::Robot, path::Vector)::Nothing
    for i in lenght(path)
        for a in path[i]
            move!(r,HorizonSide((i+2)%4))
        end
    end
end

function master!(r::Robot)
    path = move_in_angle!(r)
    putmarker!(r)
    move_back_to_start!(r,path)
end