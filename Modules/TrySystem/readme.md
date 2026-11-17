# Try — Luau Error Handling Module

A lightweight, chainable error-handling module designed for executor Luau scripts.

Try provides structured error handling, conditional catches, automatic retries, and cleanup callbacks without interrupting the entire script when an error occurs.

## Features

- **Protected Execution** — executes code inside a protected environment.
- **Catch** — handles errors matching a specific string.
- **CatchIf** — handles errors using custom conditions.
- **CatchAny** — catches any remaining unhandled errors.
- **Retry** — automatically retries failed execution.
- **Ignore** — suppresses unhandled errors.
- **Finally** — executes cleanup code after completion.
- **Chainable API** — configure everything using method chaining.

## Installation

1. Download `Try.lua` from this repository.
2. Upload it to your GitHub repository.
3. Open `Try.lua` and click **Raw**.
4. Copy the Raw URL.
5. Use the URL to load the module in your executor.

## Quick Start

```lua
local Try = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/Try.lua"
))()

local success, result = Try(function()
    print("Script started")

    local player = game.Players:FindFirstChild("Player1")

    if not player then
        error("PLAYER_NOT_FOUND")
    end

    return player.Name
end)
:Catch("PLAYER_NOT_FOUND", function(err)
    warn("Player not found:", err)
end)
:CatchAny(function(err)
    warn("Unexpected error:", err)
end)
:Finally(function(success, result)
    print("Execution finished:", success)
end)
:End()

if not success then
    warn("Execution failed:", result)
end
```

## API Reference

| Method | Description |
|---|---|
| `Try(function)` | Creates a protected execution block. |
| `Catch(pattern, handler)` | Handles errors containing a specific string or matching a predicate. |
| `CatchIf(predicate, handler)` | Handles errors when a custom condition returns `true`. |
| `CatchAny(handler)` | Handles any remaining error. |
| `Retry(count)` | Sets the number of additional execution attempts. |
| `Ignore()` | Suppresses an unhandled error. |
| `Finally(callback)` | Executes a callback after processing. |
| `End()` | Executes the configured block. |

## Retry Example

```lua
Try(function()
    PerformRequest()
end)
:Retry(3)
:CatchAny(function(err)
    warn("Request failed:", err)
end)
:End()
```

The callback will be attempted up to four times: one initial attempt and three retries.

## Conditional Error Handling

```lua
Try(function()
    ExecuteTask()
end)
:CatchIf(function(err)
    return tostring(err):find("NETWORK") ~= nil
end, function(err)
    warn("Network error:", err)
end)
:End()
```

## Finally Example

```lua
Try(function()
    ExecuteTask()
end)
:Finally(function(success, result)
    print("Task completed")
    print("Success:", success)
end)
:End()
```

## Important Notes

- `Try.lua` must be loaded before using `Try`.
- The loader requires executor support for `game:HttpGet` and `loadstring`.
- An internet connection is required when loading from GitHub.
- `Retry(n)` performs immediate retries without waiting.
- Catch handlers are checked in registration order. Register specific handlers before `CatchAny`.
- `End()` returns two values: `success` and `result`.

## License

Choose a license for this project before publishing. If no license is specified, standard copyright restrictions apply.
