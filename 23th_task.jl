function sum_of_vector(v::Vector)
    if length(v) == 0
        return 0
    end
    return sum_of_vector(v[1:end-1]) + v[end]
end

