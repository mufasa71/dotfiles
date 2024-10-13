-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable lsp.inlay_hint when in insert mode",
  callback = function(args)
    local filter = { bufnr = args.buf }
    local inlay_hint = vim.lsp.inlay_hint
    if inlay_hint.is_enabled(filter) then
      inlay_hint.enable(false, filter)
      vim.api.nvim_create_autocmd("InsertLeave", {
        once = true,
        desc = "Re-enable lsp.inlay_hint when leaving insert mode",
        callback = function()
          inlay_hint.enable(true, filter)
        end,
      })
    end
  end,
})
