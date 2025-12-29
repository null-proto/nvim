local capabilities = require('cmp_nvim_lsp').default_capabilities()
local py_capabilities = require('cmp_nvim_lsp').default_capabilities()

py_capabilities.textDocument.completion.completionItem.snippetSupport = false

-- require('jdtls').start_or_attach({
--     cmd = {'/usr/bin/jdtls'},
--     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- })
--

vim.lsp.config('denols', {
  -- root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
	root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" }),
  capabilities = capabilities,
})


vim.lsp.config('jinja_lsp', {
	filetypes = {'jinja','tmpl','html','j2'},
  capabilities = capabilities,
})

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  root_dir = function(fname)
    if vim.fs.root(fname, { "deno.json", "deno.jsonc" }) then
      return nil
    end
    return vim.fs.root(fname, { "package.json", "package.jsonc", "tsconfig.json", "jsconfig.json" })
  end,
  single_file_support = false,
})

-- words
vim.lsp.config('typos_lsp', {
  init_options = {
    config = '~/.config/typos-lsp/typos.toml',
    diagnosticSeverity = 'Hint',
  },
})

-- javascript
vim.lsp.config('svelte', {
	cmd = { "svelteserver", "--stdio" },
  capabilities = capabilities,
	root_dir = function()
    return vim.fn.getcwd()   -- just use current working dir, not /
  end,
  filetypes = { "svelte" },
})

vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
})
vim.lsp.config('astro', {
  filetypes = { 'astro' },
  capabilities = capabilities,
})

-- json
vim.lsp.config('jsonls', {
  filetypes = { 'json', 'jsonc' },
  capabilities = capabilities,
})

-- systemd
vim.lsp.config('systemd_ls', {
  capabilities = capabilities,
})

-- java
vim.lsp.config('jdtls', {
  root_dir = vim.fs.root(0, {
    ".project",
    "settings.gradle", "settings.gradle.kts",
    "build.gradle", "build.gradle.kts",
    "pom.xml",
    ".git",
  }),
  capabilities = capabilities,
})


local kt_capabilities = require('cmp_nvim_lsp').default_capabilities()

kt_capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  documentationFormat = { "markdown", "plaintext" },
  resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
}

kt_capabilities.textDocument.hover = {
  contentFormat = { "markdown", "plaintext" }
}

vim.lsp.config('kotlin_language_server', {
	root_dir = vim.fs.root(0, {
    "settings.gradle", "settings.gradle.kts",
    "build.gradle", "build.gradle.kts",
    "pom.xml",
    ".git",
  }),
  capabilities = kt_capabilities,
})

-- lua
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
})

-- python
vim.lsp.config('pyright', {
  capabilities = py_capabilities,
})

vim.lsp.config('ruff', {
  init_options = {
    settings = {
      enable = true,
      organizeImports = true,
      fixAll = true,
      lint = {
        enable = true,
        run = 'onType',
      },
    },
  },
  capabilities = py_capabilities,
})

-- c/c++
vim.lsp.config('clangd', {
  capabilities = {
    offsetEncoding = { 'utf-8', 'utf-16' },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
  cmd = { 'clangd', '--compile-commands-dir=build' },
  filetypes = { 'c', 'cc', 'h', 'hxx', 'hxx', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
})

-- rust
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
    },
    cmd = { 'rust-analyzer' },
    capabilities = capabilities,
    filetypes = { 'rust' },
    check = {
      overrideCommand = {
        'cargo',
        'clippy',
        '--workspace',
        '--message-format=json',
        '--all-targets',
        '--all-features',
      },
    },
  },
})


-- JVM
vim.lsp.enable 'jdtls' -- aur
vim.lsp.enable 'kotlin_language_server' -- aur

-- JS runtime
vim.lsp.enable 'denols'
vim.lsp.enable 'svelte'
vim.lsp.enable 'typos_lsp'
vim.lsp.enable 'tailwindcss'
vim.lsp.enable 'astro'
vim.lsp.enable 'eslint' -- node_module
vim.lsp.enable 'ts_ls'

-- web
vim.lsp.enable 'jsonls'
vim.lsp.enable 'cssls'
vim.lsp.enable 'html'
vim.lsp.enable 'jinja_lsp'

-- lua
vim.lsp.enable 'lua_ls'

-- build
vim.lsp.enable 'cmake'

-- init system
vim.lsp.enable 'systemd_ls'
vim.lsp.enable 'nixd'
vim.lsp.enable 'fish-lsp'
vim.lsp.enable 'bashls'
vim.lsp.enable 'yamlls'


-- systems language
vim.lsp.enable 'clangd'
vim.lsp.enable 'rust_analyzer'

-- scripting
vim.lsp.enable 'ruff'
vim.lsp.enable 'ruff-lsp'
vim.lsp.enable 'pyright'
