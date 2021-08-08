local g = vim.g
local cmd = vim.cmd

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

g.tokyodark_transparent_background = false
g.tokyodark_enable_italic_comment = true
g.tokyodark_enable_italic = true
g.tokyodark_color_gamma = "1.0"
cmd [[colorscheme tokyodark]]