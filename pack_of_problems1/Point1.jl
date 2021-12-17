
```
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.

Рассмотреть отдельно еще случай, когда изначально в некоторых клетках поля могут находиться маркеры.
```

```
Если на поле будут стоять маркеры, то они не повлияют на ход программы. Иначе можно было бы добавить проверку
на наличие маркера в клетке, стоящей на пути Робота.
```

using HorizonSideRobots
originRobot = Robot(animate = true, "1example.sit")

# get_line! создаёт линию из маркеров в заданном направлении и возвращает Робота в исходное положение
function get_line!(robot, side)::Nothing
    steps = 0
    while ((isborder(robot,side))==false)
        move!(robot,side)
        putmarker!(robot)
        steps += 1
    end
    for j in 1:steps 
        move!(robot, HorizonSide((Int(side)+2)%4))
    end
end

# Point1_master! главная функция программы
function Point1_master!(robot::Robot)::Nothing
    for side in [Nord, Ost, Sud, West]
        get_line!(robot, side)
    end
    putmarker!(robot)
end

Point1_master!(originRobot)