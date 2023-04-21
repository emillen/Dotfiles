vim.g.mapleader = " "

vim.cmd([[colorscheme darcula]])

local set = vim.opt
set.termguicolors = true
set.laststatus = 3
set.cmdheight = 0

set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.fileencodings = "utf-8"
set.ttyfast = true

-- Fix backspace indent
set.backspace = "indent,eol,start"

-- .abs. May be overridden by autocmd rules
set.tabstop = 4
set.softtabstop = 0
set.shiftwidth = 4
set.expandtab = true

-- set no highlting
vim.api.nvim_command("set nohlsearch")

-- .ap leader to ,
vim.g.mapleader = " "

-- Enable hidden buffers
set.hidden = true

-- Searching
-- set hlsearch
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.fileformats = "unix,dos,mac"
set.shell = vim.env.SHELL

set.ruler = true
vim.api.nvim_command("set number relativenumber")
set.wildmenu = true

-- turn off mouse
set.mouse = nil

vim.api.nvim_command("set t_Co=256")
set.guioptions = "egmrti"
set.gfn = "Monospace 10"
vim.g.CSApprox_loaded = 1

set.scrolloff = 3

-- Status bar
-- set.laststatus=2

-- Use modeline overrides
-- set.modeline = true
--
-- set.modelines=10
set.showmode = false

set.title = true
set.titleold = "Terminal"
set.titlestring = "%F"

-- set.statusline="%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"

set.clipboard = "unnamedplus"

set.swapfile = false

set.backup = false
set.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
set.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
set.signcolumn = "yes"
