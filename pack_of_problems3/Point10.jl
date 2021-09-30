function isMark(r::Robot)::Integer
    if (ismarker(r))
        temperature += temperature(r)
        counter += 1
    end
end

function upORdown(r::Robot,side::HorizonSide)::Nothing
    while not(isborder(r,side))
        move!(r)
        isMark(r)
    end

# змейкой проходит все поле и собирает информацию о температуре в клетках
function (r::Robot)::Integer
    while not(isborder(r,Ost))
        if isborder(r,Sud)
            upORdown(r,((side+2)%4))
            
        else
            upORdown(r,((side+2)%4))
        end
        
        
            
end

function master(r::Robot)::Integer
    temperature = 0
    counter = 0
    isMark(r)


