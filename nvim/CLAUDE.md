# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is an AstroNvim v5+ configuration repository for Neovim. It uses a modular plugin structure based on Lazy.nvim for package management.

## Key Architecture

### Bootstrap Flow
1. `init.lua` - Bootstraps Lazy.nvim installation
2. `lua/lazy_setup.lua` - Configures Lazy with AstroNvim and imports plugins
3. `lua/polish.lua` - Final setup step for custom Lua code (currently disabled)

### Plugin Structure
- `lua/plugins/` - Individual plugin configurations
- `lua/community.lua` - AstroCommunity module imports (currently disabled)
- All plugin files have `if true then return {} end` at the top - remove this line to activate the configuration

### Configuration Files
- `.stylua.toml` - Lua formatter configuration (120 char width, 2 spaces, double quotes)
- `.luarc.json` - Lua language server config (formatting disabled)

## Common Development Commands

### Code Formatting
```bash
stylua lua/
```

### Plugin Management
- Open Neovim and use `:Lazy` to manage plugins
- Use `:Mason` to manage LSP servers, formatters, and debuggers

## Important Notes

- Most configuration files are disabled by default with `if true then return {} end` or `if true then return end`
- Remove these lines to activate the respective configurations
- AstroNvim uses leader key as space and localleader as comma
- Mason is configured to auto-install lua-language-server, stylua, debugpy, and tree-sitter-cli