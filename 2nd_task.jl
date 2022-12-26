using HorizonSideRobots

function perimetr!(robot)
    x = go_and_count!(robot, West)
    y = go_and_count!(robot, Sud)
    fill_the_perimetr!(robot,Nord)
    go_back!(robot, Ost, x)
    go_back!(robot, Nord, y)
end

function fill_the_perimetr!(robot,side)
    while !ismarker(robot)
        while !isborder(robot,side)
            putmarker!(robot)
            move!(robot, side)
        end
        side = turn_left!(robot, side)
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

function turn_left!(robot, side)
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