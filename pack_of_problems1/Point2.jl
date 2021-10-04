#=

ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы

=#

# глабальная массив coords, содержащий координаты стартовой клетки Робота
coords = []

# moving_in_angle! передвигает Робота в нижний левый угол
function moving_in_angle!(r::Robot)
    stepsX = 0
    stepsY = 0
    for side in [West,Sud]
        while (isborder(r,side)==false)
            move!(r,side)
            stepsX += 1*(side==West)
            stepsY += 1*(side==Sud)
        end
    end
    push!(coords,stepsX)
    push!(coords,stepsY)
end

# moving_back_to_start! двигает робота из правой нижней клетки в начальную
function moving_back_to_start!(r::Robot,vector::Vector{<:Integer})::Nothing
    for side in [Nord,Ost]
        counter = coords[1]*(side==Nord) + coords[2]*(side==Ost)
        for j in 1:counter
            move!(r,side)
        end
    end
end

# get_line! создаёт линию из маркеров
function get_line!(r::Robot,side::HorizonSide)::Nothing
    while (isborder(side) = false)
        move!(r,side)
        putmarker!(r)
    end
end

# Point2_master! главная функция программы
function Point2_master!(r::Robot)::Nothing
    moving_in_angle!(r)
    for side in [Nord,Ost,Sud,West]
        get_line!(r,side)
    end
end