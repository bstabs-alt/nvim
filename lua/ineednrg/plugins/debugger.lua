return {
    packadd = 'termdebug',
    data = {
        setup = function()
            vim.g.termdebug_config = {
                wide = 160,
                variables_window = 1,
            }
        end
    }
}
