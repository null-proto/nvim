-- kemap

local hydra = require 'hydra'

local function has_horizontal_split()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local row_set = {}

  for _, win in ipairs(wins) do
    local pos = vim.api.nvim_win_get_position(win)
    row_set[pos[1]] = true
  end

  local row_count = 0
  for _ in pairs(row_set) do
    row_count = row_count + 1
  end

  return row_count > 1
end

hydra {
  name = 'Resize Window',
  mode = 'n',
  body = '<leader>w',
  config = {
    timeout = 300,
    invoke_on_body = true,
    hint = false,
  },
  heads = {
    {
      'l',
      function()
        vim.cmd 'vertical resize -4'
      end,
    },
    {
      'h',
      function()
        vim.cmd 'vertical resize +4'
      end,
    },
    {
      'k',
      function()
        if has_horizontal_split() then
          vim.cmd 'resize -4'
        end
      end,
    },
    {
      'j',
      function()
        if has_horizontal_split() then
          vim.cmd 'resize +4'
        end
      end,
    },
    { '<Esc>', nil, { exit = true } },
  },
}

hydra.setup {
  debug = false,
  exit = false,
  foreign_keys = nil,
  color = 'red',
  timeout = false,
  invoke_on_body = false,
  hint = {
    show_name = true,
    position = { 'bottom' },
    offset = 0,
    float_opts = {},
  },
  on_enter = nil,
  on_exit = nil,
  on_key = nil,
}
