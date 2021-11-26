"""

Посчитать число всех горизонтальных прямолинейных перегородок (вертикальных - нет)


"""
#= пока нет границы сверху
    пока нет границы на Ost
        пока сверху перегородка 
            идти на Ost
        перегородка += 1
        пока сверху нет перегородки 
        идти на Ost

    идти на Nord
    повторить для West
=#

include("../AbstractType.jl")
include("../functions.jl")

function master!(robot::Robot)::Nothing
    while (!isborder(robot, Nord))
        moveLikeSnake!(robot, (Ost, West), Nord)
    end
end

