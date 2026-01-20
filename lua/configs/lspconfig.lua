require("nvchad.configs.lspconfig").defaults()

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vim.fn.expand "$MASON/packages/vue-language-server" .. "/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
}

vim.lsp.config("vtsls", {
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})

vim.lsp.config("vue_ls", {
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

require("mason").setup()
require("mason-lspconfig").setup()
-- read :h vim.lsp.config for changing options of lsp servers
