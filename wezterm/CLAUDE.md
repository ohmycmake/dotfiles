# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Linting and Formatting
```bash
# Format all Lua files (excluding config/init.lua)
stylua -g '!/config/init.lua' wezterm.lua colors/ config/ events/ utils/

# Check formatting without applying changes
stylua -g '!/config/init.lua' --check wezterm.lua colors/ config/ events/ utils/

# Run Lua linter
luacheck wezterm.lua colors/* config/* events/* utils/*
```

### Testing WezTerm Configuration
```bash
# Validate configuration syntax
wezterm --config-file wezterm.lua --check-config

# Launch WezTerm with this configuration
wezterm --config-file wezterm.lua
```

## Architecture

### Module Structure
This is a modular WezTerm configuration that uses a custom `Config` class to compose settings from multiple modules:

1. **Entry Point** (`wezterm.lua`): Initializes the Config object and loads all modules in sequence
2. **Config Manager** (`config/init.lua`): Provides the `Config` class with `:init()` and `:append()` methods for composing configuration
3. **Configuration Modules** (`config/*.lua`): Each file exports a table of WezTerm configuration options
   - `appearance.lua`: Visual settings, GPU adapter selection
   - `bindings.lua`: Key bindings and shortcuts
   - `domains.lua`: SSH/WSL domain configurations
   - `fonts.lua`: Font settings
   - `general.lua`: General WezTerm settings
   - `launch.lua`: Default shell and launch menu

### Event System
The `events/` directory contains modules that register WezTerm event handlers:
- Each event module has a `.setup()` method that accepts configuration options
- Events handle UI customization (tab titles, status bars, new tab button)
- `gui-startup.lua`: Window initialization behavior

### Utilities
The `utils/` directory provides helper modules:
- `backdrops.lua`: Background image management with cycling and fuzzy search
- `gpu-adapter.lua`: Intelligent GPU/graphics API selection for WebGpu frontend
- `platform.lua`: Platform detection utilities
- `cells.lua`, `math.lua`: Helper functions
- `opts-validator.lua`: Configuration validation

### Key Binding System
- Uses `SUPER` (Alt on Windows/Linux, Cmd on macOS) and `SUPER_REV` (Alt+Ctrl / Cmd+Ctrl) modifiers
- `LEADER` key is `SUPER_REV+Space`
- Implements key tables for modal operations (font resizing, pane resizing)

### Background Image System
The backdrop system (`utils/backdrops.lua`) provides:
- Directory-based image loading from `backdrops/` folder
- Random selection, cycling, and fuzzy search capabilities
- Toggle focus mode for dimming/undimming backgrounds