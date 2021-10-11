
# ------------------------------------------------------------------------------------------------------------------------------------------------
struct BackPath

    sides::NTuple{2,HorizonSide}
    path::Vector{Int}

end
function BackPath(robot::Robot, sides::NTuple{2,HorizonSide}=(Sud,West))
    local path=Int[]
    while ( not(isborder(robot,sides[1])) || not(isborder(robot,sides[2])) )
        for side in sides 
            push!(path, movements!(robot,side))
        end
    end
    return new(reverse(inverse.(sides)),path)
end
# ------------------------------------------------------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------------------------------------------------------
function moving_back_to_start!(robot::Robot, vector::BackPath)
    i = 1
    for n in vector.path # n -- количество шагов робота в одном направлении
        movements!(robot, vector.sides[i])
        i = i % 2 + 1
    end
end
# ------------------------------------------------------------------------------------------------------------------------------------------------


back_bath = BackPath(r) # переносит робота в юго-западный угол. Возвращает массив с reverse путем, который робот проделал для того, чтобы оказаться в юго-заподном углу.
moving_back_to_start!(r, back_path) # возвращает робота из юго-заподного угла в начальное проложение