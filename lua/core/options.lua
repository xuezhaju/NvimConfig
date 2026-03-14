-- 基础编辑器选项
local options = {
    -- 显示
    number = true,              -- 显示行号
    relativenumber = true,      -- 显示相对行号
    signcolumn = "yes",         -- 始终显示符号列
    cursorline = true,          -- 高亮当前行
    
    -- 缩进
    tabstop = 4,                -- Tab 宽度
    softtabstop = 4,            -- 编辑时 Tab 宽度
    shiftwidth = 4,             -- 缩进宽度
    expandtab = true,           -- 使用空格代替 Tab
    autoindent = true,          -- 自动缩进
    
    -- 搜索
    hlsearch = true,            -- 高亮搜索结果
    incsearch = true,           -- 实时搜索
    ignorecase = true,          -- 忽略大小写
    smartcase = true,           -- 智能大小写
    
    -- 外观
    termguicolors = true,       -- 24位真彩色
    background = "dark",        -- 深色背景
    showmode = false,           -- 不显示模式（状态栏已显示）
    
    -- 行为
    mouse = "a",                -- 启用鼠标
    clipboard = "unnamedplus",  -- 系统剪贴板
    wrap = false,               -- 不自动换行
    linebreak = true,           -- 在单词边界换行
    scrolloff = 8,              -- 光标上下保留8行
    sidescrolloff = 8,          -- 光标左右保留8列
    
    -- 备份和交换文件
    swapfile = false,           -- 不创建交换文件
    backup = false,             -- 不创建备份
    undofile = true,            -- 启用持久化撤销
    
    -- 拆分窗口
    splitright = true,          -- 垂直拆分在右侧
    splitbelow = true,          -- 水平拆分在下方
}

-- 应用选项
for key, value in pairs(options) do
    vim.opt[key] = value
end
