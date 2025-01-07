return {
    "hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            sources = {
                {name = 'nvim_lsp'},
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        end
                        cmp.confirm()
                    else
                        fallback()
                    end
                end, {"i","s","c",}),
            }),
            snippet = {
                expand = function(args)
                vim.snippet.expand(args.body)
                end,
            },
        })
    end,
}
