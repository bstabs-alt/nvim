return {
	src = "https://github.com/nvim-telescope/telescope.nvim",
	data = {
		setup = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", builtin.find_files, {
				desc = "find_files",
			})
			vim.keymap.set("n", "<C-p>", builtin.git_files, {
				desc = "telescope.git_files",
			})
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, {desc = "telescope.grep",
			})
		end,
	},
}
