-- ~/.config/nvim/lua/plugins/markdown-plugin.lua
return{
    -- Markdown 增强插件
    {
        "yousefhadder/markdown-plus.nvim",
        ft = "markdown",  -- 只在 markdown 文件加载
        opts = {},        -- 使用默认配置
        -- 如果想自定义配置，可以这样：
        -- opts = {
        --     features = {
        --         auto_list = true,
        --         auto_toggle_checkbox = true,
        --         html_block_awareness = true,
        --     },
        -- },
    }
}
