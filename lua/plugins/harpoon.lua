return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<m-h><m-m>", function()
			harpoon:list():add()
		end, { desc = "Mark current position with Harpoon" })
		vim.keymap.set("n", "<m-h><m-l>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "List Harpoon marks" })

		-- Set <space>1..<space>5 be my sorcurs to movint to the files
		for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
			vim.keymap.set("n", string.format("<leader>%d", idx), function()
				harpoon:list():select(idx)
			end, { desc = "Jump to Harpoon mark " .. idx })
		end
	end,
}
