local packer = nil
local function init()
    if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
    end
    local use = packer.use
    packer.reset()
    use 'wbthomason/packer.nvim'

    use 'dense-analysis/ale'
    use 'rust-lang/rust.vim'
    use { 'neoclide/coc.nvim', branch = 'release' }

    use 'tiagovla/tokyodark.nvim' 
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins