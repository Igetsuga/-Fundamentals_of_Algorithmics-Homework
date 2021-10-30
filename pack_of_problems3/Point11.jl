```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля,
на котором могут находиться также внутренние прямоугольные перегородки 
все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки

РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту,
а две - ту же долготу, что и Робот, стоят маркеры.

```

using HorizonSideRobots
include("../use.jl")


function move_to_border!(robot::Robot, side::HorizonSide)
    steps = 0
    while (try_move!(r,side))
        steps += 1
        push!(Steps,steps)
        steps = 0
        push!(Sides,Int(side))
    end
    
end

function master!(robot::Robot)::Nothing
    for side in [Nord, Sud, West, Ost]
        move_to_border!(robot,side)
        putmarker!(r)
        move_back!(r,reverse!(Steps),reverse!(Sides))
    end
end