-- Neovim API aliases

local cmd = vim.cmd -- Execute Vim commands
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local api = vim.api -- call Vim api
local ag = vim.api.nvim_create_augroup -- create autogroup
local au = vim.api.nvim_create_autocmd -- create autocomand

-- General
g.mapleader = " " -- change leader to a space
g.maplocalleader = "\\"
opt.backup = false -- don't create backup files
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
opt.mouse = "a" -- enable mouse support
opt.swapfile = false -- don't use swapfile
opt.writebackup = false -- don't create backup files while writing
vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"

-- UI
opt.colorcolumn = "80" -- line length marker at 80 columns
opt.conceallevel = 0 -- disable conceal text
opt.cursorline = true -- show which line your cursor is on
opt.cursorlineopt = "number" -- only highlight the line number
opt.equalalways = false -- don't resize windows automatically
opt.errorbells = false -- deactivate error sounds
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99 -- should open all folds
opt.foldmethod = "expr" -- enable folding (default: 'foldmarker')
opt.guifont = "RoboNoto Nerd Font"
opt.hlsearch = true -- Activate marker in current search
opt.ignorecase = true -- ignore case letters when search
opt.inccommand = "split" -- Preview substituions live, as your type!
opt.incsearch = true -- Enable incremental search
opt.laststatus = 3 -- show only one status var for all windows
opt.linebreak = true -- wrap on word boundary
opt.list = true -- enable show chars in blank spaces
opt.listchars = "tab:▸ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»"
opt.number = true -- show line number
opt.relativenumber = true -- show relative line number
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
opt.shada = { "'10", "<0", "s10", "h" } -- Save up to 10 marks per file, no recent files, last 10 search commands, and command history

opt.sidescrolloff = 4 -- Minimal number of screen columns to keep left and right the cursor
opt.showbreak = "↳ " -- show symbol at broken line
opt.showmatch = true -- highlight matching parenthesis
opt.showmode = false -- Don't show mode, since it's already in the status line
opt.signcolumn = "yes:1" -- Always show sign column with a fixed width
opt.smartcase = true -- ignore lowecase for the whole pattern
opt.splitbelow = true -- horizontal split to the bottom
opt.splitright = true -- vertical split to the right
opt.termguicolors = true -- enable 24 bits colors in terminal

-- Memory, CPU
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = false -- faster scrolling
opt.synmaxcol = 1000 -- max column for syntax highlight
opt.updatetime = 50 -- Reduce update time to 50ms
opt.timeoutlen = 300 -- Decrease mapped sequence wait tie (display whick-key popup sooner

-- Tabs, indent
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.smartindent = true -- autoindent new lines
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.softtabstop = 4 -- Mode insertion uses tab as 4 spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- Keyboard timeout
opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete

-- Completion options
opt.completeopt = "menuone,noinsert,noselect" -- completion options

cmd([[au BufEnter * set fo-=c fo-=r fo-=o]]) -- Don't auto commenting new lines
cmd([[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]]) -- remove line lenght marker for selecte filetypes

--g,indentLine_setColors = 0        -- set indentLine color
g.indentLine_char = "|" -- set indentLine character
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- [[ Basic Keymaps ]]

-- Set highlight on search, but clear on pressing <ESC> in normal mode
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickix list" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!!"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!!"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!!"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!!"<CR>')
--
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See :help wincmd for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
