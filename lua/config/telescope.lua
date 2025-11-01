local fb_actions = require 'telescope._extensions.file_browser.actions'

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ['<C-h>'] = 'which_key',
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    file_browser = {
      path = vim.loop.cwd(),
      cwd = vim.loop.cwd(),
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = { file_browser = false, folder_browser = false },
      respect_gitignore = vim.fn.executable 'fd' == 1,
      no_ignore = false,
      follow_symlinks = false,
      browse_files = require('telescope._extensions.file_browser.finders').browse_files,
      browse_folders = require('telescope._extensions.file_browser.finders').browse_folders,
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = '',
      dir_icon_hl = 'Default',
      display_stat = { date = true, size = true, mode = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ['i'] = {
          ['<A-c>'] = fb_actions.create,
          ['<S-CR>'] = fb_actions.create_from_prompt,
          ['<A-r>'] = fb_actions.rename,
          ['<A-m>'] = fb_actions.move,
          ['<A-y>'] = fb_actions.copy,
          ['<A-d>'] = fb_actions.remove,
          ['<C-o>'] = fb_actions.open,
          ['<C-g>'] = fb_actions.goto_parent_dir,
          ['<C-e>'] = fb_actions.goto_home_dir,
          ['<C-w>'] = fb_actions.goto_cwd,
          ['<C-t>'] = fb_actions.change_cwd,
          ['<C-f>'] = fb_actions.toggle_browser,
          ['<C-h>'] = fb_actions.toggle_hidden,
          ['<C-s>'] = fb_actions.toggle_all,
          ['<bs>'] = fb_actions.backspace,
        },
        ['n'] = {
          ['c'] = fb_actions.create,
          ['r'] = fb_actions.rename,
          ['m'] = fb_actions.move,
          ['y'] = fb_actions.copy,
          ['d'] = fb_actions.remove,
          ['o'] = fb_actions.open,
          ['g'] = fb_actions.goto_parent_dir,
          ['e'] = fb_actions.goto_home_dir,
          ['w'] = fb_actions.goto_cwd,
          ['t'] = fb_actions.change_cwd,
          ['f'] = fb_actions.toggle_browser,
          ['h'] = fb_actions.toggle_hidden,
          ['s'] = fb_actions.toggle_all,
        },
      },
    },

    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'fzf'
require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}


local colors = require 'catppuccin.palettes.mocha'

local TelescopePrompt = {
  TelescopePreviewTitle = { fg = colors.crust, bg = colors.red },
  TelescopePromptTitle = { fg = colors.crust, bg = colors.red },
  TelescopeResultsTitle = { fg = colors.crust, bg = colors.red },
  TelescopeBorder = { fg = colors.crust, bg = colors.crust },
  TelescopeNormal = { bg = colors.crust },

  TelescopePromptBorder = { fg = colors.base, bg = colors.base },
  TelescopePromptNormal = { fg = colors.text, bg = colors.base },
  TelescopePromptPrefix = { fg = colors.red, bg = colors.base },
}

for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end

local GitSignsColor = {
  GitSignsAdd = { fg = colors.teal },
  GitSignsChange = { fg = colors.sapphire },
}

for hl, col in pairs(GitSignsColor) do
  vim.api.nvim_set_hl(0, hl, col)
end

vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.text, bg = colors.crust })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.crust, bg = colors.crust })
vim.api.nvim_set_hl(0, 'FloatTitle', { fg = colors.crust, bg = colors.red, bold = true })
vim.api.nvim_set_hl(0, 'DressingInputPrompt', { fg = colors.text, bg = colors.mantle, bold = true })
vim.api.nvim_set_hl(0, 'DressingInputText', { fg = colors.text, bg = colors.mantle })
