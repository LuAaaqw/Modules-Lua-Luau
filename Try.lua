local Try = {}
Try.__index = Try

local function getTraceback(err)
    local message = tostring(err)

    if debug and type(debug.traceback) == "function" then
        local ok, result = pcall(debug.traceback, message, 2)
        if ok then
            return result
        end
    end

    return message
end

local function runProtected(callback, ...)
    local args = table.pack(...)

    return xpcall(function()
        return callback(table.unpack(args, 1, args.n))
    end, getTraceback)
end

local function createTry(callback)
    assert(type(callback) == "function", "Try expects a function")

    return setmetatable({
        callback = callback,
        handlers = {},
        finallyCallback = nil,
        retryCount = 0,
        ignoreErrors = false,
        finished = false,
    }, Try)
end

function Try:Catch(pattern, callback)
    assert(type(callback) == "function", "Catch expects a handler function")
    assert(type(pattern) == "string" or type(pattern) == "function",
        "Catch expects a string or predicate function")

    self.handlers[#self.handlers + 1] = {
        type = "catch",
        pattern = pattern,
        callback = callback,
    }

    return self
end

function Try:CatchIf(predicate, callback)
    assert(type(predicate) == "function", "CatchIf expects a predicate function")
    assert(type(callback) == "function", "CatchIf expects a handler function")

    self.handlers[#self.handlers + 1] = {
        type = "condition",
        predicate = predicate,
        callback = callback,
    }

    return self
end

function Try:CatchAny(callback)
    assert(type(callback) == "function", "CatchAny expects a handler function")

    self.handlers[#self.handlers + 1] = {
        type = "any",
        callback = callback,
    }

    return self
end

function Try:Retry(count)
    count = tonumber(count) or 0
    self.retryCount = math.max(0, math.floor(count))
    return self
end

function Try:Ignore(enabled)
    self.ignoreErrors = enabled ~= false
    return self
end

function Try:Finally(callback)
    assert(type(callback) == "function", "Finally expects a function")
    self.finallyCallback = callback
    return self
end

local function matches(handler, err)
    if handler.type == "any" then
        return true
    end

    if handler.type == "condition" then
        local ok, result = runProtected(handler.predicate, err)
        return ok and result == true
    end

    if type(handler.pattern) == "string" then
        return string.find(tostring(err), handler.pattern, 1, true) ~= nil
    end

    local ok, result = runProtected(handler.pattern, err)
    return ok and result == true
end

function Try:End()
    assert(not self.finished, "This Try block has already been executed")
    self.finished = true

    local success, result

    for _ = 0, self.retryCount do
        success, result = runProtected(self.callback)
        if success then
            break
        end
    end

    if not success then
        local originalError = result
        local wasHandled = false

        for _, handler in ipairs(self.handlers) do
            if matches(handler, originalError) then
                success, result = runProtected(handler.callback, originalError)
                wasHandled = true
                break
            end
        end

        if not wasHandled and self.ignoreErrors then
            success = true
            result = originalError
        elseif not wasHandled then
            success = false
            result = originalError
        end
    end

    if self.finallyCallback then
        local finalSuccess, finalResult = runProtected(
            self.finallyCallback,
            success,
            result
        )

        if not finalSuccess then
            success = false
            result = finalResult
        end
    end

    return success, result
end

setmetatable(Try, {
    __call = function(_, callback)
        return createTry(callback)
    end,
})

return Try
