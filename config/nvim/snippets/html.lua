local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- local function camel_to_snake(args)
--   local s = args[1][1]
--   s = s:gsub("(%l)(%u)", "%1_%2")
--   s = s:lower()
--   return s
-- end

local function camel_to_snake_str(s)
  s = s:gsub("(%l)(%u)", "%1_%2")
  s = s:lower()
  return s
end

local function camel_to_snake(args)
  return camel_to_snake_str(args[1][1])
end

local function last_snake_word_options(args)
  local snake = camel_to_snake_str(args[1][1])
  local last = snake:match("([^_]+)$") or snake
  return last .. "Options"
end
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

const {}Free = makeInput("text", "{}_free");

const {}FreeBox = document.createElement("div");
{}FreeBox.id = "{}_free_box";
{}FreeBox.style.display = "none";
{}FreeBox.appendChild(fieldWrapper("Freitext", {}Free));
]],
      {
        i(1, "name"),
        rep(1),
        i(2, "value-auswahl-1"),
        i(3, "label-auswahl-1"),
        i(4, "value-auswahl-2"),
        i(5, "label-auswahl-2"),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),
  s(
    "const-select",
    fmt(
      [[
const {} = makeSelect("{}", [
  {{ value: "Unauffällig", label: "Unauffällig" }},
  {{
    value: "{}",
    label: "{}",
  }},
  {{
    value: "{}",
    label: "{}",
  }},
]);
]],
      {
        i(1, "naMe"),
        f(camel_to_snake, { 1 }),
        i(2, "value-auswahl-1"),
        i(3, "label-auswahl-1"),
        i(4, "value-auswahl-2"),
        i(5, "label-auswahl-2"),
      }
    )
  ),
  s(
    "const-row-4",
    fmt(
      [[
const {}Row = document.createElement("div");
{}Row.id = "{}_row";
{}Row.style.display = "none";
{}Row.style.gridTemplateColumns = "1fr 1fr 1fr 1fr";
{}Row.style.gap = "12px";
{}Row.style.marginBottom = "12px";

{}Row.appendChild(
  fieldWrapper("{}", {}{}),
);
{}Row.appendChild(
  fieldWrapper("{}", {}{}),
);
{}Row.appendChild(
  fieldWrapper("{}", {}{}),
);
{}Row.appendChild(
  fieldWrapper("{}", {}{}),
);
]],
      {
        i(1, "naMe"), -- 1
        rep(1), -- 2
        rep(1), -- 3
        rep(1), -- 4
        rep(1), -- 5
        rep(1), -- 6
        rep(1), -- 7

        rep(1), -- 8
        i(2, "Auswahl1"), -- 9
        rep(1), -- 10
        rep(2), -- 11

        rep(1), -- 12
        i(3, "Auswahl2"), -- 13
        rep(1), -- 14
        rep(3), -- 15

        rep(1), -- 16
        i(4, "Auswahl3"), -- 17
        rep(1), -- 18
        rep(4), -- 19

        rep(1), -- 20
        i(5, "Auswahl4"), -- 21
        rep(1), -- 22
        rep(5), -- 23
      }
    )
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
    const free = getVal("{}_free");
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
  s("todo", t("\\TODO: ")),
  s(
    "const-options",
    fmt(
      [[
const {} = makeSelect(
  "{}",
  {},
);
]],
      {
        i(1, "naMe"),
        f(camel_to_snake, { 1 }),
        f(last_snake_word_options, { 1 }),
      }
    )
  ),
}
