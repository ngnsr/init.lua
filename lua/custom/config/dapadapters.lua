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
		args = {},
		runInTerminal = true,
		--      setupCommands = {
		-- text = 'settings set target.input-path ' .. vim.fn.input('Path to stdin file: ', vim.fn.getcwd() .. '/', 'file')
		--
		--      }
	}
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.java = {
	{
		-- classPaths = { vim.fn.getcwd() },
		-- projectName = function()
		-- 	return vim.fn.input('Project name: ')
		-- end,
		javaExec = "/usr/bin/java",
		args = function()
			return vim.fn.input('Args: ')
		end,
		mainClass = function()
			return vim.fn.input('Package main class name: ')
		end,
		-- modulePaths = {},
		name = "Launch [package.name.Main]",
		request = "launch",
		type = "java"
	},
}
