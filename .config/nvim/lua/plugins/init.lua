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
		config = {},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = {
			"skim",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = {
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
		config = {},
	},
	{
		"stevearc/conform.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = {
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
		config = {
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
				"python",
				"ruby",
				"rust",
				"toml",
				"tsx",
				"typescript",
			},
			sync_installed = false,
			auto_install = true,
			highlight = {
				enabled = true,
			},
		},
	},
}
