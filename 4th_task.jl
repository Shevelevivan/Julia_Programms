using HorizonSideRobots

function diagonal_cross!(robot)
    do_the_side!(robot,Nord,Ost)
    do_the_side!(robot,Ost,Sud)
    do_the_side!(robot,Sud,West)
    do_the_side!(robot,West,Nord)
    putmarker!(robot)
end

function do_the_side!(robot,side1,side2)
    x_count = 0
    y_count = 0
    while !isborder(robot, side1) && !isborder(robot, side2)
        move!(robot,side1)
        x_count += 1
        make_a_step!(robot,side2)
        y_count += 1
    end
    side1 = inverse!(robot,side1)
    side2 = inverse!(robot,side2)
    while x_count > 0 && y_count > 0
        move!(robot,side2)
        y_count -= 1
        move!(robot,side1)
        x_count -= 1
    end
end

function make_a_step!(robot,side)
    move!(robot, side)
    putmarker!(robot)
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