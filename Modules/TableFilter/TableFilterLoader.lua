
local url = "https://raw.githubusercontent.com/LuAaaqw/Modules-Lua-Luau/refs/heads/main/Modules/TableFilter/TableFilter.lua"

assert(game and type(game.HttpGet) == "function",
    "game:HttpGet is not available")

local downloaded, source = pcall(function()
    return game:HttpGet(url)
end)

assert(downloaded and type(source) == "string" and #source > 0,
    "Could not download TableFilter.lua")

local compile = loadstring or load

assert(type(compile) == "function",
    "loadstring is not available")

local chunk, compileError = compile(source)

assert(type(chunk) == "function",
    tostring(compileError or "Compilation failed"))

local loaded, TableFilter = pcall(chunk)

assert(loaded and type(TableFilter) == "function",
    "Could not initialize TableFilter")

return TableFilter
