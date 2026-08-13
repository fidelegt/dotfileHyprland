-- Auto generado por wallust - Versión con mejor contraste

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

-- Función auxiliar para mejorar contraste (más brillante si es necesario)
local function brighten(color, amount)
	-- Simple fallback: si es muy oscuro, usamos color7 (blanco/gris claro)
	return color
end

-- Colores base con mejor legibilidad
vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.foreground, bg = colors.background })

-- Sintaxis mejorada
vim.api.nvim_set_hl(0, "Comment", { fg = colors.color7, italic = true }) -- Comentarios claros

vim.api.nvim_set_hl(0, "String", { fg = colors.color2 }) -- String
vim.api.nvim_set_hl(0, "Character", { fg = colors.color2 })

vim.api.nvim_set_hl(0, "Keyword", { fg = colors.color5, bold = true })
vim.api.nvim_set_hl(0, "Function", { fg = colors.color4, bold = false })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.color6 })
vim.api.nvim_set_hl(0, "Type", { fg = colors.color3 })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.color1 })

-- Números de línea y cursor
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.color7 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.color4, bold = true })

-- Selección
vim.api.nvim_set_hl(0, "Visual", { bg = colors.color4, fg = colors.background })

-- Mejoras adicionales para esquemas oscuros
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f1f1f" }) -- Fondo sutil
vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.foreground, bg = colors.color0 })
vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.color5, bold = true, underline = true })

-- Treesitter (si lo usas)
vim.api.nvim_set_hl(0, "@string", { fg = colors.color2 })
vim.api.nvim_set_hl(0, "@function", { fg = colors.color4 })
vim.api.nvim_set_hl(0, "@keyword", { fg = colors.color5 })
vim.api.nvim_set_hl(0, "@variable", { fg = colors.foreground })
vim.api.nvim_set_hl(0, "@comment", { fg = colors.color7, italic = true })
