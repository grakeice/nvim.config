return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "g", "z" }, -- ガイドを出すトリガーキーを指定
    cmd = "WhichKey",
    config = function()
      require("which-key").setup {
        delay = 300,
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "tsx",
        "typescript",
      },
      highlight = {
        enable = true,
      },
    },
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "CmdlineEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    -- event = "CmdlineEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = true, animate = { enabled = true } },
      input = { enabled = true },
      picker = { enabled = true, ui_select = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    "github/copilot.vim",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    dependencies = {
      { "github/copilot.vim" },
    },
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = "node",
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      { "github/copilot.vim" },
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "CmdlineEnter",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    config = function()
      require("CopilotChat").setup {
        show_help = "yes",
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
            mapping = "<leader>ce",
            description = "コードの説明をお願いする",
          },
          Review = {
            prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
            mapping = "<leader>cr",
            description = "コードのレビューをお願いする",
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
            mapping = "<leader>cf",
            description = "コードの修正をお願いする",
          },
          Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
            mapping = "<leader>co",
            description = "コードの最適化をお願いする",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
            mapping = "<leader>cd",
            description = "コードのドキュメント作成をお願いする",
          },
          Tests = {
            prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
            mapping = "<leader>ct",
            description = "テストコード作成をお願いする",
          },
          FixDiagnostic = {
            prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
            mapping = "<leader>cd",
            description = "コードの修正をお願いする",
            selection = require("CopilotChat.select").diagnostics,
          },
          Commit = {
            prompt = "実装差分に対するコミットメッセージを日本語で記述してください。",
            mapping = "<leader>cco",
            description = "コミットメッセージの作成をお願いする",
            selection = require("CopilotChat.select").gitdiff,
          },
          CommitStaged = {
            prompt = "ステージ済みの変更に対するコミットメッセージを日本語で記述してください。",
            mapping = "<leader>cs",
            description = "ステージ済みのコミットメッセージの作成をお願いする",
            selection = function(source)
              return require("CopilotChat.select").gitdiff(source, true)
            end,
          },
        },
      }
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
}
