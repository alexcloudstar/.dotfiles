local PARSERS = {
    "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
    "jsdoc", "bash", "markdown", "markdown_inline", "astro", "css", "html",
    "json", "yaml", "python", "go", "vim", "diff", "dockerfile", "make",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
        treesitter.install(PARSERS)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
            callback = function(args)
                local language = vim.treesitter.language.get_lang(args.match)
                if not language then
                    return
                end
                if pcall(vim.treesitter.start, args.buf, language) then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
