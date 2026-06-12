return {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	data = {
		setup = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
				ensure_installed = {
					"bash",
					"go",
					"javascript",
					"lua",
					"rust",
					"zig",
					"html",
					"css",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
