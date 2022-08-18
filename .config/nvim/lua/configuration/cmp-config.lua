local cmp = require("cmp")

local icons = {
  Text          = "",
  Method        = "",
  Function      = "",
  Constructor   = "",
  Field         = "ﰠ",
  Variable      = "",
  Class         = "ﴯ",
  Interface     = "",
  Module        = "",
  Property      = "ﰠ",
  Unit          = "塞",
  Value         = "",
  Enum          = "",
  Keyword       = "",
  Snippet       = "",
  Color         = "",
  File          = "",
  Reference     = "",
  Folder        = "",
  EnumMember    = "",
  Constant      = "",
  Struct        = "פּ",
  Event         = "",
  Operator      = "",
  TypeParameter = "T",
  Book          = ""
}

-- nvim-cmp setup
cmp.setup {

  snippet = {
   expand = function(args)
    require("luasnip").lsp_expand(args.body)
   end,
  },

 mapping = {
    ["<TAB>"]     = cmp.mapping.select_next_item(),
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.close(),
    ["<CR>"]      = cmp.mapping.confirm {
       behavior = cmp.ConfirmBehavior.Replace,
       select   = true,
    },
    ["<Tab>"] = function(fallback)
       if cmp.visible() then
          cmp.select_next_item()
       elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
       else
          fallback()
       end
    end,
    ["<S-Tab>"] = function(fallback)
       if cmp.visible() then
          cmp.select_prev_item()
       elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
       else
          fallback()
       end
    end,
 },

  formatting = {
    format = function(entry, vim_item)
      -- load lspkind icons
      vim_item.kind = string.format(
        "%s %s",
        icons[vim_item.kind],
        vim_item.kind
      )

      vim_item.menu = ({
        nvim_lsp = "力",
        nvim_lua = "",
        luasnip  = icons.Color,
        path     = "﫶",
        buffer   = "﬘",
        look     = icons.Book,
        emoji    = "😎",
      })[entry.source.name]

       return vim_item
   end,
   },

   -- Experimental features.
    experimental = {

     -- It will type a shadow text of the intended completion.
     ghost_text = { hl_group = 'Comment' },

    },

    -- Sources for completion, since it is modular; cmp accepts
    -- Multiple modules.
   sources = {

      -- Simple signature, normally outside an object.
      --{ name = 'nvim_lsp_signature_help', priority = 10 },

      -- For the Nvim lua specifics commands.
      { name = "nvim_lua", priority = 8 },

      -- Support with the current active LSP.
      -- Anything that LSP supports and can share with CMP.
      { name = "nvim_lsp", priority = 11 },

      -- Snippets in general to facilitate life.
      -- Type a often typed methods, like for in C.
      { name = "luasnip",  priority = 6 },

      -- Show path based on the backslashes.
      -- Type any path, relatively or globally.
      { name = "path",     priority = 9 },

      -- .
      --{ name = "buffer",   priority = 4 },

      -- Dictionary for words.
      -- Type any word that is on the /usr/share/dict/words
      {
        name           = 'look',
        priority       = 1,
        keyword_length = 3,
        max_item_count = 4,
        option = {
          convert_case = true,
          loud = true,
          dict = '/usr/share/dict/words'
        },
      },

      -- Emoji.
      -- Activate with ":".
      { name = "emoji",    priority = 2, option = { insert = true } },

      -- Calculate expressions based on the current line.
      -- Activate with something like "4 + 5".
      { name = 'calc',     priority = 10 }
   },
}

-- Load specialities from LuaSnip.
-- Set it with VSCode-like mode.
require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI"
})

-- Load loaders from VSCode.
require("luasnip.loaders.from_vscode").load()
