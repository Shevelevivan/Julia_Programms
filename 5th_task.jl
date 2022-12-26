using HorizonSideRobots

function double_perimetr!(robot)
    x = 0
    y = 0
    z = 0
    x += go_and_count!(robot, Sud)
    y += go_and_count!(robot, West)
    z += go_and_count!(robot, Sud)

    fill_the_perimetr!(robot, Nord)
    find_the_frame!(robot, Nord, Ost)
    fill_around!(robot, Nord, West)

    along!(robot, Sud)
    along!(robot, West)
    go_back!(robot, Nord, z)
    go_back!(robot, Ost, y)
    go_back!(robot, Nord, x)
end

function fill_the_perimetr!(robot, side)
    while !ismarker(robot)
        while !isborder(robot, side)
            putmarker!(robot)
            move!(robot, side)
        end
        side = turn_right!(robot, side)
    end
end

function find_the_frame!(robot, side1, side2)
    while !isborder(robot, side1)
        while !isborder(robot, side2)
            move!(robot, side2)
            if isborder(robot, side1)
                break
            end
        end
        if !isborder(robot, side1)
            move!(robot, side1)
            side2 = inverse!(robot, side2)
        else
            break
        end
    end
end

function fill_around!(robot, side1, side2)
    while !ismarker(robot)
        while isborder(robot, side1)
            putmarker!(robot)
            move!(robot, side2)
        end
        putmarker!(robot)
        move!(robot, side1)
        side1 = turn_right!(robot, side1)
        side2 = turn_right!(robot,side2)
    end
end

function along!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function go_and_count!(robot, side)
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
