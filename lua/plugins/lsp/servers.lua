-- ~/.config/nvim/lua/plugins/lsp/servers.lua
-- Mason 配置
local status_ok, mason = pcall(require, "mason")
if status_ok then
    mason.setup()
end

local status_ok, tool_installer = pcall(require, "mason-tool-installer")
if status_ok then
    tool_installer.setup({
        ensure_installed = {
            "lua-language-server",
            "pyright",
            "typescript-language-server",
            "rust-analyzer",
        },
    })
end

-- LSP 能力配置（用于补全）
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities()
end

-- LSP 服务器配置
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

-- 通用 on_attach 函数
local on_attach = function(client, bufnr)
    -- 禁用某些服务器的格式化
    if client.name == "tsserver" or client.name == "pyright" then
        client.server_capabilities.documentFormattingProvider = false
    end
    
    -- 快捷键
    local opts = { buffer = bufnr, noremap = true, silent = true }
    
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- 配置服务器
local servers = {
    "lua_ls",
    "pyright",
    "tsserver",
    "rust_analyzer",
}

for _, server in ipairs(servers) do
    local server_opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    
    -- Lua 特殊配置
    if server == "lua_ls" then
        server_opts.settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            }
        }
    end
    
    -- 安全地设置每个服务器
    pcall(function()
        lspconfig[server].setup(server_opts)
    end)
end
