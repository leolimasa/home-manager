GoLastCustomFile = ""

return function()
	local dap = require("dap")
	dap.adapters.go = {
		type = 'server',
		port = '${port}',
		executable = {
			command = 'dlv',
			args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output="dap"' },
		}
	}
	--
	-- start it with
	-- dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
	-- dap.adapters.delve = {
	-- 	type = "server",
	-- 	host = "127.0.0.1",
	-- 	port = 38697,
	-- }
	--
	--
	local splitsspaces = function(s)
		local chunks = {}
		for substring in s:gmatch(s, "%S+") do
			table.insert(chunks, substring)
		end
	end

	local goprogram = function()
		return coroutine.create(function(dap_run_co)
			vim.ui.input(
				{
					prompt = "Program",
					default = GoLastCustomFile
				},
				function(program)
					GoLastCustomFile = program
					coroutine.resume(dap_run_co, program)
				end
			)
		end)
	end


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
			name = "Debug custom test",
			request = "launch",
			mode = "test",
			program = goprogram,
		},
		{
			type = "delve",
			name = "Debug custom test with args",
			request = "launch",
			mode = "test",
			program = goprogram,
			args = function()
				return coroutine.create(function(dap_run_co)
					vim.ui.input(
						{
							prompt = "Args",
							default = GoLastArgs
						},
						function(args)
							GoLastArgs = args
							coroutine.resume(dap_run_co, splitsspaces(args))
						end
					)
				end)
			end
		},
	}

	vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '', texthl = 'WarningMsg', linehl = '', numhl = '' })
end
