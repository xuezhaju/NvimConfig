-- ~/.config/nvim/lua/plugins/transparent.lua
return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
        require("transparent").setup({
            groups = {  -- 默认组
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special',
                'Identifier', 'Statement', 'PreProc', 'Type', 'Underlined',
                'Todo', 'String', 'Function', 'Conditional', 'Repeat',
                'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn',
                'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                'EndOfBuffer',
            },
            extra_groups = {  -- 额外组
                'NormalFloat', 'NvimTreeNormal', 'BufferLineFill',
                'TelescopeNormal', 'TelescopeBorder', 'MasonNormal',
                'LazyNormal', 'WhichKeyFloat', 'NotifyBackground',
            },
        })
        
        -- Bufferline 透明支持
        pcall(function()
            vim.g.transparent_groups = vim.list_extend(
                vim.g.transparent_groups or {},
                vim.tbl_map(function(v)
                    return v.hl_group
                end, vim.tbl_values(require('bufferline.config').highlights))
            )
        end)
        
        -- Lualine 透明支持
        pcall(function()
            require('transparent').clear_prefix('lualine')
        end)
    end,
}
