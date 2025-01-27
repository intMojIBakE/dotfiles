local wk = require("which-key")
local lsp_format = require("lsp-format")
local util = require("lspconfig.util")

local signs = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  -- virtual_text = true,
})

-- Lspconfig
local lspconfig = require("lspconfig")

local global_capabilities = require("cmp_nvim_lsp").default_capabilities()
global_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
global_capabilities.textDocument.completion.completionItem.snippetSupport = true

_G.lsp_global_attach = function(_, bufnr)
  wk.register({
    ["g"] = {
      ["d"] = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
      ["h"] = { "<cmd>Lspsaga lsp_finder<cr>", "Lsp finder" },
    },
    ["]d"] = {
      "<cmd>Lspsaga diagnostic_jump_next<cr>",
      "Jump to next diagnostic",
    },
    ["[d"] = {
      "<cmd>Lspsaga diagnostic_jump_prev<cr>",
      "Jump to prev diagnostic",
    },
    ["]D"] = {
      function()
        require("lspsaga.diagnostic").goto_next({
          severity = vim.diagnostic.severity.ERROR,
        })
      end,
      "Jump to next error diagnostic",
    },
    ["[D"] = {
      function()
        require("lspsaga.diagnostic").goto_prev({
          severity = vim.diagnostic.severity.ERROR,
        })
      end,
      "Jump to prev error diagnostic",
    },
    ["K"] = { "<cmd>Lspsaga hover_doc<cr>", "Hover doc" },
    ["<leader>"] = {
      ["ca"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
      ["rn"] = { "<cmd>Lspsaga rename<cr>", "Rename symbol" },
      ["cd"] = {
        "<cmd>Lspsaga show_line_diagnostics<CR>",
        "Show line diagnostics",
      },
    },
  }, { buffer = bufnr })

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local configs = require("lspconfig.configs")
configs["unocss"] = {
  default_config = {
    cmd = { "unocss-language-server", "--stdio" },
    filetypes = {
      "html",
      "javascriptreact",
      "rescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    on_new_config = function(new_config) end,
    root_dir = function(fname)
      return util.root_pattern("unocss.config.js", "unocss.config.ts")(fname)
        or util.find_package_json_ancestor(fname)
        or util.find_node_modules_ancestor(fname)
        or util.find_git_ancestor(fname)
    end,
  },
}

local servers = {
  "pyright",
  "html",
  "eslint",
  "cssls",
  "stylelint_lsp",
  "cmake",
  "bashls",
  "dockerls",
  "yamlls",
  "zls",
  "gopls",
  "sumneko_lua",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = lsp_global_attach,
    capabilities = global_capabilities,
  })
end

require("rust-tools").setup({
  server = {
    on_attach = lsp_global_attach,
    capabilities = global_capabilities,
  },
})

require("clangd_extensions").setup({
  server = {
    on_attach = function(client, bufnr)
      lsp_global_attach(client, bufnr)
      lsp_format.on_attach(client)
    end,
    capabilities = global_capabilities,
  },
})

lspconfig.jsonls.setup({
  on_attach = lsp_global_attach,
  capabilities = global_capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
})

local function get_typescript_server_path(root_dir)
  local global_ts =
    "/home/lnk/.local/share/pnpm/global/5/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

require("lspconfig").volar.setup({
  on_attach = lsp_global_attach,
  capabilities = global_capabilities,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
  },
  init_options = {
    typescript = {
      tsdk = "/usr/lib/node_modules/typescript/lib",
    },
  },
})

require("lspconfig").sqls.setup({
  on_attach = function(client, bufnr)
    require("sqls").on_attach(client, bufnr)
  end,
})
