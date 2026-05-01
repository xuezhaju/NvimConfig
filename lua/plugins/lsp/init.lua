-- ~/.config/nvim/lua/plugins/lsp/init.lua
return {
    -- Mason 用于安装 LSP 服务器
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    
    -- 用于自动安装 LSP 服务器
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls",           -- 注意：从 tsserver 改名为 ts_ls
                    "rust_analyzer",
                    "clangd",
                },
                automatic_installation = true,
            })
        end,
    },
    
    -- 新的 LSP 配置方式（Neovim 0.10+ 推荐）
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- 调用新的 LSP 配置文件
            require("plugins.lsp.new_servers")
        end,
    },
}
