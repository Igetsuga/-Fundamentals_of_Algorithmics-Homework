function movements_in_angle!(r::Robot, side::HorizonSide, massive::Vector{<:Integer})::Nothing
    while isborder!(r,side) == false
        move!(r, side)
        massive[HorizonSide(side)+1] +=1
    end
end

PATH = []
path = [0,0]

function pathXY(r)::Vector{<:Integer}
    for i in 0:3
        while 
end

function movements!(r::Robot)::Vector{<:Integer}
    while not(isborder(r,Sud) && isborder(r,West)) 
        for side in (Sud, West)
            steps = 0
            while not(isborder(r,side))
                move!(r,side)
                steps += 1
            end
            push!(PATH,steps) 
        end
    end
    return revers!(PATH)
end

function pathXY(massive::Vector{<:Integer})

end

function back_in_start!(r::Robot)::Nothing
    for i in lenght(PATH)
        for a in PATH[i]
            move!(r, HorizonSide(i%2)) 
        end
    end
end

function go_by_border!(r::Robot, side::HorizonSide, massive::Vector{<:Integer})::Nothing
    for steps in massive[abs( (HorizonSide(side)+3) - (HorisinSide(side)+1) )]
        move!(r,side)
        massive[HorisinSide(side)+3] += 1
        putmarker!(r)
        while (isborder(side) == false)
            move!(side)
            massive[HorisinSide(side)+3] += 1
        end
    end  
end

function master_function(r::Robot)
    
    movements!(r)

    for sides in HorizonSide
        go_by_border!(r,sides, path)
    end

    back_in_start!(r)
end

# создание массива path = Int[]
# добавить элемент в массив push!(path, то что добавляем)
# reverse(path) или reverse!(path)
# movements!(r, num::Integer, side::HorizonSide)
# function f(a::Vector\Matrix\Array{<:Integer})