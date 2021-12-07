local function printTable( t )
 
    local printTable_cache = {}
 
    local function sub_printTable( t, indent )
 
        if ( printTable_cache[tostring(t)] ) then
            print( indent .. "*" .. tostring(t) )
        else
            printTable_cache[tostring(t)] = true
            if ( type( t ) == "table" ) then
                for pos,val in pairs( t ) do
                    if ( type(val) == "table" ) then
                        print( indent .. "[" .. pos .. "] => " .. tostring( t ).. " {" )
                        sub_printTable( val, indent .. string.rep( " ", string.len(pos)+8 ) )
                        print( indent .. string.rep( " ", string.len(pos)+6 ) .. "}" )
                    elseif ( type(val) == "string" ) then
                        print( indent .. "[" .. pos .. '] => "' .. val .. '"' )
                    else
                        print( indent .. "[" .. pos .. "] => " .. tostring(val) )
                    end
                end
            else
                print( indent..tostring(t) )
            end
        end
    end
 
    if ( type(t) == "table" ) then
        print( tostring(t) .. " {" )
        sub_printTable( t, "  " )
        print( "}" )
    else
        sub_printTable( t, "  " )
    end
end

local function part_1(filename)
    local file = io.open(filename, "r")
    io.input(file)

    -- Initial position
    local h_pos = 0 -- Horizontal position
    local v_pos = 0 -- Vertial position 

    while true do
        local line = io.read()
        if (line == nil) then break end

        local command, amount = string.match(line, "(%S+)%s*(%S)")

        if (command == "forward") then
            h_pos = h_pos + tonumber(amount)
        elseif (command == "up") then
            v_pos = v_pos - tonumber(amount)
        elseif (command == "down") then
            v_pos = v_pos + tonumber(amount)
        end
    end
    io.close(file)

    -- print("Horizontal: " .. h_pos)
    -- print("Vertical position: " .. v_pos)
    return v_pos * h_pos
end

local function part_2(filename)
    local file = io.open(filename, "r")
    io.input(file)

    -- Initial position
    local h_pos = 0 -- Horizontal position
    local v_pos = 0 -- Vertical position 
    local aim = 0   -- Submarine aim

    while true do
        local line = io.read()
        if (line == nil) then break end

        local command, amount = string.match(line, "(%S+)%s*(%S)")

        if (command == "down") then
            aim = aim + tonumber(amount)
        elseif (command == "up") then
            aim = aim - tonumber(amount)
        elseif (command == "forward") then
            h_pos = h_pos + tonumber(amount)
            v_pos = v_pos + (aim * tonumber(amount))
        end
    end
    io.close(file)

    -- print("Horizontal: " .. h_pos)
    -- print("Vertical position: " .. v_pos)
    return v_pos * h_pos
end

print(part_2('input'))
