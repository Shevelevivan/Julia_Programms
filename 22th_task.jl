function to_symmetric_position!(robot, side)
    if isborder(robot, side)
        move_to_limit!(robot, inverse!(robot,side))
    else
        move!(robot,side)
        to_simmetric_position!(robot, side)
        move!(robot,side)
    end
end

function inverse!(robot, side)
    if side == Sud
        return Nord
    elseif side == Nord
        return Sud
    elseif side == West
        return Ost
    else
        return West
    end
end

function move_to_limit!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
        move_to_limit!(robot,side)
    end
end