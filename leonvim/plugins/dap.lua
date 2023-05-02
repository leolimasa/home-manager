return function()
	local dap = require("dap")
	-- dap.adapters.delve = {
	-- 	type = 'server',
	-- 	port = '${port}',
	-- 	executable = {
	-- 		command = 'dlv',
	-- 		args = { 'dap', '-l', '127.0.0.1:${port}' },
	-- 	}
	-- }
	--
	-- For go, start it with 
	-- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
	dap.adapters.delve = {
		type = "server",
		host = "127.0.0.1",
		port = 38697,
	}

	dap.configurations.go = {
		{
			type = "delve",
			name = "Debug file",
			request = "launch",
			program = "${file}"
		},
		{
			type = "delve",
			name = "Debug test file", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}"
		},
		-- works with go.mod packages and sub packages
		{
			type = "delve",
			name = "Debug all tests",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		},
		{
			type = "delve",
			name = "Debug all tests",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}"
		},
		{
			type = "delve",
			name = "Debug mdm test",
			request = "launch",
			mode = "test",
			program = "code.transportant.us/attendant/mdm/bundle"
		},
	}

	vim.fn.sign_define('DapBreakpoint',{ text ='', texthl ='ErrorMsg', linehl ='', numhl =''})
	vim.fn.sign_define('DapStopped',{ text ='', texthl ='WarningMsg', linehl ='', numhl =''})
end
