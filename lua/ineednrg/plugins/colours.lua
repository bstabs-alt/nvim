function ColourDatBoi(colour --[[@param colour? string ]])
    colour = colour or 'jellybeans'

    vim.cmd.colorscheme(colour)

    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    --vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    --vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "none" })
    --vim.api.nvim_set_hl(0, "CursorLine", { bg = c.none })
    --vim.api.nvim_set_hl(0, "StatusLine", { bg = c.none })
end

return {
    src = "https://github.com/wtfox/jellybeans.nvim",
    data = {
        setup = function()
            --- @type jellybeans.Config
            local opts = {
                transparent = true,
                flat_ui = false, -- toggles "flat UI" for pickers
                plugins = {
                    all = true,
                    auto = true, -- auto-detect installed plugins via lazy.nvim
                },
                on_highlights = function(hl, c)
                    hl.FloatBorder = { bg = c.none }
                    hl.Pmenu = { bg = c.none }
                end,
                --on_colors = function(c) end,
            }
            require('jellybeans').setup(opts)

            ColourDatBoi()
        end,
    },
}
