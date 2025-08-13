-- some config

vim.g.mapleader = " "

vim.wo.number = true
vim.wo.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.softtabstop = 4

vim.cmd [[
	highlight Normal guibg=#252535

	highlight Comment guifg=#5C6370 gui=italic
	highlight Constant guifg=#D19A66
	highlight Identifier guifg=#61AFEF
	highlight Statement guifg=#C678DD gui=bold
	highlight Type guifg=#E5C07B
	highlight Special guifg=#56B6C2
	highlight Underlined gui=underline
	highlight Error guifg=#F44747 gui=bold
	highlight Todo guifg=#FF8800 gui=bold
	highlight String guifg=#98C379

	highlight LineNr guifg=#50605B
	highlight CursorLine guibg=#777777
	highlight CursorLineNr guifg=#FF87AF gui=bold
	set cursorline

	command! -nargs=? -complete=file HS split <args>
	cnoreabbrev hs HS
]]

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap=true, silent=true })
vim.keymap.set("n", "<leader>n", function()
	local state = require("neo-tree.sources.manager").get_state("filesystem")
	local node = state.tree:get_node()
	if node and node.type == "directory" then
		require("neo-tree.sources.manager").refresh("filesystem", { path = node.path })
	elseif node then
		-- if it is a file, use its parent directory
		local dir = vim.fn.fnanemodify(node.path, ":h")
		require("neo-tree.sources.manager").refresh("filesystem", { path = dir})
	end
end, { desc = "Set Neo-tree root to selected directory" })
vim.keymap.set("n", "<leader>l", function()
	vim.diagnostic.setloclist()
	vim.cmd("lopen")
end, { desc = "Open diagnostics list" })

vim.o.mouse = ""
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.signcolumn = "yes"

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
})

-- autocmds

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		if vim.fn.argc() == 0 then
			vim.cmd("Neotree position=current dir=" .. vim.loop.os_homedir())
		end
	end
})

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function(data)
		vim.diagnostic.hide()
	end,
})

vim.api.nvim_create_autocmd({"InsertLeave", "CmdlineEnter"}, {
	callback = function(data)
		vim.diagnostic.show()
	end,
})

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins")
