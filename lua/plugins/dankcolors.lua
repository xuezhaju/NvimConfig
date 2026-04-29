return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#131313',
				base01 = '#131313',
				base02 = '#849293',
				base03 = '#849293',
				base04 = '#dbedee',
				base05 = '#f6feff',
				base06 = '#f6feff',
				base07 = '#f6feff',
				base08 = '#ff7fac',
				base09 = '#ff7fac',
				base0A = '#6cf0f9',
				base0B = '#88ff92',
				base0C = '#b2f9ff',
				base0D = '#6cf0f9',
				base0E = '#88f7ff',
				base0F = '#88f7ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#849293',
				fg = '#f6feff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#6cf0f9',
				fg = '#131313',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#849293' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#b2f9ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#88f7ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#6cf0f9',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#6cf0f9',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#b2f9ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#88ff92',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dbedee' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dbedee' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#849293',
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
