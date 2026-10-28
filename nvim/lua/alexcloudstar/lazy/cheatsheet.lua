return {
    "alexcloudstar/cheatsheet.nvim",

    dependencies = { "nvim-telescope/telescope.nvim" },

    opts = function()
        return {
            aliases = { "Cc" },
            categories = require("alexcloudstar.cheatsheet_data"),
        }
    end,
}
