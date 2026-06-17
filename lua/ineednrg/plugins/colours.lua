function ColourDatBoi(color)
    color = color or 'jellybeans'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    src = "https://github.com/wtfox/jellybeans.nvim",
    data = {
        setup = function()
            ColourDatBoi()
        end,
    },
}
