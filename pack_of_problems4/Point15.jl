```

ДАНО: Робот - в произвольной клетке поля 

РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы

```

```

1. Предлагаю сделать нового робота у которого функция move! = try_move!. Т.е. каждым шагом он будет пытаться обойти что-то.
2. Я не помню как объявлять функцию заранее для try_move_var2!
UPD. 1. оказалость не нужным
UPD. Для кошмарных внутренних перегородок можно юзать робота Beta и его функцию get_back!, а для
обхода периметра robota.beta = originRobot 

```

include("../AbstractType.jl")
include("../functions.jl")




function master(robot::Robot)
    back_path = moving_in_angle!(robot)
    putmarker!(robot)
    for side in [Nord, Ost, Sud, West]
        flag = true
        while (flag)
            if !(isborder(robot, side))
                move!(robot, side)
                putmarker!(robot)
            else
                if (try_move!(robot, side))
                    putmarker!(robot)
                else
                    flag = false
                end
            end
        end
    end
    moving_back_to_start!(robot, back_path)    
end




