function get_line!(r::Robot, side::HorizonSide)::Nothing
    steps = 0
    while (not(isborder(r,side)))
        move!(r,side)
        putmarker!(r)
        steps += 1
    end
    for i in steps
        move!(r,HorizonSide(((Int(side)+2)%4)))
    end
    steps = 0
end

function where_would_u_like_to_start(x::Integer,y::Integer)::Nothing
    for i in x
        move!(r, Ost)
    end
    for j in y
        move!(r,Nord)
    end
end

function master(r::Robot)::Nothing

    where_would_u_like_to_start(5,6)
    
    for side in HorizonSide
        get_line!(r,side)
    end
    putmarker!(r)
end