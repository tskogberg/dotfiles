local empty_border = { " ", " ", " ", " ", " ", " ", " ", " " }

return {
  "nvim-telescope/telescope.nvim",
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "folke/trouble.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        borderchars = {
          prompt = empty_border,
          results = empty_border,
          preview = empty_border,
        },
        layout = {
          prompt_position = "top"
        },
        prompt_prefix = "  ",
        selection_caret = "  ",
      },
      pickers = {
        find_files = {
          previewer = true,
          find_command = { "fd", "--type", "file", "--hidden", "--strip-cwd-prefix" },
        },
        git_files = {
          previewer = true,
        },
        lsp_references = {
          show_line = true,
          fname_width = 0.5
        }
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          mappings = {
          }
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        }
      }
    })
    require("telescope").load_extension("fzf")
  end
}
