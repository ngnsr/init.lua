local dap = require('dap')

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/local/opt/llvm/bin/lldb-dap',
	name = 'lldb'
}

dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		-- stopOnEntry = false,
		args = { '-b', './res/input5.txt' },
		-- args = function()
		-- 	return vim.fn.input('Args: ')
		-- end,
		runInTerminal = true,
		--      setupCommands = {
		-- text = 'settings set target.input-path ' .. vim.fn.input('Path to stdin file: ', vim.fn.getcwd() .. '/', 'file')
		--
		--      }
	}
}

dap.configurations.c = dap.configurations.cpp
