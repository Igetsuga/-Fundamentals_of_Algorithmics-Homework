```
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника.
Робот - в произвольной клетке поля между внешней и внутренней перегородками. 

РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
```

using HorizonSideRobots
originRobot = Robot(animate = true, "6example.sit")
include("../AbstractType.jl")
include("../functions.jl")



function test1(robot::Robot, borderSide::HorizonSide)
    height = 0
    width = 0
    stepsToBack = 0
    reqBorder = borderSide
    # можно было через while сделать: задать итератор = 4, и при каждом проходе по циклу менять значение side на next_side_pr(side)
    for side in [reqBorder, next_side_pr(reqBorder), next_side_pr(next_side_pr(reqBorder)), anti_side(next_side_pr(reqBorder))]
        while isborder(robot, side)
            if (side == next_side_pr(next_side_pr(reqBorder)))
                height += 1
            elseif (side == reqBorder)
                stepsToBack += 1
            end
            move!(robot, next_side(side))
            putmarker!(robot)
        end
        move!(robot, side)
        putmarker!(robot)
    end
    for _ in 1:(height - stepsToBack)
        move!(robot, next_side_pr(moveSide))
        putmarker!(robot)
    end
end

function findReq(robot::Robot, moveSide::HorizonSide)
    if isborder(robot, moveSide) && !isangle!(robot)
        isReq = false
        steps = 0
        while isborder(robot, moveSide) && !isborder(robot, next_side_pr(moveSide))
            move!(robot, next_side_pr(moveSide))
            steps += 1
        end
        if !isborder(robot, next_side_pr(moveSide))
            isReq = true
        end
        moving_defsteps!(robot, anti_side(next_side_pr(moveSide)), steps)
        return isReq
    else
        return false
    end
end


function moveLikeSnake!(robot, moveSides::NTuple{2,HorizonSide}, borderSide::HorizonSide)::Nothing
    flag = false
    while !(isborder(robot, borderSide)) && !(flag) 
        for side in moveSides
            while !flag
                if (!isborder(robot, side))
                    move!(robot,side)
                elseif !(findReq(robot, side))
                    #println("stop there")
                    break 
                else 
                    flag = true
                    break
                end
            end

            if flag 
                test1(robot, side)
                break
            end

            if !(isborder(robot, borderSide))
                move!(robot, borderSide)
            else
                break
            end
        end
    end    
end

# master! главная функция программы
function master6!(robot::Robot)::Nothing
    back_path = moving_in_angle!(robot)

    moveLikeSnake!(robot, (Nord, Sud), Ost)

    moving_in_angle!(robot)
    moving_back_to_start!(robot, back_path)
end