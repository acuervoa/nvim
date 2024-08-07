local map = vim.keymap.set

-- Toggle hlsearch if it's on, otherwise just do "enter"
map("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.hlsearch:get() then
		vim.cmd.nohl()
		return ""
	else
		return "<CR>"
	end
end, { expr = true })

-- Thre are builtin keymaps for this now, but I like that it shows
-- the float when I navigate to the error - so I override them.
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)

-- Keybinds to make split navigation easier.
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- quick exec
--map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
map(
	"n",
	"<leader><leader>x",
	'<cmd>source %<CR><cmd>lua print("File sourced")<CR>',
	{ desc = "Execute the current file" }
)

-- remove buffer
map("n", "<leader>bd", ":bd!<CR>", { desc = "Deletes the current buffer" })

-- folder functions
map("n", "<leader>fz", function()
	vim.cmd([[normal zfaf]])
end, { desc = "Fold the function" })

-- Indent in visual mode
map("v", "<", "<gv", { desc = "Indent out and keeps the selection" })
map("v", ">", ">gv", { desc = "Indent in and keeps the selection" })

-- Focus the next search result
map("n", "n", "nzzzv", { desc = "Goes to text result on the search and put the cursor in the middle of the screen" })
map("n", "N", "Nzzzv", { desc = "Goes to prev result on the search and put the cursor in the middle of the screen" })

-- join lines focus
map("n", "J", "mzJ`z", { desc = "Join lines and keep in the same place the cursor" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- navigate between windows in terminal mode
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- quick env file edit
map("n", "<leader>ee", ":vsp .env<CR>", { desc = "Open .env file in a vertical split" })

-- These mapping control the size of splits (height/width)
map("n", "<M-,>", "<C-w>5<")
map("n", "<M-.>", "<C-w>5>")
map("n", "<M-t>", "<C-W>5+")
map("n", "<M-s>", "<C-W>5-")

-- Move lines up/down with <alt+k>/<alt+j>
map("n", "<M-j>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .+1<CR>==]])
	end
end)

map("n", "<M-k>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .-2<CR>==]])
	end
end)
