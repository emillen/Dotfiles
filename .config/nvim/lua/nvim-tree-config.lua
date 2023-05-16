-- examples for your init.lua

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	hijack_netrw = true,
	disable_netrw = true,
	hijack_unnamed_buffer_when_opening = true,
	git = {
		ignore = false,
	},
	update_focused_file = {
		enable = true,
		update_root = false,
		ignore_list = {},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
