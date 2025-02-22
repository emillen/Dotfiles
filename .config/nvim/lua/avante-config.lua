require("avante_lib").load()
require("avante").setup({
	debug = false,
	provider = "copilot",
	-- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
	-- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
	-- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
	auto_suggestions_provider = "copilot",
	cursor_applying_provider = nil,
	-- Used for counting tokens and encoding text.
	-- By default, we will use tiktoken.
	-- For most providers that we support we will determine this automatically.
	-- If you wish to use a given implementation, then you can override it here.
	tokenizer = "tiktoken",
	rag_service = {
		enabled = false, -- Enables the rag service, requires OPENAI_API_KEY to be set
	},
	-- claude = {
	-- 	endpoint = "https://api.anthropic.com",
	-- 	model = "claude-3-5-sonnet-20241022",
	-- 	timeout = 30000, -- Timeout in milliseconds
	-- 	temperature = 0,
	-- 	max_tokens = 8000,
	-- },
	copilot = {
		endpoint = "https://api.githubcopilot.com",
		model = "gpt-4o-2024-08-06",
		proxy = nil, -- [protocol://]host[:port] Use this proxy
		allow_insecure = false, -- Allow insecure server connections
		timeout = 30000, -- Timeout in milliseconds
		temperature = 0,
		max_tokens = 4096,
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
		minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
		enable_token_counting = true, -- Whether to enable token counting. Default to true.
		enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
	},
	mappings = {
		diff = {
			ours = "co",
			theirs = "ct",
			all_theirs = "ca",
			both = "cb",
			cursor = "cc",
			next = "]x",
			prev = "[x",
		},
		suggestion = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},
		sidebar = {
			apply_all = "A",
			apply_cursor = "a",
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
		},
	},
	hints = { enabled = true },
	windows = {
		position = "right", -- the position of the sidebar
		wrap = true, -- similar to vim.o.wrap
		width = 30, -- default % based on available width
		sidebar_header = {
			enabled = true, -- true, false to enable/disable the header
			align = "center", -- left, center, right for title
			rounded = true,
		},
		input = {
			prefix = "> ",
			height = 8, -- Height of the input window in vertical layout
		},
		edit = {
			border = "rounded",
			start_insert = true, -- Start insert mode when opening the edit window
		},
		ask = {
			floating = false, -- Open the 'AvanteAsk' prompt in a floating window
			start_insert = true, -- Start insert mode when opening the ask window
			border = "rounded",
			focus_on_apply = "ours", -- which diff to focus after applying
		},
	},
	highlights = {
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	diff = {
		autojump = true,
		list_opener = "copen",
		--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
		--- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
		--- Disable by setting to -1.
		override_timeoutlen = 500,
	},
	suggestion = {
		debounce = 600,
		throttle = 600,
	},

	web_search_engine = {
		provider = "tavily",
	},
})
