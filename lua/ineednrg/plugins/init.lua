if vim.fn.has("nvim-0.12") then
    local specs = {
        require("ineednrg.plugins.treesitter"),
    }

    if vim.env.NVIM_PROFILE == "dev" then
        specs = vim.list_extend(specs, {
            require("ineednrg.plugins.lsp"),
            require("ineednrg.plugins.colours"),
            require("ineednrg.plugins.fzf"),
            require("ineednrg.plugins.fugitive"),
            require("ineednrg.plugins.undotree"),
            require("ineednrg.plugins.which_key"),
            --require("ineednrg.plugins.conform"),
            --require("ineednrg.plugins.mini"),
            --require("ineednrg.plugins.telescope"),
            --require("ineednrg.plugins.harpoon"),
        })
    end

    vim.pack.add(specs, {
        load = function(plug)
            vim.cmd.packadd(plug.spec.name)
            local setup = (plug.spec.data or {}).setup
            if type(setup) == "function" then
                local ok, err = pcall(setup)
                if not ok then
                    local msg = "plugin setup failed: " .. plug.spec.name .. ": " .. tostring(err)
                    vim.notify(msg, vim.log.levels.WARN)
                end
            end
        end,
    })
else
    print(">=nvim-0.12 is required to pack.add plugins.")
end
