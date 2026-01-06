return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        style = "storm", -- Matches your WezTerm background
        transparent = true, -- Let WezTerm control the transparency/blur
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
