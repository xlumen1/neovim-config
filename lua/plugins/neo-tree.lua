return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status" },
	git_status = {
		enable = true,
		signs = {
			added = "+",
			modified = "~",
			deleted = "-",
			renamed   = "N",
			untracked = "U",
			ignored   = "I",
			unstaged  = "X",
			staged    = "V",
			conflict  = "C",
		},
	},
	filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
	  visible = true
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["o"] = "open",
          ["h"] = "close_node",
        },
	position = "right",
      },
    })
  end,
}

