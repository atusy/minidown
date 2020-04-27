--wip: remove elem.attr.attributes.tooltip

function Span(elem)
  local tooltip = elem.attr.attributes.tooltip
  if tooltip then
    tooltip = '<span class=tooltip aria-label="' .. tooltip .. '">'
    return {
      pandoc.RawInline("html", tooltip),
      elem,
      pandoc.RawInline("html", "</span>")
    }
  end
end
