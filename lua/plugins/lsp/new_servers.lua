-- ~/.config/nvim/lua/plugins/lsp/new_servers.lua
-- 使用 Neovim 0.10+ 的新 API: vim.lsp.config

-- 通用 on_attach 函数
local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    -- LSP 快捷键
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    
    -- 修复：使用新的方式检查格式化支持
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end
end

-- 通用能力配置
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- 添加补全能力（如果安装了 nvim-cmp）
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_lsp.default_capabilities()
end

-- 使用新的 vim.lsp.config API 配置各个服务器
-- 注意：这个 API 需要 Neovim 0.10+

-- 检查是否支持新 API
if vim.lsp.config then
    -- C/C++ 语言服务器 (clangd)
    vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        filetypes = { "c", "cpp", "cxx", "cc", "h", "hpp", "hxx" },
        root_markers = { 
            "compile_commands.json", 
            ".clangd", 
            ".git", 
            "CMakeLists.txt", 
            "Makefile",
            "build.ninja"
        },
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- Lua 语言服务器
    vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "selene.toml" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            }
        },
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- Python 语言服务器
    vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { 
            "pyproject.toml", 
            "setup.py", 
            "setup.cfg", 
            "requirements.txt", 
            "Pipfile", 
            "pyrightconfig.json", 
            ".git" 
        },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                }
            }
        },
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- TypeScript/JavaScript 语言服务器 (注意名称改为 ts_ls)
    vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { 
            "javascript", 
            "javascriptreact", 
            "javascript.jsx", 
            "typescript", 
            "typescriptreact", 
            "typescript.tsx" 
        },
        root_markers = { 
            "package.json", 
            "tsconfig.json", 
            "jsconfig.json", 
            ".git" 
        },
        init_options = {
            hostInfo = "neovim"
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            -- 禁用 ts_ls 的格式化功能（可以用 prettier 代替）
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
        end,
    })

    -- Rust 语言服务器
    vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            }
        },
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- 启用所有配置的服务器
    vim.lsp.enable({
        "lua_ls",
        "pyright", 
        "ts_ls",
        "rust_analyzer",
        "clangd",
    })
    
else
    -- 回退到旧的 lspconfig 方式（用于 Neovim 0.9 及以下版本）
    local lspconfig = require("lspconfig")
    
    -- Lua
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            }
        },
    })
    
    -- Python
    lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
    
    -- TypeScript (使用新的名称 ts_ls)
    lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
        end,
    })
    
    -- Rust
    lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

-- 诊断显示配置
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- 诊断符号
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
