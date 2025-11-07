-- ---general setting---
vim.opt.compatible = false -- not compatible with vi
vim.opt.encoding = "utf-8" -- set encoding utf-8 when opening file
vim.scriptencoding = "utf-8" -- use multi-byte in VimScript
vim.opt.backup = false -- don't make backup file
vim.opt.swapfile = false -- dont' make swap file
vim.opt.fileencoding = "utf-8" -- encoding when saving
vim.opt.fileencodings={ "ucs-boms", "utf-8", "euc-jp", "cp932" } -- auto-recognize when loading. left is priority
vim.opt.fileformats= {"unix", "dos", "mac" } -- auto-recognize newline. left is priority

-- resolve the problems of full size text. ex.◯
-- Some exception is applied using setcellwidths() for preventing UI collapse. Exceptions are
-- 罫線素片, ブロック要素 and Nerdfont ple lower triangle
vim.opt.ambiwidth = "double"
vim.fn.setcellwidths({
   {0x2500, 0x257f, 1},
   {0x2580, 0x259f, 1},
   {0xe0b8, 0xe0be, 1},
})

vim.opt.autoread = true  -- auto-read when editting file is changed
vim.opt.hidden = true  -- can open other files when buffer is being editting. 
vim.opt.showcmd = true -- show command typing now on status area.
vim.g.mapleader = "<Space>"  -- map Space to Leader
vim.opt.number = true -- show line number of under cursor line
vim.opt.relativenumber = true -- show relative line number
vim.opt.modeline = false -- unvim.opt.modeline


-- ---cursor---
vim.opt.cursorline = true -- highlight present line
vim.opt.cursorcolumn = true -- highlight present column
vim.opt.virtualedit = "onemore" -- cursor can move 1 char after EOL
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"   -- move L or R at EOL can move next line 
vim.opt.conceallevel = 2
vim.opt.concealcursor = "" -- only conceal not present line

-- can move across apparent line even if it is logicaly single line
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })
vim.keymap.set('n', '<down>', 'gj', { noremap = true })
vim.keymap.set('n', '<up>', 'gk', { noremap = true })

vim.opt.backspace = { "indent", "eol", "start" }  -- backspace available

-- ---mouse---
-- disable mouse
vim.opt.mouse = ""

-- ---paste---
-- sync to clipboard
vim.opt.clipboard = "unnamedplus"

-- ---bracket---
vim.opt.showmatch = true  -- show matching bracket when input bracket
vim.g.loaded_matchit = true -- extend '%'

-- ---layout---
vim.opt.laststatus = 2 -- show status line always
vim.opt.title = true -- show title-name 
vim.opt.visualbell = true  -- beep sound visualization

-- ---completion---
vim.opt.wildmode = "list:longest"  -- file name completion in command line mode
vim.opt.history = 5000  -- set command history  

-- ---Tab,Indent---
vim.opt.expandtab = true  -- change TAB to Space  
vim.opt.tabstop = 2  -- TAB is 2 Spaces
vim.opt.softtabstop = 2  -- TAB or Backspace move 2 on series spaces
vim.opt.shiftwidth = 2  -- width when new line
vim.opt.list = true
vim.opt.listchars = "tab:▸-" -- TAB seems ▸-
vim.opt.autoindent = true  -- continue same indent when new line
vim.opt.smartindent = true  -- enable smartindent
vim.opt.breakindent = true

-- ---search---
vim.opt.ignorecase = true -- ignore upper and lower case when search string is lower case
vim.opt.smartcase = true -- distinct upper and lower case when search string contains upper case
vim.opt.incsearch = true -- realtime searching
vim.opt.wrapscan = true -- next result when hit bottom move back to top
vim.opt.hlsearch = true -- highlight hit words
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true }) -- cancel highlight words when 2 ESC

-- ---IME---
if ( vim.fn.has('unix') == 1 and vim.fn.has('wsl') == 0 and vim.fn.has('mac') == 0 ) then
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = { "*" },
    callback = function()
      -- fcitx-remote returns 1 if current method is mozc
      vim.system({'fcitx-remote'}, { text = true }, function(obj) 
        if ( obj.stdout == "1" ) then
          vim.system('fcitx-remote -s fcitx-keyboard-us')
        end
      end)
    end
  })
end


-- ---log---
vim.opt.verbosefile = "/tmp/nvim.log"
vim.opt.verbose = 0

-- ---terminal---
vim.opt.shell = "/bin/zsh"
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>', { noremap = true, silent = true })

-- ----------------------------
-- python3 setting
-- ----------------------------
vim.g.python3_host_prog = vim.fn.expand('~/nvim-python3/bin/python3')
vim.g.python_host_prog = vim.fn.expand('~/nvim-python2/bin/python2')

-- ----------------------------
-- colorscheme
-- ----------------------------
-- set termguicolors
if ( vim.fn.exists('+termguicolors') ) then
  vim.opt.termguicolors = true
end

vim.g.solarized_termcolors = 256

vim.syntax = on  -- enable syntax highlighting

-- ----------------------------
-- languege specific config
-- ----------------------------
vim.filetype = on

-- Disable expandtab for Makefile
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Makefile",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Set filetype "tf" to "terraform"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tf",
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

vim.cmd("source ~/dotfiles/nvim/language/c.vim")

--- ---------------------------
--- package
--- ---------------------------
require("config.lazy")

vim.g.copilot_proxy_strict_ssl = false
