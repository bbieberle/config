-- Bootstrap Lazy Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.signcolumn = "yes"
vim.opt.expandtab = true


local setup_lsp_configs = function()
        local lspconfig = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = {
                        'documentation',
                        'detail',
                        'additionalTextEdits',
                }
        }
        lspconfig.pyright.setup {}
        lspconfig.clangd.setup {}
        lspconfig.cmake.setup {}
        lspconfig.dockerls.setup {}
        lspconfig.graphql.setup {}
        lspconfig.jdtls.setup {}
        lspconfig.jsonls.setup {}
        lspconfig.sqlls.setup {}
        --lspconfig.helm_ls.setup {} Experimental
        lspconfig.azure_pipelines_ls.setup {}
        lspconfig.bashls.setup {}
        lspconfig.terraformls.setup {}
        lspconfig.rnix.setup {}
        lspconfig.rust_analyzer.setup {
                settings = {
                        ["rust-analyzer"] = {
                                assist = {
                                        importEnforceGranularity = true,
                                        importPrefix = "crate"
                                },
                                cargo = {
                                        allFeatures = true,
                                        buildScripts = { enable = true }
                                },
                                completion = {
                                        autoimport = {
                                                enable = true
                                        }
                                },
                                procMacro = {
                                        enable = true
                                },
                                checkOnSave = {
                                        command = "clippy"
                                },
                                updates = {
                                        channel = "nightly"
                                }
                        }
                },
                capabilities = capabilities
        }
        lspconfig.lua_ls.setup {
                settings = {
                        Lua = {
                                diagnostics = {
                                        globals = { 'vim' }
                                }
                        }
                }
        }
        lspconfig.yamlls.setup {
                settings = {
                        yaml = {
                                format = {
                                        enable = true
                                },
                                keyOrdering = false,
                                validate = true,
                                schemaStore = {
                                        enable = true
                                }
                        }
                }
        }
        lspconfig.tsserver.setup {
                settings = {
                        typescript = {
                                format = {
                                        indentSize = 4,
                                        convertTabsToSpaces = true,
                                        trimTrailingWhitespace = true,
                                        semicolons = "remove"
                                }
                        }
                }
        }
end

-- Configuration
local telescope_conf = {
        defaults = {
                mappings = {
                        i = {
                                ["<C-e>"] = "move_selection_previous"
                        }
                }
        },
        pickers = {
                lsp_references = {
                        theme = "dropdown",
                },
                find_files = {
                        theme = "dropdown",
                        mappings = {
                                i = {
                                        ["<C-e>"] = "move_selection_previous",
                                }
                        }
                }
        },
        extensions = {
                fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                }
        }
}

-- Nvim Tree Configuration
local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<TAB>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'c', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'N', api.fs.create, opts('Create'))
end

local nvim_tree_conf = {
        sort_by = "case_sensitive",
        on_attach = on_attach,
        renderer = {
                group_empty = true,
        },
        filters = {
                dotfiles = true,
        },
}

local nvim_treesitter_conf = {
        indent = { enable = true },
        ensure_installed = { "terraform",
                "rust", "python", "css", "json", "html", "toml", "make", "scss", "typescript",
                "yaml", "vim", "lua" },
        auto_install = true,
        highlight = { enable = true, disable = { '' }, additional_vim_regex_highlighting = false }
}

local lualine_conf = {
        options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                        statusline = 100,
                        tabline = 1000,
                        winbar = 1000,
                }
        },
        sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'fileformat', 'filetype' },
                lualine_y = { 'lsp_progress' },
                lualine_z = { 'location' }
        },
        inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
}

require("lazy").setup({
        { 
                "williamboman/mason-lspconfig.nvim", 
                config = function ()
                        require("mason-lspconfig").setup {
                                ensure_installed = { "lua_ls", "rust_analyzer" },
                                automatic_installation = true
                        }
                        setup_lsp_configs()
                end,
                dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } 
        },
        {
                "hrsh7th/nvim-cmp",
                config = function()
                        local cmp = require 'cmp'
                        local icons = {
                                Array = '  ',
                                Boolean = '  ',
                                Class = '  ',
                                Color = '  ',
                                Constant = '  ',
                                Constructor = '  ',
                                Enum = '  ',
                                EnumMember = '  ',
                                Event = '  ',
                                Field = '  ',
                                File = '  ',
                                Folder = '  ',
                                Function = '  ',
                                Interface = '  ',
                                Key = '  ',
                                Keyword = '  ',
                                Method = '  ',
                                Module = '  ',
                                Namespace = '  ',
                                Null = ' ﳠ ',
                                Number = '  ',
                                Object = '  ',
                                Operator = '  ',
                                Package = '  ',
                                Property = '  ',
                                Reference = '  ',
                                Snippet = '  ',
                                String = '  ',
                                Struct = '  ',
                                Text = '  ',
                                TypeParameter = '  ',
                                Unit = '  ',
                                Value = '  ',
                                Variable = '  ',
                        }
                        require("luasnip/loaders/from_vscode").lazy_load()
                        cmp.setup({
                                snippet = {
                                        expand = function(args)
                                                require('luasnip').lsp_expand(args.body)
                                        end,
                                },
                                mapping = cmp.mapping.preset.insert({
                                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                        ['<tab>'] = cmp.mapping.confirm({ select = true }),
                                        ['<C-e>'] = cmp.mapping.select_prev_item(),
                                        ['<C-k>'] = cmp.mapping.scroll_docs()
                                }),
                                formatting = {
                                        format = function(entry, item)
                                                item.kind = string.format('%s', icons[item.kind])
                                                item.menu = ({
                                                        buffer = '[Buffer]',
                                                        luasnip = '[Snip]',
                                                        nvim_lsp = '[LSP]',
                                                        nvim_lua = '[API]',
                                                        path = '[Path]',
                                                        rg = '[RG]',
                                                })[entry.source.name]

                                                return item
                                        end,
                                },
                                experimental = {
                                        ghost_text = true
                                },
                                sources = cmp.config.sources(
                                        {
                                                { name = "nvim_lsp", max_item_count = 20 },
                                                { name = "luasnip",  max_item_count = 5 },
                                                { name = "path" }
                                        },
                                        {
                                                { name = "buffer" }
                                        })
                        })
                end,
                lazy = false,
                dependencies = {
                        "hrsh7th/cmp-nvim-lsp",
                        "hrsh7th/cmp-buffer",
                        "hrsh7th/cmp-path",
                        "saadparwaiz1/cmp_luasnip"
                }
        },
        { "williamboman/mason.nvim",                  build = ":MasonUpdate", config = true },
        {
                "nvim-telescope/telescope.nvim",
                tag = "0.1.1",
                opts = telescope_conf,
                dependencies = { 'nvim-lua/plenary.nvim', 'gbrlsnchs/telescope-lsp-handlers', 'sharkdp/fd',
                        'nvim-tree/nvim-web-devicons', 'nvim-treesitter/nvim-treesitter' },
                setup = function(args)
                        local telescope = require 'telescope'
                        telescope.setup(args)
                        telescope.load_extension('lsp_handlers')
                        telescope.load_extension('fzf')
                end
        },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        {
                "nvim-tree/nvim-tree.lua",
                opts = nvim_tree_conf,
                dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
        {
                "L3MON4D3/LuaSnip",
                dependencies = { 'rafamadriz/friendly-snippets' },
                config = true,
                setup = function(args)
                        local snip = require 'luasnip'
                        snip.setup(args)
                        snip.loaders.from_vscode.lazy_load()
                end
        },
        { "nvim-lualine/lualine.nvim",       opts = lualine_conf, dependencies = { 'arkav/lualine-lsp-progress' } },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        'tpope/vim-fugitive',
        { 'lewis6991/gitsigns.nvim',  config = true },
        'Mofiqul/dracula.nvim',
        'NLKNguyen/papercolor-theme',
        { "catppuccin/nvim", name = "catppuccin" },
        'preservim/nerdcommenter',
        'ryanoasis/vim-devicons',
        'easymotion/vim-easymotion',
        { 'Darazaki/indent-o-matic',  config = true },
        { 'gbprod/yanky.nvim',        config = true, opts = {} },
        { 'simrat39/rust-tools.nvim', config = true },
        {
                'kylechui/nvim-surround',
                event = "VeryLazy",
                config = function()
                        require("nvim-surround").setup({})
                end
        }
})

require 'nvim-treesitter.configs'.setup(nvim_treesitter_conf)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.filetype.add {
        extension = {
                tf = 'terraform'
        }
}

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
vim.cmd.colorscheme "catppuccin-frappe"
