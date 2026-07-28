-- ---general setting---
vim.g.mapleader = " "         -- map Space to Leader
vim.g.maplocalleader = "\\"    -- keep local mappings separate from global Leader
vim.opt.fileencoding = "utf-8" -- encoding when saving
vim.opt.fileencodings = { "ucs-boms", "utf-8", "euc-jp", "cp932" } -- auto-recognize when loading. left is priority
vim.opt.fileformats = { "unix", "dos", "mac" }                     -- auto-recognize newline. left is priority

vim.opt.backup = false   -- don't make backup file
vim.opt.swapfile = false -- don't make swap file
vim.opt.autoread = true  -- auto-read when editing file is changed
vim.opt.modeline = false -- disable modeline for safety

vim.opt.showcmd = true        -- show command typing now on status area
vim.opt.number = true         -- show line number of under cursor line
vim.opt.relativenumber = true -- show relative line number
vim.opt.backspace = { "indent", "eol", "start" } -- backspace available across indent, EOL and insert-start

-- Resolve the problems of full size text. ex. ◯
-- Some exception is applied using setcellwidths() for preventing UI collapse.
-- Exceptions are box drawing, block elements and Nerd Font lower triangles.
vim.opt.ambiwidth = "double"
vim.fn.setcellwidths({
  { 0x2500, 0x257f, 1 },
  { 0x2580, 0x259f, 1 },
  { 0xe0b8, 0xe0be, 1 },
})

-- ---cursor---
vim.opt.cursorline = true               -- highlight present line
vim.opt.cursorlineopt = "number"        -- highlight present line number and screenline
vim.opt.cursorcolumn = false            -- highlight present column
vim.opt.virtualedit = "onemore"         -- cursor can move 1 char after EOL
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~" -- move L or R at EOL can move next line
vim.opt.conceallevel = 2
vim.opt.concealcursor = "" -- only conceal not present line

-- ---mouse---
vim.opt.mouse = "a"

-- ---paste---
vim.opt.clipboard = "unnamedplus" -- sync to clipboard

-- ---bracket---
vim.opt.showmatch = true -- show matching bracket when input bracket

-- ---layout---
vim.opt.laststatus = 2    -- show status line always
vim.opt.title = true      -- show title-name
vim.opt.visualbell = true -- beep sound visualization

-- ---completion---
vim.opt.wildmode = "list:longest" -- file name completion in command line mode
vim.opt.history = 5000            -- set command history
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }
vim.opt.complete = {} -- disable built-in CTRL-N/CTRL-P completion sources
vim.opt.pumborder = "rounded"
vim.opt.pummaxwidth = 40
vim.opt.autocomplete = false

-- ---Tab,Indent---
vim.opt.expandtab = true   -- change TAB to Space
vim.opt.tabstop = 2        -- TAB is 2 Spaces
vim.opt.softtabstop = 2    -- TAB or Backspace move 2 on series spaces
vim.opt.shiftwidth = 2     -- width when new line
vim.opt.autoindent = true  -- continue same indent when new line
vim.opt.smartindent = true -- enable smartindent
vim.opt.breakindent = true -- keep wrapped lines aligned with their indent
vim.opt.list = true
vim.opt.listchars = "tab:▸-" -- TAB seems ▸-

-- ---search---
vim.opt.ignorecase = true -- ignore upper and lower case when search string is lower case
vim.opt.smartcase = true  -- distinct upper and lower case when search string contains upper case
vim.opt.incsearch = true  -- realtime searching
vim.opt.wrapscan = true   -- next result when hit bottom move back to top
vim.opt.hlsearch = true   -- highlight hit words
vim.opt.updatetime = 500

-- ---colorscheme---
vim.opt.termguicolors = true -- enable true color

-- ---language specific config---
vim.filetype.add({
  extension = {
    astro = "astro",
    tf = "terraform",
  },
  pattern = {
    [".*%.h"] = "c",
  },
})
