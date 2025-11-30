vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.scrolloff = 5
vim.o.confirm = true
vim.opt.colorcolumn = "80,100"

-- Speed optimizations
vim.o.lazyredraw = true
vim.o.ttyfast = true
vim.o.synmaxcol = 200

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- LSP restart keymap
vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

vim.api.nvim_set_hl(0, "IblIndent", { fg = "#5c5c5c", nocombine = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
})

-- Enable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
        {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                update_debounce = 100,
                attach_to_untracked = false,
                sign_priority = 6,
            },
        },

        {
            "nvim-tree/nvim-tree.lua",
            cmd = { "NvimTreeToggle", "NvimTreeOpen" },
            keys = {
                { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
            },
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {
                git = { timeout = 400 },
            },
        },

        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                delay = 0,
                icons = { mappings = vim.g.have_nerd_font, keys = vim.g.have_nerd_font and {} or {} },
                spec = {
                    { "<leader>f", group = "[F]ind" },
                    { "<leader>l", group = "[L]SP" },
                    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                },
            },
        },

        {
            "williamboman/mason.nvim",
            cmd = "Mason",
            opts = {},
        },

        {
            "nvim-lualine/lualine.nvim",
            event = "VeryLazy",
            opts = {
                options = { refresh = { statusline = 100 } },
                sections = {
                    lualine_b = {
                        "branch", "diff",
                        { "diagnostics", sources = { "nvim_diagnostic" } },
                    },
                    lualine_c = { "filename" },
                },
            },
        },

        {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            keys = {
                { "<leader>f", "<cmd>Telescope find_files<cr>" },
                { "<leader>g", "<cmd>Telescope live_grep<cr>" },
                { "<leader>b", "<cmd>Telescope buffers<cr>" },
                { "<leader>h", "<cmd>Telescope help_tags<cr>" },
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
            config = function()
                local telescope = require("telescope")
                telescope.setup({
                    defaults = {
                        file_ignore_patterns = { "%.git/", "target/" },
                    },
                })
                pcall(telescope.load_extension, "fzf")
            end,
        },

        {
            "neovim/nvim-lspconfig",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                { "j-hui/fidget.nvim", opts = {} },
                "saghen/blink.cmp",
            },
            config = function()
                vim.diagnostic.config({
                    virtual_text = {
                        source = "if_many",
                        prefix = "●",
                        severity_sort = true,
                    },
                    float = {
                        border = "rounded",
                        source = "if_many",
                        focusable = true,
                    },
                    signs = true,
                    underline = true,
                    update_in_insert = false,
                    severity_sort = true,
                })

                -- LSP keymaps
                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(event)
                        local map = function(keys, func, desc)
                            vim.keymap.set("n", keys, func,
                                { buffer = event.buf, desc = desc })
                        end
                        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
                        map("gd", vim.lsp.buf.definition, "Go to definition")
                        map("gr", vim.lsp.buf.references, "Go to references")
                        map("<leader>r", vim.lsp.buf.rename, "Rename")
                        map("<leader>a", vim.lsp.buf.code_action, "Code action")
                        map("K", vim.lsp.buf.hover, "Hover documentation")
                        map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
                    end,
                })

                local capabilities = require("blink.cmp").get_lsp_capabilities()

                local servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                completion = { callSnippet = "Replace" },
                                diagnostics = { globals = { "vim" } }
                            }
                        },
                        path = "home/juan/.lua_ls",
                    },
                    gopls = {},
                    clangd = {},
                    zls = {
                        path = "/home/juan/.zls",
                    }
                }

                local ensure_installed = vim.tbl_keys(servers)

                require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

                require("mason-lspconfig").setup({
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities = vim.tbl_deep_extend("force", {},
                                capabilities,
                                server.capabilities or {})
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                })
            end,
        },


        {
            "mrcjkb/rustaceanvim",
            version = "^5",
            ft = { "rust" },
            config = function()
                vim.g.rustaceanvim = {
                    server = {
                        capabilities = require("blink.cmp").get_lsp_capabilities(),
                        settings = {
                            ["rust-analyzer"] = {
                                check = { command = "clippy" },
                                cargo = {
                                    buildScripts = { enable = true },
                                },
                                procMacro = { enable = true },
                                diagnostics = {
                                    enable = true,
                                    experimental = { enable = false }
                                },
                                inlayHints = {
                                    bindingModeHints = { enable = true },
                                    chainingHints = { enable = false },
                                    closingBraceHints = { enable = true },
                                    closureReturnTypeHints = { enable = true },
                                    lifetimeElisionHints = { enable = true },
                                    parameterHints = { enable = true },
                                    typeHints = { enable = true },
                                },
                            },
                        },
                    },
                }
            end,
        },

        {
            "lukas-reineke/indent-blankline.nvim",
            event = { "BufReadPost", "BufNewFile" },
            main = "ibl",
            opts = {
                indent = {
                    char = "│",
                },
                scope = {
                    enabled = false,
                },
            },
        },

        {
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            opts = {
                notify_on_error = false,
                format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
                formatters_by_ft = {
                    lua = { "stylua" },
                    js = { "prettier" },
                    json = { "prettier" },
                    go = { "gofumpt" },
                    zig = { "zls" },
                    c = { "clang-format" }
                },
            },
        },

        {
            "saghen/blink.cmp",
            event = "InsertEnter",
            version = "1.*",
            opts = {
                keymap = { preset = "super-tab" },
                sources = {
                    default = { "lsp", "path", "snippets" },
                    providers = {
                        lsp = { timeout_ms = 300 }
                    }
                },
                completion = {
                    documentation = { auto_show = true, auto_show_delay_ms = 100 },
                    menu = { draw = { treesitter = { "lsp" } } }
                },
                signature = { enabled = true },
            },
        },

        {
            "https://github.com/santos-gabriel-dario/darcula-solid.nvim",
            dependencies = {
                "https://github.com/rktjmp/lush.nvim",
            },
            -- config = function()
            --     vim.cmd.colorscheme("darcula-solid")
            -- end,
        },

        {
            "logannday/gruber-darker-nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme gruber-darker]])
            end,
        },

        {
            "https://github.com/Shatur/neovim-ayu",
            -- config = function()
            --     vim.cmd.colorscheme("ayu")
            -- end,
        },

        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true
        },

        {
            "folke/todo-comments.nvim",
            event = { "BufReadPost", "BufNewFile" },
            opts = { signs = false },
        },

        {
            "brenton-leighton/multiple-cursors.nvim",
            version = "*",
            opts = {},
            keys = {
                { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" },      desc = "Add cursor and move down" },
                { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" },      desc = "Add cursor and move up" },

                { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
                { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

                { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" },      desc = "Add or remove cursor" },

                { "<Leader>m",     "<Cmd>MultipleCursorsAddVisualArea<CR>",    mode = { "x" },           desc = "Add cursors to the lines of the visual area" },

                { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" },      desc = "Add cursors to cword" },
                { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" },      desc = "Add cursors to cword in previous area" },

                { "<Leader>d",     "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" },      desc = "Add cursor and jump to next cword" },
                { "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "x" },      desc = "Jump to next cword" },

                { "<Leader>l",     "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" },      desc = "Lock virtual cursors" },
            },
        },

        {
            "nvim-treesitter/nvim-treesitter",
            event = { "BufReadPost", "BufNewFile" },
            build = ":TSUpdate",
            main = "nvim-treesitter.configs",
            opts = {
                ensure_installed = { "lua", "rust", "c" },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = { enable = false },
            },
        },
    },
    {
        ui = { icons = vim.g.have_nerd_font and {} or {} },
    })
