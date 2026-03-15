local M = {}

-- 检查 RoseSong 是否运行
local function is_rosesong_running()
  local handle = io.popen("pgrep -f rosesong")
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

-- 启动 RoseSong 如果没运行
local function ensure_rosesong()
  if not is_rosesong_running() then
    vim.fn.jobstart("rsg start", { detach = true })
    vim.notify("RoseSong 已启动", vim.log.levels.INFO)
    vim.defer_fn(function() end, 1000)
  end
end

-- 新增：关闭 RoseSong
local function stop_rosesong()
  if is_rosesong_running() then
    vim.fn.jobstart("rsg stop", { detach = true })
    vim.notify("RoseSong 已关闭", vim.log.levels.INFO)
  end
end

-- 新增：退出 Neovim 时自动关闭 RoseSong
local function setup_autoclose()
  -- 创建自动命令组
  local augroup = vim.api.nvim_create_augroup("RoseSongAutoClose", { clear = true })
  
  -- 在退出 Neovim 时自动关闭 RoseSong
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = augroup,
    callback = function()
      if is_rosesong_running() then
        vim.fn.jobstart("rsg stop", { detach = true })
      end
    end,
  })
  
  -- 在退出 Neovim 后强制清理（备用）
  vim.api.nvim_create_autocmd("VimLeave", {
    group = augroup,
    callback = function()
      -- 确保所有子进程都被清理
      vim.fn.jobstart("pkill -f rosesong", { detach = true })
    end,
  })
end

-- 获取当前播放状态
local function get_now_playing()
  local handle = io.popen("rsg playlist 2>/dev/null | grep '▶'")
  local result = handle:read("*a")
  handle:close()
  if result ~= "" then
    return result:gsub("%s+", " "):gsub("▶", "")
  end
  return "暂无播放"
end

-- 跳转指定数量
local function skip_songs(count)
  ensure_rosesong()
  count = tonumber(count) or 1
  for i = 1, count do
    vim.fn.jobstart("rsg next", { detach = true })
  end
  vim.notify(string.format("⏭️ 跳过了 %d 首", count), vim.log.levels.INFO)
end

-- 显示菜单
function M.show_menu()
  ensure_rosesong()
  local now_playing = get_now_playing()
  
  local items = {
    { "1", "🎵 输入BV号", "播放单个视频" },
    { "2", "📁 输入收藏夹FID", "播放收藏夹" },
    { "3", "⏯️  播放/暂停", "切换播放状态" },
    { "4", "⏭️  下一首", "切换到下一首" },
    { "5", "⏮️  上一首", "切换到上一首" },
    { "6", "⏹️  停止", "停止播放" },
    { "7", "⏭️⏭️  跳过多首", "输入数字跳转" },
    { "8", "ℹ️  当前播放", now_playing },
    { "9", "🔚 退出RoseSong", "关闭音乐播放器" },
  }
  
  vim.ui.select(items, {
    prompt = "🎵 Bilibili 音乐控制",
    format_item = function(item)
      return string.format("%s. %s - %s", item[1], item[2], item[3])
    end,
  }, function(choice)
    if not choice then return end
    
    local cmd = choice[1]
    
    if cmd == "1" then
      vim.ui.input({ prompt = "输入BV号 (如 BV1xx411c7mD): " }, function(input)
        if input and input ~= "" then
          ensure_rosesong()
          vim.fn.jobstart("rsg add -b " .. input, { detach = true })
          vim.defer_fn(function()
            vim.fn.jobstart("rsg play", { detach = true })
            vim.notify("正在播放: " .. input, vim.log.levels.INFO)
          end, 500)
        end
      end)
      
    elseif cmd == "2" then
      vim.ui.input({ prompt = "输入收藏夹FID (数字): " }, function(input)
        if input and input ~= "" then
          ensure_rosesong()
          vim.fn.jobstart("rsg add -f " .. input, { detach = true })
          vim.notify("已加载收藏夹 FID: " .. input, vim.log.levels.INFO)
        end
      end)
      
    elseif cmd == "3" then
      ensure_rosesong()
      vim.fn.jobstart("rsg play", { detach = true })
      vim.notify("播放/暂停", vim.log.levels.INFO)
      
    elseif cmd == "4" then
      ensure_rosesong()
      vim.fn.jobstart("rsg next", { detach = true })
      vim.notify("下一首", vim.log.levels.INFO)
      
    elseif cmd == "5" then
      ensure_rosesong()
      vim.fn.jobstart("rsg previous", { detach = true })
      vim.notify("上一首", vim.log.levels.INFO)
      
    elseif cmd == "6" then
      vim.fn.jobstart("rsg stop", { detach = true })
      vim.notify("停止播放", vim.log.levels.INFO)
      
    elseif cmd == "7" then
      vim.ui.input({ prompt = "跳过多首 (输入数字如 5 10): " }, function(input)
        if input and input ~= "" then
          skip_songs(input)
        end
      end)
      
    elseif cmd == "8" then
      vim.notify(now_playing, vim.log.levels.INFO)
      
    elseif cmd == "9" then
      stop_rosesong()
    end
  end)
end

-- 播放/暂停
function M.play_pause()
  ensure_rosesong()
  vim.fn.jobstart("rsg play", { detach = true })
end

-- 下一首
function M.next()
  ensure_rosesong()
  vim.fn.jobstart("rsg next", { detach = true })
end

-- 上一首
function M.prev()
  ensure_rosesong()
  vim.fn.jobstart("rsg previous", { detach = true })
end

-- 停止
function M.stop()
  vim.fn.jobstart("rsg stop", { detach = true })
end

-- 跳过多首
function M.skip(count)
  skip_songs(count)
end

-- 新增：手动关闭 RoseSong
function M.shutdown()
  stop_rosesong()
end

-- 新增：重启 RoseSong
function M.restart()
  stop_rosesong()
  vim.defer_fn(function()
    ensure_rosesong()
  end, 1000)
end

-- 初始化自动关闭功能
setup_autoclose()

return M
