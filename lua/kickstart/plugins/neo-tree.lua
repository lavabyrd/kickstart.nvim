return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- Optionally include devicons if needed
    'nvim-tree/nvim-web-devicons',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', noremap = true, silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
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

    -- Auto-close NeoTree if it's the last window AND a file was opened
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
