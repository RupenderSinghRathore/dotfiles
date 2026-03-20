return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#121415',
				base01 = '#121415',
				base02 = '#868d91',
				base03 = '#868d91',
				base04 = '#dde6eb',
				base05 = '#f8fcff',
				base06 = '#f8fcff',
				base07 = '#f8fcff',
				base08 = '#ff9fbd',
				base09 = '#ff9fbd',
				base0A = '#c1e3f6',
				base0B = '#a5ffb0',
				base0C = '#e1f4ff',
				base0D = '#c1e3f6',
				base0E = '#d1efff',
				base0F = '#d1efff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#868d91',
				fg = '#f8fcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#c1e3f6',
				fg = '#121415',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#868d91' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e1f4ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d1efff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#c1e3f6',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#c1e3f6',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#e1f4ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb0',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dde6eb' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dde6eb' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#868d91',
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
