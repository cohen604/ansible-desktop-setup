local packer = nil
local function init()
    if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
    end
    local use = packer.use
    packer.reset()
    use 'wbthomason/packer.nvim'

    use 'rust-lang/rust.vim'
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
    use 'hrsh7th/nvim-compe'
    use 'vimwiki/vimwiki'
    use 'junegunn/fzf.vim'
    use 'tpope/vim-surround'

    use 'tiagovla/tokyodark.nvim' 
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
