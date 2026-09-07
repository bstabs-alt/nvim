return {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    ver = "0.15.0",
    data = {
        setup = function()
            --require('nvim-treesitter').install { 'bash', 'go', 'rust', 'zig' }
            local ts_group = vim.api.nvim_create_augroup("ts_group", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = ts_group,
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    --if ft == "markdown" or ft == "tex" or ft == "plaintex" then return end
                    --local lang = vim.treesitter.language.get_lang(ft)
                    --if not lang or not vim.treesitter.language.add(lang) then return end

                    pcall(vim.treesitter.start)
                    --vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo[0][0].foldmethod = 'expr'
                end,
            })
        end,
    },
}
