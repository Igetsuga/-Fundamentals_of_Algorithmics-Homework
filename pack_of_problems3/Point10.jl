# isMark определяет жесть ли в клетке маркер
function isMark(r::Robot, temperature::Integer, counter::Integer)::Integer
    if (ismarker(r))
        temperature += temperature
        counter += 1
    end
end

# upORdown идёт до упора вверх в вверх или вниз, проверяет наличие маркера на каждом шагу 
function upORdown(r::Robot,side::HorizonSide)::Nothing
    while not(isborder(r,side))
        move!(r)
        isMark(r)
    end

# змейкой проходит все поле и собирает информацию о температуре в клетках
function tuda_suda(r::Robot)::Integer
        if isborder(r,Sud)
            upORdown(r,((side+2)%4))
        else
            upORdown(r,((side+2)%4))
        end     
end

# master главная функция программа
function master(r::Robot)::Integer
    temperature = 0
    counter = 0
    isMark(r)
    while (not(isborder(r,Ost)))
        tuda_suda(r)
    end
    return (temperature/counter)
end


