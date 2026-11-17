# Modules-Lua-Luau

A collection of custom Lua and Luau modules, utilities, and additional methods.

This repository contains independent modules designed to extend scripting capabilities and simplify common development tasks.

New modules and features will be added over time.

## Repository Structure

```text
Modules-Lua-Luau/
│
├── Modules/
│   ├── TrySystem/
│   ├── Async/
│   ├── Utilities/
│   └── ...
│
├── Loaders/
│   └── ...
│
└── README.md
```

## Modules

Each module is designed to serve a specific purpose and can be used independently.

| Module | Description | Status |
|---|---|---|
| TrySystem | Structured error handling | Available |
| Async | Asynchronous execution utilities | Planned |
| Utilities | General-purpose helper functions | Planned |

More modules will be added in future updates.

## Installation

Modules can be loaded directly from GitHub using their Raw URLs.

Example:

```lua
local url = "https://raw.githubusercontent.com/LuAaaqw/Modules-Lua-Luau/main/Modules/TrySystem/Try.lua"

local source = game:HttpGet(url)
local Try = loadstring(source)()
```

Replace the URL with the Raw URL of the module you want to use.

## Compatibility

- Lua
- Luau
- Roblox environments
- Executor environments (depending on the module)

Some modules may require specific functions or capabilities provided by the execution environment.

Check each module's documentation for compatibility requirements.

## Documentation

Each module should have its own documentation describing:

- Purpose and functionality
- Available methods
- Usage examples
- Requirements
- Compatibility
- Known limitations

## Updates

This repository is actively maintained. Existing modules may receive improvements, optimizations, bug fixes, and additional methods.

New modules will be added as they become available.

## License

No license has been specified yet. Unless a license is added, standard copyright restrictions apply.
