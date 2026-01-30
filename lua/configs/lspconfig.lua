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
      preferences = {
        jsxAttributeCompletionStyle = "braces",
      },
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
      preferences = {
        jsxAttributeCompletionStyle = "braces",
      },
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

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classFunctions = {
        "cn",
        "cva",
        "tv",
        "clsx",
        "tw",
        "twMerge",
      },
    },
  },
})

vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = {
        { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
        { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
      },
    },
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "bun.lock",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

require("mason").setup()
require("mason-lspconfig").setup()
-- read :h vim.lsp.config for changing options of lsp servers
