# ------------------------------------------------------------------------------------------------------------------------------------------------
mutable struct Coords
    x::Integer
    y::Integer

    Coords() = new(0,0) # - такой конструктор определен для удобства использования
    Coords(x::Integer,y::Integer) = new(x,y)
end
# ------------------------------------------------------------------------------------------------------------------------------------------------


function move_Coords!(coords::Coords, side::HorizonSide)
    if side==Nord
        coords.y += 1
    elseif side==Sud
        coords.y -= 1
    elseif side==Ost
        coords.x += 1
    else #if side==West
        coords.x -= 1
    end
end

get_coords(coord::Coords) = (coord.x, coord.y)

#=
function get_coords(coord::Coords)
    return (coord.x, cord.y)
end
=#
