-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local autocmdopts = {
		group = augroup,
		buffer = bufnr,
		callback = function()
			lsp_formatting(bufnr)
		end,
	}

	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", autocmdopts)

	-- Allow us to enable and disable autoformatting
	vim.api.nvim_create_user_command("DisableLspAutoformat", function()
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	end, {})
	vim.api.nvim_create_user_command("EnableLspAutoformat", function()
		vim.api.nvim_create_autocmd("BufWritePre", autocmdopts)
	end, {})

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
	vim.keymap.set("n", "<space>gf", lsp_formatting, bufopts)
	vim.keymap.set("n", "<space>gd", function()
		require("telescope.builtin").diagnostics({ bufnr = 0 })
	end, bufopts)
	--vim.keymap.set("n", "<space>gF", vim.api.nvim_com)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["ts_ls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["gopls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
-- require("lspconfig")["yamlls"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- 	capabilities = capabilities,
-- })
require("lspconfig")["marksman"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["jsonls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["ansiblels"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	checkOnSave = {
		allFeatures = true,
		overrideCommand = {
			"cargo",
			"clippy",
			"--workspace",
			"--message-format=json",
			"--all-targets",
			"--all-features",
		},
	},
})
require("lspconfig")["ruby_lsp"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	enabledFeatures = { "codeActions", "definition" },
	thingies = {},
})
require("lspconfig")["puppet"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["bashls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = { globals = { "vim" } },
		},
	},
})

require("lspconfig")["vuels"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
