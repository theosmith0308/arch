 -- ================================================================================================
 -- TITLE : vim-moonfly-colors
 -- ABOUT : A dark charcoal theme for modern Neovim
 -- LINKS :
 --   > https://github.com/bluz71/vim-moonfly-colors
 -- ================================================================================================

return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme moonfly')
  end
}
