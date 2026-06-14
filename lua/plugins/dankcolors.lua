return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#161311',
				base01 = '#161311',
				base02 = '#908986',
				base03 = '#908986',
				base04 = '#eae0dc',
				base05 = '#fffaf8',
				base06 = '#fffaf8',
				base07 = '#fffaf8',
				base08 = '#ffa29f',
				base09 = '#ffa29f',
				base0A = '#f5d8cc',
				base0B = '#b6ffa5',
				base0C = '#ffefe8',
				base0D = '#f5d8cc',
				base0E = '#ffe6db',
				base0F = '#ffe6db',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#908986',
				fg = '#fffaf8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#f5d8cc',
				fg = '#161311',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#908986' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffefe8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffe6db',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#f5d8cc',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#f5d8cc',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffefe8',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b6ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eae0dc' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eae0dc' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#908986',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
