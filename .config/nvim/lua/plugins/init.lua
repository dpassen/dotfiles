return {
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				variant = "tinted",
			})
			vim.cmd.colorscheme("modus")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			"skim",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			formatters_by_ft = {
				lua = {
					"stylua",
				},
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"clojure",
					"cpp",
					"css",
					"html",
					"java",
					"javascript",
					"json",
					"kotlin",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"ruby",
					"rust",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
				},
				sync_installed = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
