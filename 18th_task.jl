using HorizonSideRobots

function move_to_limit!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
        move_to_limit!(robot,side)
    end
end