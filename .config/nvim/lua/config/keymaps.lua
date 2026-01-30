local map = vim.keymap.set 
local opts = { noremap = true, silent = true }

-- General maps
map('n', '<leader>q', '<Cmd>qa<CR>', opts)
map('n', '<leader>Q', '<Cmd>qa!<CR>', opts)
map('n', '<leader>w', '<Cmd>bd<CR>', opts)
map('n', '<leader>W', '<Cmd>bd!<CR>', opts)
map('n', '<leader>s', '<Cmd>w<CR>', opts)

-- Neotree
map('n', '<leader>e', '<Cmd>Neotree focus<CR>', opts)
map('n', '<leader>E', '<Cmd>Neotree toggle reveal<CR>', opts)

-- Mac iterm note: make sure you remap the option key to Esc+
-- move to buffer
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- go to buffer in pos
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- stolen
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in the middle", silent = true })

