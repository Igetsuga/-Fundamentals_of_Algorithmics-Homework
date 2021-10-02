
"""
На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток, 
начиная с юго-западного угла поля, когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля
(n - это параметр функции). Начальное положение Робота - произвольное, конечное - совпадает с начальным.
Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток.
(Подсказка: здесь могут быть полезными две глобальных переменных, в которых будут содержаться текущие декартовы координаты
Робота относительно начала координат в левом нижнем углу поля, например)

"""
# start содержит начальные координаты Робота
start = [0,0]

# GoToAngle! двигает робота в юго-западный угол
function GoToAngle!(r::Robot)::Nothing
        for side in [West, Sud]
                counter = 0
                while (!(isborder(r,side)))
                        move!(r,side)
                        counter += 1 
                end
                start[Int(HorizonSide(Int(side)))] = counter 
        end
end

# move_back! возвращает робота обратно по линии
function move_back!(r::Robot, side::HorizonSide)
        while (not(isborder(r,HorizonSide((Int(side)+2)%4))))
                move!(r,HorizonSide((Int(side)+2)%4))
        end
end

sizeX = 0
sizeY = 0

# SizeOfField! считает размеры поля
function SizeOField(r::Robot)::NTuple{2,Integer}
        GoToAngel!(r)
        for side in [Nord,Ost]
                counter = 0 
                while (!(isborder(r,side)))
                        move!(r,side)
                        counter += 1
                end 
                sizeX += counter*(side==Ost)
                sizeY += counter*(side==Nord)  
        end
        return sizeX,sizeY
end

# drow! рисует часть/сторону квадрата на линии единичной ширины
function drow!(r::Robot, N::Integer)
        counter = 1
        n = 2*N
        while (!not(isborder(r,Nord)))
                if (counter%n == <= n//2)
                        putmarker!(r)
                        move!(r,Nord)
                        counter += 1 
                end
        end
        move_back!(r, Nord) 
end

# master! главная функция программы
function master!(r::Robot, N::Integer)::Nothing
        
        GoToAngle!(r)

        SizeOField(r)

        k = 2*N
        for j in 1:sizeX
                if j%k <= k//2
                        drow!(r,N)
                else
                        continue
                end
        end

        GoToAngle!(r)

        for side in [Nord, Ost]
                for j in start[(Int(side)+2)%4]
                        move!(r,side)
                end
        end
end
