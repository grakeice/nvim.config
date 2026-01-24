-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest",
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
M.colorify = {
  enabled = true,
  mode = "virtual",
}
M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "SnacksPickerFiles" },
    { txt = "  Recent Files", keys = "fo", cmd = "SnacksPickerRecent" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "SnacksPickerGrep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {
  tabufline = {
    lazyload = false,
  },
}
vim.api.nvim_create_user_command("SnacksPickerFiles", function()
  Snacks.picker.files()
end, {})
vim.api.nvim_create_user_command("SnacksPickerRecent", function()
  Snacks.picker.recent()
end, {})
vim.api.nvim_create_user_command("SnacksPickerGrep", function()
  Snacks.picker.grep()
end, {})

return M
