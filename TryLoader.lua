local url = "https://raw.githubusercontent.com/LuAaaqw/Modules-Lua-Luau/main/Try.lua"

assert(game and type(game.HttpGet) == "function", "game:HttpGet is not available")

local downloaded, source = pcall(function()
    return game:HttpGet(url)
end)

assert(downloaded and type(source) == "string" and #source > 0,
    "Could not download Try.lua")

local compile = loadstring or load
assert(type(compile) == "function", "loadstring is not available")

local chunk, compileError = compile(source)
assert(type(chunk) == "function", tostring(compileError or "Try.lua compilation failed"))

local loaded, Try = pcall(chunk)
assert(loaded and type(Try) == "table", "Could not initialize Try.lua")

return Try
