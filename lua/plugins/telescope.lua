return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8", -- Specifies the version of telescope.nvim to use
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required dependency for telescope.nvim
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make", -- Build command to compile the fzf-native extension
			cond = function()
				return vim.fn.executable("make") == 1 -- Only build if 'make' is available
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" }, -- UI select extension for telescope
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Adds file icons if nerd fonts are enabled
		{ "nvim-telescope/telescope-project.nvim" }, -- Project management extension
		{ "nvim-telescope/telescope-file-browser.nvim" }, -- File browser extension
		{ "cljoly/telescope-repo.nvim" }, -- Repository list
	},
	event = "VeryLazy", -- Load telescope.nvim lazily for faster startup
	config = function()
		local builtin = require("telescope.builtin") -- Import telescope's built-in functions
		local actions = require("telescope.actions") -- Import telescope's action functions
		local trouble = require("trouble.sources.telescope")
		local open_with_trouble = require("trouble.sources.telescope").open

		-- Telescope setup with default options
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = { -- Ripgrep arguments for searching
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "🔍 ", -- Prefix for the search prompt
				selection_caret = " ", -- Caret for the selected item
				entry_prefix = "  ", -- Prefix for each entry
				initial_mode = "insert", -- Start in insert mode
				selection_strategy = "reset", -- Reset selection when list changes
				-- file_sorter = require("telescope.sorters").get_fuzzy_file,
				-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				sorting_strategy = "ascending", -- Sort results in ascending order
				layout_strategy = "horizontal", -- Use horizontal layout
				layout_config = {
					horizontal = {
						mirror = false,
						preview_width = 0.5,
					},
					vertical = {
						mirror = false,
					},
					width = 0.75,
					height = 0.75,
					preview_cutoff = 120,
				},
				file_ignore_patterns = { "node_modules", ".git" }, -- Ignore these directories
				path_display = { "truncate" }, -- Truncate long file paths
				winblend = 0, -- Transparency for telescope window
				border = {}, -- Border for telescope window
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- Border characters
				color_devicons = true, -- Enable colored devicons
				use_less = true, -- Use less for previewing files
				set_env = { ["COLORTERM"] = "truecolor" }, -- Set environment variable for true color
				mappings = {
					i = { -- Insert mode mappings
						["<esc>"] = actions.close, -- Close telescope with ESC
						["<C-t>"] = open_with_trouble, -- Open with trouble plugin
						["<C-j>"] = actions.move_selection_next, -- Move selection down
						["<C-k>"] = actions.move_selection_previous, -- Move selection up
					},
					n = { -- Normal mode mappings
						["<C-t>"] = open_with_trouble, -- Open with trouble plugin
					},
				},
				extensions = {

					["ui-select"] = {
						require("telescope.themes").get_dropdown(), -- Use dropdown theme for UI select
					},
					["project"] = {
						base_dirs = {
							"~/projects",
							"~/work",
						},
						hidden_files = true, -- Show hidden files in project extension
					},
					["file_browser"] = {
						theme = "ivy", -- Use ivy theme for file browser
						hijack_netrw = true, -- Replace netrw with telescope file browser
					},
				},
			},
		})

		-- Load Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "project")
		pcall(require("telescope").load_extension, "file_browser")
		pcall(require("telescope").load_extension, "repo")

		-- Key mappings for Telescope functionalities
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set(
			"n",
			"<leader>ss",
			builtin.builtin,
			{ desc = "[S]earch [S]elect - Show Telescope search options" }
		)
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep - Search text in files" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume - Resume previous search" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Search open buffers" })

		-- Overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Search in teh current project" })

		-- Additional configuration options
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Search files with specific pattern" })

		-- Shortcut for searching Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]otes" })

		-- Keybindings for project and file browser extensions
		vim.keymap.set(
			"n",
			"<leader>sp",
			require("telescope").extensions.project.project,
			{ desc = "[S]earch [P]rojects" }
		)
		vim.keymap.set(
			"n",
			"<leader>fb",
			require("telescope").extensions.file_browser.file_browser,
			{ desc = "[Search] [F]iles [B]rowser" }
		)
	end,
}
