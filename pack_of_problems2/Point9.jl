```

ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. 
Робот - в произвольной клетке поля.

РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

```
using HorizonSideRobots
r = Robot(animate = true)
include("../cheatRobot.jl")

# будем ходить кругом, пока не найжем этот маркер.
# 1 Вниз, 2 Вправо, 2 Вверх, 3 Влево, 3 Вниз, 4 Вправо, 4 Вверх и тд.
function Point9_master!(r::Robot)
    flag = false
    steps = 0
    if (ismarker(r))
        return true
    else 
        while !ismarker(r)
            for side in [Ost, Nord, West, Sud]
                steps += 1*(side==Ost || side==West)
                for step in 1:steps
                    move!(r,side)
                    if (ismarker(r))
                        return true
                    end
                end
            end
        end
    end
end
    


