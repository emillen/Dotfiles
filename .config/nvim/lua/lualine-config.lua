local colors = {
	orange = "#fe8019",
	green = "#98971a",
	yellow = "#d79921",
	purple = "#b16286",
	gray = "#3c3836",
	black = "#1d2021",
	white = "#ebdbb2",
	blue = "#458588",
}
-- jag gillar glass
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
