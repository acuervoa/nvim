-- ~/.config/nvim/lua/plugins/mason.lua

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim", -- Integrates Mason with nvim-lspconfig
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Automatically installs tools managed by Mason
	},
	config = function()
		-- Setup Mason
		require("mason").setup()

		-- Setup Mason tool installer
		local ensure_installed = {
			"stylua", -- Lua formatter
			"lua_ls", -- Lua LSP
			"pyright", -- Python LSP
			"tsserver", -- TypeScript/JavaScript LSP
			"debugpy", -- Python debugger
			"php-debug-adapter", -- PHP debugger
			"node-debug2-adapter", -- Node.js debugger for JavasScript/TypeScript
			"codelldb", --Rust and C/C++ debugger
			"bash-debug-adapter", --Bash debugger
			-- Add more tools and servers as needed
			"isort",
			"black",
			"rustfm",
			"prettierd",
			"prettier",
			"php-cs-fixer",
			"shfmt",
			"rust-analyzer",
		}
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = false,
			run_on_start = true,
		})

		-- Setup Mason-LSPConfig
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(
							vim.lsp.protocol.make_client_capabilities()
						),
					})
				end,
			},
		})

		-- Setup Mason-Nvim-Dap
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"debugpy",
				"php-debug-adapter",
				"node-debug2-adapter",
				"codelldb",
				"bash-debug-adapter",
			},
			automatic_installation = true,
		})

		require("mason-null-ls").setup({
			ensure_installed = { "prettier", "eslint_d" },
		})
	end,
}
