local function TableFilter(source, predicate)
    assert(type(source) == "table", "TableFilter: source must be a table")
    assert(type(predicate) == "function", "TableFilter: predicate must be a function")

    local result = {}
    local count = 0
    local maxIndex = 0
    local isArray = true

    for key in pairs(source) do
        if type(key) ~= "number" or key < 1 or key % 1 ~= 0 then
            isArray = false
            break
        end

        count = count + 1

        if key > maxIndex then
            maxIndex = key
        end
    end

    if isArray and count == maxIndex then
        local resultIndex = 0

        for index = 1, maxIndex do
            local value = source[index]

            if predicate(value, index, source) then
                resultIndex = resultIndex + 1
                result[resultIndex] = value
            end
        end
    else
        for key, value in pairs(source) do
            if predicate(value, key, source) then
                result[key] = value
            end
        end
    end

    return result
end

return TableFilter
