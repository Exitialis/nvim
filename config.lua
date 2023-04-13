require "user.go"

lvim.plugins = {
  { "ray-x/lsp_signature.nvim" },
  { "marko-cerovac/material.nvim" },
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
  { "kylechui/nvim-surround" },
  {
    "glepnir/lspsaga.nvim",
    config = function()
      local saga = require("lspsaga")

      saga.setup({})
    end,
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  { "kdheepak/lazygit.nvim" },
  ({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
      }
    end,
  })
}

-- init lsp_signature
require "lsp_signature".setup({})

-- init nvim-surround
require "nvim-surround".setup({})

lvim.lsp.buffer_mappings.normal_mode['gr'] = { "<cmd>Lspsaga lsp_finder<CR>", "Go to reference" }
lvim.lsp.buffer_mappings.normal_mode['gg'] = { "<cmd>LazyGit<CR>", "Lazygit" }
vim.opt.clipboard = "unnamed,unnamedplus"

vim.g.material_style = "palenight"
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "material"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-[>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<C-]>"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- remap back and forward location
vim.api.nvim_set_keymap('n', '<C-[>', '<C-o>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-]>', '<C-i>', { noremap = true })

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Diagnostics in edit mode too
lvim.lsp.diagnostics.update_in_insert = true

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
lvim.builtin.which_key.mappings["la"] = { "<cmd>Lspsaga code_action<CR>", "Code action" }
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
  b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  u = {
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    "Undo Stage Hunk",
  },
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  C = {
    "<cmd>Telescope git_bcommits<cr>",
    "Checkout commit(for current file)",
  },
  d = {
    "<cmd>Gitsigns diffthis HEAD<cr>",
    "Git Diff",
  },
}
lvim.builtin.which_key.mappings["dT"] = {
  "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  "Set conditional breakpoint" }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Отключаем вкладки в vim
lvim.builtin.bufferline.active = false
-- Позволяет избавиться от проблемы при выходе из файла без изменений, чтобы не мешал перемещаться и не заставлял вводить !
vim.opt.hidden = true
-- Автосохранение файла перед выходом из него
vim.opt.autowrite = true

-- Autoclose selection window after select option
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr('%')
    vim.keymap.set("n", "o", function()
      vim.api.nvim_command([[execute "normal! \<cr>"]])
      vim.api.nvim_command(bufnr .. 'bd')
    end, { buffer = bufnr })
  end,
  pattern = "qf",
})

lvim.autocommands = {
  {
    { "BufEnter", "BufWinEnter" },
    {
      group = "lvim_user",
      pattern = "*.go",
      command = "setlocal ts=4 sw=4",
    },
  },
}

-- remove dap-ui console because it always empty
lvim.builtin.dap.ui.config.layouts[1].elements = {
  { id = "breakpoints", size = 0.17 },
  { id = "scopes",      size = 0.58 },
  { id = "watches",     size = 0.25 },
}
lvim.builtin.dap.ui.config.layouts[2].elements[2] = nil
lvim.builtin.dap.ui.config.layouts[2].elements[1].size = 1
