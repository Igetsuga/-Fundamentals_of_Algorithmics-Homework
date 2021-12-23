```

На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток, 
начиная с юго-западного угла поля, когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля
n - это параметр функции. Начальное положение Робота - произвольное, конечное - совпадает с начальным.
Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток.


```

using HorizonSideRobots
include("../AbstractType.jl")
include("../functions.jl")
originRobot = Robot(10,10,animate = true)
coordsRobot = CoordsRobot(originRobot, 0, 0)





#------------------------------------------------------------------------------------------------------------------------------#



function master12!(robot, data)::Nothing
    back_path = moving_in_angle!(robot)

    function mod_putmarker!(robot::CoordsRobot, data)
        x = robot.x
        y = robot.y
        if x in (0 : data - 1) && y in (0 : data - 1) || x in (data : 2 * data- 1) && y in (data : 2 * data- 1)
            putmarker!(robot.coordsrobot)
        end
    end

    function moveToBorder!(robot, side)::Nothing
        while (!isborder(robot, side))
            move!(robot, side)
            println(robot.x, robot.y)
            mod_putmarker!(robot, data)
        end
    end

    function moveLikeSnake!(robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
        isborderSide = false
        while !(isborderSide)
            for side in moveSides
                moveToBorder!(robot, side)
                if !(isborderSide(robot, borderSide))
                    move!(robot, borderSide)
                    mod_putmarker!(robot, data)
                else
                    isborderSide = true
                    break
                end
            end
        end    
    end
                                          
    moveLikeSnake!(robot, (Nord, Sud), Ost)

    moving_in_angle!(robot)
    moving_back_to_start!(robot, back_path)
end

master12!(coordsRobot, 2)
