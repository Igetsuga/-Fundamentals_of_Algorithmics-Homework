# будем ходить кругом, пока не найжем этот маркер.
# 1 Вниз, 2 Вправо, 2 Вверх, 3 Влево, 3 Вниз, 4 Вправо, 4 Вверх и тд.
function master(r::Robot)::Norhing
    flag = true
    counter = 1
    if (ismarker(r))
        break
    else
        move!(r,Sud)
        # не знаю правильно ли я использовал картежи
        for side in [(Ost,Nord),(West, Sud)]
            for steps in range(counter + 1*(side==Ost or side==Nord))
                if (not(ismarker(r)))
                    move!(r,side)
                else
                    flag = false
                    break
                end
            end
            counter += 2
        end
        # здесь проверка, на всякий случай, не знают выбросит ли первый break из внешнего if.
        if (not(flag))
            break
        end
    end
end
    


