function move_and_mark!(robot, side)
    if isborder(robot, side)
        putmarker!(robot)
    else
        move!(robot, side)
        move_and_mark!(robot, side)
        move!(robot, inverse!(robot, side))
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