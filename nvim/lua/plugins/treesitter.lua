-- nvim-treesitter's main branch is the one that targets Neovim 0.11+. Unlike the
-- old master branch it does not enable anything implicitly: parsers are
-- installed explicitly and highlighting is started per buffer.
local parsers = {
  "bash",
  "css",
  "diff",
  "dockerfile",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "gowork",
  "hcl",
  "helm",
  "html",
  "javascript",
  -- No jsonc parser exists; the json one handles jsonc buffers.
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- mason owns the tree-sitter CLI and prepends its bin to PATH, so it has to be
    -- set up before the executable check below.
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()

      -- The main branch compiles parsers with the tree-sitter CLI instead of
      -- shipping prebuilt ones. mason installs it, but not before this runs on a
      -- cold start, so skip the attempt rather than emit one error per parser.
      if vim.fn.executable("tree-sitter") == 1 then
        -- install() is asynchronous and only fetches what is missing.
        require("nvim-treesitter").install(parsers)
      else
        vim.schedule(function()
          vim.notify(
            "tree-sitter CLI not found; restart once mason finishes installing it to build parsers",
            vim.log.levels.WARN
          )
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        desc = "Start treesitter highlighting and indentation where a parser exists",
        callback = function(event)
          local language = vim.treesitter.language.get_lang(event.match) or event.match

          if not vim.treesitter.language.add(language) then
            return
          end

          vim.treesitter.start(event.buf, language)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
