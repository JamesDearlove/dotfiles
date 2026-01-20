return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
        vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
        vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })

        vim.keymap.set("n", "<leader>ft", builtin.git_status, { desc = "Git status" })
    end,
}

