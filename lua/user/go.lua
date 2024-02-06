local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = true,
        gc_details = true,
        test = true,
        tidy = true,
      },
      analyses = {
        fieldalignment = true, -- find structs that would use less memory if their fields were sorted
        nilness = true,        -- check for redundant or impossible nil comparisons
        shadow = true,         -- check for possible unintended shadowing of variables
        unusedparams = true,   -- check for unused parameters of functions
        unusedwrite = true,    -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
      }
    },
  },
})
lsp_manager.setup("golangci_lint_ls", {})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["G"] = {
  name = "+Go",
  g = { "<cmd>GoGenerate %<cr>", "Go generate file" },
  i = { "<cmd>GoIfErr <cr>", "If err" },
  d = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test" }
}

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}

------------------------
-- Language Key Mappings
------------------------

------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup({
  delve = {
    build_flags = "-tags=integration",
  },
})
