return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"blade",
				"css",
				"go",
				"gomod",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"nix",
				"org",
				"php",
				"phpdoc",
				"python",
				"query",
				"rust",
				"sql",
				"svelte",
				"toml",
				"typescript",
				"regex",
				"vim",
				"yaml",
			},
			ignore_install = {},
			highlight = {
				enable = true,
				disable = { "help" },
				additional_vim_regex_highlighting = { "org" },
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			modules = {},
			sync_install = false,
			auto_install = true,
		})

		-- local function(plug, config)
		--   local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		--   parser_config.blade = {
		--     install_info = {
		--       url = "https://github.com/EmranMR/tree-sitter-blade",
		--       files = {"src/parser.c"},
		--       branch = "main",
		--     },
		--     filetype = "blade"
		--   }
		--
		--   vim.filetype.add({
		--     pattern = {
		--       ['.*%.blade%.php'] = 'blade',
		--     }
		--   })
		--
		--   require(plug.main).setup(config);
		-- end
	end,
}
