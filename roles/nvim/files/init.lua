local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

g.mapleader = " "

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.o.completeopt = "menuone,noselect"
local rust_tools = require('rust-tools')
local compe = require('compe')

rust_tools.setup({})
compe.setup({
	source = {
		buffer = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		path = true,
		tabnine = true,
		vim_dadbod_completion = true,
	},
})

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  --elseif vim.fn['vsnip#available'](1) == 1 then
   -- return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

map('i', '<c-space>', 'compe#complete()', { expr = true })
map('i', '<CR>', 'compe#confirm("<CR>")', { expr = true })
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


local nvim_lsp = require('lspconfig')
local on_attach = function(client)
    local opts = { noremap = true, silent = true }
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
})

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

g.tokyodark_transparent_background = true
g.tokyodark_enable_italic_comment = true
g.tokyodark_enable_italic = false
g.tokyodark_color_gamma = "1.0"

cmd [[colorscheme tokyodark]]

g.nu = true

opts = { noremap = true, silent = true }

map('n', '<leader>x', [[<cmd> Cargo run<CR>]], opts)
map('n', '<leader>b', [[<cmd> Cargo build<CR>]], opts)
map('n', '<leader>c', [[<cmd> Cargo check<CR>]], opts)
map('n', '<leader>f', [[<cmd> RustFmt<CR>]], opts) 

vim.wo.number = true
vim.bo.grepprg = 'rg --vimgrep'

g.vimwiki_list = {{
	path = '~/vimwiki/',
	syntax = 'markdown',
	ext = '.md'}}
