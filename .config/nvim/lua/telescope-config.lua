require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "%.git/.*" },
		mappings = {
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-j>"] = require("telescope.actions").move_selection_next,
			},
		},
	},
	pickers = {
		live_grep = {
			additional_args = function()
				return { "--hidden", "--no-ignore-vcs", "--glob", "!.git" }
			end,
		},
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
