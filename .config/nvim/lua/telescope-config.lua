require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-j>"] = require("telescope.actions").move_selection_next,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
				n = {
					["<c-d>"] = "delete_buffer",
				},
			},
		},
	},
})
