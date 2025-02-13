---@diagnostic disable: undefined-doc-name, param-type-mismatch, duplicate-index

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 524288, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 2, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    },
    rooter = {
      detector = {},
      ignore = { servers = {}, dirs = {} },
      autochdir = false,
      notify = false,
    },
    sessions = { autosave = { cwd = false, last = false } },
    options = {
      opt = {
        autochdir = true,
        autoread = true,
        backspace = "indent,eol,start,nostop",
        backupcopy = "yes",
        backupskip = "",
        breakindent = true,
        cmdheight = 0,
        completeopt = "menu,menuone,noselect",
        confirm = true,
        copyindent = true,
        cursorline = false,
        diffopt = "internal,filler,closeoff,hiddenoff,algorithm:minimal,horizontal",
        expandtab = true,
        fileencoding = "utf-8",
        fsync = true,
        hidden = true,
        hlsearch = false,
        ignorecase = true,
        incsearch = true,
        infercase = true,
        joinspaces = false,
        laststatus = 2,
        linebreak = true,
        number = false,
        redrawtime = 2500,
        regexpengine = 2,
        relativenumber = false,
        ruler = true,
        secure = true,
        shiftwidth = 2,
        shortmess = "AFIOTWacfost",
        showmode = false,
        showtabline = 2,
        signcolumn = "auto",
        smartcase = true,
        smarttab = true,
        softtabstop = 2,
        spell = false,
        swapfile = false,
        tabstop = 2,
        termguicolors = true,
        timeoutlen = 700,
        ttimeoutlen = 30,
        undofile = true,
        updatetime = 300,
        virtualedit = "none",
        whichwrap = "<>[]hl",
        wildignore = { "*/node_modules/*", "*/.git/*", "*/vendor/*", "*/.suroot/*" },
        wildmenu = true,
        -- wildmode = "list:longest,list:full",
        -- wildmode = "list,longest",
        -- wildoptions = "fuzzy",
        wrap = true,
        wrapscan = true,
        writebackup = true,
      },
      g = {
        editorconfig = false,
        markdown_fenced_languages = { "shell=bash" },
        ultest_deprecation_notice = 0,
        ultest_summary_width = 30,
        --[[ clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
          },
          paste = {
            ["+"] = function()
              return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
            end,
            ["*"] = function()
              return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
            end,
          },
        }, ]]
      },
    },
    mappings = {
      n = {
        -- ["<A-Down>"] = ":m .+1<CR>==",
        -- ["<A-Up>"] = ":m .-2<CR>==",
        ["<A-Left>"] = "<Cmd>vertical resize +2<CR>",
        ["<A-Right>"] = "<Cmd>vertical resize -2<CR>",
        ["<C-A-Up>"] = "<Cmd>resize +2<CR>",
        ["<C-A-Down>"] = "<Cmd>resize -2<CR>",
        ["<C-Left>"] = "<Cmd>wincmd h<CR>",
        ["<C-M-Left>"] = "<Cmd>tabprevious<CR>",
        ["<C-M-Right>"] = "<Cmd>tabnext<CR>",
        ["<C-Right>"] = "<Cmd>wincmd l<CR>",
        ["<C-t>"] = "<Cmd>ToggleTerm<CR>",
        ["<C-q>"] = "<Cmd>q<CR>",
        ["<C-s>"] = "<Cmd>silent! update! | redraw<CR>",
        ["bh"] = "<Cmd>lua vim.lsp.buf.code_action()<CR>",
        ["bn"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
        ["bv"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
        ["bg"] = "<Cmd>diffget<CR>",
        ["bp"] = "<Cmd>diffput<CR>",
        ["l"] = "V",
        ["<Leader>ch"] = function()
          --stylua: ignore
          if vim.print(vim.o.cmdheight) == 0 then vim.cmd("set cmdheight=2") elseif vim.print(vim.o.cmdheight) == 2 then vim.cmd("set cmdheight=0") end
        end,
        ["<Leader>o"] = "o<Esc>",
        ["<Leader>O"] = "O<Esc>",
        -- ["zb"] = "<Cmd>bprevious<CR>",
        -- ["zn"] = "<Cmd>bnext<CR>",
        ["ze"] = ":e ",
        -- ["cc"] = function()
        --   require("astrocore.buffer").close()
        -- end,
        ["cc"] = "<Cmd>bdelete<CR>",
        ["ct"] = function()
          require("astrocore.buffer").close_tab()
        end,
        ["zh"] = "<Cmd>lua vim.diagnostic.goto_next()<CR><Cmd>lua vim.lsp.buf.code_action()<CR>",
        ["zq"] = "<Cmd>q<CR>",
        ["zr"] = ":%s/",
        ["zz"] = "<Cmd>silent! update! | redraw<CR>",
        ["b>"] = "]c",
        ["b<"] = "[c",
        ["<A-t>"] = 'v<Right><Right><Right>"_di[<End><Space>]<Esc>',
      },
      x = {
        -- ["<M-Down>"] = ":m '>+1<CR>gv-gv",
        -- ["<M-Up>"] = ":m '<-2<CR>gv-gv",
        -- ["<C-s>"] = ":'<,'>sort<CR>",
        -- ["<C-u>"] = ":'<,'>sort u<CR>",
        ["bg"] = ":diffget<CR>",
        ["bp"] = ":diffput<CR>",
        --stylua: ignore
        ["bh"] = function() vim.lsp.buf.code_action() end,
        ["<C-j>"] = { ":join<CR>", silent = true },
        ["zr"] = ":s/",
      },
    },
  },
}
