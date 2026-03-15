-- ~/.config/nvim/init.lua
-- 必须在任何加载之前设置 leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 加载 lazy.nvim 配置
require("config.lazy")

-- 加载核心配置
require("core")
-- vim.cmd.colorscheme("tokyonight")
