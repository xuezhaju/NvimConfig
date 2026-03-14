-- ~/.config/nvim/lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- 修改 fzf 扩展的配置
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- 只有在 make 成功时才构建
            build = "make",
            -- 或者使用 cmake（如果系统有 cmake）
            -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            cond = function()
                -- 检查是否支持编译
                local ok, _ = pcall(io.popen, "make --version")
                return ok
            end,
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        
        telescope.setup({
            defaults = {
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<Esc>"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- 忽略 node_modules 等目录
                    find_command = { "rg", "--files", "--hidden", "--glob", "!{.git,node_modules}/**" },
                },
                live_grep = {
                    additional_args = { "--hidden", "--glob", "!{.git,node_modules}/**" },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- 启用模糊匹配
                    override_generic_sorter = true,  -- 覆盖通用排序器
                    override_file_sorter = true,     -- 覆盖文件排序器
                    case_mode = "smart_case",        -- 智能大小写
                }
            },
        })
        
        -- 安全加载 fzf 扩展
        pcall(function()
            telescope.load_extension("fzf")
        end)
        
        -- 快捷键
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "搜索内容" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "查找缓冲区" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "查找帮助" })
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "查找最近文件" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "查找快捷键" })
        vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "查找命令" })
        vim.keymap.set("n", "<leader>f.", builtin.resume, { desc = "恢复上次搜索" })
    end,
}
