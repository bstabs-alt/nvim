if vim.fn.has("nvim-0.12") then
    local specs = { require("ineednrg.plugins.treesitter") }
    local p = vim.env.NVIM_PROFILE

    if p == "dev" or p == "work" then
        specs = vim.list_extend(specs, {
            require("ineednrg.plugins.colours"),
            --require("ineednrg.plugins.lsp"),
            require("ineednrg.plugins.debugger"),
            require("ineednrg.plugins.fzf"),
            require("ineednrg.plugins.fugitive"),
            require("ineednrg.plugins.undotree"),
            require("ineednrg.plugins.vimtex"),
            require("ineednrg.plugins.which_key"),
        })
    end
    if p == "dev" then
        specs = vim.list_extend(specs, {
            --require("ineednrg.plugins.conform"),
            --require("ineednrg.plugins.mini"),
            --require("ineednrg.plugins.telescope"),
            --require("ineednrg.plugins.harpoon"),
        })
    end

    local function load_spec(name, data)
        vim.cmd.packadd({ name, bang = vim.v.vim_did_init == 0 })
        local setup = (data or {}).setup
        if type(setup) == "function" then
            local ok, err = pcall(setup)
            if not ok then
                local msg = "plugin setup failed: " .. name .. ": " .. tostring(err)
                vim.notify(msg, vim.log.levels.WARN)
            end
        end
    end

    local remote = {}
    for _, spec in ipairs(specs) do
        if spec.src then
            table.insert(remote, spec)
        else
            load_spec(spec.packadd, spec.data)
        end
    end

    vim.pack.add(remote, {
        load = function(plug)
            load_spec(plug.spec.name, plug.spec.data)
        end
    })
else
    print(">=nvim-0.12 is required to use pack.add for plugins")
end
