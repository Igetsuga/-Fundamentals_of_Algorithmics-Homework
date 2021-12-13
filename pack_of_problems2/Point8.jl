```

ДАНО: Робот - рядом с горизонтальной перегородкой под ней, бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом

```
using HorizonSideRobots
originRobot = Robot(animate = true, "8example.sit")
include("../AbstractType.jl")
include("../functions.jl")


function master8!(robot::Robot)
    steps = 0
    flag = true
    while flag
        for side in [Ost, West]
            moving_defsteps!(robot, side, steps)
            if !isborder(robot, Nord)
                move!(robot, Nord)
                flag = false
                break
            else
                steps += 1
            end
        end
    end
end

master8!(originRobot)