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
			triggers = { "<leader>", "<LocalLeader>" },
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

		local normal_mode_mappings = {
			{ "<leader>-", "<cmd>vertical resize -5<CR>", desc = "resize +5", nowait = false, remap = false },
			{ "<leader>/", group = "Ecovim", nowait = false, remap = false },
			{ "<leader>//", "<cmd>Alpha<CR>", desc = "open dashboard", nowait = false, remap = false },
			{ "<leader>/c", "<cmd>e $MYVIMRC<CR>", desc = "open config", nowait = false, remap = false },
			{ "<leader>/i", "<cmd>Lazy<CR>", desc = "manage plugins", nowait = false, remap = false },
			{ "<leader>/s", group = "Session", nowait = false, remap = false },
			{ "<leader>/u", "<cmd>Lazy update<CR>", desc = "update plugins", nowait = false, remap = false },
			{ "<leader>1", hidden = true, nowait = false, remap = false },
			{ "<leader>2", hidden = true, nowait = false, remap = false },
			{ "<leader>3", hidden = true, nowait = false, remap = false },
			{ "<leader>4", hidden = true, nowait = false, remap = false },
			{ "<leader>5", hidden = true, nowait = false, remap = false },
			{ "<leader>6", hidden = true, nowait = false, remap = false },
			{ "<leader>7", hidden = true, nowait = false, remap = false },
			{ "<leader>8", hidden = true, nowait = false, remap = false },
			{ "<leader>9", hidden = true, nowait = false, remap = false },
			{ "<leader>=", "<cmd>vertical resize +5<CR>", desc = "resize +5", nowait = false, remap = false },
			{ "<leader>V", "<C-W>s", desc = "split below", nowait = false, remap = false },
			{ "<leader>a", group = "Actions", nowait = false, remap = false },
			{ "<leader>an", "<cmd>set nonumber!<CR>", desc = "line numbers", nowait = false, remap = false },
			{ "<leader>ar", "<cmd>set norelativenumber!<CR>", desc = "relative number", nowait = false, remap = false },
			{ "<leader>b", group = "Buffer", nowait = false, remap = false },
			{
				"<leader>bc",
				'<cmd>lua require("utils").closeOtherBuffers()<CR>',
				desc = "Close but current",
				nowait = false,
				remap = false,
			},
			{ "<leader>bf", "<cmd>bfirst<CR>", desc = "First buffer", nowait = false, remap = false },
			{ "<leader>bs", group = "Sort", nowait = false, remap = false },
			{ "<leader>c", group = "LSP", nowait = false, remap = false },
			{
				"<leader>cD",
				"<cmd>Telescope diagnostics wrap_results=true<CR>",
				desc = "workspace diagnostics",
				nowait = false,
				remap = false,
			},
			{ "<leader>cR", desc = "structural replace", nowait = false, remap = false },
			{ "<leader>ca", desc = "code action", nowait = false, remap = false },
			{
				"<leader>cd",
				"<cmd>Trouble diagnostics toggle<CR>",
				desc = "local diagnostics",
				nowait = false,
				remap = false,
			},
			{ "<leader>cf", desc = "format", nowait = false, remap = false },
			{ "<leader>cl", desc = "line diagnostics", nowait = false, remap = false },
			{ "<leader>cr", desc = "rename", nowait = false, remap = false },
			{
				"<leader>ct",
				"<cmd>LspToggleAutoFormat<CR>",
				desc = "toggle format on save",
				nowait = false,
				remap = false,
			},
			{ "<leader>d", group = "Debug", nowait = false, remap = false },
			{ "<leader>dC", desc = "close UI", nowait = false, remap = false },
			{ "<leader>dO", desc = "step out", nowait = false, remap = false },
			{ "<leader>dU", desc = "open UI", nowait = false, remap = false },
			{ "<leader>dV", desc = "log variable above", nowait = false, remap = false },
			{ "<leader>da", desc = "attach", nowait = false, remap = false },
			{ "<leader>db", desc = "breakpoint", nowait = false, remap = false },
			{ "<leader>dc", desc = "continue", nowait = false, remap = false },
			{ "<leader>dd", desc = "continue", nowait = false, remap = false },
			{ "<leader>dh", desc = "visual hover", nowait = false, remap = false },
			{ "<leader>di", desc = "step into", nowait = false, remap = false },
			{ "<leader>do", desc = "step over", nowait = false, remap = false },
			{ "<leader>dr", desc = "repl", nowait = false, remap = false },
			{ "<leader>ds", desc = "scopes", nowait = false, remap = false },
			{ "<leader>dt", desc = "terminate", nowait = false, remap = false },
			{ "<leader>dv", desc = "log variable", nowait = false, remap = false },
			{ "<leader>dw", desc = "watches", nowait = false, remap = false },
			{ "<leader>g", group = "Git", nowait = false, remap = false },
			{ "<leader>gA", "<cmd>!git add .<CR>", desc = "add all", nowait = false, remap = false },
			{ "<leader>gB", "<cmd>Telescope git_branches<CR>", desc = "branches", nowait = false, remap = false },
			{ "<leader>ga", "<cmd>!git add %:p<CR>", desc = "add current", nowait = false, remap = false },
			{
				"<leader>gb",
				'<cmd>lua require("internal.blame").open()<CR>',
				desc = "blame",
				nowait = false,
				remap = false,
			},
			{ "<leader>gc", group = "Conflict", nowait = false, remap = false },
			{ "<leader>gh", group = "Hunk", nowait = false, remap = false },
			{ "<leader>gi", "<cmd>Octo issue list<CR>", desc = "Issues List", nowait = false, remap = false },
			{ "<leader>gl", group = "Log", nowait = false, remap = false },
			{
				"<leader>glA",
				'<cmd>lua require("plugins.telescope").my_git_commits()<CR>',
				desc = "commits (Telescope)",
				nowait = false,
				remap = false,
			},
			{
				"<leader>glC",
				'<cmd>lua require("plugins.telescope").my_git_bcommits()<CR>',
				desc = "buffer commits (Telescope)",
				nowait = false,
				remap = false,
			},
			{ "<leader>gla", "<cmd>LazyGitFilter<CR>", desc = "commits", nowait = false, remap = false },
			{
				"<leader>glc",
				"<cmd>LazyGitFilterCurrentFile<CR>",
				desc = "buffer commits",
				nowait = false,
				remap = false,
			},
			{ "<leader>gm", desc = "blame line", nowait = false, remap = false },
			{ "<leader>gp", "<cmd>Octo pr list<CR>", desc = "Pull Requests List", nowait = false, remap = false },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "telescope status", nowait = false, remap = false },
			{ "<leader>gw", group = "Worktree", nowait = false, remap = false },
			{ "<leader>gwc", desc = "create worktree", nowait = false, remap = false },
			{ "<leader>gww", desc = "worktrees", nowait = false, remap = false },
			{ "<leader>p", group = "Project", nowait = false, remap = false },
			{ "<leader>pf", desc = "file", nowait = false, remap = false },
			{
				"<leader>pl",
				"<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
				desc = "list",
				nowait = false,
				remap = false,
			},
			{ "<leader>pr", desc = "refactor", nowait = false, remap = false },
			{ "<leader>pt", "<cmd>TodoTrouble<CR>", desc = "todo", nowait = false, remap = false },
			{ "<leader>pw", desc = "word", nowait = false, remap = false },
			{ "<leader>q", desc = "quicklist", nowait = false, remap = false },
			{ "<leader>r", group = "Refactor", nowait = false, remap = false },
			{ "<leader>s", group = "Search", nowait = false, remap = false },
			{
				"<leader>sH",
				'<cmd>lua require("plugins.telescope").command_history()<CR>',
				desc = "command history",
				nowait = false,
				remap = false,
			},
			{ "<leader>sc", "<cmd>Telescope colorscheme<CR>", desc = "color schemes", nowait = false, remap = false },
			{
				"<leader>sd",
				'<cmd>lua require("plugins.telescope").edit_neovim()<CR>',
				desc = "dotfiles",
				nowait = false,
				remap = false,
			},
			{
				"<leader>sh",
				"<cmd>Telescope oldfiles hidden=true<CR>",
				desc = "file history",
				nowait = false,
				remap = false,
			},
			{ "<leader>sq", "<cmd>Telescope quickfix<CR>", desc = "quickfix list", nowait = false, remap = false },
			{
				"<leader>ss",
				"<cmd>Telescope search_history theme=dropdown<CR>",
				desc = "search history",
				nowait = false,
				remap = false,
			},
			{ "<leader>t", group = "Table Mode", nowait = false, remap = false },
			{ "<leader>tm", desc = "toggle", nowait = false, remap = false },
			{ "<leader>tt", desc = "tableize", nowait = false, remap = false },
			{ "<leader>v", "<C-W>v", desc = "split right", nowait = false, remap = false },
		}

		local visual_mode_mappings = {
			mode = { "v" },
			{ "<leader>a", group = "Actions", nowait = false, remap = false },
			{ "<leader>c", group = "LSP", nowait = false, remap = false },
			{ "<leader>ca", desc = "range code action", nowait = false, remap = false },
			{ "<leader>cf", desc = "range format", nowait = false, remap = false },
			{ "<leader>g", group = "Git", nowait = false, remap = false },
			{ "<leader>gh", group = "Hunk", nowait = false, remap = false },
			{ "<leader>ghr", desc = "reset hunk", nowait = false, remap = false },
			{ "<leader>ghs", desc = "stage hunk", nowait = false, remap = false },
			{ "<leader>p", group = "Project", nowait = false, remap = false },
			{ "<leader>pr", desc = "refactor", nowait = false, remap = false },
			{ "<leader>r", group = "Refactor", nowait = false, remap = false },
			{ "<leader>s", "<cmd>'<,'>sort<CR>", desc = "sort", nowait = false, remap = false },
			{ "<leader>t", group = "Table Mode", nowait = false, remap = false },
			{ "<leader>tt", desc = "tableize", nowait = false, remap = false },
		}

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Register                                                 │
		-- ╰──────────────────────────────────────────────────────────╯

		wk.add(normal_mode_mappings, opts)
		wk.add(visual_mode_mappings, visual_opts)

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
