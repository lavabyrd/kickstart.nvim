return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
          ['<leader>e'] = 'close_window',
        },
      },
    },
  },
  config = function()
    local file_opened = false

    -- Detect when any file is opened
    vim.api.nvim_create_autocmd('BufRead', {
      callback = function()
        file_opened = true
      end,
    })

    -- Auto-close Neo-tree if it's the last window AND a file was opened before
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('NeoTreeAutoClose', { clear = true }),
      callback = function()
        local buflisted = vim.fn.getbufinfo { buflisted = 1 }
        if file_opened and #buflisted == 1 and vim.bo.filetype == 'neo-tree' then
          vim.cmd 'quit'
        end
      end,
    })
  end,
}
