---@diagnostic disable: undefined-doc-name, param-type-mismatch

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
      update_in_insert = false,
      underline = true,
      float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    },
    rooter = {
      detector = {},
      ignore = {
        servers = {},
        dirs = {},
      },
      autochdir = false,
      -- scope = "win",
      notify = false,
    },
    options = {
      opt = {
        autochdir = true,
        autoread = true,
        backspace = { "indent", "eol", "start", "nostop" },
        backupcopy = "yes",
        backupskip = "",
        breakindent = true,
        cmdheight = 0,
        -- completeopt = { "menu", "menuone", "noselect", "popup" },
        completeopt = { "menu", "menuone", "noselect" },
        confirm = true,
        copyindent = true,
        cursorline = false,
        diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" },
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
        redrawtime = 1500,
        regexpengine = 2,
        relativenumber = false,
        ruler = true,
        secure = true,
        shell = "fish -il",
        shiftwidth = 2,
        --stylua: ignore
        shortmess = { A = true, F = true, I = true, O = true, T = true, W = true, c = true, f = true, o = true, s = true, t = true, },
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
        timeoutlen = 750,
        ttimeoutlen = 10,
        undofile = true,
        updatetime = 100,
        virtualedit = "none",
        whichwrap = "<>[]hl",
        wildmenu = true,
        -- wildmode = "list:longest,list:full",
        wildmode = "list,longest",
        wildignore = { "*/node_modules/*", "*/.git/*", "*/vendor/*", "*/.suroot/*" },
        wrap = true,
        wrapscan = true,
        writebackup = true,
      },
      g = {
        editorconfig = false,
        markdown_fenced_languages = { "shell=bash" },
        ultest_deprecation_notice = 0,
        ultest_summary_width = 30,
        clipboard = {
          name = "OSC 52",
          copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
          },
          paste = {
            ["+"] = function() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end,
            ["*"] = function() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end,
          },
        },
      },
    },
    mappings = {
      n = {
        ["<A-Down>"] = ":m .+1<CR>==",
        ["<A-Up>"] = ":m .-2<CR>==",
        ["<C-Left>"] = "<Cmd>wincmd h<CR>",
        ["<C-Right>"] = "<Cmd>wincmd l<CR>",
        ["<C-q>"] = "<Cmd>q<CR>",
        ["<C-s>"] = { "<Cmd>silent! update! | redraw<CR>" },
        ["bh"] = "<Cmd>lua vim.lsp.buf.code_action()<CR>",
        ["bn"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
        ["bv"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
        ["bg"] = "<Cmd>diffget<CR>",
        ["bp"] = "<Cmd>diffput<CR>",
        ["ff"] = "<Cmd>foldopen<CR>",
        ["fv"] = "<Cmd>foldclose<CR>",
        ["gv"] = "V<Cmd>call matchup#motion#find_matching_pair(0, 0)<CR>",
        ["l"] = "V",
        ["zb"] = "<Cmd>bprevious<CR>",
        ["ze"] = ":e ",
        ["cc"] = function() require("astrocore.buffer").close() end,
        ["zf"] = { "<Cmd>lua require('conform').format()<CR><cmd>silent! update! | redraw<CR>" },
        ["zh"] = "<Cmd>lua vim.diagnostic.goto_next()<CR><cmd>lua vim.lsp.buf.code_action()<CR>",
        ["zn"] = "<Cmd>bnext<CR>",
        ["zq"] = "<Cmd>q<CR>",
        ["zr"] = ":%s/",
        ["zx"] = ":d<CR>",
        ["zz"] = { "<Cmd>silent! update! | redraw<CR>" },
      },
      v = {
        ["<A-Down>"] = ":m '>+1<CR>gv-gv",
        ["<A-Up>"] = ":m '<-2<CR>gv-gv",
        ["<C-s>"] = ":sort<CR>",
        ["zx"] = ":d<CR>",
      },
      x = {
        ["<C-s>"] = ":sort<CR>",
      },
    },
  },
}
