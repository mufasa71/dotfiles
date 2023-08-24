local wk = require "which-key"
local typescript = require "typescript"
local null_ls = require "null-ls"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_augroup("AutoFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = "AutoFormatting",
      buffer = bufnr,
      callback = function() vim.lsp.buf.format { async = false } end
    })
  end
end

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup()
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
lspconfig.volar.setup { capabilities }
lspconfig.flow.setup { capabilities }
lspconfig.ocamllsp.setup { capabilities }
lspconfig.tailwindcss.setup { capabilities }
lspconfig.groovyls.setup { capabilities }
lspconfig.jsonls.setup { capabilities }
lspconfig.denols
    .setup { capabilities, root_dir = util.root_pattern("deno.json") }
util.on_setup = lspconfig.util.add_hook_before(util.on_setup, function(config)
  local cwd = vim.loop.cwd()
  if config.name == "tsserver" and vim.fn.filereadable(cwd .. "/deno.json") == 1 then
    config.single_file_support = false
  end
end)

lspconfig.lua_ls.setup {
  capabilities,
  on_attach = function(client, bufnr) on_attach(client, bufnr) end,
  settings = {
    Lua = {
      format = { enable = true },
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "use" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      telemetry = { enable = false }
    }
  }
}

require("rust-tools").setup { capabilities, on_attach }

local function has_eslint_configured(utils)
  return utils.root_has_file({ ".eslintrc.js", "eslint.config.js", ".eslintrc" }) or
      utils.has_file("eslint.config.js")
end

null_ls.setup({
  on_attach = function(client, bufnr) on_attach(client, bufnr) end,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.eslint
        .with({ condition = has_eslint_configured }),
    null_ls.builtins.code_actions.eslint
        .with({ condition = has_eslint_configured }),
    require("typescript.extensions.null-ls.code-actions")
  }
})

typescript.setup({
  disable_commands = false,
  server = {
    root_dir = util.root_pattern("tsconfig.json"),
    settings = { typescript = { format = { indentSize = 2 } } },
    capabilities,
    on_attach = function(client, bufnr) on_attach(client, bufnr) end
  }
})

wk.register({
  ["<space>f"] = { vim.lsp.buf.format, "Format with lsp" },
  ["<space>e"] = { vim.diagnostic.open_float, "Open float" },
  ["<space>q"] = { vim.diagnostic.setloclist, "Set loc list" },
  ["[d"] = { vim.diagnostic.goto_prev, "" },
  ["]d"] = { vim.diagnostic.goto_next, "" },
  ["]D"] = { function() vim.diagnostic.goto_prev { wrap = false } end, "" },
  ["[D"] = { function() vim.diagnostic.goto_next { wrap = false } end, "" }
})

wk.register({
  ["gd"] = { vim.lsp.buf.definition, "Definition" },
  ["gD"] = { vim.lsp.buf.declaration, "Declaration" },
  ["gr"] = { vim.lsp.buf.references, "References" },
  ["gi"] = { vim.lsp.buf.implementation, "Implementation" },
  ["gq"] = { vim.lsp.buf.formatting, "Format" }
})

wk.register({
  w = {
    a = { vim.lsp.buf.add_workspace_folder, "Add workspace" },
    r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace" },
    l = {
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
      "List workspace"
    }
  },
  ["so"] = {
    function() require("telescope.builtin").lsp_document_symbols() end,
    "Show symbols"
  },
  ["ca"] = { vim.lsp.buf.code_action, "LSP Code action" },
  ["rn"] = { vim.lsp.buf.rename, "LSP Rename" }
}, { prefix = "<leader>" })

wk.register({
  K = { vim.lsp.buf.hover, "Hover" },
  ["<C-k>"] = { vim.lsp.buf.type_definition, "Definition" },
  ["1gd"] = { vim.lsp.buf.document_symbol, "Document symbol" },
  ["1gD"] = { vim.lsp.buf.workspace_symbol, "" }
})

wk.register({
  ["ca"] = { vim.lsp.buf.range_code_action, "Code action on selected lines" }
}, { mode = "v", prefix = "<leader>" })

wk.register({
  s = { "<cmd>TypescriptOrganizeImports<cr>", "TS Import sort" },
  S = { "<cmd>TypescriptRemoveUnused<cr>", "TS Remove unused vars" },
  F = { "<cmd>TypescriptFixAll<cr>", "TS Fix all" },
  R = { "<cmd>TypescriptRenameFile<cr>", "TS Rename file" },
  I = { "<cmd>TypescriptAddMissingImports<cr>", "TS Import all" },
  G = { "<cmd>TypescriptGoToSourceDefinition<cr>", "TS Go to source definition" }
}, { prefix = "g" })
