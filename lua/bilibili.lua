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

-- 关闭 RoseSong
local function stop_rosesong()
  if is_rosesong_running() then
    vim.fn.jobstart("rsg stop", { detach = true })
    vim.notify("RoseSong 已关闭", vim.log.levels.INFO)
  end
end

-- 退出 Neovim 时自动关闭 RoseSong
local function setup_autoclose()
  local augroup = vim.api.nvim_create_augroup("RoseSongAutoClose", { clear = true })
  
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = augroup,
    callback = function()
      if is_rosesong_running() then
        vim.fn.jobstart("rsg stop", { detach = true })
      end
    end,
  })
  
  vim.api.nvim_create_autocmd("VimLeave", {
    group = augroup,
    callback = function()
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

-- 前进指定数量
local function skip_forward(count)
  ensure_rosesong()
  count = tonumber(count) or 1
  for i = 1, count do
    vim.fn.jobstart("rsg next", { detach = true })
  end
  vim.notify(string.format("⏭️ 前进了 %d 首", count), vim.log.levels.INFO)
end

-- 后退指定数量
local function skip_backward(count)
  ensure_rosesong()
  count = tonumber(count) or 1
  for i = 1, count do
    vim.fn.jobstart("rsg previous", { detach = true })
  end
  vim.notify(string.format("⏮️ 后退了 %d 首", count), vim.log.levels.INFO)
end

-- 显示菜单
function M.show_menu()
  ensure_rosesong()
  local now_playing = get_now_playing()
  
  local items = {
    { "🎵 输入BV号", "播放单个视频" },
    { "📁 输入收藏夹FID", "播放收藏夹" },
    { "⏯️  播放/暂停", "切换播放状态" },
    { "⏭️  下一首", "切换到下一首" },
    { "⏮️  上一首", "切换到上一首" },
    { "⏹️  停止", "停止播放" },
    { "⏭️⏭️  前进多首", "输入数字前进" },
    { "⏮️⏮️  后退多首", "输入数字后退" },
    { "ℹ️  当前播放", now_playing },
    { "🔚 退出RoseSong", "关闭音乐播放器" },
  }
  
  vim.ui.select(items, {
    prompt = "🎵 Bilibili 音乐控制",
    format_item = function(item)
      return string.format("%s - %s", item[1], item[2])
    end,
  }, function(choice)
    if not choice then return end
    
    local cmd = choice[1]
    
    if cmd == "🎵 输入BV号" then
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
      
    elseif cmd == "📁 输入收藏夹FID" then
      vim.ui.input({ prompt = "输入收藏夹FID (数字): " }, function(input)
        if input and input ~= "" then
          ensure_rosesong()
          vim.fn.jobstart("rsg add -f " .. input, { detach = true })
          vim.notify("已加载收藏夹 FID: " .. input, vim.log.levels.INFO)
        end
      end)
      
    elseif cmd == "⏯️  播放/暂停" then
      ensure_rosesong()
      vim.fn.jobstart("rsg play", { detach = true })
      vim.notify("播放/暂停", vim.log.levels.INFO)
      
    elseif cmd == "⏭️  下一首" then
      ensure_rosesong()
      vim.fn.jobstart("rsg next", { detach = true })
      vim.notify("下一首", vim.log.levels.INFO)
      
    elseif cmd == "⏮️  上一首" then
      ensure_rosesong()
      vim.fn.jobstart("rsg previous", { detach = true })
      vim.notify("上一首", vim.log.levels.INFO)
      
    elseif cmd == "⏹️  停止" then
      vim.fn.jobstart("rsg stop", { detach = true })
      vim.notify("停止播放", vim.log.levels.INFO)
      
    elseif cmd == "⏭️⏭️  前进多首" then
      vim.ui.input({ prompt = "前进几首? (输入数字): " }, function(input)
        if input and input ~= "" then
          skip_forward(input)
        end
      end)
      
    elseif cmd == "⏮️⏮️  后退多首" then
      vim.ui.input({ prompt = "后退几首? (输入数字): " }, function(input)
        if input and input ~= "" then
          skip_backward(input)
        end
      end)
      
    elseif cmd == "ℹ️  当前播放" then
      vim.notify(now_playing, vim.log.levels.INFO)
      
    elseif cmd == "🔚 退出RoseSong" then
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

-- 前进多首
function M.forward(count)
  skip_forward(count)
end

-- 后退多首
function M.backward(count)
  skip_backward(count)
end

-- 手动关闭
function M.shutdown()
  stop_rosesong()
end

-- 重启
function M.restart()
  stop_rosesong()
  vim.defer_fn(function()
    ensure_rosesong()
  end, 1000)
end

-- 初始化自动关闭功能
setup_autoclose()

return M
