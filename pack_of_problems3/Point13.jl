"""

ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

(Подсказка: решение будет подобно решению задачи 1, если направление премещения Робота задавать кортежами пары значений типа HorizonSide)

"""

function side_inverse(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side)+2)%4)
end

# возвращает Робота в центр креста, после того, как тот нарисовал одну чать креста
function go_back!(r::Robot, counterX::Integer, counterY::Integer, vector::NTuple{2,HorizonSide})::Nothing 
    for j in counterX
        move!(r,side_inverse(vector[1]))
    end
    for k in counterY
        move!(r,side_inverse(vector[2]))
    end
end

#  get_line_of_cross! рисует одну чать креста из центра креста и возвращает робота в центр креста
function get_line_of_cross!(r::Robot, vector::NTuple{2,HorizonSide})::Nothing
    counterX = 0
    counterY = 0
    for side in vector
        counterX = 0
        counterY = 0
        if (!(isborder(r,side)))
            move!(r,side)
            putmarker!(r)
            counterX += 1*(side == Ost || side == West)
            counterY += 1*(side == Nord || side == Sud)
        else
            break
        end
    end
    go_back!(r,counterX,counterY,vector)
end

function master(r::Robot)::Nothing
    for vector in [(West,Sud),(West,Nord),(Ost,Sud),(Ost,Nord)]
        get_line_of_cross!(r,vector)
    end
    putmarker!(r)
end

    

