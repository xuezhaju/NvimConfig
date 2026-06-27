
<div align="center">

# 🚀 我的 Neovim 配置文件

**一个现代化、功能强大且美观的 Neovim 编辑器配置**

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![License](https://img.shields.io/badge/许可证-MIT-red.svg?style=for-the-badge)](LICENSE)

</div>

## ✨ 主要特性

| 分类 | 功能 |
|------|------|
| 🎨 **外观美化** | Catppuccin / Tokyonight 主题、透明背景、自定义状态栏 |
| 🤖 **代码补全** | 完整 LSP 支持：C/C++、Python、Rust、TypeScript、Lua |
| 🔍 **文件搜索** | Telescope 模糊搜索：文件、文本、缓冲区、命令 |
| 🌳 **文件树** | Nvim-tree，支持 Git 状态显示和文件图标 |
| 📝 **Markdown** | 实时渲染、语法高亮、浏览器预览 |
| 🎵 **音乐播放** | 内置 B站音乐播放器 (RoseSong) |
| 🐚 **内置终端** | 方便的分屏终端，快捷键快速切换 |
| 📦 **插件管理** | Lazy.nvim 实现快速启动和懒加载 |

## 📸 效果预览

<!-- 这里放你的截图 -->

## 🚀 安装方法

### 环境要求

- Neovim 0.10+
- Git
- 任意一款 [Nerd Fonts](https://www.nerdfonts.com/) 字体（推荐 FiraCode Nerd Font）

### 安装步骤

```bash
# 备份你现有的配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆本仓库
git clone https://github.com/xuezhaju/NvimConfig.git ~/.config/nvim

# 打开 Neovim，Lazy.nvim 会自动安装所有插件
nvim +Lazy sync +qa
```


## 快捷键、功能讲解

### B站音乐播放功能讲解
[讲解专栏文档](./rosesong.md)

### 基础操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>w` | 保存文件 |
| `<leader>q` | 退出 |
| `<leader>Q` | 强制退出所有 |

### 窗口管理
| 快捷键 | 功能 |
|--------|------|
| `<C-h/j/k/l>` | 在窗口间移动 |
| `<leader>sv` | 垂直分屏 |
| `<leader>sh` | 水平分屏 |
| `<leader>sc` | 关闭当前分屏 |
| `<leader>so` | 只保留当前窗口 |

### 文件树
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开/关闭文件树 |
| `<leader>E` | 聚焦文件树窗口 |

### Telescope 搜索
| 快捷键 | 功能 |
|--------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 搜索文本内容 |
| `<leader>fb` | 搜索已打开的缓冲区 |
| `<leader>fk` | 查看所有快捷键 |
| `<leader>fo` | 最近打开的文件 |

### LSP/代码补全
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `K` | 显示悬停文档 |
| `<leader>rn` | 重命名符号 |
| `<leader>ca` | 代码操作 |
| `<leader>f` | 格式化代码 |

### B站音乐控制
| 快捷键 | 功能 |
|--------|------|
| `<leader>bm` | 打开控制菜单 |
| `<leader>bp` | 播放/暂停 |
| `<leader>bn` | 下一首 |
| `<leader>bP` | 上一首 |
| `<leader>b+` | 前进指定数量 |
| `<leader>b-` | 后退指定数量 |
| `<leader>bl` | 显示播放列表 |

### 主题与外观
| 快捷键 | 功能 |
|--------|------|
| `<leader>th` | 循环切换主题 |
| `<leader>tm` | 菜单选择主题 |
| `<leader>ut` | 切换透明背景 |

## 📦 主要插件

| 插件 | 说明 |
|------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理器 |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | 主题配色 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮 |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊搜索 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 自动补全 |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件树 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 顶部标签栏 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown 渲染 |

## 📁 目录结构

```
~/.config/nvim/
├── init.lua                 # 入口文件
└── lua/
    ├── core/                # 核心配置
    │   ├── options.lua      # 编辑器选项
    │   ├── keymaps.lua      # 快捷键映射
    │   └── autocmds.lua     # 自动命令
    ├── plugins/             # 插件配置
    │   ├── init.lua         # 插件列表
    │   ├── lsp/             # LSP 相关配置
    │   └── ...
    └── themes/              # 主题配置
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

[MIT](LICENSE)

---


**⭐ 如果这个配置对你有帮助，欢迎给个 Star！**


