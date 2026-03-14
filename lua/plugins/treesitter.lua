-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- 使用 lazy.nvim 的 event 机制，在文件打开时加载
    event = { "BufReadPost", "BufNewFile" },
    -- 或者使用 cmd 机制，在运行特定命令时加载
    -- cmd = { "TSInstall", "TSUpdate" },
    config = function()
        -- 确保在配置前插件已完全加载
        local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end
        
        treesitter.setup({
            -- 确保安装的解析器列表
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "c",
                "cpp",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "yaml",
                "markdown",
                "markdown_inline",
                "bash",
                "gitignore",
                "regex",
                "diff",
            },
            -- 自动安装缺失的解析器
            auto_install = true,
            highlight = {
                enable = true,
                -- 使用 treesitter 高亮而不是正则表达式
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            -- 文本对象支持（可选）
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })
    end,
}
