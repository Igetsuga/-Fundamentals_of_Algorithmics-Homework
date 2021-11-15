```
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля c внутреннеми перегородоками.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
Рассмотреть отдельно еще случай, когда изначально в некоторых клетках поля могут находиться маркеры.
```

```
Если на поле будут стоять маркеры, то они не повлияют на ход программы. Иначе можно было бы добавить проверку
на наличие маркера в клетке, стоящей на пути Робота.

```

#using HorizonSideRobots
#originRobot = Robot(animate = true)
include("../AbstractType.jl")
include("../functions.jl")

function master!(robot::Beta)
    for side in [Nord, Ost, Sud, West]
        while (try_move!(robot, side)) 
            putmarker!(robot.beta)
        end
        putmarker!(robot.beta)
        get_back!(robot)
    end
    putmarker!(robot.beta)
end


