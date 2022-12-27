using HorizonSideRobots
HSR = HorizonSideRobots

abstract type AbstractRobot end

HSR.move!(robot::AbstractRobot,side)=move!(get_robot(robot), side)

HSR.isborder(robot::AbstractRobot,side)=isborder(get_robot(robot),side)

HSR.putmarker!(robot::AbstractRobot)=putmarker!(get_robot(robot))

HSR.ismarker(robot::AbstractRobot)=ismarker(get_robot(robot))

HSR.temperature(robot::AbstractRobot)=temperature(get_robot(robot))

mutable struct Coordinates
    x::Int
    y::Int
end

function HorizonSideRobots.move!(coord::Coordinates, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    else
        coord.x -= 1
    end
end

get_coord(coord::Coordinates) = (coord.x, coord.y)

struct CoordRobot <: AbstractRobot
    robot ::Robot
    coord ::Coordinates
end

function HorizonSideRobots.move!(robot::CoordRobot, side)
    move!(robot.robot, side)
    move!(robot.coord, side)
end

get_robot(robot::CoordRobot) = robot.robot
get_coord(robot::CoordRobot) = get_coord(robot.coord)

function wall_search!(robot)
    wall_side = Nord
    coord_robot = CoordRobot(robot, Coordinates(0,0))
    steps = 0
    while isborder(coord_robot,wall_side)
        steps += 1
        moving_direction = turn_right!(coord_robot,wall_side)
        go_n_steps!(coord_robot,moving_direction,steps)
        if !isborder(coord_robot,wall_side)
            break
        else
            return_back!(coord_robot,turn_left!(coord_robot,wall_side))
        end
        moving_direction = turn_left!(coord_robot,wall_side)
        go_n_steps!(coord_robot,moving_direction,steps)
        if !isborder(coord_robot,wall_side)
            break
        else
            return_back!(coord_robot,turn_right!(coord_robot,wall_side))
        end
    end
end

function go_n_steps!(robot::CoordRobot,side,steps)
    while steps > 0
        move!(robot,side)
        steps -= 1
    end
end

function return_back!(robot::CoordRobot,side)
    while robot.coord.x != 0
        move!(robot,side)
    end
end

function turn_right!(robot::CoordRobot, side)
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

function turn_left!(robot::CoordRobot, side)
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

function inverse!(robot::CoordRobot, side)
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