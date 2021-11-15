```
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля,
на котором могут находиться также внутренние прямоугольные перегородки 
все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки

РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту,
а две - ту же долготу, что и Робот, стоят маркеры.

```

using HorizonSideRobots
originRobot = Robot(animate = true)
include("AbstractType.jl")
include("functions.jl")



function master(robot::Beta)
    for side in [Nord, Ost, Sud, West]
        while (try_move!(robot, side)) end
        putmarker!(robot.beta)
        get_back!(robot)
    end
end