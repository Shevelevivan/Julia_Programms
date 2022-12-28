function doubledist!(robot, side)
    if !isborder(robot,side)
        move!(robot,side)
        doubledist!(robot, side)
    else
        move!(robot,inverse!(robot,side))
        move!(robot, inverse!(robot,side))
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