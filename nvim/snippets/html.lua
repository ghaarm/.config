local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "const-multi-free",
    fmt(
      [[
const {} = makeSelectMulti("broncho_{}", [
  {{ value: "Unauffällig", label: "Unauffällig" }},
  {{
    value: "{}",
    label: "{}",
  }},
  {{
    value: "{}",
    label: "{}",
  }},
  {{ value: "freitext", label: "Freitext" }},
]);

const {}Free = makeInput("text", "broncho_{}_free");

const {}FreeBox = document.createElement("div");
{}FreeBox.id = "broncho_{}_free_box";
{}FreeBox.style.display = "none";
{}FreeBox.appendChild(fieldWrapper("Freitext", {}Free));
]],
      {
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 1
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 2
        i(2, "value-auswahl-1"), -- 3
        i(3, "label-auswahl-1"), -- 4
        i(4, "value-auswahl-2"), -- 5
        i(5, "label-auswahl-2"), -- 6
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 7
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 8
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 9
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 10
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 11
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 12
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 13
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }), -- 14
      }
    ),
    {
      stored = {
        [1] = i(1, "NAME"),
      },
    }
  ),
  s(
    "function-render-multi-free",
    fmt(
      [[
function render{}() {{
  const values = getValMulti("broncho_{}");
  {}FreeBox.style.display = values.includes("freitext")
    ? "block"
    : "none";
}}
]],
      {
        i(1, "Name"),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
      }
    )
  ),
  s(
    "function-build-multi-text",
    fmt(
      [[
function build{}Text() {{
  const values = getValMulti("broncho_{}");
  const labels = getSelectedLabelsMulti("broncho_{}");

  const items = labels.filter(
    (label) => label !== "Freitext" && label !== "Bitte wählen",
  );

  if (values.includes("freitext")) {{
    const free = getVal("broncho_{}_free");
    if (free) items.push(free);
  }}

  return items.join(", ");
}}
]],
      {
        i(1, "NAME"),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
      }
    )
  ),
  s(
    "appendchildjs-multi-free",
    fmt(
      [[
left.appendChild(
  fieldWrapper("{} (Mehrfachauswahl mit STRG)", {}),
);
left.appendChild({}FreeBox);
]],
      {
        i(1, "NAME"),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
        f(function(args)
          return string.lower(args[1][1])
        end, { 1 }),
      }
    )
  ),
}
