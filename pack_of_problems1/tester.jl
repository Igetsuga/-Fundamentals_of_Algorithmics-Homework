
include("../cheatRobot.jl")

function master(r::Robot)
    try_move!(r,Ost)
end