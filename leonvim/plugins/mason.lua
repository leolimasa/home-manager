return function()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup { ensure_installed = { "lua_ls" },
		automatic_installations = true
	}
	-- Have mason start an lspconfig when attached to a buffer
	mason_lspconfig.setup_handlers {
		function(server_name)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
			require('lspconfig')[server_name].setup {
				capabilities = capabilities
			}
		end,
	}
end
