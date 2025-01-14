return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<M-h>'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 50,
        max_height = 20,
        border = 'rounded',
      },
    }
    -- vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '-', require('oil').toggle_float, { desc = 'Open parent directory in float window' })
  end,
}
