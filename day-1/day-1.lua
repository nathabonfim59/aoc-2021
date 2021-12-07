local function part_1()
    local sample = io.open('input', 'r')
    io.input(sample)

    local increased = 0
    local previous_value = 0
    local line_number = 0

    while true do
        local content = tonumber(io.read())

        if (content == nil) then
            break
        else
            if (content > previous_value and line_number > 0) then
                increased = increased + 1
            end
        end
        previous_value = content
        line_number = line_number + 1
    end

    io.close(sample)

    return increased
end

local function part_2()
    local sample = io.open('input', 'r')
    io.input(sample)

    local increased = 0
    local line_number = 0
    local triad_counter = 0

    local a = 0
    local b = 0
    local c = 0

    local current_sum = 0
    local next_sum = 0

    while true do
        -- Update line number
        line_number =  line_number + 1

        -- Read file contents
        local content = tonumber(io.read())

        if (content == nil) then
            break
        else
            triad_counter = triad_counter + 1
            if (line_number > 3) then
                current_sum = a + b + c
                next_sum = content + b + a

                -- print("A: "..a.."; B: "..b.."; C: "..c.."; Current: "..content )

                -- print("Current sum: ", current_sum)
                -- print("Next sum: ", next_sum)

                if (next_sum > current_sum) then
                    increased = increased + 1
                end
            end

            -- Update last values
            c = b
            b = a
            a = content
        end
    end

    io.close(sample)
    return increased
end

print("Part 1: "..part_1())
print("Part 2: "..part_2())
