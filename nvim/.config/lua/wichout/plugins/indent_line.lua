return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '▏',
        tab_char = '▏',
        smart_indent_cap = true,
        repeat_linebreak = false,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'dashboard',
          'help',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
