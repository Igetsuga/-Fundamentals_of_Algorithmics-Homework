#=

ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы

=#

# глабальная массив coords, содержащий координаты стартовой клетки Робота
coords = []

using HorizonSideRobots
originRobot = Robot(animate = true, "2example.sit")
include("../functions.jl")

# get_line! создаёт линию из маркеров
function get_line!(robot::Robot,side::HorizonSide)::Nothing
    while (isborder(robot,side) == false)
        move!(robot,side)
        putmarker!(robot)
    end
end

# Point2_master! главная функция программы
function master2!(robot::Robot)::Nothing
    back_path = moving_in_angle!(robot)

    for side in [Nord,Ost,Sud,West]
        get_line!(robot,side)
    end

    moving_back_to_start!(robot, back_path)
end

master2!(originRobot)