return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")
		require("conform").setup({
			formatters_by_ft = {
				css = { "prettied", "prettier" },
				graphql = { "prettied", "prettier" },
				html = { "prettied", "prettier" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettied", "prettier" },
				json = { "prettied", "prettier" },
				markdown = { "prettied", "prettier" },
				typescript = { "prettied", "prettier" },
				typescriptreact = { "prettied", "prettier" },
				yeml = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", "ast-grep", lsp_format = "fallback" },
				php = { "php-cs-fixer" },
				bash = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "format file" })

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			conform.format({ async = true, lsp_fallback = true, range = range })
		end, { range = true })
	end,
}
