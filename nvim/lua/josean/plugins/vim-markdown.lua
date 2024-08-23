-- https://github.com/preservim/vim-markdown/issues/616
--
return {
  'plasticboy/vim-markdown',
  branch = 'master',
  require = { 'godlygeek/tabular' },
  lazy = true, -- Lädt das Plugin nur, wenn es benötigt wird
  ft = { "md", "markdown" },
  config = function()
    vim.cmd([[
    let g:vim_markdown_folding_disabled = 1 " disable header folding

    let g:vim_markdown_conceal = 0 " do not use conceal feature, the implementation is not so good

    let g:tex_conceal = "" " disable math tex conceal feature
    let g:vim_markdown_math = 1

    let g:vim_markdown_frontmatter = 1     " support front matter of various format " for YAML format
    let g:vim_markdown_toml_frontmatter = 1  " for TOML format
    let g:vim_markdown_json_frontmatter = 1  " for JSON format
    ]])
  end,
}
