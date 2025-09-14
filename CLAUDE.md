# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository containing configurations for:
- **Neovim**: AstroNvim v5+ configuration with modular plugin structure
- **WezTerm**: Modular terminal emulator configuration with custom event system

## Commands

### Neovim Configuration

#### Code Formatting
```bash
# Format Neovim Lua configuration
cd nvim && stylua lua/
```

### WezTerm Configuration

#### Linting and Formatting
```bash
# Format WezTerm Lua files (excluding config/init.lua)
cd wezterm && stylua -g '!/config/init.lua' wezterm.lua colors/ config/ events/ utils/

# Check formatting without applying changes
cd wezterm && stylua -g '!/config/init.lua' --check wezterm.lua colors/ config/ events/ utils/

# Run Lua linter
cd wezterm && luacheck wezterm.lua colors/* config/* events/* utils/*
```

#### Testing WezTerm Configuration
```bash
# Validate configuration syntax
cd wezterm && wezterm --config-file wezterm.lua --check-config

# Launch WezTerm with this configuration
cd wezterm && wezterm --config-file wezterm.lua
```

## Architecture

### Neovim Structure

#### Bootstrap Flow
1. `nvim/init.lua` - Bootstraps Lazy.nvim installation
2. `nvim/lua/lazy_setup.lua` - Configures Lazy with AstroNvim and imports plugins
3. `nvim/lua/polish.lua` - Final setup step for custom Lua code (currently disabled)

#### Plugin System
- `nvim/lua/plugins/` - Individual plugin configurations
- `nvim/lua/community.lua` - AstroCommunity module imports (currently disabled)
- All plugin files have `if true then return {} end` at the top - remove this line to activate the configuration

#### Configuration Files
- `nvim/.stylua.toml` - Lua formatter configuration (120 char width, 2 spaces, double quotes)
- `nvim/.luarc.json` - Lua language server config (formatting disabled)

### WezTerm Structure

#### Module System
The WezTerm configuration uses a custom `Config` class to compose settings:

1. **Entry Point** (`wezterm/wezterm.lua`): Initializes Config and loads all modules
2. **Config Manager** (`wezterm/config/init.lua`): Provides `Config` class with `:init()` and `:append()` methods
3. **Configuration Modules** (`wezterm/config/*.lua`): Each exports WezTerm configuration options
   - `appearance.lua`: Visual settings, GPU adapter selection
   - `bindings.lua`: Key bindings and shortcuts
   - `domains.lua`: SSH/WSL domain configurations
   - `fonts.lua`: Font settings
   - `general.lua`: General WezTerm settings
   - `launch.lua`: Default shell and launch menu

#### Event System
The `wezterm/events/` directory contains modules that register WezTerm event handlers:
- Each event module has a `.setup()` method that accepts configuration options
- Events handle UI customization (tab titles, status bars, new tab button)
- `gui-startup.lua`: Window initialization behavior

#### Utilities
The `wezterm/utils/` directory provides helper modules:
- `backdrops.lua`: Background image management with cycling and fuzzy search
- `gpu-adapter.lua`: Intelligent GPU/graphics API selection
- `platform.lua`: Platform detection utilities
- `cells.lua`, `math.lua`: Helper functions
- `opts-validator.lua`: Configuration validation

## Key Patterns

### Neovim
- Most configuration files are disabled by default with `if true then return {} end`
- Remove these lines to activate the respective configurations
- AstroNvim uses space as leader key and comma as localleader
- Mason auto-installs lua-language-server, stylua, debugpy, and tree-sitter-cli

### WezTerm
- Uses `SUPER` (Alt on Windows/Linux, Cmd on macOS) and `SUPER_REV` (Alt+Ctrl / Cmd+Ctrl) modifiers
- `LEADER` key is `SUPER_REV+Space`
- Implements key tables for modal operations (font resizing, pane resizing)
- Background images loaded from `wezterm/backdrops/` folder with cycling capabilities