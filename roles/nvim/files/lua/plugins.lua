return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'dense-analysis/ale'
    use 'rust-lang/rust.vim'
    use 'fannheyward/coc-rust-analyzer'

end)