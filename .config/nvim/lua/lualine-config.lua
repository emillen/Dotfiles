local theme = require("lualine.themes.modus-vivendi")
local orange = "#cc7832"
local green = "#6a8759"
local yellow = "#ffc66d"
local purple = "#9876aa"

theme.normal.a.bg = orange
theme.normal.b.fg = orange

theme.insert.a.bg = green
theme.insert.b.fg = green

theme.visual.a.bg = purple
theme.visual.b.fg = purple

theme.replace.a.bg = yellow
theme.replace.b.fg = yellow

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
	},
})
