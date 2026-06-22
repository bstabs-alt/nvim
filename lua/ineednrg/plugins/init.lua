--vim.cmd("packadd! nohlsearch")
if vim.fn.has("nvim-0.12") then
    --require('quicker').setup {}
    --require('gitsigns').setup {}
    local colours = require("ineednrg.plugins.colours")
    --local conform = require("ineednrg.plugins.conform")
    local fzf = require("ineednrg.plugins.fzf")
    --local mini = require("ineednrg.plugins.mini")
    --local telescope = require("ineednrg.plugins.telescope")
    local treesitter = require("ineednrg.plugins.treesitter")
    --local harpoon = require("ineednrg.plugins.harpoon")
    local undotree = require("ineednrg.plugins.undotree")
    local fugitive = require("ineednrg.plugins.fugitive")
    local lsp = require("ineednrg.plugins.lsp")
    local which_key = require("ineednrg.plugins.which_key")

    vim.pack.add({
        colours,
        --conform,
        fugitive,
        fzf,
        --mini,
        --telescope,
        treesitter,
        --harpoon,
        undotree,
        lsp,
        which_key,
    }, {
        load = function(plug)
            local setup = (plug.spec.data or {}).setup
            vim.cmd.packadd(plug.spec.name)
            if setup ~= nil and type(setup) == "function" then
                setup()
            end
        end,
    })
else
    print(">=nvim-0.12 is required to pack.add plugins.")
end
