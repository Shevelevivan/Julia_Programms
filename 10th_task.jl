using HorizonSideRobots

function checker_board_N!(robot,N::Int)
    x = go_and_count!(robot,Sud)
    y = go_and_count!(robot,West)
    fill_the_bord!(robot,Nord,N)
    along!(robot,Sud)
    along!(robot,West)
    go_back!(robot,Nord,x)
    go_back!(robot,Ost,y)
end

function fill_the_bord!(robot,side,N)
    count1 = 0
    count2 = 0
    countn = 0
    while !isborder(robot,side)
        for j in 1:N
            for k in 1:N
                if !isborder(robot,side)
                    fill_a_row_1!(robot,N)
                    count1 += 1
                end
            end
            countn += 1
            for k in 1:N
                if !isborder(robot,side)
                    fill_a_row_2!(robot,N)
                    count2 += 1
                end
            end
            countn += 1
        end
    end
    if count1 % N != 0
        fill_a_row_1!(robot,N)
    elseif count2 % N != 0
        fill_a_row_2!(robot,N)
    elseif count1 > count2
        fill_a_row_2!(robot,N)
    elseif count1 < count2
        fill_a_row_1!(robot,N)
    elseif countn % 2 == 0
        fill_a_row_1!(robot,N)
    elseif countn % 2 != 0
        fill_a_row_2!(robot,N)
    end
end

function fill_a_row_1!(robot,N)
    while !isborder(robot,Ost)
        move_N_steps_marker!(robot,Ost,N)
        move_N_steps!(robot,Ost,N)
    end
    along!(robot,West)
    if !isborder(robot,Nord)
        move!(robot,Nord)
    end
end

function fill_a_row_2!(robot,N)
    while !isborder(robot,Ost)
        move_N_steps!(robot,Ost,N)
        move_N_steps_marker!(robot,Ost,N)
    end
    along!(robot,West)
    if !isborder(robot,Nord)
        move!(robot,Nord)
    end
end

function move_N_steps!(robot,side,N)
    for i in 1:N
        if !isborder(robot,side)
            move!(robot,side)
        else
            break
        end
    end
end

function move_N_steps_marker!(robot,side,N)
    count = 0
    for i in 1:N
        if !isborder(robot,side)
            putmarker!(robot)
            move!(robot,side)
            count += 1
        else
            if count % N != 0
                putmarker!(robot)
            end
            break
        end
    end
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