return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		---@diagnostic disable-next-line: missing-fields
		notify.setup({
			stages = "fade_in_slide_out", -- animation style
			timeout = 1500, -- default timeout for notifications
			background_colour = "#2E3440",
		})
		-- this overwrites the vim notify function
		vim.notify = notify.notify
	end,
}
