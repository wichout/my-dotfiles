return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  config = function()
    local logo = [[
    ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
    ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
    ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
    ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
    ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
    ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
    ]]
    logo = string.rep('\n', 8) .. logo .. '\n\n\n'

    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = vim.split(logo, '\n'),
        center = {
          { icon = ' ', key = 'f', desc = 'Open File     ', action = 'Telescope find_files' },
          { icon = ' ', key = 'n', desc = 'New File      ', action = 'ene | startinsert' },
          { icon = ' ', key = 'r', desc = 'Recent Files  ', action = 'Telescope oldfiles' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy          ', action = 'Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit          ', action = 'qa' },
        },
      },
    }
  end,
}
