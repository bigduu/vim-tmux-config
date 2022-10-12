vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.api.nvim_set_keymap
local opt = {
  noremap = true,
  silent = true
}

map("i", "jk", "<ESC>", opt)
map("i", "kk", "<ESC>", opt)
map("i", "jj", "<ESC>", opt)

map("n", "H", ":BufferLineCyclePrev<CR>", opt)
map("n", "L", ":BufferLineCycleNext<CR>", opt)

map("n", "<Tab>", "%", opt)

map("n", "<leader>v", ":NvimTreeFindFile<CR>", opt)
map("n", "<leader>w", ":NvimTreeToggle<CR>", opt)


map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)

map("n", "<C-a>", "<C-w>>", opt)
map("n", "<C-d>", "<C-w><", opt)

map("n", "<C-q>", "<C-w>q", opt)

map("n", "<leader>e", ":HopWord<CR>", opt)

map("n", "<leader>tr", ":TranslateW<CR>", opt)
map("v", "<leader>tr", ":TranslateW<CR>", opt)

-- rename
map('n', '<leader>re', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
-- code action
map('i', '<ctrl><space>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
map('n', '<leader>l', ':CodeActionMenu<CR>', opt)
-- go xx
map("n", "<leader>gf", ":Telescope find_files<CR>", opt)
map('n', 'gd', ':Telescope lsp_definitions<CR>', opt)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
map('n', 'gi', ':Telescope lsp_implementations<CR>', opt)
map('n', 'gr', ':Telescope lsp_references<CR>', opt)
map('n', '<leader>sp', ':Telescope lsp_document_symbols<CR>', opt)
map('n', '<leader>ic', ':Telescope lsp_incoming_calls<CR>', opt)
map('n', '<leader>oc', ':Telescope lsp_outgoing_calls<CR>', opt)
-- diagnostic
map('n', 'go', ':Telescope diagnostics<CR>', opt)
map('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
map('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
map('n', '<leader>ff', ':Format<CR>', opt)
-- find
map("n", "<leader>fp", ":Telescope live_grep<CR>", opt)


local pluginKeys = {}

-- maplsp
pluginKeys.mapLSP = function(mapbuf)
  --rename
  mapbuf('n', '<leader>re', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- go xx
  mapbuf("n", "<leader>gf", ":Telescope find_files<CR>", opt)
  mapbuf('n', 'gd', ':Telescope lsp_definitions<CR>', opt)
  mapbuf('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gi', ':Telescope lsp_implementations<CR>', opt)
  mapbuf('n', 'gr', ':Telescope lsp_references<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', ':Telescope diagnostics<CR>', opt)
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  mapbuf('n', '<leader>ff', ':Format<CR>', opt)
  mapbuf('n', '<leader>l', ':CodeActionMenu<CR>', opt)
end

pluginKeys.rustMapLSP = function(mapbuf)
  mapbuf('n', '<leader>rr', ':RustRun<CR>', opt)
  mapbuf('n', '<leader>rb', ':RustBuild<CR>', opt)
end



-- nvim-cmp
pluginKeys.cmp = function(cmp)
  return {
    --['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<esc>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          cmp.confirm()
        end
      else
        cmp.complete()
      end
    end, { "i", "s", "c", }),
  }
end


return pluginKeys
