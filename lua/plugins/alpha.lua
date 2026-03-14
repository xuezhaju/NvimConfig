-- ~/.config/nvim/lua/plugins/alpha.lua
-- 注意：这个文件必须返回一个表！

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- 设置 header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
    "                    🚀  Neovim IDE                   ",
}

-- 设置按钮
dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  查找文件", ":Telescope find_files<CR>"),
    dashboard.button("r", "󰄉  最近文件", ":Telescope oldfiles<CR>"),
    dashboard.button("g", "󰊄  查找文本", ":Telescope live_grep<CR>"),
    dashboard.button("c", "  配置", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("p", "󰏗  插件", ":Lazy<CR>"),
    dashboard.button("q", "󰅚  退出", ":qa<CR>"),
}

-- 设置 footer
dashboard.section.footer.val = "    " .. os.date("%Y-%m-%d %H:%M:%S")

-- 配置 alpha
alpha.setup(dashboard.config)

-- 重要：必须返回一个表！这是 alpha 插件的配置
return {
    -- 这里可以放一些 alpha 的额外配置
    -- 但通常返回空表也可以
}
