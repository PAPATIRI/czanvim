# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal [LazyVim](https://github.com/LazyVim/LazyVim)-based Neovim configuration, cloned into `~/AppData/Local/nvim-lazyvim` (Windows). LazyVim itself is a dependency pulled in by `lazy.nvim`; this repo only contains *overrides* on top of it. The owner is migrating from VS Code and targets a multi-stack workflow: **.NET/C#, Go, PHP/Laravel, Vue/TypeScript/React, and Flutter/Dart**.

Note: inline comments throughout the config are written in Indonesian — preserve that language when editing existing comments.

## Structure & how config is applied

- `init.lua` — bootstraps `require("config.lazy")` then `require("config.roslyn")`. The `roslyn` require is an explicit addition beyond the LazyVim default.
- `lua/config/` — LazyVim's standard hook points, each auto-loaded at a fixed time: `options.lua` (before startup), `keymaps.lua` / `autocmds.lua` (on `VeryLazy`), `lazy.lua` (plugin manager bootstrap). `roslyn.lua` is a custom file, loaded explicitly from `init.lua`.
- `lua/plugins/*.lua` — every file here is auto-imported by `lazy.nvim` (`{ import = "plugins" }`). Each returns a plugin spec table. Files are grouped by concern, not by plugin, so one language's setup can span several files (e.g. C# touches `dotnet.lua`, `csharp-dap.lua`, `config/roslyn.lua`, and formatter/treesitter entries).
- `lazyvim.json` — declares which **LazyVim extras** are enabled (go, php, typescript, vue, tailwind, json, markdown, mini-surround). Edit this via `:LazyExtras` rather than by hand; it defines the baseline that the `lua/plugins/` overrides extend.

### The override pattern (important)

Plugin specs here almost never redefine a plugin from scratch — they extend LazyVim's defaults. Two idioms recur and must be used correctly to avoid clobbering LazyVim's config:

- `opts = function(_, opts) vim.list_extend(opts.ensure_installed, {...}) end` — **append** to existing lists (treesitter parsers, mason packages). Do not replace the table.
- `opts = { ... }` (plain table) — merged into defaults by `lazy.nvim`. Used for scalar/nested settings.

When adding language support, follow the existing spread: register the treesitter parser (`treesitter.lua`), the LSP server (`config/*.lua` or an `nvim-lspconfig` `servers` entry), the formatter (`formatting.lua`, keyed by filetype in `conform.nvim`), and any mason `ensure_installed` package.

## Commands

There is no build/test suite — this is editor config. "Running" it means launching Neovim with this config.

```sh
# Launch this config explicitly (does not touch a normal ~/.config/nvim)
NVIM_APPNAME=nvim-lazyvim nvim

# Plugin management (inside nvim)
:Lazy            # UI: install / update / clean / check plugins
:Lazy sync       # apply lazy-lock.json / update to spec
:LazyExtras      # toggle LazyVim extras (writes lazyvim.json)
:LazyHealth      # diagnose config/plugin problems
:Mason           # manage LSP servers, formatters, DAP adapters
```

`lazy-lock.json` pins exact plugin commits — commit changes to it alongside plugin spec changes so the setup stays reproducible.

### Formatting Lua

Lua files are formatted with **StyLua** (`stylua.toml`: 2-space indent, 120 column width). Match this when editing `.lua` files. `conform.nvim` runs `stylua` on save for `lua`.

## Stack-specific notes worth knowing before editing

- **C# / .NET**: LSP is `roslyn.nvim` (not omnisharp), installed via a custom Mason registry (`github:Crashdummyy/mason-registry`) added in `dotnet.lua`. Server settings (inlay hints, code lens, full-solution analysis) live in `config/roslyn.lua`. Debugging uses `netcoredbg`; `csharp-dap.lua` deliberately points the DAP adapter at the raw `netcoredbg.exe` inside mason packages rather than the `.CMD` shim (the shim has a Windows slash-normalization bug that makes it exit 1). Formatter is `csharpier`.
- **PHP/Laravel**: LSP forced to `intelephense` (`vim.g.lazyvim_php_lsp` in `options.lua`). Blade files get a custom tree-sitter parser (`tree-sitter-blade`) and filetype detection wired up in `treesitter.lua`; formatted with `blade-formatter` + `pint`.
- **Avalonia/XAML**: `.axaml`/`.xaml` are registered as custom filetypes (`options.lua`) that borrow the XML tree-sitter parser, with custom `mini.icons` glyphs (`ui.lua`) and `xstyler` formatting (`formatting.lua`, invokes the dotnet global tool at `~/.dotnet/tools/xstyler`).
- **Sessions**: `persistence.nvim` is disabled (`disable.lua`) in favor of `mini.sessions` (`mini-session.lua`, `<leader>q…` keymaps). Don't re-enable persistence.
- **Colorscheme**: default is `tokyonight`; `catppuccin` and `rose-pine` are also configured (catppuccin set to transparent). Change the active one via the `LazyVim` spec in `colorscheme.lua`.
