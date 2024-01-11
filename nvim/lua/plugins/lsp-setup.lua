-- TODO: Unified table for mason-managed and manual servers. Some can be installed through mason, some need shadowenv/other stuff/are provided through project config
-- Something like
-- local servers = {
--   lspconfig_name = {
--     auto_install = [nil | false | true | mason_package_name]
--     config = {}
--   }
-- }
local table_merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end


-- Servers you want mason to keep installed
local servers = {
  bashls = {},
  cssls = {},
  emmet_ls = {},
  html = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  elmls = {},
  tailwindcss = {},
}

-- Servers you'll handle yourself. Could still be through mason, or through env management. Up to you.
local manually_installed_servers = {
  solargraph = {
    settings = {
      solargraph = {
        diagnostics = false
      }
    },
    init_options = {
      formatting = true
    }
  },
  gopls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Replace",
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      }
    }
  },
  elixirls = {
    cmd = { "/home/tomas/.elixir-ls/release/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
      },
    },
  },
}

return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'folke/which-key.nvim',
      'folke/neodev.nvim',
      'jay-babu/mason-null-ls.nvim'
    },
    config = function()
      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')


      -- auto-install servers mentioned in table above
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers)
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Highlighting references
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_exec(
            [[
              augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]],
            false
          )
        end

        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({})
            end
          })
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        require('which-key').register(require('plugins.which-key.lsp-binds'), { buffer = bufnr })
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup(table_merge({ capabilities = capabilities, on_attach = on_attach },
            servers[server_name] or {}))
        end
      }

      for server_name, config in pairs(manually_installed_servers) do
        lspconfig[server_name].setup(table_merge({ capabilities = capabilities, on_attach = on_attach }, config or {}))
      end
    end
  }
}
