let g:NERDCreateDefaultMappings = 0
filetype plugin on
let mapleader = " "
set belloff=all  " disable bell sounds
set noswapfile

noremap n j
noremap e k
noremap i l
noremap k n
noremap K N

noremap u i
noremap N J
noremap f e
noremap F E
noremap <C-e> <C-k>
noremap <leader>cf <cmd>lua vim.lsp.buf.format()<cr>
noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>
noremap <leader>ck <cmd>lua vim.lsp.buf.hover()<cr>
noremap <leader>cd <cmd>Telescope lsp_definitions <cr>
noremap <leader>gz = <cmd>lua require'telescope.builtin'.git_stash()<cr>
noremap <leader>sp = <cmd>lua require'telescope.builtin'.live_grep()<cr>
noremap <leader>cj = <cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<cr>
noremap <leader>cJ = <cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<cr>
noremap <leader>cx = <cmd>lua require'telescope.builtin'.diagnostics()<cr>
noremap <leader>cr = <cmd>lua require'telescope.builtin'.lsp_references()<cr>
noremap <leader>cR = <cmd>lua vim.lsp.buf.rename()<cr>
noremap <leader>ss = <cmd>Telescope current_buffer_fuzzy_find <cr>
noremap <leader>cl = <cmd>lua vim.lsp.codelens.get()<cr>

nnoremap <leader>gn <cmd>Gitsigns next_hunk<cr>
nnoremap <leader>ge <cmd>Gitsigns prev_hunk<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>ft <cmd>NvimTreeToggle<cr>
nnoremap <leader>fs <cmd>w<cr>
noremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <leader>gg <cmd>Git<cr>

nnoremap <leader>gs <cmd>Gitsigns stage_hunk<cr>
nnoremap <leader>gx <cmd>Gitsigns reset_hunk<cr>
nnoremap <leader>gB <cmd>Gitsigns toggle_current_line_blame<cr>
nnoremap <leader>gv <cmd>Gitsigns preview_hunk_inline<cr>

nnoremap <leader>ws <cmd>split<cr>
nnoremap <leader>wv <cmd>vs<cr>
nnoremap <leader>wd <cmd>q<cr>
nnoremap <leader>wi <cmd>winc l<cr>
nnoremap <leader>wh <cmd>winc h<cr>
nnoremap <leader>wn <cmd>winc j<cr>
nnoremap <leader>we <cmd>winc k<cr>

" Telescope Settings
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>sp <cmd>Telescope live_grep<cr>
nnoremap <leader>ht <cmd>Telescope colorscheme<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gV <cmd>Gvdiffsplit<cr>

nnoremap <leader>ci <cmd><buffer>lsp call execute('LspCodeActionSync source.organizeImports')<cr>

noremap <C-_> <cmd>undo<cr>
inoremap <C-_> <cmd>undo<cr>
noremap <C-?> <cmd>redo<cr>

nnoremap <A-/> <plug>NERDCommenterToggle
vnoremap <A-/> <plug>NERDCommenterToggle

nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gp <cmd>Git push<cr>
nnoremap <leader>ct <cmd>TodoTelescope<cr>

set number

noremap <C-E> <C-K>

vnoremap t <Plug>(easymotion-s2)
nnoremap t <Plug>(easymotion-s2)
setlocal spell spelllang=en_us
noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>

noremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<cr>
noremap <leader>cn <cmd>lua vim.diagnostic.goto_next()<cr>
noremap <leader>ce <cmd>lua vim.diagnostic.goto_prev()<cr>

noremap <leader>nf <cmd>Telescope zk notes<cr>
noremap <leader>nn <cmd>ZkNew<cr>
