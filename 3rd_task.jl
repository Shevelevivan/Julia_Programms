using HorizonSideRobots

function field!(robot)
    x = go_and_count!(robot, West)
    y = go_and_count!(robot, Sud)
    fill_the_field!(robot, Nord, Ost)
    along!(robot,Sud)
    along!(robot,West)
    go_back!(robot, Ost, x)
    go_back!(robot, Nord, y)
end

function fill_the_field!(robot, side, secondary_side)
    while !isborder(robot, side)
        while !isborder(robot, secondary_side)
            putmarker!(robot)
            move!(robot, secondary_side)
        end
        putmarker!(robot)
        move!(robot, side)
        secondary_side = inverse!(robot, secondary_side)
    end
    draw_line!(robot,secondary_side)
end

function along!(robot,side)
    while !isborder(robot,side)
        move!(robot,side)
    end
end

function go_and_count!(robot,side)
    count = 0
    while !isborder(robot, side)
        move!(robot, side)
        count += 1
    end
    return count
end

function go_back!(robot, side, count)
    while count > 0
        move!(robot, side)
        count -= 1
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

function draw_line!(robot, side)
    while !isborder(robot, side)
        putmarker!(robot)
        move!(robot,side)
    end
    putmarker!(robot)
end