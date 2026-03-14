-- ~/.config/nvim/lua/plugins/init.lua
return {
    -- 首先加载主题
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    
    -- 工具类插件
    require("plugins.telescope"),
    require("plugins.lualine"),
    
    -- Treesitter
    require("plugins.treesitter"),
    
    -- 文件树
    require("plugins.nvim-tree"),
    
    -- LSP 相关
    require("plugins.lsp.init"),
    require("plugins.lsp.cmp"),  -- 这应该是第25行左右
    
    -- 标签美化
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "moll/vim-bbye",  -- 更好的关闭缓冲区
        },
        version = "*",
        event = "BufEnter",
        config = function()
            require("plugins.bufferline")
        end,
    },

    -- 启动页美化
    {
        "goolord/alpha-nvim",
        dependencies = { 
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        event = "VimEnter",
        config = function()
            require("plugins.alpha")  -- 我们将在新文件中配置
        end,
    },

    -- 其他有用插件
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n", desc = "注释当前行" },
            { "gc", mode = "v", desc = "注释选中区域" },
        },
        config = function()
            require("Comment").setup()
        end,
    },
    
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "BufEnter",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    indicator = {
                        icon = '▎',
                        style = 'icon',
                    },
                    buffer_close_icon = '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                }
            })
        end,
        keys = {
            { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "转到缓冲区1" },
            { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "转到缓冲区2" },
            { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "转到缓冲区3" },
            { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "转到缓冲区4" },
            { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "上一个缓冲区" },
            { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "下一个缓冲区" },
        },
    },
}
