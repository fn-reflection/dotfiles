-- DISABLE LOADING TO QUICK LAUNCH
vim.g.did_install_default_menus = 1;
vim.g.did_install_syntax_menu = 1;
vim.g.did_indent_on = 1;
vim.g.did_load_filetypes = 1;
vim.g.did_load_ftplugin = 1;
vim.g.loaded_2html_plugin = 1;
vim.g.loaded_gzip = 1;
vim.g.loaded_man = 1;
vim.g.loaded_matchit = 1;
vim.g.loaded_matchparen = 1;
vim.g.loaded_netrwPlugin = 1;
vim.g.loaded_remote_plugins = 1;
vim.g.loaded_shada_plugin = 1;
vim.g.loaded_spellfile_plugin = 1;
vim.g.loaded_tarPlugin = 1;
vim.g.loaded_tutor_mode_plugin = 1;
vim.g.loaded_zipPlugin = 1;
vim.g.skip_loading_mswin = 1;
vim.g.skip_defaults_vim = 1;

-- KEY MAPPING
vim.g.mapleader = ' '
vim.opt.whichwrap:append('<')
vim.opt.whichwrap:append('>')
vim.opt.whichwrap:append('h')
vim.opt.whichwrap:append('l')
vim.keymap.set('n', 'v', '<C-v>') -- use VISUAL BLOCK as default and avoid conflict (C-v as PASTE)
vim.keymap.set('n', 'cc', '<nop>') -- disable change line
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set("", "<C-j>", "<Plug>(edgemotion-j)", opt)
vim.keymap.set("", "<C-k>", "<Plug>(edgemotion-k)", opt)

-- CUSTOMIZE
vim.opt.autoindent = true -- same indent as current line
vim.opt.autoread = true -- auto reload file when changed
vim.opt.clipboard:append{'unnamedplus'} -- use system clipboard
vim.opt.expandtab = true -- convert tab to space
vim.opt.ignorecase = true -- ic as default, `:set noic` to disable
vim.opt_local.number = true -- show line numbers as default, `:set nonu` to disable
vim.opt.mouse = 'a' -- enable mouse on all modes
vim.opt.smartcase = true -- case sensitive search when query has some upper-case character
vim.opt.smartindent = true -- smart indent by parenthesis
vim.opt.tabstop = 4 -- tab size
vim.opt.termguicolors = true -- enable 24-bit RGB color for feline
vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
    -- use from VSCode Neovim or Neovim
    use {
        'tani/vim-jetpack',
        opt = 1
    } -- to bootstrap vim-jetpack
    use 'tpope/vim-commentary' -- https://github.com/tpope/vim-commentary, gc<motion> to comment out
    use 'haya14busa/vim-edgemotion' -- https://github.com/haya14busa/vim-edgemotion
    use 'easymotion/vim-easymotion' -- https://github.com/easymotion/vim-easymotion

    if vim.g.vscode then
        return nil
    end

    -- use from only Neovim
    use {
        'neoclide/coc.nvim', -- language server, https://github.com/neoclide/coc.nvim:q
        branch = 'release'
    }
    use 'feline-nvim/feline.nvim' -- status bar, https://github.com/Famiu/feline.nvim
    use 'lambdalisue/fern.vim' -- filer, https://github.com/lambdalisue/fern.vim
    use 'airblade/vim-gitgutter' -- git diff, https://github.com/airblade/vim-gitgutter
    use 'zefei/vim-wintabs' -- filetab, https://github.com/zefei/vim-wintabs
    use {
        'nvim-treesitter/nvim-treesitter',
        ['do'] = ':TSUpdate'
    }
    use 'simeji/winresizer' -- https://github.com/simeji/winresizer
end)

if vim.g.vscode then
    return nil
end

require('jetpack.packer').startup(function(use)
    -- use from VSCode Neovim or Neovim
    use {
        'tani/vim-jetpack',
        opt = 1
    } -- to bootstrap vim-jetpack
    use 'tpope/vim-commentary' -- https://github.com/tpope/vim-commentary, gc<motion> to comment out
    use 'haya14busa/vim-edgemotion' -- https://github.com/haya14busa/vim-edgemotion
    use 'easymotion/vim-easymotion' -- https://github.com/easymotion/vim-easymotion

    if vim.g.vscode then
        return nil
    end

    -- use from only Neovim
    use 'feline-nvim/feline.nvim'
    use 'zefei/vim-wintabs' -- https://github.com/zefei/vim-wintabs
    use {
        'neoclide/coc.nvim', -- https://github.com/neoclide/coc.nvim
        branch = 'release'
    }
    use 'lambdalisue/fern.vim' -- https://github.com/lambdalisue/fern.vim
    use {
        'nvim-treesitter/nvim-treesitter',
        ['do'] = ':TSUpdate'
    }
    use 'airblade/vim-gitgutter'
    use 'simeji/winresizer'
end)

require('feline').setup()
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    }
}
