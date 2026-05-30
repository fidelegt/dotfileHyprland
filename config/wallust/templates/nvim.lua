-- Auto generado por wallust

vim.cmd("highlight clear")
vim.cmd("set termguicolors")

local colors = {
	background = "{{background}}",
	foreground = "{{foreground}}",

	color0 = "{{color0}}",
	color1 = "{{color1}}",
	color2 = "{{color2}}",
	color3 = "{{color3}}",
	color4 = "{{color4}}",
	color5 = "{{color5}}",
	color6 = "{{color6}}",
	color7 = "{{color7}}",
}

vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.color7, italic = true })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.color5 })
vim.api.nvim_set_hl(0, "String", { fg = colors.color2 })
vim.api.nvim_set_hl(0, "Function", { fg = colors.color4 })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.color6 })
vim.api.nvim_set_hl(0, "Type", { fg = colors.color3 })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.color1 })

vim.api.nvim_set_hl(0, "LineNr", { fg = colors.color5 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.color4 })
vim.api.nvim_set_hl(0, "Visual", { bg = colors.color2 })
