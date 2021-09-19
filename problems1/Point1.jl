function get_line!(side::HorizonSide)::Nothing
    steps = 0
    while (not(isborder(r,side)))
        putmarker!(r)
        move!(r,side)
        step += 1
    end
    for j in steps 
        move!(r,HorizonSide((Int(side)+2)%4))
    end
end

function Point1_master!(r::Robot)::Nothing
    for side in HorizonSide
        get_line!(side)
    end
end
