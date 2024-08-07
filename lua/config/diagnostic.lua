-- Disable virtual text for diagnostics
vim.diagnostic.config({
	virtual_text = false,
})

-- Define custom icons for diagnostic signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }

-- Loop through each diagnostic type and its corresponding icon
for type, icon in pairs(signs) do
	-- Create the highlight group name by concatenating 'DiagnosticSign' with the diagnostic type
	local hl = "DiagnosticSign" .. type
	-- Define the diagnostic sign with the custom icon and highlight group
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
