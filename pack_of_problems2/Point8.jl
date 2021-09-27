# master главная фуекция программы
function master!(r::Robot)::Nothing
    counter = 1
    # идем влево на j клеток, если яму не нашли, идем вправо на j+1 клтетку и тд. пока яма не будет найдена
    if not(isnorder(r,Nord))
        while (isborder(r,Nord))
            for SIDE in (1,3)
                for steps in range(counter)
                    if (not(isnorder(r,Nord)))
                        move!(r,HorizonSide(SIDE))
                    else
                        move!(r,Nord)
                        # я не знаю, как этот break работает, но мне нужно, чтобы он меня выбросил из самой внешней функции if, если он так не
                        # делает, то юзаем flag
                        break
                    end
                end
                counter+=1 
            end
        end
    else
        move!(r,Nord)
    end
end