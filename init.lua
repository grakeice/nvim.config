vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Check if running in VSCode
if vim.g.vscode then
  -- VSCode Neovim extension - skip NvChad plugins
  local map = vim.keymap.set
  map("n", "<leader>w", "<cmd>w<cr>", { desc = "保存" })
  map("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename" })

  map("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, { desc = "LSP code action" })

  map("n", "<leader>lA", function()
    vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = vim.lsp.diagnostic.get_line_diagnostics() } }
  end, { desc = "LSP source action" })

  -- カーソル位置のエラーを表示
  map("n", "<leader>ld", function()
    vim.diagnostic.open_float { scope = "cursor", border = "rounded" }
  end, { desc = "LSP diagnostics" })

  -- プロジェクト全体のエラー一覧を表示
  map("n", "<leader>lD", function()
    vim.diagnostic.open_float { scope = "buffer", border = "rounded" }
  end, { desc = "LSP diagnostics (Workspace)" })

  map("n", "<leader>lf", function()
    vim.lsp.buf.format()
  end, { desc = "Format file" })

  -- #region 見た目通りのカーソル移動
  local vscode = require "vscode-neovim"
  local mappings = {
    up = "k",
    down = "j",
    wrappedLineStart = "0",
    wrappedLineFirstNonWhitespaceCharacter = "^",
    wrappedLineEnd = "$",
  }

  local function moveCursor(to, select)
    return function()
      local mode = vim.api.nvim_get_mode()
      if mode.mode == "V" or mode.mode == "" then
        return mappings[to]
      end

      vscode.action("cursorMove", {
        args = {
          {
            to = to,
            by = "wrappedLine",
            value = vim.v.count1,
            select = select,
          },
        },
      })
      return "<Ignore>"
    end
  end

  map("n", "k", moveCursor "up", { expr = true })
  map("n", "j", moveCursor "down", { expr = true })

  map("v", "k", moveCursor("up", true), { expr = true })
  map("v", "j", moveCursor("down", true), { expr = true })

  map("n", "<Up>", moveCursor "up", { expr = true })
  map("n", "<Down>", moveCursor "down", { expr = true })

  map("v", "<Up>", moveCursor("up", true), { expr = true })
  map("v", "<Down>", moveCursor("down", true), { expr = true })
  -- #endregion

  -- これ以降の処理を読み込まない
  return
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"
require "configs.textobjects"

vim.schedule(function()
  require "mappings"
end)
