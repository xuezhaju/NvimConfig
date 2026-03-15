-- ~/.config/nvim/lua/plugins/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function()
        -- NvChad 风格的颜色定义
        local colors = {
            bg = "#1e1e2e",
            fg = "#cdd6f4",
            yellow = "#f9e2af",
            cyan = "#94e2d5",
            darkblue = "#45475a",
            green = "#a6e3a1",
            orange = "#fab387",
            violet = "#cba6f7",
            magenta = "#f38ba8",
            blue = "#89b4fa",
            red = "#f38ba8",
        }

        -- 自定义 NvChad 主题
        local nvchad_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.violet, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
            insert = {
                a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
            visual = {
                a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
            replace = {
                a = { fg = colors.bg, bg = colors.red, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
            command = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
            inactive = {
                a = { fg = colors.fg, bg = colors.darkblue, gui = "bold" },
                b = { fg = colors.fg, bg = colors.darkblue },
                c = { fg = colors.fg, bg = colors.bg },
            },
        }

        -- 模式图标映射
        local mode_icons = {
            n = { icon = "󰊕", name = "NORMAL" },
            i = { icon = "󰏫", name = "INSERT" },
            v = { icon = "󰆐", name = "VISUAL" },
            V = { icon = "󰆐", name = "V-LINE" },
            ["␖"] = { icon = "󰆐", name = "V-BLOCK" },
            c = { icon = "󰘧", name = "COMMAND" },
            r = { icon = "󰑓", name = "REPLACE" },
            t = { icon = "󰊕", name = "TERMINAL" },
        }

        -- 自定义模式组件
        local function mode()
            local current_mode = vim.api.nvim_get_mode().mode
            local mode_info = mode_icons[current_mode] or { icon = "󰊕", name = current_mode:upper() }
            return string.format(" %s %s ", mode_info.icon, mode_info.name)
        end

        -- 自定义 LSP 状态
        local function lsp_status()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            if #buf_clients == 0 then
                return " 󰢱 "
            end
            
            local names = {}
            for _, client in ipairs(buf_clients) do
                table.insert(names, client.name)
            end
            return " 󰣖 " .. table.concat(names, ",")
        end

        -- 自定义诊断信息
        local function diagnostics()
            local counts = {
                error = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR] or 0,
                warn = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN] or 0,
                info = vim.diagnostic.count(0)[vim.diagnostic.severity.INFO] or 0,
                hint = vim.diagnostic.count(0)[vim.diagnostic.severity.HINT] or 0,
            }
            
            local result = {}
            if counts.error > 0 then
                table.insert(result, "󰅚" .. counts.error)
            end
            if counts.warn > 0 then
                table.insert(result, "󰀪" .. counts.warn)
            end
            if counts.info > 0 then
                table.insert(result, "󰋼" .. counts.info)
            end
            if counts.hint > 0 then
                table.insert(result, "󰌶" .. counts.hint)
            end
            
            if #result == 0 then
                return ""
            end
            return " " .. table.concat(result, " ")
        end

        -- 设置 lualine
        require("lualine").setup({
            options = {
                theme = nvchad_theme,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { 
                        "NvimTree", 
                        "neo-tree", 
                        "alpha", 
                        "dashboard",
                        "lazy",
                        "mason",
                        "TelescopePrompt",  -- 添加 Telescope 提示符
                    },
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { 
                    "branch",
                    {
                        "diff",
                        colored = true,
                        symbols = { added = "󰐕 ", modified = "󰏫 ", removed = "󰅖 " },
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        symbols = {
                            modified = "●",
                            readonly = "󰌾",
                            unnamed = "[No Name]",
                        },
                    },
                    diagnostics,
                },
                lualine_x = {
                    lsp_status,
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { 
                    { "location", padding = 1 },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            -- 修复扩展部分：使用字符串而不是模块
            extensions = { 
                "nvim-tree",  -- 这是字符串，不是 require
                "quickfix",
                "fugitive",
                -- "telescope",  -- 如果还报错，先注释掉 telescope
            },
        })
    end,
}
