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

function multiple_perimetr!(robot)
    coord_robot = CoordRobot(robot, Coordinates(0,0))
    move_to_the_corner!(coord_robot,Sud,West)
    fill_the_perimetr!(robot, Nord)
    find_the_start_y!(coord_robot,Nord)
    find_the_start_x!(coord_robot,Ost)
end

function find_the_start_x!(robot::CoordRobot,side)
    while robot.coord.x != 0
        if isborder(robot,side)
            cross_the_obstacle!(robot,Ost)
        else
            while !isborder(robot,side)
                if robot.coord.x == 0
                    break
                end
                move!(robot,side)
            end
        end
    end
end

function cross_the_obstacle!(robot::CoordRobot,side)
    while isborder(robot,side) && !isborder(robot,Nord)
        move!(robot,Nord)
    end
    move!(robot,Ost)
    while isborder(robot,Sud) && !isborder(robot,side)
        move!(robot,side)
    end
    while robot.coord.y != 0 && !isborder(robot,Sud)
        move!(robot,Sud)
    end
end

function find_the_start_y!(robot::CoordRobot,side)
    while robot.coord.y != 0 && !isborder(robot,side)
        move!(robot,side)
    end
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

function move_to_the_corner!(robot::CoordRobot,side1,side2)
    factor = false
    while factor == false
        if isborder(robot, side1) && isborder(robot, side2)
            factor = true
        else
            along!(robot,side1)
            along!(robot,side2)
        end
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