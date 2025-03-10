return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
  },
  opts = { adapters = { "rustaceanvim.neotest" } },
}
