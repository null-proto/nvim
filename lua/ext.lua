return {
	{
		'ggml-org/llama.vim',
		init = function()
			vim.g.llama_config = {
				auto_fim = true,
			}
		end,
	},
	--	'sphamba/smear-cursor.nvim',
	'NvChad/nvim-colorizer.lua',
	'stevearc/dressing.nvim',
	'lewis6991/gitsigns.nvim',
	'neovim/nvim-lspconfig',
	'stevearc/conform.nvim',
	'nvim-lualine/lualine.nvim',
	-- 'williamboman/mason.nvim',
	-- 'williamboman/mason-lspconfig.nvim',
	{ 'nvimtools/hydra.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'nvim-telescope/telescope-symbols.nvim' },
	{ 'nvim-tree/nvim-tree.lua' },
	{ 'lukas-reineke/indent-blankline.nvim',      main = 'ibl' },
	{ 'catppuccin/nvim',                          name = 'catppuccin', priority = 1000 },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{ 'L3MON4D3/LuaSnip',                         version = 'v2.3.0',  build = 'make install_jsregexp' },
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
	},
	{
		'stevearc/aerial.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { { 'nushell/tree-sitter-nu', build = ':TSUpdate nu' } },
		build = ':TSUpdate',
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'hedyhli/outline.nvim',
		config = function()
			vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
			require('outline').setup {}
		end,
	},
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
	-- { 'mrcjkb/rustaceanvim', version = '^5', },
	-- { 'altermo/ultimate-autopair.nvim', event={'InsertEnter','CmdlineEnter'}, branch='v0.6',opts={}, }
	-- lazy.nvim
	-- { "folke/noice.nvim", event = "VeryLazy", dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries "MunifTanjim/nui.nvim", OPTIONAL: `nvim-notify` is only needed, if you want to use the notification view. If not available, we use `mini` as the fallback "rcarriga/nvim-notify", }
}
