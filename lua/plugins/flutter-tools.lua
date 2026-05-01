return {
    {
        ft = "dart",
        'nvim-flutter/flutter-tools.nvim',
            lazy = false,  -- 建议立即加载，以便使用 Flutter 相关命令
            dependencies = {
                'nvim-lua/plenary.nvim',     -- 必须依赖
                'stevearc/dressing.nvim',    -- 可选，优化UI选择界面
            },
            config = function()
                require("flutter-tools").setup({
                    ui = {
                        border = "rounded",  -- 让窗口边框圆润
                    },
                    -- 调试配置（如果需要）
                    debugger = {
                        enabled = true,
                    },
                })
            end,
    }
}
