if vim.fn.has("nvim-0.12") then
	--require('fzf-lua').setup { fzf_colors = true }
	--require('mini.completion').setup {}
	--require('quicker').setup {}
	--require('gitsigns').setup {}
	local jellybeans = "wtfox/jellybeans.nvim"
	local telescope = require("ineednrg.plugins.telescope")
	local treesitter = require("ineednrg.plugins.treesitter")
	local harpoon = require("ineednrg.plugins.harpoon")
	local undotree = require("ineednrg.plugins.undotree")
	local fugitive = require("ineednrg.plugins.fugitive")
	local lsp = require("ineednrg.plugins.lsp")
	local which_key = require("ineednrg.plugins.which_key")

	vim.pack.add({
		jellybeans,
		telescope,
		treesitter,
		harpoon,
		undotree,
		fugitive,
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
	vim.pack.setup()
	-- Only required if you have packer configured as `opt`
	vim.cmd([[packadd packer.nvim]])
	return require("packer").startup(function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")
		use({
			"wtfox/jellybeans.nvim",
			as = "jellybeans",
			config = function()
				vim.cmd("colorscheme jellybeans")
			end,
		})
		--use 'nvim-telescope/telescope-fzf-native.nvim'
		use({
			"nvim-telescope/telescope.nvim",
			tag = "v0.2.1",
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
		use("theprimeagen/harpoon")
		use("theprimeagen/vim-be-good")
		use("mbbill/undotree")
		use("tpope/vim-fugitive")
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"stevearc/conform.nvim",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/nvim-cmp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"j-hui/fidget.nvim",
			},
		})
		use("folke/which-key.nvim")
	end)
end
