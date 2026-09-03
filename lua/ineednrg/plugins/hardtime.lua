return {
    src = "https://github.com/m4xshen/hardtime.nvim",
    data = {
        setup = function()
            local hardtime = require("hardtime")
            hardtime.setup()
        end
    }
}
