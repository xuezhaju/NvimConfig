## 🎵 B站音乐播放器 (RoseSong) 部署指南

本配置集成了 B站音乐播放功能，让你可以在 Neovim 中直接听 B站的收藏夹音乐。

原项目链接: <https://github.com/huahuadeliaoliao/RoseSong>

### 安装 RoseSong

```bash
# 1. 克隆项目
git clone https://github.com/huahuadeliaoliao/RoseSong.git
cd RoseSong

# 2. 编译安装
cargo build --release
mkdir -p ~/.local/bin
cp target/release/rosesong ~/.local/bin/
cp target/release/rsg ~/.local/bin/

# 3. 添加到 PATH（Fish shell）
set -U fish_user_paths ~/.local/bin $fish_user_paths

# 或 Bash/Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

### 安装依赖

```bash
# Arch Linux
sudo pacman -S gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly

# Ubuntu/Debian
sudo apt install gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly
```

### 使用方法

#### 基本命令
```bash
# 启动 RoseSong
rsg start

# 添加 B站视频（通过 BV 号）
rsg add -b BV1xx411c7mD

# 添加收藏夹（通过 FID）
rsg add -f 3530305357

# 控制播放
rsg play      # 播放/暂停
rsg next      # 下一首
rsg previous  # 上一首
rsg stop      # 停止

# 查看播放列表
rsg playlist
```

#### Neovim 快捷键
| 快捷键 | 功能 |
|--------|------|
| `<leader>bm` | 打开控制菜单 |
| `<leader>bp` | 播放/暂停 |
| `<leader>bn` | 下一首 |
| `<leader>bP` | 上一首 |
| `<leader>b+` | 前进指定数量 |
| `<leader>b-` | 后退指定数量 |
| `<leader>bl` | 显示播放列表 |
| `<leader>bx` | 关闭 RoseSong |
| `<leader>bR` | 重启 RoseSong |

### 如何获取 BV 号和 FID

- **BV 号**：B站视频网址中的标识符
  ```
  https://www.bilibili.com/video/BV1xx411c7mD
                            ^^^^^^^^^^^^^^ 这就是 BV 号
  ```

- **FID（收藏夹ID）**：打开你的收藏夹页面，URL 中的数字
  ```
  https://space.bilibili.com/xxx/favlist?fid=3530305357
                                              ^^^^^^^^^^ 这就是 FID
  ```

### 注意事项

1. 首次使用需要先 `rsg start` 启动服务
2. 关闭 Neovim 时会自动停止 RoseSong
3. 播放列表默认分页显示，可在终端中输入数字翻页
4. 需要网络连接才能播放

### 故障排除

```bash
# 检查 RoseSong 是否运行
pgrep -f rosesong

# 手动停止
rsg stop
pkill -f rosesong

# 查看日志（如果有）
tail -f ~/RoseSong/rosesong.log
```
```

