return {
    src = "https://github.com/folke/which-key.nvim",
    data = {
        setup = function()
            local which_key = require("which-key")
            which_key.setup({
                ---@type  wk.Spec
                spec = {},
                preset = "helix",
                expand = 1,
                layout = {
                    spacing = 3,
                    width = { min = 20, max = 40 }
                },
                ---@type wk.Win.opts
                win = {
                    anchor = "NW",
                    --border = table.concat(_G.get_border_symbols(), ","),
                    border = "single",

                },
                plugins = {
                    presets = {
                        operators = true,
                        motions = true,
                        text_objects = true,
                    },
                },
                keys = {
                    scroll_down = "<C-n>",
                    scroll_up = "<C-p>",
                },
                icons = {
                    --breadcrumb = "»",
                    --separator = "➜",
                    --group = "+",
                    --ellipsis = "…",
                    mappings = true,
                    --- See `lua/which-key/icons.lua` for more details
                    --- Set to `false` to disable keymap icons from rules
                    ----@type wk.IconRule[]|false
                    --rules = {},
                    --keys = {
                    --    C = "󰘴 ",
                    --    M = "󰘵 ",
                    --    D = "󰘳 ",
                    --    S = "󰘶 ",
                    --    CR = "󰌑 ",
                    --    Esc = "󱊷 ",
                    --    NL = "󰌑 ",
                    --    BS = "󰁮",
                    --    Space = "󱁐 ",
                    --    Tab = "󰌒 ",
                    --},
                },
            })

            vim.keymap.set({ "n", "v", "t" }, "<leader>?", function()
                which_key.show({ global = true, loop = true })
            end, { desc = "which_key buffer maps" })

            --which_key.show({ keys = "<leader>", loop = true })
        end
    }
}
