#!/usr/bin/env bash
# ============================================
# tmux 插件自动管理器
# 功能：首次启动自动安装，后续启动检查更新
# ============================================

set -euo pipefail

PLUGIN_DIR="${HOME}/.config/tmux/plugins"
LOG_FILE="${PLUGIN_DIR}/.update.log"

# 插件列表：格式为 "GitHub用户/仓库名"
PLUGINS=(
    "tmux-plugins/tmux-sensible"
    "tmux-plugins/tmux-resurrect"
    "tmux-plugins/tmux-yank"
    "christoomey/vim-tmux-navigator"
)

# 确保插件目录存在
mkdir -p "$PLUGIN_DIR"

install_plugin() {
    local plugin=$1
    local name=$(basename "$plugin")
    local target="${PLUGIN_DIR}/${name}"

    if [[ ! -d "$target" ]]; then
        git clone --depth 1 "https://github.com/${plugin}.git" "$target" 2>/dev/null
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Installed: $plugin" >> "$LOG_FILE"
    fi
}

update_plugin() {
    local plugin=$1
    local name=$(basename "$plugin")
    local target="${PLUGIN_DIR}/${name}"

    if [[ -d "$target" ]]; then
        # 后台静默更新，不阻塞 tmux 启动
        (cd "$target" && git pull --quiet 2>/dev/null) &
    fi
}

main() {
    for plugin in "${PLUGINS[@]}"; do
        install_plugin "$plugin"
        update_plugin "$plugin"
    done
}

main
