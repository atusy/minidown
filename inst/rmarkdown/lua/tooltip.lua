--wip: remove elem.attr.attributes.tooltip

function Span(elem)
  local tooltip = elem.attributes and elem.attributes.tooltip
  if tooltip then
    return {
      pandoc.RawInline(
        "html", '<span class=tooltip aria-label="' .. tooltip .. '">'
      ),
      elem,
      pandoc.RawInline("html", "</span>")
    }
  end
end
