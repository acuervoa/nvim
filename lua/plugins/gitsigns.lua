return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup({
			-- Configuration for signs
			signs = {
				add = { text = "│" }, -- Sign for added lines
				change = { text = "│" }, -- Sign for changed lines
				delete = { text = "_" }, -- Sign for deleted lines
				topdelete = { text = "‾" }, -- Sign for top deleted lines
				changedelete = { text = "~" }, -- Sign for changed and deleted lines
			},
			-- Git directory watch configuration
			watch_gitdir = {
				interval = 1000, -- Interval for git directory check in milliseconds
				follow_files = true, -- Follow moved or renamed files
			},
			-- Blame line configuration
			current_line_blame = true, -- Enable blame information for the current line
			current_line_blame_opts = {
				virt_text = true, -- Use virtual text for blame info
				virt_text_pos = "eol", -- Position blame info at end of line
				delay = 500, -- Delay in milliseconds before showing blame info
			},
			sign_priority = 6, -- Priority of git signs
			update_debounce = 100, -- Debounce time for updates in milliseconds
			status_formatter = nil, -- Use default status formatter
			max_file_length = 40000, -- Max file length to process for git signs
			-- Configuration for preview window
			preview_config = {
				border = "single", -- Border style for preview window
				style = "minimal", -- Minimal style for preview window
				relative = "cursor", -- Position preview window relative to cursor
				row = 0, -- Row offset for preview window
				col = 1, -- Column offset for preview window
			},
		})

		-- Define highlights for deprecated settings
		local hl_links = {
			{ "GitSignsAdd", "GitGutterAdd" },
			{ "GitSignsAddLn", "GitGutterAddLn" },
			{ "GitSignsAddNr", "GitGutterAddNr" },
			{ "GitSignsChange", "GitGutterChange" },
			{ "GitSignsChangeLn", "GitGutterChangeLn" },
			{ "GitSignsChangeNr", "GitGutterChangeNr" },
			{ "GitSignsChangedelete", "GitGutterChange" },
			{ "GitSignsChangedeleteLn", "GitGutterChangeLn" },
			{ "GitSignsChangedeleteNr", "GitGutterChangeNr" },
			{ "GitSignsDelete", "GitGutterDelete" },
			{ "GitSignsDeleteLn", "GitGutterDeleteLn" },
			{ "GitSignsDeleteNr", "GitGutterDeleteNr" },
			{ "GitSignsTopdelete", "GitGutterDelete" },
			{ "GitSignsTopdeleteLn", "GitGutterDeleteLn" },
			{ "GitSignsTopdeleteNr", "GitGutterDeleteNr" },
		}

		-- Set highlights for git signs based on GitGutter highlights
		for _, hl in ipairs(hl_links) do
			vim.api.nvim_set_hl(0, hl[1], { link = hl[2] })
		end
	end,
}

