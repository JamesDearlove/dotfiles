return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
    config = function ()
        local presets = require("markview.presets")

        require("markview").setup({
            markdown = {
                headings = presets.headings.glow,
                list_items = {
                    shift_width = 2
                }
            }
        })
    end
};

