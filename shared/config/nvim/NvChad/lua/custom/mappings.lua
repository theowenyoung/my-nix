local M = {}
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
M.disabled = {
  n = {
    ["<leader>x"] = "",
  },
}

-- h(elllllll)

-- general
M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["<Space>X"] = { ":%bd|e#<CR>", "close all buffers but this one" },
    ["C-M-w"] = { "<C-w>", "open window manager" },
    -- ["gx"] = { ":!open <c-r><c-a><CR>", "open url", opts = {
    --   silent = true,
    -- } },
    ["qq"] = { ":q<CR>", "quit" },
    ["<Leader>w"] = { ":w<CR>", "save filee" },
    ["<D-s>"] = { ":w<CR>", "save file" },
    ["<BS>"] = { "<C-^>", "toggle last buffer" },
    ["<Leader>be"] = { ":%bd|e#<CR>", "close all other buffers except the current one" },
    ["<leader>x"] = { [["+x]], "delete with cut" },
    ["<Leader>d"] = { [["+d]], "delete with cut" },
    ["<Leader>c"] = { [["+c]], "change with cut" },
    ["<Leader>D"] = { [["+D]], "delete with cut" },
    ["<Leader>s"] = { ":%sno/", "substitute exactly" },
    ["x"] = { [["_x]], "delete not cut" },
    ["d"] = { [["_d]], "delete not cut" },
    ["c"] = { [["_c]], "change not cut" },
    ["D"] = { [["_D]], "delete not cut" },
    -- close buffer + hide terminal buffer
    ["<leader><BS>"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
  x = {
    ["x"] = { [["_x]], "delete ../../ not cut" },
    ["d"] = { [["_d]], "delete not cut" },
    ["c"] = { [["_c]], "change not cut" },
    ["D"] = { [["_D]], "delete not cut" },
    ["<leader>x"] = { [["+x]], "delete with cut" },
    ["<Leader>d"] = { [["+d]], "delete with cut" },
    ["<Leader>c"] = { [["+c]], "change with cut" },
    ["<Leader>D"] = { [["+D]], "delete with cut" },
    ["<C-r>"] = { [["hy:%s/<C-r>h//g<left><left>]], "replace selected word" },
  },
  i = {
    ["<C-s>"] = { "<ESC>:w<CR>", "save file" },
    ["<C-a>"] = { "<ESC>^i", "beginning of line" },
    ["<C-M-w"] = { "<ESC><C-w>", "open window manager" },
    ["<D-s>"] = { "<ESC>:w<CR>", "save file" },
  },
  t = {
    ["<C-M-w>"] = { termcodes "<C-\\><C-N><C-w>", "open window manager" },
    ["<C-h>"] = { termcodes "<C-\\><C-N>" .. "<C-w>h", "switch left window" },
    ["<C-j>"] = { termcodes "<C-\\><C-N>" .. "<C-w>j", "switch down window" },
    ["<C-k>"] = { termcodes "<C-\\><C-N>" .. "<C-w>k", "switch up window" },
    ["<C-l>"] = { termcodes "<C-\\><C-N>" .. "<C-w>l", "switch right window" },
    ["<C-n>"] = { termcodes "<C-\\><C-N>" .. "<cmd> NvimTreeToggle <CR>", "switch right window" },
  },
}

M.open_url = {
  n = {
    ["gx"] = { "<Plug>(open-url-browser)", "open url", opts = {
      silent = true,
    } },
  },
  x = {
    ["gx"] = { "<Plug>(open-url-browser)", "open url", opts = {
      silent = true,
    } },
  },
}

M.far = {
  n = {
    ["<Leader>S"] = {
      ":Farr<cr>",
      "find and replace, substitute",
    },
  },
  x = {
    ["<Leader>S"] = {
      ":Farr<cr>",
      "find current word, and replace",
    },
  },
}
M.telescope = {
  i = {
    ["<C-M-o>"] = { "<ESC><cmd> Telescope find_files <CR>", "find files" },
    ["<C-M-b>"] = { "<ESC><cmd> Telescope buffers <CR>", "find buffers" },
    ["<C-M-r>"] = { "<cmd> Telescope resume <CR>", "resume last results" },
  },
  n = {
    ["<C-M-o>"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<C-M-b>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<C-M-r>"] = { "<cmd> Telescope resume <CR>", "resume last results" },
  },
  t = {
    ["<C-M-o>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
        require("telescope.builtin").find_files()
      end,
      "find files",
    },
    ["<C-M-b>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
        require("telescope.builtin").find_buffers()
      end,
      "find buffers",
    },
  },
}
M.lsp_config = {
  n = {
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "show line diagnostics",
    },
    ["<leader>E"] = {
      "<cmd>Telescope diagnostics<CR>",
      "show all lsp error",
    },
  },
}
-- more keybinds!
return M
