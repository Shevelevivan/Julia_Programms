using HorizonSideRobots

function vertical_cross!(robot)
    make_a_side!(robot, Nord)
    make_a_side!(robot, Ost)
    make_a_side!(robot, Sud)
    make_a_side!(robot, West)
    putmarker!(robot)
end

function make_a_side!(robot, side)
    draw_line!(robot, side)
    side = inverse!(robot, side)
    go_back!(robot, side)
end

function draw_line!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function go_back!(robot, side)
    while ismarker(robot)
        move!(robot, side)
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
