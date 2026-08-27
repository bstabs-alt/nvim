return {
    src = 'https://github.com/lervag/vimtex',
    data = {
        setup = function()
            vim.g.vimtex_view_method = 'sioyek' --'zathura'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_compiler_latexmk = {
                out_dir = 'build'
            }
        end
    }
}
