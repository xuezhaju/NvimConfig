-- ~/.config/nvim/lua/plugins/init.lua
return {
    require("themes.init"),

    -- 🔧 LSP 和补全配置（加在这里）
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
    },

    -- bufferline 标签美化（梯形风格）
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = "BufEnter",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    indicator = {
                        icon = '▎',
                        style = 'icon',
                    },
                    buffer_close_icon = '󰅖',
                    modified_icon = '●',
                    close_icon = '󰅖',
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
                    separator_style = "slant",  -- 这里设置梯形风格
                    always_show_bufferline = true,
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
    -- 撤销树
    {
      "XXiaoA/atone.nvim",
      cmd = "Atone",
      opts = {},
    },
    
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
        {
          "rcarriga/nvim-notify",
          opts = {
            timeout = 3000,
            max_width = 40,
            minimum_width = 20,
            fps = 30,
            render = "minimal",
            stages = "fade_in_slide_out",
            top_down = true,
            background_colour = "#000000",
          },
        },
      },
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
            require("alpha").setup(require("alpha.themes.dashboard").config)
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
}
