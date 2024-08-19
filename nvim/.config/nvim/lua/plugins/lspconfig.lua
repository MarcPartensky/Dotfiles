return {
	-- 'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(client, bufnr)
		    -- Enable completion triggered by <c-x><c-o>
		    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		    -- Mappings.
		    -- See `:help vim.lsp.*` for documentation on any of the below functions
		    local bufopts = { noremap = true, silent = true, buffer = bufnr }
		    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		    vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		    end, bufopts)
		    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
		    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
		end

		local lsp_flags = {
		    -- This is the default in Nvim 0.7+
		    debounce_text_changes = 150,
		}

		require 'lspconfig'.lua_ls.setup {
		    on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			    return
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			    runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			    },
			    -- Make the server aware of Neovim runtime files
			    workspace = {
				checkThirdParty = false,
				library = {
				    vim.env.VIMRUNTIME
				    -- Depending on the usage, you might want to add additional paths here.
				    -- "${3rd}/luv/library"
				    -- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			    }
			})
		    end,
		    settings = {
			Lua = {}
		    }
		}

		require 'lspconfig'.prismals.setup {}

		require 'lspconfig'.svelte.setup {}

		require 'lspconfig'.grammarly.setup {
		    filetypes = { "markdown" }
		}

		require 'lspconfig'.tailwindcss.setup({
		    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" },
		})

		require 'lspconfig'.eslint.setup({
		    --- ...
		    on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
			    buffer = bufnr,
			    command = "EslintFixAll",
			})
		    end,
		    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
		})

		require 'lspconfig'.emmet_ls.setup({
		    -- on_attach = on_attach,
		    capabilities = capabilities,
		    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
		    init_options = {
			html = {
			    options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			    },
			},
		    }
		})

		require 'lspconfig'.prismals.setup {}

		require 'lspconfig'.biome.setup {}

		require 'lspconfig'.bashls.setup {}

		require 'lspconfig'.docker_compose_language_service.setup {}

		require("lspconfig").dockerls.setup {
		    settings = {
			docker = {
			    languageserver = {
				formatter = {
				    ignoreMultilineInstructions = true,
				},
			    },
			}
		    }
		}

		require('lspconfig')['pyright'].setup {
		    on_attach = on_attach,
		    flags = lsp_flags,
		}
		require('lspconfig')['tsserver'].setup {
		    on_attach = on_attach,
		    flags = lsp_flags,
		}
		require('lspconfig')['rust_analyzer'].setup {
		    on_attach = on_attach,
		    flags = lsp_flags,
		    -- Server-specific settings...
		    settings = {
			["rust-analyzer"] = {}
		    }
		}
	end
}
