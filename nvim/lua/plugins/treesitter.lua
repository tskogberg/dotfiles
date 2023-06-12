return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'go', 'html', 'json', 'lua', 'python', 'ruby', 'vim', 'yaml', 'elixir', 'erlang', 'elm'
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' }, -- Needed for non-treesitter indentation to work
      },
      indent = {
        enable = true,
        -- Disabling treesitter-indentation until either of the following tickets is resolved:
        -- https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
        -- https://github.com/tree-sitter/tree-sitter-ruby/issues/230
        disable = { 'ruby' }
      },
      autotag = {
        enable = true,
      },
      endwise = {
        enable = true,
      }
    })
  end,
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
  }
}
