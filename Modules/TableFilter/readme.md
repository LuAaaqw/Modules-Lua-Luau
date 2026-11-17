# TableFilter

A lightweight Lua/Luau utility for filtering tables using custom conditions.

## Features

- Filter array-style tables.
- Filter dictionary-style tables.
- Preserve dictionary keys.
- Filter values by type, range or custom conditions.
- Access values, keys and the original table inside predicates.
- Keep the original table unchanged.

## Installation

Repository structure:

```text
Modules/
└── TableFilter/
    ├── TableFilter.lua
    └── TableFilterLoader.lua
```

## Loading

### Using TableFilterLoader

```lua
local TableFilter = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/LuAaaqw/Modules-Lua-Luau/refs/heads/main/Modules/TableFilter/TableFilterLoader.lua"
))()
```

### Direct Loading

```lua
local TableFilter = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/LuAaaqw/Modules-Lua-Luau/refs/heads/main/Modules/TableFilter/TableFilter.lua"
))()
```

## Usage

### Array Filtering

```lua
local numbers = {4, 7, 10, 13, 16, 19}

local filtered = TableFilter(numbers, function(value)
    return value > 10
end)

print(table.concat(filtered, ", "))
```

Output:

```text
13, 16, 19
```

### Dictionary Filtering

```lua
local playerData = {
    Coins = 500,
    Level = 12,
    Admin = true,
    Username = "Player"
}

local numericData = TableFilter(playerData, function(value)
    return type(value) == "number"
end)

print(numericData.Coins)
print(numericData.Level)
```

### Custom Filtering

```lua
local data = {
    Coins = 500,
    Bonus = -100,
    ExtraValue = 250000,
    Level = 15
}

local suspicious = TableFilter(data, function(value)
    return type(value) ~= "number"
        or value < 0
        or value > 100000
end)

for key, value in pairs(suspicious) do
    warn("Suspicious value:", key, value)
end
```

## API Reference

### TableFilter(source, predicate)

| Parameter | Description |
|---|---|
| `source` | Table to filter |
| `predicate` | Function that determines which entries are kept |

The predicate receives three arguments:

- `value` — current value.
- `key` — current key or array index.
- `source` — original table.

Return a truthy value to keep an entry or `false`/`nil` to exclude it.

## Return Value

Returns a new table containing matching entries.

- Dense arrays are compacted.
- Dictionary keys are preserved.
- Sparse numeric tables retain their original keys.
- The original table is not modified.
- Nested tables are not deep-copied.

## Requirements

- Lua or Luau.
- For remote loading: an environment supporting `game:HttpGet` and `loadstring` or `load`.

## Security Note

TableFilter is a data-filtering utility, not a standalone anti-cheat.

Client-side data can be modified. Security-sensitive validation must be performed on the server.

## License

No license has been specified. Standard copyright restrictions apply.
