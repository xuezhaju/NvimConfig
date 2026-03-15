-- 设置 leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 保存和退出
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "保存文件" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "退出" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "强制退出所有" })

-- 窗口导航
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "切换到左侧窗口" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "切换到下方窗口" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "切换到上方窗口" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "切换到右侧窗口" })

-- 窗口大小调整
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "减小窗口宽度" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "增加窗口宽度" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "减小窗口高度" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "增加窗口高度" })

-- 标签页导航
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "新建标签页" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "关闭其他标签页" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "关闭当前标签页" })
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "移动标签页" })
vim.keymap.set("n", "<leader>t[", ":tabprevious<CR>", { desc = "上一个标签页" })
vim.keymap.set("n", "<leader>t]", ":tabnext<CR>", { desc = "下一个标签页" })

-- 缓冲区导航
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "下一个缓冲区" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "上一个缓冲区" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "删除缓冲区" })
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { desc = "列出缓冲区" })

-- 搜索高亮取消
vim.keymap.set("n", "<ESC>", ":nohlsearch<CR><ESC>", { desc = "取消搜索高亮" })

-- 复制到系统剪贴板
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "复制到系统剪贴板" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "复制行到系统剪贴板" })

-- 粘贴从系统剪贴板
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "从系统剪贴板粘贴" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "从系统剪贴板粘贴（光标前）" })

-- 移动行（插入模式）
vim.keymap.set("i", "<C-j>", "<ESC>:m .+1<CR>==gi", { desc = "下移当前行" })
vim.keymap.set("i", "<C-k>", "<ESC>:m .-2<CR>==gi", { desc = "上移当前行" })

-- 移动行（可视模式）
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "下移选中行" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "上移选中行" })

-- 保持选中状态的缩进
vim.keymap.set("v", "<", "<gv", { desc = "向左缩进并保持选中" })
vim.keymap.set("v", ">", ">gv", { desc = "向右缩进并保持选中" })

-- 文件树
-- vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "切换文件树" })
-- vim.keymap.set("n", "<leader>E", "<Cmd>NvimTreeFocus<CR>", { desc = "聚焦文件树" })
-- vim.keymap.set("n", "<leader>r", "<Cmd>NvimTreeRefresh<CR>", { desc = "刷新文件树" })

-- 🎵 Bilibili 音乐控制
vim.keymap.set("n", "<leader>bm", function()
  require("bilibili").show_menu()
end, { desc = "B站音乐控制菜单" })

vim.keymap.set("n", "<leader>bp", function()
  require("bilibili").play_pause()
end, { desc = "播放/暂停" })

vim.keymap.set("n", "<leader>bn", function()
  require("bilibili").next()
end, { desc = "下一首" })

vim.keymap.set("n", "<leader>bP", function()
  require("bilibili").prev()
end, { desc = "上一首" })

vim.keymap.set("n", "<leader>bs", function()
  require("bilibili").stop()
end, { desc = "停止" })

vim.keymap.set("n", "<leader>bl", function()
  require("bilibili").show_playlist()
end, { desc = "显示播放列表" })

vim.keymap.set("n", "<leader>bx", function()
  require("bilibili").shutdown()
end, { desc = "关闭RoseSong" })

vim.keymap.set("n", "<leader>bR", function()
  require("bilibili").restart()
end, { desc = "重启RoseSong" })
