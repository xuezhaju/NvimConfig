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
    require("plugins.lsp.cmp"),

    -- nvim-navic - 代码导航
    {
      "SmiteshP/nvim-navic",
      dependencies = { "neovim/nvim-lspconfig" },
      opts = {
        lsp = {
          auto_attach = true,
        },
      },
    },  -- ← 这里加了逗号

    -- 撤销树
    {
      "XXiaoA/atone.nvim",
      cmd = "Atone",
      opts = {},
    },  -- ← 这里加了逗号
    
    -- 消息通知美化
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },  -- ← 这里确保有逗号

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
            require("plugins.alpha")
        end,
    },

    -- 自动括号
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    
    -- 注释插件
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
    
    -- 标签美化（重复了？你这里有两个 bufferline，保留一个即可）
    -- 如果不需要第二个，可以删除这个
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
    },  -- ← 最后这个要有逗号吗？如果是最后一个可以不加，但建议统一加
}
