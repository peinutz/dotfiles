function FocusPreviousWindow()
  local prev_win_id = vim.fn.winnr('#')
  vim.cmd('wincmd p')
  if prev_win_id ~= vim.fn.winnr('#') then
    vim.cmd('wincmd p')
  end
end

-- add your own keymapping
-- Move buffers left and right
lvim.keys.normal_mode["<C-n>"] = ":tabnext<CR>"
lvim.keys.normal_mode["H"] = ":bp<CR>"
lvim.keys.normal_mode["L"] = ":bn<CR>"
lvim.keys.normal_mode["Q"] = ":bd<CR>"
lvim.keys.normal_mode["<"] = ":NvimTreeFocus<CR>"



-- general
-- lvim.log.level = "warn"
lvim.format_on_save = true
--
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.builtin.bufferline.options.truncate_names = false
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

vim.opt.relativenumber = true

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set("n", "<C-n>", ":tabnext<CR>")

-- moves blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- moves up and down, but keeps cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search terms stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", ">", ":<C-w>p")

-- vim spectre search
vim.keymap.set('n', '<leader>V', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>vw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word"
})
vim.keymap.set('n', '<leader>vp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file"
})



-- Other LunarVim configurations...


-- Refactor
-- Remaps for the refactoring operations currently offered by the plugin
lvim.keys.normal_mode["<leader>re"] = "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>"
lvim.keys.visual_mode["<leader>re"] = "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>"
lvim.keys.normal_mode["<leader>rf"] = "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>"
lvim.keys.visual_mode["<leader>rf"] = "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>"
lvim.keys.normal_mode["<leader>rv"] = "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>"
lvim.keys.visual_mode["<leader>rv"] = "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>"
lvim.keys.normal_mode["<leader>ri"] = "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>"
lvim.keys.visual_mode["<leader>ri"] = "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>"
lvim.keys.normal_mode["<leader>rb"] = "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>"
lvim.keys.normal_mode["<leader>rbf"] = "<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>"



-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.auto_open = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.telescope.defaults.layout_strategy = "vertical"
lvim.builtin.telescope.defaults.layout_config.height = 0.9
lvim.builtin.telescope.defaults.layout_config.width = 0.9
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 10

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
  "yaml",
  "graphql",

}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


lvim.plugins = {
  { "davidosomething/format-ts-errors.nvim" },
  { "catppuccin/nvim", name = "catppuccin"  },
  {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
},  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  {

    "tpope/vim-surround",
  },
  {
    "ray-x/lsp_signature.nvim"
  },
  {
    "github/copilot.vim"
  },
  { 'kevinhwang91/nvim-ufo'}
  ,
  {
    'nvim-tree/nvim-web-devicons'  },
  { 'nvim-pack/nvim-spectre' }

}


local catppuccin = require("catppuccin").setup({
  lazy = false,
  flavour = "catppuccin-frappe",
   background = { -- :h background
        light = "frappe",
        dark = "mocha",
    },
})


vim.cmd.colorscheme "catppuccin-frappe"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
  handlers = {
    ["textDocument/publishDiagnostics"] = function(
      _,
      result,
      ctx,
      config
    )
      if result.diagnostics == nil then
        return
      end

      -- ignore some tsserver diagnostics
      local idx = 1
      while idx <= #result.diagnostics do
        local entry = result.diagnostics[idx]

        local formatter = require('format-ts-errors')[entry.code]
        entry.message = formatter and formatter(entry.message) or entry.message

        -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        if entry.code == 80001 then
          -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
          table.remove(result.diagnostics, idx)
        else
          idx = idx + 1
        end
      end

      vim.lsp.diagnostic.on_publish_diagnostics(
        _,
        result,
        ctx,
        config
      )
    end,
  },
})

lspconfig.tsserver.setup({
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
})



local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "javascript", "vue", "javascriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
    format = nil,

  },
  {
    exe = 'eslint',
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "vue",
    },
    format = nil,
  }
}


-- Set up autocmd for triggering null-ls on save
-- vim.cmd([[autocmd BufWritePre <buffer> lua require'null-ls'.save()]])

-- Folding plugin
-- vim.o.foldcolumn = '1' -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true
-- }
-- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--   require('lspconfig')[ls].setup({
--     capabilities = capabilities
--     -- you can add other fields for setting up lsp server in this table
--   })
-- end


-- require('ufo').setup()
