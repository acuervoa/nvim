local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

-- Markdown disable indent line
au("BufEnter", {
	pattern = "markdown",
	callback = function()
		vim.g.indentLine_enabled = 0
	end,
})

-- Highlight yanked text
au("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
	end,
	group = ag("yank_highlight", {}),
})

-- Automatically resize splits when window is resized
au("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

-- close some filetypes with <q>
au("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Active wrap y spell to some filetypes
au("FileType", {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage", "norg" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Remove blank spaces at the end of the lines when save file
au({ "BufWritePre" }, {
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
	end,
})
