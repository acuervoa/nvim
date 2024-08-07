-- lua/plugins/cmp.lua
-- Autocompletion
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			build = (function()
				-- Check if the system is Windows or if 'make' is not executable, and skip the build process in such cases.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"onsails/lspkind-nvim",
		"hrsh7th/cmp-path", -- Path source for nvim-cmp
		"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
		"hrsh7th/cmp-omni",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
		"hrsh7th/cmp-cmdline", -- Command line source for nvim-cmp
		"hrsh7th/cmp-nvim-lua", -- Neovim Lua API source for nvim-cmp
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				-- Define how snippets should be expanded.
				expand = function(args)
					luasnip.lsp_expand(args.body)
					--                    vim.fn("vsnip#anonymous")(args.body)
				end,
			},
			-- Configure the completion menu options.
			completion = { completeopt = "menu,menuone,noinsert,noselect" },

			-- Key mappings for the completion menu.
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection.
				["<C-e>"] = cmp.mapping.abort(), -- Abort completion.
				["<Esc>"] = cmp.mapping.close(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up.
				["<C-u>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down.
				["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Select next item.
				["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Select previous item.
				["<C-n>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-p>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- Define the sources for autocompletion.
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP source.
				{ name = "luasnip" }, -- Snippet source.
				{ name = "buffer", keyword_length = 2 }, -- Buffer source.
				{ name = "path" }, -- Path source.
				{ name = "nvim_lua" }, -- Neovim Lua API source.
				{ name = "cmdline" }, -- Command line source.
				{ name = "null-ls" },
				{ name = "emoji", insert = true },
			}),

			-- Customize the formatting of the completion menu items.
			view = {
				entries = "custom",
			},
			---@diagnostic disable-next-line: missing-fields
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					menu = {
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						nvim_lua = "[Lua]",
						path = "[Path]",
						buffer = "[Buffer]",
						emoji = "[Emoji]",
						omni = "[Omni]",
						cmdline = "[Cmd]",
					},
				}),
			},

			-- Enable experimental features.
			experimental = {
				ghost_text = true, -- Show ghost text for suggestions.
			},
		})

		cmp.setup.filetype("tex", {
			sources = {
				{ name = "omni" },
				{ name = "buffer", keyword_length = 2 },
				{ name = "path" },
			},
		})

		-- Configuracion para un tipo de archivo especifico
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "cmp_git" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Usar fuente de buffer para '/' y '?'
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Specific setup for command line completion.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
		vim.cmd([[
          highlight! link CmpItemMenu Comment
          " gray
          highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
          " blue
          highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
          highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
          " light blue
          highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
          highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
          highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
          " pink
          highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
          highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
          " front
          highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
          highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
          highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
        ]])
	end,
}
