using HorizonSideRobots

function checker_board!(robot)
    technicalcount = 0
    x = go_and_count!(robot, Sud, technicalcount)
    if ismarker(robot)
        technicalcount = 1
    else
        technicalcount = 0
    end
    y = go_and_count!(robot, West, technicalcount)
    if ismarker(robot)
        technicalcount = 1
    else
        technicalcount = 0
    end
    technicalcount += 1
    fill_the_field!(robot,Nord,Ost,technicalcount)
    along!(robot,Sud)
    along!(robot,West)
    go_back!(robot, Ost, x+1)
    go_back!(robot, Nord, y-1)
end

function fill_the_field!(robot, side, secondary_side,technicalcount)
    while !isborder(robot, side)
        while !isborder(robot, secondary_side)
            if technicalcount % 2 == 0
                putmarker!(robot)
            end
            move!(robot, secondary_side)
            technicalcount += 1
        end
        if technicalcount % 2 == 0
            putmarker!(robot)
        end
        move!(robot, side)
        technicalcount += 1
        secondary_side = inverse!(robot, secondary_side)
    end
    draw_line!(robot,secondary_side,technicalcount)
end

function go_and_count!(robot,side,technicalcount)
    count = 0
    while !isborder(robot, side)
        if technicalcount % 2 == 0
            putmarker!(robot)
        end
        move!(robot, side)
        technicalcount += 1
        count += 1
    end
    return count
end

function along!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end
    
function go_back!(robot, side, count)
    while count > 0
        move!(robot, side)
        count -= 1
    end
end

function draw_line!(robot, side,technicalcount)
    while !isborder(robot, side)
        if technicalcount % 2 == 0
            putmarker!(robot)
        end
        move!(robot,side)
        technicalcount += 1
    end
    if technicalcount % 2 == 0
        putmarker!(robot)
    end
end