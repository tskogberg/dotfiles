-- Plugins that don't have enough config to warrant their own file go here
return {
  {
    'tpope/vim-fugitive',
    event = "BufWinEnter",
  },
  {
    'henrik/git-grep-vim',
    event = "BufWinEnter",
  },
  {
    'tpope/vim-eunuch',
    event = "BufWinEnter",
  },
}
