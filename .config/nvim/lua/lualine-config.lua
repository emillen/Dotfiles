local colors = {
	orange = "#cc7832",
	green = "#6a8759",
	yellow = "#ffc66d",
	purple = "#9876aa",
	gray = "#323232",
	black = "#2b2b2b",
	white = "#c5c8c6",
	blue = "#6897bb",
}

local theme = {
	normal = {
		a = { bg = colors.orange, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	insert = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	visual = {
		a = { bg = colors.purple, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	replace = {
		a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	command = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
	inactive = {
		a = { bg = colors.orange, fg = colors.black, gui = "bold" },
		b = { bg = colors.gray, fg = colors.white },
		c = { bg = colors.gray, fg = colors.white },
	},
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
	},
})
