local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
return {
  -- Autosnippets
  --
  --
  s({ trig = "g%", wordTrig = false, desr = "~\\% geschütztes Prozent", snippetType = "autosnippet" }, {
    t([[~\%]]),
  }),
  s({ trig = "reff", wordTrig = true, dscr = "referenz latex", snippetType = "autosnippet" }, {
    t("\\ref{"),
    i(1),
    t("}"),
  }),
  -- normale snippets
  --
  --
  -- s({
  --   trig = "g%",
  --   wordTrig = false, -- cmtsub, O2tsub, ...
  --   dscr = "~\\% geschütztes Prozent",
  -- }, {
  --   t("~\\%"),
  --   i(1),
  -- }),
  s({
    trig = "tsup",
    wordTrig = false, -- darf mitten im Wort stehen (cmtsup, O2tsup, ...)
    dscr = "Text superscript",
  }, {
    t("\\textsuperscript{"),
    i(1),
    t("}"),
    i(0),
  }),

  -- tsub: Subscript hinter bereits getipptem Text
  s({
    trig = "tsub",
    wordTrig = false, -- cmtsub, O2tsub, ...
    dscr = "Text subscript",
  }, {
    t("\\textsubscript{"),
    i(1),
    t("}"),
    i(0),
  }),
  s(
    {
      trig = "citef",
      name = "Zitat foot",
      wordTrig = false, -- cmtsub, O2tsub, ...
      dscr = "Zitat als Fußnote: \\cite + Seite",
    },
    fmt([[\footnote{{\cite{{{}}}, S. {}}}]], {
      i(1, "name"),
      i(2, "Seite"),
    })
  ),
}
