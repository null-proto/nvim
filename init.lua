local home = os.getenv 'HOME'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- --
vim.opt.termguicolors = true
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.numberwidth = 3
vim.opt.cul = true
vim.opt.ic = false
vim.opt.showbreak = '> '
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.undodir = home .. '/.cache/nvim/undo/'
vim.opt.backup = true
vim.opt.backupdir = home .. '/.cache/nvim/backups/'
vim.opt.wrap = false
vim.opt.mouse = ''

vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true

vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- vim.cmd.colorscheme 'catppuccin-macchiato'

-- keymaps
-- toggle comment "<leader>gc<leader>" works in normal as well as visual
--
-- norm
vim.keymap.set('n', '<leader>fm', ':Ex<CR>')
vim.keymap.set('n', '<leader>e', ':NvimTreeOpen<CR>')
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')

-- nav
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')

-- >> hydra.lua
-- -- resize splits
-- vim.keymap.set('n', '<leader>wh', ':vertical resize -2<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>wl', ':vertical resize +2<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>wj', ':resize -2<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>wk', ':resize +2<CR>', { silent = true })
-- << --

-- buffer
vim.keymap.set('n', '<leader>1', ':bnext<CR>')
vim.keymap.set('n', '<leader>2', ':bprevious<CR>')
vim.keymap.set('n', '<leader>3', ':bdelete<CR>')

-- lsp
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)

-- telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>gf', ':Telescope git_files<CR>')
vim.keymap.set('n', '<leader>gs', ':Telescope git_status<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')

-- aerial
vim.keymap.set('n', '<leader>a', '<Cmd>AerialToggle<CR>')

-- ins
vim.keymap.set('i', '<C-f>', '<Cmd>Telescope find_files<CR>')

-- alias
vim.keymap.set('n', '<leader>n', ':bnext<CR>')
vim.keymap.set('n', '<leader>p', ':bprevious<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope git_files<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')

-- preserve cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    --- @diagnostic disable-next-line: deprecated
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

vim.diagnostic.config {
  virtual_text = true,
  float = {
    focusable = false,
    -- style = "minimal",
    -- border = "none",
    source = 'always',
    -- header = "[ Diagnostic ]",
    -- prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
}

-- end of file or empty line
vim.opt.fillchars:append { eob = '✦' } -- void dot

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#3a3a3a", bg = "NONE" })
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  -- pattern = { "c", "cpp", "h", "hpp", "cuda", "html", "astro", "lua", "py", "rs", "js"  },
  pattern = '*',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})



-- lazy init ------------------------------------------------------------------------------------------------
--
--
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('lazy').setup {
  spec = {
    { import = 'ext' },
  },
  checker = { enabled = false },
}

require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    dark = 'mocha',
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = 'dark',
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    loops = { 'italic' },
    functions = {},
    keywords = {},
    strings = { 'italic' },
    variables = {},
    numbers = { 'bold' },
    booleans = { 'bold' },
    properties = {},
    types = {},
    operators = {},
    miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
    telescope = {
      enabled = true,
    },
  },
}

vim.cmd.colorscheme 'catppuccin-mocha'


require 'config.hydra'
-- require 'config.mason'
require 'config.null-ls'
require 'config.lsp'
require 'config.cmp'
require 'config.aerial'
require 'config.telescope'
require 'config.treesitter'
require 'config.dressing'
require 'config.gitsigns'
require 'config.lualine'
require 'config.utils'
-- require 'config.noice'
-- require 'config.dpa'
