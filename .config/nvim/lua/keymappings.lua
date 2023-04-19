-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- KEYBINDINGS

-- center when moving around
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

-- search replace
map("n", "<leader>s", ":%s/<C-r><C-w>//gI<Left><Left><Left>")
map("v", "<leader>s", ":s/\\%V//gI<Left><Left><Left><Left>")

-- abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qall qall")

-- toggle nvimtree
map("n", "<leader>nf", ":NvimTreeFindFile<CR>")
map("n", "<leader>nt", ":NvimTreeToggle<CR>")

-- toggle between tabs
map("n", "<Tab>", "gt")
map("n", "<S-Tab>", "gT")

-- telescope
map("n", "<leader>b", "<cmd>Telescope buffers<CR>")
map("n", "<leader>e", "<cmd>Telescope find_files<CR>")
map("n", "<leader>f", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>g", "<cmd>Telescope git_files<CR>")

-- add and subtract numbers
map("v", "+", "<C-a>")
map("n", "+", "<C-a>")
map("v", "-", "<C-x>")
map("n", "-", "<C-x>")

-- paste without yanking
map("x", "<leader>p", '"_dP')

-- Close buffer
map("n", "<leader>c", ":bd<CR>")

-- Switching windows
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")

-- Vmap for maintain Visual Mode after shifting > and <
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<S-tab>", "<gv")
map("v", "<tab>", ">gv")

-- Move lines up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("i", "<expr> <Tab>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
map("s", "<expr> <Tab>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
map("i", "<expr> <S-Tab>", "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
map("s", "<expr> <S-Tab>", "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
