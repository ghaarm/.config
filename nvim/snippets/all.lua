local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Snippet für Suchmuster in der Kommandozeile
  s("pattern", {
    t("/\\v\\<"),
    i(1, "dein_text"),
    t("\\>/")
  }),

  -- Beispiel für einen anderen Snippet
  s("replace", {
    t(":%s/"),
    i(1, "search"),
    t("/"),
    i(2, "replace"),
    t("/g")
  })
}
