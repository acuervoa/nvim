return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	lazy = true,
	config = function()
		local present, wk = pcall(require, "which-key")
		if not present then
			return
		end

		wk.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				spelling = {
					enabled = true, -- enabling this will show WhickKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = false, -- adds help for motions text_objects=false, --help for text objects triggered after entering an operator
					windows = false, -- default bindings on <c-w>
					nav = false, -- misc bindings to work with windows
					z = false, -- bindings for folds, spelling and others prefixed with z
					g = false, -- bindings for frefixed with g
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			defer = function(ctx)
				if ctx.mode == "n" and ctx.operator == "gc" then
					return "Comments"
				end
				return false
			end,
			key_lables = {
				-- overrride the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			win = {
				no_overlap = true,
				padding = { 2, 2, 2, 2 }, -- {top, right, bottom, left}
				title = true,
				title_pos = "center",
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min an max width of the columns
				spacing = 4, -- spacing between columns
				align = "left", -- aling columns left, center or right
			},
			--filter = false, -- Enable this to hide mappings for which you didn't specigy a label
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = { "<leader>", "<M>" },
		})
		local opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		}

		local visual_opts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		}

		local wk = require("which-key")

		-- Mapeos en modo normal
		local normal_mode_mappings = {
			{ "<leader>", "<cmd>WhichKey<CR>", desc = "Show all keymaps" },
			-- Resizing y Splitting
			{
				"<leader>-",
				"<cmd>vertical resize -5<CR>",
				desc = "Decrease vertical window size by 5",
				nowait = false,
				remap = false,
			},
			{
				"<leader>=",
				"<cmd>vertical resize +5<CR>",
				desc = "Increase vertical window size by 5",
				nowait = false,
				remap = false,
			},
			{ "<leader>V", "<C-W>s", desc = "Split window below", nowait = false, remap = false },
			{ "<leader>v", "<C-W>v", desc = "Split window right", nowait = false, remap = false },

			-- Ecovim y Gestión de Sesiones
			{ "<leader>/", group = "Ecovim", nowait = false, remap = false },
			{ "<leader>//", "<cmd>Alpha<CR>", desc = "Open dashboard", nowait = false, remap = false },
			{ "<leader>/c", "<cmd>e $MYVIMRC<CR>", desc = "Open Neovim config", nowait = false, remap = false },
			{ "<leader>/i", "<cmd>Lazy<CR>", desc = "Manage plugins with Lazy", nowait = false, remap = false },
			{ "<leader>/u", "<cmd>Lazy update<CR>", desc = "Update plugins", nowait = false, remap = false },

			-- Buffers Ocultos
			{ "<leader>1", hidden = true, desc = "Hidden buffer 1", nowait = false, remap = false },
			{ "<leader>2", hidden = true, desc = "Hidden buffer 2", nowait = false, remap = false },
			{ "<leader>3", hidden = true, desc = "Hidden buffer 3", nowait = false, remap = false },
			{ "<leader>4", hidden = true, desc = "Hidden buffer 4", nowait = false, remap = false },
			{ "<leader>5", hidden = true, desc = "Hidden buffer 5", nowait = false, remap = false },
			{ "<leader>6", hidden = true, desc = "Hidden buffer 6", nowait = false, remap = false },
			{ "<leader>7", hidden = true, desc = "Hidden buffer 7", nowait = false, remap = false },
			{ "<leader>8", hidden = true, desc = "Hidden buffer 8", nowait = false, remap = false },
			{ "<leader>9", hidden = true, desc = "Hidden buffer 9", nowait = false, remap = false },

			-- Acciones Generales y Gestión de Buffers
			{ "<leader>a", group = "Actions", nowait = false, remap = false },
			{ "<leader>an", "<cmd>set nonumber!<CR>", desc = "Toggle line numbers", nowait = false, remap = false },
			{
				"<leader>ar",
				"<cmd>set norelativenumber!<CR>",
				desc = "Toggle relative line numbers",
				nowait = false,
				remap = false,
			},
			{ "<leader>b", group = "Buffer", nowait = false, remap = false },
			{
				"<leader>bc",
				'<cmd>lua require("utils").closeOtherBuffers()<CR>',
				desc = "Close all buffers except current",
				nowait = false,
				remap = false,
			},
			{ "<leader>bf", "<cmd>bfirst<CR>", desc = "Go to first buffer", nowait = false, remap = false },
			{ "<leader>bd", ":bd!<CR>", desc = "Force close the current buffer", nowait = false, remap = false },
			{ "<leader>bs", group = "Sort", nowait = false, remap = false },

			-- LSP y Depuración (se cambia <leader> por <M>)
			{ "<M-c>", group = "LSP", nowait = false, remap = false },
			{
				"<M-c>D",
				"<cmd>Telescope diagnostics wrap_results=true<CR>",
				desc = "Workspace diagnostics",
				nowait = false,
				remap = false,
			},
			{ "<M-c>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action", nowait = false, remap = false },
			{
				"<M-c>d",
				"<cmd>TroubleToggle<CR>",
				desc = "Toggle diagnostics in Trouble",
				nowait = false,
				remap = false,
			},
			{ "<M-c>f", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format code", nowait = false, remap = false },
			{
				"<M-c>l",
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				desc = "Line diagnostics",
				nowait = false,
				remap = false,
			},
			{ "<M-c>r", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol", nowait = false, remap = false },
			{ "<M-c>t", "<cmd>LspToggleAutoFormat<CR>", desc = "Toggle format on save", nowait = false, remap = false },

			-- Debugging (se cambia <leader> por <M>)
			{ "<M-d>", group = "Debug", nowait = false, remap = false },
			{
				"<M-d>C",
				"<cmd>lua require'dap'.terminate()<CR>",
				desc = "Terminate debug session",
				nowait = false,
				remap = false,
			},
			{ "<M-d>O", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step out", nowait = false, remap = false },
			{
				"<M-d>U",
				"<cmd>lua require'dapui'.toggle()<CR>",
				desc = "Toggle debug UI",
				nowait = false,
				remap = false,
			},
			{ "<M-d>V", "<cmd>lua require'dap'.up()<CR>", desc = "Step up", nowait = false, remap = false },
			{
				"<M-d>a",
				"<cmd>lua require'dap'.continue()<CR>",
				desc = "Continue execution",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>b",
				"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
				desc = "Toggle breakpoint",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>c",
				"<cmd>lua require'dap'.continue()<CR>",
				desc = "Continue execution",
				nowait = false,
				remap = false,
			},
			{ "<M-d>d", "<cmd>lua require'dap'.run_last()<CR>", desc = "Run last", nowait = false, remap = false },
			{
				"<M-d>h",
				"<cmd>lua require'dap.ui.widgets'.hover()<CR>",
				desc = "Debug hover",
				nowait = false,
				remap = false,
			},
			{ "<M-d>i", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step into", nowait = false, remap = false },
			{ "<M-d>o", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step over", nowait = false, remap = false },
			{
				"<M-d>r",
				"<cmd>lua require'dap'.repl.toggle()<CR>",
				desc = "Toggle REPL",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>s",
				"<cmd>lua require'dap'.list_breakpoints()<CR>",
				desc = "List breakpoints",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>t",
				"<cmd>lua require'dap'.disconnect()<CR>",
				desc = "Disconnect debug session",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>v",
				"<cmd>lua require'dap.ui.variables'.hover()<CR>",
				desc = "View variable value",
				nowait = false,
				remap = false,
			},
			{
				"<M-d>w",
				"<cmd>lua require'dap.ui.variables'.scopes()<CR>",
				desc = "View scopes",
				nowait = false,
				remap = false,
			},

			-- Git Operations (se cambia <leader> por <M>)
			{ "<M-g>", group = "Git", nowait = false, remap = false },
			{ "<M-g>A", "<cmd>!git add .<CR>", desc = "Add all changes", nowait = false, remap = false },
			{ "<M-g>B", "<cmd>Telescope git_branches<CR>", desc = "List git branches", nowait = false, remap = false },
			{ "<M-g>a", "<cmd>!git add %:p<CR>", desc = "Add current file", nowait = false, remap = false },
			{
				"<M-g>b",
				'<cmd>lua require("gitsigns").blame_line()<CR>',
				desc = "Blame current line",
				nowait = false,
				remap = false,
			},
			{ "<M-g>c", group = "Conflict", nowait = false, remap = false },
			{ "<M-g>h", group = "Hunk", nowait = false, remap = false },
			{ "<M-g>i", "<cmd>Octo issue list<CR>", desc = "List GitHub issues", nowait = false, remap = false },
			{ "<M-g>l", group = "Log", nowait = false, remap = false },
			{ "<M-g>p", "<cmd>Octo pr list<CR>", desc = "List GitHub pull requests", nowait = false, remap = false },
			{ "<M-g>s", "<cmd>Telescope git_status<CR>", desc = "Show git status", nowait = false, remap = false },
			{ "<M-g>w", group = "Worktree", nowait = false, remap = false },

			-- Gestión de Proyectos (se cambia <leader> por <M>)
			{ "<M-p>", group = "Project", nowait = false, remap = false },
			{ "<M-p>f", "<cmd>Telescope find_files<CR>", desc = "Find project file", nowait = false, remap = false },
			{
				"<M-p>l",
				"<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
				desc = "List project repositories",
				nowait = false,
				remap = false,
			},
			{
				"<M-p>r",
				"<cmd>Trouble lsp_references<CR>",
				desc = "Refactor project code",
				nowait = false,
				remap = false,
			},
			{ "<M-p>t", "<cmd>TodoTrouble<CR>", desc = "Show project TODOs", nowait = false, remap = false },
			{ "<M-p>w", "<cmd>Telescope live_grep<CR>", desc = "Search project word", nowait = false, remap = false },

			-- Quickfix y Búsqueda (se cambia <leader> por <M>)
			{ "<M-q>", "<cmd>Telescope quickfix<CR>", desc = "Open quicklist", nowait = false, remap = false },
			{ "<M-s>", group = "Search", nowait = false, remap = false },
			{
				"<M-s>H",
				'<cmd>lua require("plugins.telescope").command_history()<CR>',
				desc = "Command history",
				nowait = false,
				remap = false,
			},
			{ "<M-s>c", "<cmd>Telescope colorscheme<CR>", desc = "Select colorscheme", nowait = false, remap = false },
			{
				"<M-s>d",
				'<cmd>lua require("plugins.telescope").edit_neovim()<CR>',
				desc = "Search and edit dotfiles",
				nowait = false,
				remap = false,
			},
			{
				"<M-s>h",
				"<cmd>Telescope oldfiles hidden=true<CR>",
				desc = "Show file history",
				nowait = false,
				remap = false,
			},
			{ "<M-s>q", "<cmd>Telescope quickfix<CR>", desc = "Show quickfix list", nowait = false, remap = false },
			{
				"<M-s>s",
				"<cmd>Telescope search_history theme=dropdown<CR>",
				desc = "Search history",
				nowait = false,
				remap = false,
			},

			-- Modo Tabla (se cambia <leader> por <M>)
			{ "<M-t>", group = "Table Mode", nowait = false, remap = false },
			{ "<M-t>m", "<cmd>TableModeToggle<CR>", desc = "Toggle table mode", nowait = false, remap = false },
			{ "<M-t>t", "<cmd>Tableize<CR>", desc = "Tableize", nowait = false, remap = false },

			-- Otras Acciones Notables (se mantiene <leader>)
			{
				"<CR>",
				function()
					if vim.opt.hlsearch:get() then
						vim.cmd.nohl()
						return ""
					else
						return "<CR>"
					end
				end,
				desc = "Toggle search highlighting or execute enter",
				expr = true,
				nowait = false,
				remap = false,
			},
			{
				"]d",
				vim.diagnostic.goto_next,
				desc = "Go to the next diagnostic and show details",
				nowait = false,
				remap = false,
			},
			{
				"[d",
				vim.diagnostic.goto_prev,
				desc = "Go to the previous diagnostic and show details",
				nowait = false,
				remap = false,
			},
			{ "<C-h>", "<C-w><C-h>", desc = "Move focus to the left split", nowait = false, remap = false },
			{ "<C-l>", "<C-w><C-l>", desc = "Move focus to the right split", nowait = false, remap = false },
			{ "<C-j>", "<C-w><C-j>", desc = "Move focus to the split below", nowait = false, remap = false },
			{ "<C-k>", "<C-w><C-k>", desc = "Move focus to the split above", nowait = false, remap = false },
			{
				"<leader><leader>x",
				'<cmd>source %<CR><cmd>lua print("File sourced")<CR>',
				desc = "Source the current file and print a confirmation",
				nowait = false,
				remap = false,
			},
			{
				"<leader>fz",
				function()
					vim.cmd([[normal zfaf]])
				end,
				desc = "Fold the current function",
				nowait = false,
				remap = false,
			},
			{ "n", "nzzzv", desc = "Jump to next search result and center cursor", nowait = false, remap = false },
			{ "N", "Nzzzv", desc = "Jump to previous search result and center cursor", nowait = false, remap = false },
			{ "J", "mzJ`z", desc = "Join lines without moving the cursor", nowait = false, remap = false },
			{
				"<leader>ee",
				":vsp .env<CR>",
				desc = "Open the .env file in a vertical split",
				nowait = false,
				remap = false,
			},
			{ "<M-,>", "<C-w>5<", desc = "Decrease split width by 5 columns", nowait = false, remap = false },
			{ "<M-.>", "<C-w>5>", desc = "Increase split width by 5 columns", nowait = false, remap = false },
			{ "<M-t>", "<C-W>5+", desc = "Increase split height by 5 rows", nowait = false, remap = false },
			{ "<M-s>", "<C-W>5-", desc = "Decrease split height by 5 rows", nowait = false, remap = false },
			{
				"<M-j>",
				function()
					if vim.opt.diff:get() then
						vim.cmd([[normal! ]c]])
					else
						vim.cmd([[m .+1<CR>==]])
					end
				end,
				desc = "Move current line down or jump to next diff hunk",
				nowait = false,
				remap = false,
			},
			{
				"<M-k>",
				function()
					if vim.opt.diff:get() then
						vim.cmd([[normal! ]c]])
					else
						vim.cmd([[m .-2<CR>==]])
					end
				end,
				desc = "Move current line up or jump to previous diff hunk",
				nowait = false,
				remap = false,
			},

			-- Conform Plugin (se mantiene <leader>)
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files", nowait = false, remap = false },

			-- Gitsigns Plugin (se mantiene <leader>)
			{
				"<leader>gB",
				'<cmd>lua require("gitsigns").blame_line()<CR>',
				desc = "Blame current line",
				nowait = false,
				remap = false,
			},
			{
				"<leader>gh",
				'<cmd>lua require("gitsigns").preview_hunk()<CR>',
				desc = "Preview hunk",
				nowait = false,
				remap = false,
			},

			-- Harpoon Plugin (se mantiene <leader>)
			{ "<leader>h", group = "Harpoon", nowait = false, remap = false },
			{
				"<leader>ha",
				'<cmd>lua require("harpoon.mark").add_file()<CR>',
				desc = "Add file to Harpoon",
				nowait = false,
				remap = false,
			},
			{
				"<leader>hm",
				'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
				desc = "Toggle Harpoon menu",
				nowait = false,
				remap = false,
			},
			{
				"<leader>h1",
				'<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
				desc = "Navigate to Harpoon file 1",
				nowait = false,
				remap = false,
			},
			{
				"<leader>h2",
				'<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
				desc = "Navigate to Harpoon file 2",
				nowait = false,
				remap = false,
			},

			-- nvim-lint Plugin (se mantiene <leader>)
			{
				"<leader>ll",
				"<cmd>lua require('lint').try_lint()<CR>",
				desc = "Run linter on current file",
				nowait = false,
				remap = false,
			},

			-- nvim-ufo Plugin (se mantiene <leader>)
			{
				"zR",
				'<cmd>lua require("ufo").openAllFolds()<CR>',
				desc = "Open all folds",
				nowait = false,
				remap = false,
			},
			{
				"zM",
				'<cmd>lua require("ufo").closeAllFolds()<CR>',
				desc = "Close all folds",
				nowait = false,
				remap = false,
			},

			-- Telescope Plugin (se mantiene <leader>)
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files", nowait = false, remap = false },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep", nowait = false, remap = false },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers", nowait = false, remap = false },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find help tags", nowait = false, remap = false },
		}

		-- Mapeos en modo visual
		local visual_mode_mappings = {
			{ "<", "<gv", desc = "Decrease indent and retain selection", nowait = false, remap = false },
			{ ">", ">gv", desc = "Increase indent and retain selection", nowait = false, remap = false },
			{ "<leader>a", group = "Actions", nowait = false, remap = false },
			{ "<leader>c", group = "LSP", nowait = false, remap = false },
			{
				"<leader>ca",
				"<cmd>lua vim.lsp.buf.range_code_action()<CR>",
				desc = "Range code action",
				nowait = false,
				remap = false,
			},
			{
				"<leader>cf",
				"<cmd>lua vim.lsp.buf.range_formatting()<CR>",
				desc = "Range format",
				nowait = false,
				remap = false,
			},
			{ "<leader>g", group = "Git", nowait = false, remap = false },
			{ "<leader>gh", group = "Hunk", nowait = false, remap = false },
			{
				"<leader>ghr",
				'<cmd>lua require("gitsigns").reset_hunk()<CR>',
				desc = "Reset hunk",
				nowait = false,
				remap = false,
			},
			{
				"<leader>ghs",
				'<cmd>lua require("gitsigns").stage_hunk()<CR>',
				desc = "Stage hunk",
				nowait = false,
				remap = false,
			},
			{ "<leader>p", group = "Project", nowait = false, remap = false },
			{
				"<leader>pr",
				"<cmd>Trouble lsp_references<CR>",
				desc = "Refactor project code",
				nowait = false,
				remap = false,
			},
			{ "<leader>r", group = "Refactor", nowait = false, remap = false },
			{ "<leader>s", "<cmd>'<,'>sort<CR>", desc = "Sort selected text", nowait = false, remap = false },
			{ "<leader>t", group = "Table Mode", nowait = false, remap = false },
			{ "<leader>tt", "<cmd>Tableize<CR>", desc = "Tableize", nowait = false, remap = false },
		}

		-- Mapeos en modo terminal
		local terminal_mode_mappings = {
			{ "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode to normal mode", nowait = false, remap = false },
			{
				"<C-w>h",
				"<C-\\><C-n><C-w>h",
				desc = "Navigate to the left split from terminal mode",
				nowait = false,
				remap = false,
			},
			{
				"<C-w>j",
				"<C-\\><C-n><C-w>j",
				desc = "Navigate to the split below from terminal mode",
				nowait = false,
				remap = false,
			},
			{
				"<C-w>k",
				"<C-\\><C-n><C-w>k",
				desc = "Navigate to the split above from terminal mode",
				nowait = false,
				remap = false,
			},
			{
				"<C-w>l",
				"<C-\\><C-n><C-w>l",
				desc = "Navigate to the right split from terminal mode",
				nowait = false,
				remap = false,
			},
		}
		wk.add(normal_mode_mappings, { mode = "n" })
		wk.add(visual_mode_mappings, { mode = "v" })
		wk.add(terminal_mode_mappings, { mode = "t" })

		local function attach_markdown(bufnr)
			wk.add({
				a = {
					name = "Actions",
					m = { "<cmd>MarkdownPreviewToggle<CR>", "markdown preview" },
				},
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_typescript(bufnr)
			wk.add({
				c = {
					name = "LSP",
					e = { "<cmd>TSC<CR>", "workspace errors (TSC)" },
					F = { "<cmd>TSToolsFixAll<CR>", "fix all" },
					i = { "<cmd>TSToolsAddMissingImports<CR>", "import all" },
					o = { "<cmd>TSToolsOrganizeImports<CR>", "organize imports" },
					s = { "<cmd>TSToolsSortImports<CR>", "sort imports" },
					u = { "<cmd>TSToolsRemoveUnused<CR>", "remove unused" },
				},
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_npm(bufnr)
			wk.add({
				n = {
					name = "NPM",
					c = { '<cmd>lua require("package-info").change_version()<CR>', "change version" },
					d = { '<cmd>lua require("package-info").delete()<CR>', "delete package" },
					h = { "<cmd>lua require('package-info').hide()<CR>", "hide" },
					i = { '<cmd>lua require("package-info").install()<CR>', "install new package" },
					r = { '<cmd>lua require("package-info").reinstall()<CR>', "reinstall dependencies" },
					s = { '<cmd>lua require("package-info").show()<CR>', "show" },
					u = { '<cmd>lua require("package-info").update()<CR>', "update package" },
				},
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_zen(bufnr)
			wk.add({
				["z"] = { "<cmd>ZenMode<CR>", "zen" },
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_jest(bufnr)
			wk.add({
				j = {
					name = "Jest",
					f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "run current file" },
					i = { '<cmd>lua require("neotest").summary.toggle()<CR>', "toggle info panel" },
					j = { '<cmd>lua require("neotest").run.run()<CR>', "run nearest test" },
					l = { '<cmd>lua require("neotest").run.run_last()<CR>', "run last test" },
					o = { '<cmd>lua require("neotest").output.open({ enter = true })<CR>', "open test output" },
					s = { '<cmd>lua require("neotest").run.stop()<CR>', "stop" },
				},
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_spectre(bufnr)
			wk.add({
				["R"] = { "[SPECTRE] Replace all" },
				["o"] = { "[SPECTRE] Show options" },
				["q"] = { "[SPECTRE] Send all to quicklist" },
				["v"] = { "[SPECTRE] Change view mode" },
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		local function attach_nvim_tree(bufnr)
			wk.add({
				["="] = { "<cmd>NvimTreeResize +5<CR>", "resize +5" },
				["-"] = { "<cmd>NvimTreeResize -5<CR>", "resize +5" },
			}, {
				buffer = bufnr,
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		end

		return {
			attach_markdown = attach_markdown,
			attach_typescript = attach_typescript,
			attach_npm = attach_npm,
			attach_zen = attach_zen,
			attach_jest = attach_jest,
			attach_spectre = attach_spectre,
			attach_nvim_tree = attach_nvim_tree,
		}
	end,
}
