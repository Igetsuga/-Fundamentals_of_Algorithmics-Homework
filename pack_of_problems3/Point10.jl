```

ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров

РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток

```


using HorizonSideRobots

originRobot = Robot(animate = false, "10example.sit")
mod_CmR = MODcountmarkersRobot(originRobot,0,0)

show!(originRobot)
include("../AbstractType.jl")
include("../functions.jl")

function moveLikeSnake!(robot::MODcountmarkersRobot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
    flag = true
    while flag
        for side in moveSides
            while !(isborder(robot.robot, side))
                move!(robot, side)
            end
            if !(isborder(robot.robot, borderSide))
                move!(robot, borderSide)
            else
                flag = false
            end
        end
    end    
end


# master главная функция программа
function master!(robot::MODcountmarkersRobot)::Real
    moveLikeSnake!(robot, (Nord, Sud), Ost)
    return (robot.temperature / robot.markers)
end

master!(mod_CmR)

