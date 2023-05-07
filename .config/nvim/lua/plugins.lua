local vim_plug_exists = vim.fn.expand("~/.local/share/nvim/site/autoload/plug.vim")
local curl_exists = vim.fn.executable("curl")

if not (vim.fn.filereadable(vim_plug_exists) == 1) then
	print("downloading vim-plug")
	if curl_exists == 1 then
		vim.fn.system(
			"curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
		)
	else
		error("curl is not installed")
		vim.fn.execute("q!")
	end
end

local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.vim/plugged")

Plug("doums/darcula")
Plug("machakann/vim-sandwich")
Plug("nvim-lualine/lualine.nvim")
Plug("lewis6991/gitsigns.nvim")
Plug("vim-scripts/grep.vim")
Plug("vim-scripts/CSApprox")
Plug("Raimondi/delimitMate")
Plug("Yggdroot/indentLine")
Plug("editor-bootstrap/vim-bootstrap-updater")
Plug("tpope/vim-rhubarb")
Plug("github/copilot.vim")

Plug("nvim-lua/plenary.nvim")
Plug("jose-elias-alvarez/null-ls.nvim")
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")
Plug("hrsh7th/vim-vsnip-integ")
Plug("hrsh7th/nvim-cmp")
Plug("nvim-treesitter/nvim-treesitter")
Plug("nvim-treesitter/playground")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")
Plug("numToStr/Comment.nvim")

Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.0" })

Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-tree/nvim-tree.lua")
Plug("rafamadriz/friendly-snippets")

Plug("christoomey/vim-tmux-navigator")
Plug("rodjek/vim-puppet")

vim.g.make = "gmake"
if vim.fn.exists("make") then
	vim.g.make = "make"
end

Plug("Shougo/vimproc.vim", {
	["do"] = function()
		vim.call(vim.g.make)
	end,
})

Plug("iamcco/markdown-preview.nvim", { ["do"] = "cd app && npm install" })

vim.call("plug#end")
