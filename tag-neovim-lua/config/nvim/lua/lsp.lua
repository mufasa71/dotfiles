local nvim_lsp = require 'lspconfig'
local nvim_lsp_install = require 'lspinstall'
local util = nvim_lsp.util
local ts_utils = require("nvim-lsp-ts-utils")
-- local null_ls = require("null-ls")
local remap = vim.api.nvim_buf_set_keymap

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
local function preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 10
  before_context = before_context or 5
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  local range = location.targetRange or location.range
  local contents =
    vim.api.nvim_buf_get_lines(bufnr, range.start.line - before_context, range["end"].line + 1 + context, false)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype)
end

local function preview_location_callback(_, method, result)
  local context = 10
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    ---@diagnostic disable-next-line: lowercase-global
    floating_buf, floating_win = preview_location(result[1], context)
  else
    ---@diagnostic disable-next-line: lowercase-global
    floating_buf, floating_win = preview_location(result, context)
  end
end

function PeekDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), floating_win) then
    vim.api.nvim_set_current_win(floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
  end
end

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes  = 100
  end

  local opts = { noremap = true, silent = true }

  remap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  remap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  remap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  remap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  remap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  remap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  remap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  remap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  remap(bufnr, 'n', '1gd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  remap(bufnr, 'n', '1gD', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  remap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  remap(bufnr, 'n', 'pd', '<cmd>lua PeekDefinition()<CR>', opts)

  remap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  remap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  remap(bufnr, 'n', '[D', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>', opts)
  remap(bufnr, 'n', ']D', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>', opts)

  remap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  remap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  remap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  remap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  remap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  remap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)


  if client.resolved_capabilities.document_formatting then
    remap(bufnr, 'n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    remap(bufnr, 'n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  if client.resolved_capabilities.code_lens then
    remap(bufnr, "n", "gl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  end

  if false and client.name == 'typescript' then
    -- Disable tsserver formatting as we plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    ts_utils.setup {
      debug                          = false,
      disable_commands               = false,
      enable_import_on_completion    = false,

      import_all_timeout             = 5000,
      import_all_scan_buffers        = 100,
      import_all_select_source       = false,
      import_all_priorities = {
        buffers        = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files    = 2, -- git files or files with relative path markers
        same_file      = 1, -- add to existing import statement
      },

      eslint_enable_code_actions     = true,
      eslint_bin                     = "eslint",
      eslint_enable_disable_comments = true,
      eslint_enable_diagnostics      = true,
      eslint_config_fallback         = nil,

      enable_formatting              = true,
      formatter                      = "prettier",
      formatter_config_fallback      = nil,

      update_imports_on_move         = false,
      require_confirmation_on_move   = false,
      watch_dir                      = nil,
    }

    ts_utils.setup_client(client)
    remap(bufnr, 'n', 'go', ':TSLspOrganize<CR>',   { silent = true })
    remap(bufnr, 'n', 'gf', ':TSLspFixCurrent<CR>', { silent = true })
    remap(bufnr, 'n', 'gI', ':TSLspImportAll<CR>',  { silent = true })
  end

  vim.cmd [[autocmd CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb()]]
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local efm_settings = {
  rootMarkers = {".eslintrc.js", ".eslintrc.json", ".git/"},
  languages = {
    javascript = {eslint},
    typescript = {eslint},
    typescriptreact = {eslint}
  }
}

local lua_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      -- path = runtime_path,
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim', 'use' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  }
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  return {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- null_ls.setup {}

nvim_lsp_install.setup()

local function setup_servers()
  nvim_lsp.flow.setup{}
  local servers = nvim_lsp_install.installed_servers()
  for _, server in pairs(servers) do
    local config = make_config()
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "typescript" then
      config.filetypes = {"typescript", "typescript.tsx", "typescriptreact"}
    end
    if server == "efm" then
      config.init_options = {documentFormatting = true}
      config.filetypes = {"javascript", "typescript", "typescriptreact"}
      config.root_dir = function(fname)
        return util.root_pattern("tsconfig.json")(fname) or
          util.root_pattern(".eslintrc.js", ".eslintrc.json", ".git")(fname);
      end
      config.settings = efm_settings
    end
    nvim_lsp[server].setup(config)
  end
end

setup_servers()

nvim_lsp_install.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

