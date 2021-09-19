# path массив, который содержит путь робота из начальной в угловую точку
path = []
# робот пытается обойти препятствие
function try_to_get_around!(r::Robor)::Integer
    for side in ()
end
# при неудачной попытке робота обойти препятствие возвращает его назад на steps шагов
function get_back(r::Robot,side::HorizonSide,steps::Integer)::Nothing
    for i in steps
        move!(r,HorizonSide((Int(side)+2)%4))
    end
end