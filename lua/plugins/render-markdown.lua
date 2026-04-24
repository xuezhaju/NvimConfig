return{
    -- 在 lazy 插件的 setup 列表中添加这个
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- 依赖：Treesitter 和图标插件 (任选其一即可)
        dependencies = {
            'nvim-treesitter/nvim-treesitter',      -- 必须
            'nvim-tree/nvim-web-devicons',          -- 可选，用于图标
            -- 'echasnovski/mini.icons',            -- 备选图标插件
        },
        ft = "markdown",
        -- 基本配置，如果不需要自定义，可以留空或置为 {}
        opts = {},
        -- 快捷键，方便开关渲染效果 (按 <Leader> + m + r)
        keys = {
            { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', desc = 'Toggle Markdown rendering' },
        },
    }
}
