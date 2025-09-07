-- Leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.clipboard = "unnamedplus"

-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.showmatch = false
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"
vim.opt.formatoptions:append("t")
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- Indentation
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Files and backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autoread = true
vim.opt.directory = vim.fn.expand("~/dev/tmp")

-- Performance
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

-- Terminal colors
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
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

-- Plugin setup
require("lazy").setup({
        -- Fuzzy finder
        {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                        require("telescope").setup({
                                defaults = {
                                        file_ignore_patterns = { "node_modules", ".git/" },
                                },
                        })
                end,
        },

        -- Git
        { "tpope/vim-fugitive" },
        { "lewis6991/gitsigns.nvim", config = true },

        -- LSP
        {
                "williamboman/mason.nvim",
                config = true,
        },
        {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "mason.nvim" },
                config = function()
                        require("mason-lspconfig").setup({
                                ensure_installed = { "lua_ls", "rust_analyzer" },
                                automatic_installation = true,
                        })
                end,
        },
        {
                "neovim/nvim-lspconfig",
                dependencies = { "mason-lspconfig.nvim" },
                config = function()
                        local lspconfig = require("lspconfig")
                        local capabilities = vim.lsp.protocol.make_client_capabilities()

                        -- Setup LSP servers
                        lspconfig.lua_ls.setup({
                                capabilities = capabilities,
                                settings = {
                                        Lua = {
                                                diagnostics = { globals = { "vim" } },
                                                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                                        },
                                },
                        })

                        lspconfig.rust_analyzer.setup({
                                capabilities = capabilities,
                        })
                end,
        },

        -- Completion
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        "hrsh7th/cmp-nvim-lsp",
                        "hrsh7th/cmp-buffer",
                        "L3MON4D3/LuaSnip",
                        "saadparwaiz1/cmp_luasnip",
                },
                config = function()
                        local cmp = require("cmp")
                        cmp.setup({
                                snippet = {
                                        expand = function(args)
                                                require("luasnip").lsp_expand(args.body)
                                        end,
                                },
                                mapping = {
                                        ["<Tab>"] = cmp.mapping.select_next_item(),
                                        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                                        ["<CR>"] = cmp.mapping.confirm({ select = true }),
                                },
                                sources = {
                                        { name = "nvim_lsp" },
                                        { name = "buffer" },
                                        { name = "luasnip" },
                                },
                        })
                end,
        },

        -- Quality of life
        { "windwp/nvim-autopairs", config = true },
        { "numToStr/Comment.nvim", config = true },
        {
                "https://codeberg.org/ericrulec/gruber-darker.nvim",
                lazy = false,
                priority = 1000,
                config = function()
                        vim.cmd.colorscheme("gruber-darker")
                end,
        },

})

-- Key mappings
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Telescope mappings
vim.keymap.set("n", "<leader>;", "<cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

-- LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
                local opts = { buffer = args.buf, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>ff", function()
                        vim.lsp.buf.format({ async = true })
                end, opts)
        end,
})

-- Colorscheme and highlights
vim.cmd.colorscheme("default")
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FF8C00" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFA500" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#FF8C00" })

-- Statusline with git branch
vim.opt.statusline = "%f %m%r%h%w [%{FugitiveHead()}]%=%l:%c %P"
