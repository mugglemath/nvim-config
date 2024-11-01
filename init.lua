-- Initialize Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader Key Configuration
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Key Mappings
vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- Line Numbers
vim.wo.number = true

-- GUI Font Configuration (if running in GUI)
if vim.fn.has("gui_running") then
    vim.opt.guifont = "JetBrainsMono Nerd Font:h12" 
end

-- Plugin Configuration
local plugins = {
  -- Colorscheme
  {
     "folke/tokyonight.nvim",
     lazy = false,
     priority = 1000,
     opts = {},
  },
  
  -- Telescope for fuzzy finding
  { 
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  
  -- Treesitter for syntax highlighting and more
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate" 
  },
  
  -- NeoTree for file exploration
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }
}

local opts = {}

-- Setup Lazy.nvim with the defined plugins
require("lazy").setup(plugins, opts)

-- Telescope Key Mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Treesitter Configuration
local config = require('nvim-treesitter.configs')
config.setup({
  ensure_installed = { "lua", 'c', 'go', 'rust', 'javascript', 'typescript', 'java', 'python' },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Colorscheme Setup
require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight")

