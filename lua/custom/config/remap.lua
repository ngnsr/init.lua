-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- own should work only with C/C++ but..
vim.keymap.set("n", "<leader>r", "<Cmd>w | !ninja -C \'./build/\' | ./build/prog <CR>",
	{ desc = 'Write Compile [R]un Ninja' })
vim.keymap.set("n", "<leader>rm", "<Cmd>w | !make -C \'./build/\' | ./build/prog <CR>",
	{ desc = 'Write Compile [R]un Make' })
--

vim.keymap.set("n", "<leader>so", "<Cmd>source $MYVIMRC<CR>", { desc = 'Source config' })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<Leader>b', ':lua require"dap".toggle_breakpoint(vim.fn.input("Condition: "))<CR>')

vim.keymap.set({ 'n', 'i' }, '<C-b>', "<Esc>:Lex<CR>:vertical resize 30<CR>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e /Users/rr/.config/nvim/init.lua<CR>");
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>so", vim.cmd("so"))

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
	actions.select_default:replace(function()
		actions.close(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		print(selection[1])
	end)
	return true
end

vim.keymap.set("n", "<leader>t", function()
	-- example for running a command on a file
	local opts = {
		attach_mappings = run_selection,
		find_command = { "fd", "-t=f", "-a" },
		path_display = { "absolute" },
	}
	require('telescope.builtin').find_files(opts)
end)

function tprint(t, s)
	for k, v in pairs(t) do
		local kfmt = '["' .. tostring(k) .. '"]'
		if type(k) ~= 'string' then
			kfmt = '[' .. k .. ']'
		end
		local vfmt = '"' .. tostring(v) .. '"'
		if type(v) == 'table' then
			tprint(v, (s or '') .. kfmt)
		else
			if type(v) ~= 'string' then
				vfmt = tostring(v)
			end
			print(type(t) .. (s or '') .. kfmt .. ' = ' .. vfmt)
		end
	end
end

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}
end, { desc = "toggle diagnostic" })
-- vim.api.nvim_set_keymap('x', '<leader>m', ':lua ReplaceSecondToLastSelection()<CR>', { silent = true })
--
