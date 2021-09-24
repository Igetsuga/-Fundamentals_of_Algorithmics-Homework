# стоит избегать использования глобальных переменных

function go_over_the_field(r::Robot)::Nothing
    # Робот в правом нижнем углу
    side = Ost
    counter_gg = nextrow_right(r)
    while !isborder(r,Nord)
        move!(r,side)
        side = inverse(side)
        counter_gg += nextrow_right(r)
    end
end 

function nextrow(r,side)
    if ismarker(r)
        counter+=1
    end
    while !isborder(r,side)
        move!(r,side)
    end
    if ismarker(r)
        counter+=1
    end
end

function nextrow_right(r)::Integer
    counter0 = 0
    if ismarker(r)
        counter+=1
    end
    return counter0
end