local win = require("leonvim.window")

return {
	t = {
		["<c-h>"] = "<c-\\><c-n><c-w>h",
		["<c-j>"] = "<c-\\><c-n><c-w>j",
		["<c-k>"] = "<c-\\><c-n><c-w>k",
		["<c-l>"] = "<c-\\><c-n><c-w>l",
		["<c-w>z"] = win.zoom,
		["<c-w>H"] = "<c-\\><c-n><c-w>H",
		["<c-w>J"] = "<c-\\><c-n><c-w>J",
		["<c-w>K"] = "<c-\\><c-n><c-w>K",
		["<c-w>L"] = "<c-\\><c-n><c-w>L",
		["<c-w>v"] = "<c-\\><c-n><c-w>v",
		["<c-w>="] = "<c-\\><c-n><c-w>=",
		["<c-q>"] = "<c-\\><c-n>"

	},
	n = {
		["<c-w>z"] = "<cmd>ZenMode<cr>",
		["<c-w>b"] = "<cmd>botright new<cr>",
	}
}

