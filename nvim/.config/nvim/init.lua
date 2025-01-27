local getTime = tonumber(os.date("%H"))
if(getTime <= 3)
then
    print("Good night, Shinohara")
elseif(getTime <= 12)
then
    print("Good morning, Shinohara")
elseif(getTime <= 17)
then
    print("Good afternoon, Shinohara")
elseif(getTime <= 23)
then
    print("Good evening, Shinohara")
end

vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

vim.g.os = vim.loop.os_uname().sysname
-- vim.g.open_command = "xdg-open"
vim.g.mapleader = " "

vim.opt.number = true

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

