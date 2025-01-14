return {
  'luukvbaal/statuscol.nvim',
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      relculright = true,
      segments = {
        {
          sign = { namespace = { 'gitsigns' }, maxwidth = 1 },
        },
        {
          sign = { namespace = { 'diagnostic/signs' }, maxwidth = 1 },
        },
        { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        {
          sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = 'v:lua.ScSa',
        },
      },
    }
  end,
}
