```

ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. 
Робот - в произвольной клетке поля.

РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

```
using HorizonSideRobots
originRobot = Robot(animate = true, "9example.sit")

# будем ходить кругом, пока не найжем этот маркер.
# 1 Вниз, 2 Вправо, 2 Вверх, 3 Влево, 3 Вниз, 4 Вправо, 4 Вверх и тд.
function master9!(robot::Robot)
    flag = false
    steps = 0
    if (ismarker(robot))
        return true
    else 
        while !ismarker(robot)
            for side in [Ost, Nord, West, Sud]
                steps += 1*(side == Ost || side == West)
                for step in 1:steps
                    move!(robot,side)
                    if (ismarker(robot))
                        return true
                    end
                end
            end
        end
    end
end

master9!(originRobot)