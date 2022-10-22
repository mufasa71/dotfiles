local lsp_config = require "lspconfig"

local util = require "lspconfig.util"
local lsp_installer = require "nvim-lsp-installer"
local wk = require "which-key"
local rust_tools = require "rust-tools"
local typescript = require "typescript"
local null_ls = require "null-ls"
-- local refactoring = require "refactoring"

lsp_installer.setup {
  ensure_installed = {
    "tsserver", "sumneko_lua", "eslint", "flow", "rust_analyzer"
  }, -- ensure these servers are always installed
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

wk.register({
  ["<space>f"] = {vim.lsp.buf.format, "Format with lsp"},
  ["<space>e"] = {vim.diagnostic.open_float, "Open float"},
  ["<space>q"] = {vim.diagnostic.setloclist, "Set loc list"},
  ["[d"] = {vim.diagnostic.goto_prev, ""},
  ["]d"] = {vim.diagnostic.goto_next, ""},
  ["]D"] = {function() vim.diagnostic.goto_prev {wrap = false} end, ""},
  ["[D"] = {function() vim.diagnostic.goto_next {wrap = false} end, ""}
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc",
                              "v:lua.MiniCompletion.completefunc_lsp")

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes = 100
  end

  wk.register({
    ["gd"] = {vim.lsp.buf.definition, "Definition"},
    ["gD"] = {vim.lsp.buf.declaration, "Declaration"},
    ["gr"] = {vim.lsp.buf.references, "References"},
    ["gi"] = {vim.lsp.buf.implementation, "Implementation"},
    ["gq"] = {vim.lsp.buf.formatting, "Format"}
  })

  wk.register({
    w = {
      a = {vim.lsp.buf.add_workspace_folder, "Add workspace"},
      r = {vim.lsp.buf.remove_workspace_folder, "Remove workspace"},
      l = {
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
        "List workspace"
      }
    },
    ["so"] = {
      function() require("telescope.builtin").lsp_document_symbols() end,
      "Show symbols"
    },
    ["ca"] = {vim.lsp.buf.code_action, "Code action"},
    ["rn"] = {vim.lsp.buf.rename, "Rename"}
  }, {prefix = "<leader>"})

  wk.register({
    K = {vim.lsp.buf.hover, "Hover"},
    ["<C-k>"] = {vim.lsp.buf.type_definition, "Definition"},
    ["1gd"] = {vim.lsp.buf.document_symbol, "Document symbol"},
    ["1gD"] = {vim.lsp.buf.workspace_symbol, ""}
  })

  wk.register({
    ["ca"] = {vim.lsp.buf.range_code_action, "Code action on selected lines"}
  }, {mode = "v", prefix = "<leader>"})

  if client.server_capabilities.code_lens then
    wk.register({["gl"] = {vim.lsp.codelens.run, "Code lens"}});
    vim.api
        .nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  end

  vim.cmd [[autocmd CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()]]
end

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
  }
  -- cmp_capabilities.update_capabilities(capabilities)

  return capabilities
end

util.default_config = vim.tbl_extend("force", util.default_config, {
  capabilities = make_capabilities(),
  on_attach = on_attach
})

-- lsp_config.tsserver.setup {
--   root_dir = util.root_pattern("tsconfig.json"),
--   settings = {
--     typescript = {format = {indentSize = 2}, enableJavascript = false}
--   }
-- }

-- lsp_config.eslint.setup {
--   on_new_config = function(config, root_dir)
--     local pnp_js = util.path.join(root_dir, ".pnp.loader.mjs")
--     local eslint_config = require("lspconfig.server_configurations.eslint")
--
--     if util.path.exists(pnp_js) then
--       config.cmd = {"yarn", "exec", unpack(eslint_config.default_config.cmd)};
--     end
--   end
-- }

lsp_config.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT"
        -- Setup your lua path
        -- path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim", "use"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}

rust_tools.setup {server = {on_attach = on_attach}}
lsp_config.flow.setup {}

typescript.setup({
  disable_commands = false,
  debug = false,
  server = {
    root_dir = util.root_pattern("tsconfig.json"),
    settings = {typescript = {format = {indentSize = 2}}},
    on_attach = function(client, bufnr)
      wk.register({
        s = {"<cmd>TypescriptOrganizeImports<cr>", "TS Import sort"},
        S = {"<cmd>TypescriptRemoveUnused<cr>", "TS Remove unused vars"},
        F = {"<cmd>TypescriptFixAll<cr>", "TS Fix all"},
        R = {"<cmd>TypescriptRenameFile<cr>", "TS Rename file"},
        I = {"<cmd>TypescriptAddMissingImports<cr>", "TS Import all"}
      }, {prefix = "g"})
      on_attach(client, bufnr)
    end
  }
})

local function has_eslint_configured(utils)
  return utils.root_has_file(".eslintrc.js")
end

null_ls.setup({
  sources = {
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.completion.spell,
    -- null_ls.builtins.code_actions.refactoring,
    -- null_ls.builtins.diagnostics.proselint,
    -- null_ls.builtins.code_actions.proselint,
    null_ls.builtins.code_actions.gitsigns, null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.eslint
        .with({condition = has_eslint_configured}),
    null_ls.builtins.code_actions.eslint
        .with({condition = has_eslint_configured}),
    null_ls.builtins.formatting.prettier
  }
})

-- refactoring.setup({})
