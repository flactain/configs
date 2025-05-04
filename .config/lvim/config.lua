-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
local map = vim.keymap.set
-- 左右移動
map('i', '<M-h>', '<Left>', { noremap = true, desc = 'Move cursor left in insert mode' })
map('i', '<M-l>', '<Right>', { noremap = true, desc = 'Move cursor right in insert mode' })
-- 上下移動もオプションで追加可能
map('i', '<M-k>', '<Up>', { noremap = true, desc = 'Move cursor up in insert mode' })
map('i', '<M-j>', '<Down>', { noremap = true, desc = 'Move cursor down in insert mode' })

--reload
map('n', '<leader>r', ':e!<CR>', {
    noremap = true,
    silent = true,
    desc = 'Reload current buffer forcefully'  -- キーマッピングの説明を追加
})

lvim.lsp.buffer_mappings.normal_mode['K'] = {
  "<cmd>lua vim.lsp.buf.hover()<CR>",
  "Show hover"
}

--noh
lvim.keys.normal_mode["<ESC><ESC>"] = ":nohlsearch<CR>"

--plugins
lvim.plugins = {
  -- 既存のプラグインがある場合は、その後に追加
  {
    --vim-visual-multi vscodeのctrl+dみたいな感じ
    "mg979/vim-visual-multi",
    branch = "master",
  }
}

--yank sync clipboard
vim.opt.clipboard = "unnamedplus"  -- システムのクリップボードと連携
