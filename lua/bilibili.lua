-- ~/.config/nvim/lua/bilibili.lua
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
    { "7", "📋 显示播放列表", "查看当前列表" },
    { "8", "ℹ️  当前播放", now_playing },
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
      vim.cmd("vnew | terminal rsg playlist")
      vim.cmd("wincmd L | vertical resize 60")
      
    elseif cmd == "8" then
      vim.cmd("terminal rsg playlist | head -20")
    end
  end)
end

-- 添加快捷函数
function M.play_pause()
  ensure_rosesong()
  vim.fn.jobstart("rsg play", { detach = true })
end

function M.next()
  ensure_rosesong()
  vim.fn.jobstart("rsg next", { detach = true })
end

function M.prev()
  ensure_rosesong()
  vim.fn.jobstart("rsg previous", { detach = true })
end

function M.stop()
  vim.fn.jobstart("rsg stop", { detach = true })
end

function M.show_playlist()
  vim.cmd("vnew | terminal rsg playlist")
  vim.cmd("wincmd L | vertical resize 60")
end

return M
