-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define leader key before lazy setup
vim.g.mapleader = ' '

-- Configure plugins with lazy.nvim
require("lazy").setup({
  -- Treesitter for better syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "rust", "go", "typescript", "javascript", "lua", "vim", "vimdoc", "svelte" },
        highlight = { enable = true },
        indent = { enable = true }
      }
    end
  },

  { "nvim-neotest/nvim-nio" },

    {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        }
      }
    end
  },
  -- Undo tree
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
    end
  },

{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        -- Use dots for indentation
        indent = {
            char = "⋅", -- You can use "⋅" (middle dot) or "." (regular dot)
        },
        -- Remove the underline
        scope = {
            show_start = false,
            show_end = false,
            highlight = "CursorColumn", -- Disable highlighting
        },
        -- Disable the underline globally
        whitespace = {
            highlight = "CursorColumn", -- Disable whitespace highlighting
        },
    },
},

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
      })
    end
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true }) -- Git status
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true }) -- Git commit
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { noremap = true, silent = true }) -- Git push
    end
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{
        defaults = {
          file_ignore_patterns = { "^.git/", "node_modules" }
        }
      }
    end
  },

  {
    'olimorris/persisted.nvim',
    config = function()
      require('persisted').setup({
        save_dir = vim.fn.stdpath('data') .. '/sessions/', -- Directory to save sessions
        silent = true, -- No notifications
        autoload = true, -- Automatically load the last session
        on_autoload_no_session = function()
          vim.notify('No session to load.')
        end,
      })
    end
  },

  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    event="VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false }
      })
    end
  },

  -- Theme
  {
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    config = function()
      require('ayu').setup({
        mirage = false,
        overrides = {
          LineNr = { fg = "#964B00" },  -- brown
        }
      })
      vim.cmd('colorscheme ayu-dark')
    end
  },

  -- Utilities
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

  {
    'numToStr/Comment.nvim',
    config = true
  },

  -- Formatter
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier, -- JavaScript/TypeScript
          null_ls.builtins.formatting.gofmt, -- Go
          null_ls.builtins.formatting.rustfmt, -- Rust
          null_ls.builtins.formatting.clang_format, -- C/C++
          null_ls.builtins.formatting.stylua, -- Lua
        },
      })
    end
  },

  {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = { enable = false },
        lightbulb = { enable = false },
      })
    end
  },

  -- Markdown Preview
{
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
},

  -- Wakatime
  {'wakatime/vim-wakatime'},
  
  {
  'simrat39/rust-tools.nvim',
  config = function()
    require('rust-tools').setup({
      server = {
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = "clippy",
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
          }
        }
      }
    })
  end
},

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Define on_attach function
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      end

      -- Setup Mason
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'rust_analyzer', 'gopls', 'ts_ls', 'lua_ls' }
      })

      -- Get LSP capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      -- Function to safely setup LSP servers
      local function safe_setup(server_name, config)
        local success, err = pcall(function()
          lspconfig[server_name].setup(config)
        end)
        if not success then
          -- Suppress error messages for missing language servers
          vim.notify("LSP server " .. server_name .. " not found: " .. err, vim.log.levels.WARN, { title = "LSP Setup" })
        end
      end

      -- clangd
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        init_options = {
          clangdFileStatus = true,
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })

      -- TypeScript LSP setup
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
        single_file_support = false,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      })

      -- Rust LSP setup
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = "clippy",
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
          }
        }
      })

      -- Go LSP setup
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
    end
  },
})

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.updatetime = 1
vim.opt.signcolumn = 'yes'
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Keymappings
local opts = { noremap = true, silent = true }

-- File navigation
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- File tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', opts)
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', opts)

-- Quick commands
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>q', ':q<CR>', opts)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)

-- Markdown preview
vim.keymap.set('n', '<leader>mm', ':MarkdownPreviewToggle<CR>', opts)

-- Insert mode shortcuts
vim.keymap.set('i', 'jj', '<Esc>', opts)

-- Center screen after vertical movements
vim.keymap.set('n', 'j', 'jzz', opts)
vim.keymap.set('n', 'k', 'kzz', opts)

-- Auto-escape after new line
vim.keymap.set('n', 'o', 'o<Esc>', opts)
vim.keymap.set('n', 'O', 'O<Esc>', opts)

-- Undo tree keymapping
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', opts)

vim.keymap.set('n', '<leader>ss', ':PersistedSave<CR>', opts) -- Save session
vim.keymap.set('n', '<leader>sl', ':PersistedLoad<CR>', opts) -- Load session

-- Key mappings for LSP
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

local function create_new_file()
  local new_file = vim.fn.input("New file: ")
  if new_file ~= "" then
    vim.cmd("edit " .. new_file)
  end
end

local signs = { Error = "✗", Warn = "!", Hint = "➤", Info = "ℹ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.keymap.set("n", "<leader>nf", create_new_file, { desc = "Create new file" })

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = { prefix = '● ' },
  float = {
    source = 'always',
    border = 'rounded'
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.c', '*.rs', '*.go', '*.ts', '*.tsx', '*.js' ,'*.py', '*.html'},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

function OpenTerminalBottomThird()
  -- Check if a terminal buffer already exists
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      -- Switch to the existing terminal window
      vim.cmd('botright split | resize ' .. math.floor(vim.o.lines * 0.33))
      vim.cmd('buffer ' .. buf)
      vim.cmd('startinsert')
      return
    end
  end

  -- If no terminal buffer exists, create a new one
  local height = math.floor(vim.o.lines * 0.33)
  vim.cmd('botright split | resize ' .. height)
  vim.cmd('term')

  -- Disable line numbers and enter insert mode
  vim.api.nvim_win_set_option(0, 'number', false)
  vim.api.nvim_win_set_option(0, 'relativenumber', false)
  vim.cmd('startinsert')
end

-- Toggle terminal
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua OpenTerminalBottomThird()<CR>', { noremap = true, silent = true })
