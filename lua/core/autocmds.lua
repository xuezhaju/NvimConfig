-- 创建一个自动命令组
local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- 文件类型检测
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- 当离开插入模式时自动保存
vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup,
    pattern = "*",
    command = "silent! write",
})

-- 自动调整窗口大小
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    pattern = "*",
    command = "tabdo wincmd =",
})

-- 高亮复制区域
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- 创建新文件时自动插入模板
vim.api.nvim_create_autocmd("BufNewFile", {
    group = augroup,
    pattern = "*.py",
    callback = function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
            "#!/usr/bin/env python3",
            "# -*- coding: utf-8 -*-",
            "",
            "",
            '"""',
            "Created on " .. os.date("%Y-%m-%d %H:%M:%S"),
            '',
            "@author: " .. os.getenv("USER") or os.getenv("USERNAME"),
            '"""',
            "",
            "",
            "def main():",
            "    pass",
            "",
            "",
            'if __name__ == "__main__":',
            "    main()",
        })
        vim.cmd("normal! G")
    end,
})
