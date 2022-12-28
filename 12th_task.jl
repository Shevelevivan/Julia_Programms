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

function count_all!(robot)
    count = 0
    coord_robot = CoordRobot(robot, Coordinates(0,0))
    move_to_the_corner!(coord_robot,Sud,West)
    count = go_across!(robot,Nord,Ost,count)
    along!(robot,West)
    along!(robot,Sud)
    find_the_start_y!(coord_robot,Nord)
    find_the_start_x!(coord_robot,Ost)
    print(count)
end

function go_across!(robot,wall_side,moving_direction,count)
    state = 0
    count = 0
    micro_count = 0
    while !isborder(robot,wall_side)
        while !isborder(robot, moving_direction)
            micro_count = 0
            if !isborder(robot,wall_side)
                while !isborder(robot,wall_side)
                    if isborder(robot,moving_direction)
                        break
                    end
                    i = try_move!(robot,moving_direction)
                    if i == true
                        micro_count += 1
                    end
                end
            elseif isborder(robot,wall_side)
                if micro_count == 1
                    while isborder(robot,wall_side)
                        if isborder(robot,moving_direction)
                            break
                        end
                        try_move!(robot,moving_direction)
                    end
                    micro_count = 0
                else
                    while isborder(robot,wall_side)
                        if isborder(robot,moving_direction)
                            break
                        end
                        try_move!(robot,moving_direction)
                    end
                    count += 1
                    micro_count = 0
                end
            end
        end
        try_move!(robot,Nord)
        if isborder(robot,Nord)
            break
        end
        moving_direction = inverse!(robot,moving_direction)
    end
    return count - 1
end

function try_move!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
        return true
    else
        return false
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

function along!(robot::CoordRobot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function along!(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function find_the_start_y!(robot::CoordRobot,side)
    while robot.coord.y != 0 && !isborder(robot,side)
        move!(robot,side)
    end
end

function find_the_start_x!(robot::CoordRobot,side)
    while robot.coord.x != 0 && !isborder(robot,side)
        move!(robot,side)
    end
end