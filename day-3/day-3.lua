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


-- Store every bit of the diagnostic in a table
local function expand_diagnostic(data)
    local diagnostic = {}

    -- Store every bit of the diagnostic in a table
    for bit in string.gmatch(data, '.') do
        table.insert(diagnostic, bit)
    end

    return diagnostic
end

local function random_filename(prefix)
    prefix = prefix or '' -- Default prefix
    local filename -- The random file name generated

    math.randomseed(os.time())
    filename = prefix .. math.random()

    return filename
end

local function filter_to_tmp_file(filename, bits, position, value)
    local file = io.open(filename, "r")
    local temp_filename = random_filename('bit-' .. position)
    local temp_file = io.open(temp_filename, "a")

    local msb_list = {} -- List containing the number of ocurrencies of 1 or 0
    local line_number = 1


    while true do
        local line = io.read()
        -- Debug
        -- print("---")
        -- print("File: "..filename)
        -- if (line == nil) then break end
        -- print("Line: "..line)
        -- EndDebug
        if (line == nil) then break end

        -- Count the number of occurrences each bit
        local diagnostic_report = expand_diagnostic(line)

        for i = 1, bits do
            -- Debug
            -- print("---")
            -- print("File: "..filename)
            -- print("Value: "..value)
            -- -- print("Pos: "..position)
            -- -- print("Counter: "..i)
            -- print("Report: "..diagnostic_report[i])
            -- print("Bits: "..bits)
            -- print("---")
            -- DebugEnd
            if (i == position and diagnostic_report[i] == value) then
                temp_file:write(line, "\n")
            end
        end


        line_number = line_number + 1
    end

    -- Debug
    -- print(diagnostic_report[3])
    -- os.exit(0)
    -- DebugEnd

    file.close()
    temp_file.close()

    return temp_filename
end

local function part_1(filename)
    local file = io.open(filename, 'r')
    io.input(file)

    local msb_list = {}

    local line_number = 0
    local bits = 0

    while true do
        local line = io.read()
        if (line == nil) then break end
        if (line_number == 0) then
            bits = string.len(line)

            msb_init(msb_list, bits)
        end

        -- Calculate the most significant digits for a given bit
        local diagnostic_report = expand_diagnostic(line)

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


local function part_2(filename)
    local file = io.open(filename, "r")
    io.input(file)

    local bits = 0      -- Bits in the diagnostic report
    local msb_list = {} -- List containing the number of ocurrencies of 1 or 0
    local line_number = 1

    while true do
        local line = io.read()
        if (line == nil) then break end

        -- Initialization procedures
        if (line_number == 1) then
            bits = string.len(line)
            msb_init(msb_list, bits)
        end

        -- Count the number of occurrences each bit
        local diagnostic_report = expand_diagnostic(line)

        for i = 0, bits do
            calc_msb(diagnostic_report[i], msb_list[i])
        end

        line_number = line_number + 1
    end

    file.close()

    -- print(verify_msb)
    local base_file = filename -- File to read in order to filter
    for i = 1, bits do
        base_file = filter_to_tmp_file(
            base_file,
            bits,
            i,
            verify_msb(msb_list[i])
        )
        -- Debug
        print(base_file)
        -- #endregion
    end
end

print(part_2('sample'))
-- print(part_1('sample'))
