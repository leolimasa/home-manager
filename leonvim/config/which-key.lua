return function()
	local wk = require("which-key")
	wk.setup({
		icons = {
			group = ""
		}
	})
	for mode, mappings in pairs(require("leonvim.leader_keymaps")) do
		for prefix, submappings in pairs(mappings) do
			wk.register(
				submappings,
				{ prefix = prefix, mode = mode })
		end
	end
end
