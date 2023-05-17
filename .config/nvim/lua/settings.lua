local set = vim.opt

vim.g.mapleader = " "

vim.cmd("set termguicolors")
vim.cmd("set background=dark")
vim.cmd("colorscheme gruvbox")

set.termguicolors = true
set.laststatus = 3
set.cmdheight = 0

set.cursorline = true

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

set.scrolloff = 3

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
