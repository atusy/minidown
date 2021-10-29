function Span(elem)
  local tooltip = elem.attributes and elem.attributes.tooltip
  if tooltip then
    local tooltip_str = pandoc.utils.stringify(tooltip)
    local attributes = {}
    attributes["aria-label"] = tooltip_str
    attributes["title"] = tooltip_str
    for k,v in pairs(elem.attributes) do
      if k ~= "tooltip" then
        attributes[k] = v
      end
    end
    elem.attributes = attributes
    return elem
  end
end

