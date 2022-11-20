require "user.go"

lvim.plugins = {
  { "ray-x/lsp_signature.nvim" },
  { "marko-cerovac/material.nvim" },
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" }
}

-- init lsp_signature
require "lsp_signature".setup({})

vim.g.material_style = "palenight"
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "material"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "yaml",
  "go",
}

lvim.builtin.which_key.mappings["o"] = { "<cmd>NvimTreeFocus<cr>", "Focus file tree" }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "gofmt", filetypes = { "go" } },
  { name = "goimports", filetypes = { "go" } }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "golangci_lint",
    filetypes = { "go" }
  }
}
