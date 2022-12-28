function do_1_step!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
    else
        move!(robot, turn_left!(robot,side))
        do_1_step!(robot, side)
        move!(robot, turn_right!(robot,side))
    end
end

function turn_right!(robot, side)
    if side == Nord
        return Ost
    elseif side == Ost
        return Sud
    elseif side == Sud
        return West
    else
        return Nord
    end
end

function turn_left!(robot, side)
    if side == Nord
        return West
    elseif side == West
        return Sud
    elseif side == Sud
        return Ost
    else
        return Nord
    end
end