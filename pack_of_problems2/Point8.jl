```

ДАНО: Робот - рядом с горизонтальной перегородкой под ней, бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом

```
using HorizonSideRobots
r = Robot(animate = true)
include("../cheatRobot.jl")

function Point8_master!(r::Robot)
    flag = false
    counter = 1
    if (isborder(r,Nord))
        while (isborder(r,Nord))
            for side in [West,Ost]
                for steps in 1:counter
                    move!(r, side)
                    if !isborder(r, Nord)
                        move!(r,Nord)
                        flag = true
                        break
                    end
                end
                counter += 1
            end
            if flag 
                break
            end
        end
    else
        move!(r,Nord)
        flag = true
    end
end