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
vim.keymap.set('i', 'jj', '<esc>')

-- CUSTOMIZE
vim.opt.clipboard:append{'unnamedplus'} -- use system clipboard
vim.opt.ignorecase = true -- ic as default, `:set noic` to disable
vim.opt_local.number = true -- show line numbers as default, `:set nonu` to disable
vim.opt.mouse = 'a' -- enable mouse on all modes
vim.opt.smartcase = true -- case sensitive search when query has some upper-case character
vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
    -- use from VSCode Neovim or Neovim
    use {
        'tani/vim-jetpack',
        opt = 1
    } -- to bootstrap vim-jetpack
    use 'tpope/vim-commentary'
    use 'easymotion/vim-easymotion'
    use 'haya14busa/vim-edgemotion'

    if vim.g.vscode then
        return nil
    end

    -- use from only Neovim
    use 'feline-nvim/feline.nvim'
    use 'zefei/vim-wintabs'
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }
    use 'lambdalisue/fern.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        ['do'] = ':TSUpdate'
    }
    use 'airblade/vim-gitgutter'
    use 'simeji/winresizer'
end)
