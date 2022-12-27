using HorizonSideRobots

function find_the_marker!(robot)
    side = West
    steps = 1
    while !ismarker(robot)
        temporary_step = steps
        while temporary_step > 0
            if ismarker(robot)
                break
            end
            move!(robot,side)
            temporary_step -= 1
        end
        side = turn_right!(robot,side)
        temporary_step = steps
        while temporary_step > 0
            if ismarker(robot)
                break
            end
            move!(robot,side)
            temporary_step -= 1
        end
        side = turn_right!(robot,side)
        steps += 1
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