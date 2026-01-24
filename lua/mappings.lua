require "nvchad.mappings"
local conform = require "conform"

-- add yours here

local map = vim.keymap.set
local key = require "which-key"
local picker = require "snacks.picker"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "K", function()
  vim.lsp.buf.hover {
    border = "rounded",
  }
end)
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>w", "<cmd> w <cr>")
map("n", "<leader>q", "<cmd> q <cr>")
-- 移動関連

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- 挿入モード (入力中も見た目通りに移動したい場合)
map("i", "<Up>", "<C-o>gk")
map("i", "<Down>", "<C-o>gj")

-- VSCodeのようにコード移動をする
-- ノーマルモード
map("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
map("n", "<A-Down>", ":m .+1<CR>==", { silent = true })

-- 挿入モード
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { silent = true })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { silent = true })

-- ビジュアルモード（複数行選択時の移動）
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

-- git関連
key.add {
  { "<leader>g", icon = "󰊢", desc = "Git" },
}

map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Lsp関連

key.add {
  { "<leader>l", icon = "󱖫", desc = "LSP関連の操作" },
}

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
  picker.diagnostics()
end, { desc = "LSP diagnostics (Workspace)" })

map("n", "<leader>lf", function()
  conform.format()
end, { desc = "Format file" })

map("n", "<leader>lr", function()
  require "nvchad.lsp.renamer"()
end, { desc = "LSP NvRenamer" })

-- トグルスイッチ
key.add {
  { "<leader>t", icon = "", desc = "Toggle settings" },
}

map("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

map("n", "<leader>tn", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = false
    print "Line numbers: OFF"
  elseif vim.wo.number then
    vim.wo.relativenumber = true
    print "Line numbers: Relative"
  else
    vim.wo.number = true
    print "Line numbers: Absolute"
  end
end, { desc = "Toggle line number mode" })

-- Telescope
key.add {
  { "<leader>f", icon = "󰭎", desc = "Telescope" },
}

vim.keymap.del("n", "<leader>fm")

map("n", "<leader>fw", function()
  picker.grep()
end, { desc = "Live grep" })

map("n", "<leader>ff", function()
  picker.files()
end, { desc = "Find files" })

map("n", "<leader>fa", function()
  picker.files { ignored = true, hidden = true }
end, { desc = "Find all files" })

map("n", "<leader>fo", function()
  picker.recent()
end, { desc = "Find recent files" })

map("n", "<leader>fz", function()
  picker.lines()
end, { desc = "Find in current buffer" })

map("n", "<leader>fh", function()
  picker.help()
end, { desc = "Find helps" })

map("n", "<leader>fb", function()
  picker.buffers()
end, { desc = "Find buffers" })

map("n", "<leader><space>", function()
  picker.smart()
end, { desc = "Smart Finder" })

-- Copilot
key.add {
  { "<leader>c", icon = "", desc = "Copilot" },
}

map("n", "<leader>co", function()
  require("CopilotChat").open {
    sticky = { "#buffer:active" },
    auto_insert_mode = true,
  }
end, { desc = "Copilot Chatを開く" })
