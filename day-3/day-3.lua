local function calc_msb(byte, msb_counter)
    -- print("Byte: ", byte, "; Line: ", msb_counter)
    if (byte == '1') then
        msb_counter[1] = msb_counter[1] + 1
    elseif (byte == '0') then
        msb_counter[2] = msb_counter[2] + 1
    end
end

local function verify_msb(msb_counter)
    -- 1 -> 0 ocurrencies counter
    -- 2 -> 1 ocurrencies counter
    if (msb_counter[2] > msb_counter[1]) then
        return "0"
    else
        return "1"
    end
end

local function verify_lsb(msb_counter)
    -- 1 -> 0 ocurrencies counter
    -- 2 -> 1 ocurrencies counter
    if (msb_counter[2] < msb_counter[1]) then
        return "0"
    else
        return "1"
    end
end

local function msb_init(msb_list, bits)
    local i = 1

    while (i <= bits) do
        table.insert(msb_list, {0, 0})
        i = i + 1
    end
end

local function part_1(filename)
    local file = io.open(filename, 'r')
    io.input(file)

    local msb_list = {}

    local line_number = 0
    local bits = 0
    local match_regex = '';

    while true do
        local line = io.read()
        if (line == nil) then break end
        if (line_number == 0) then
            bits = string.len(line)

            msb_init(msb_list, bits)
        end

        local diagnostic_report = {}

        -- Create a table with every bit
        for bit in string.gmatch(line, ".") do
            table.insert(diagnostic_report, bit)
        end

        -- Calculate the most significant digits for a given bit
        for i = 1, bits do
            calc_msb(diagnostic_report[i], msb_list[i])
        end

        line_number = line_number + 1
    end

    io.close(file)

    local gama_rate = {
        ['bin'] = '',
        ['integer'] = 0
    }
    local epsilon_rate = {
        ['bin'] = '',
        ['integer'] = 0
    }
    local power_comsuption = 0

    -- Calc rates
    for i = 1, bits do
        gama_rate.bin = gama_rate.bin..
            verify_msb(msb_list[i])
        epsilon_rate.bin = epsilon_rate.bin..
            verify_lsb(msb_list[i])
    end
    gama_rate.integer = tonumber(gama_rate.bin, 2)
    epsilon_rate.integer = tonumber(epsilon_rate.bin, 2)

    -- print("Gama Rate: ", gama_rate.integer)
    -- print("Epsilon Rate: ", epsilon_rate.integer)

    power_comsuption = gama_rate.integer * epsilon_rate.integer

    return power_comsuption
end

print(part_1('./input'))
