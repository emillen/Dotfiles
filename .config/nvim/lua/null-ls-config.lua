require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,

        --  require("null-ls").builtins.diagnostics.eslint,
        --  require("null-ls").builtins.code_actions.eslint,
       
        require("null-ls").builtins.formatting.autopep8,
        require("null-ls").builtins.diagnostics.pylint,

        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.completion.spell,

        require("null-ls").builtins.formatting.rustfmt,

        require("null-ls").builtins.formatting.gofmt,

        require("null-ls").builtins.diagnostics.erb_lint,

        require("null-ls").builtins.diagnostics.puppet_lint,
        require("null-ls").builtins.formatting.puppet_lint,

        require("null-ls").builtins.formatting.rubocop,
        require("null-ls").builtins.diagnostics.rubocop,

        require("null-ls").builtins.formatting.beautysh,
    },
})
