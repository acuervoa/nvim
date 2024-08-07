return {
	-- Specify the main plugin and its dependency
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			-- Plugin configuration
			opts = {
				position = "bottom", -- Position of the Trouble panel (bottom, top, left, right)
				height = 10, -- Height of the Trouble panel
				icons = { -- Use icons in the Trouble panel
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				mode = "document_diagnostics", -- Default mode (workspace_diagnostics, document_diagnostics, quickfix, loclist, lsp_references)
				fold_open = "", -- Icon for opened folds
				fold_closed = "", -- Icon for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				action_keys = { -- Keys for actions in the Trouble panel
					close = { "q", "<esc" }, -- Close the Trouble panel
					cancel = "<c-e>", -- Cancel the action
					refresh = "r", -- Refresh the Trouble panel
					jump = { "<cr>", "<tab>" }, -- Jump to the location
					open_split = { "<c-x>" }, -- Open in a split
					open_vsplit = { "<c-v>" }, -- Open in a vertical split
					open_tab = { "<c-t>" }, -- Open in a new tab
					jump_close = { "o" }, -- Jump and close the Trouble panel
					toggle_mode = "m", -- Toggle between modes
					toggle_preview = "P", -- Toggle preview
					hover = "K", -- Show hover information
					preview = "p", -- Preview the location
					close_folds = { "zM", "zm" }, -- Close all folds
					open_folds = { "zR", "zr" }, -- Open all folds
					toggle_fold = { "zA", "za" }, -- Toggle fold
					previous = "k", -- Go to the previous item
					next = "j", -- Go to the next item
				},
				indent_lines = true, -- add an indet guide below the fold icons
				auto_open = false, -- Do not open Trouble automatically
				auto_close = true, -- Automatically close Trouble if no errors
				auto_preview = false, -- Do not show preview automatically
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result.
				use_diagnostic_signs = true, -- Use diagnostic signs
			},

			-- Command to open the plugin
			cmd = "Trouble",

			-- Key mappings to facilitate the use of the plugin
			keys = {
				{ "<leader>x", desc = "Trouble" },
				-- Toggle the diagnostics view
				{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

				-- Toggle the diagnostics for the current woksapace
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},

				-- Toggle the Quickfix list
				{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
				{
					"<leader>xl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitios / references/ ... (Trouble)",
				},
				{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
				{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			},
		})
	end,
}
