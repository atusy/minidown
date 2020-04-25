--wip: remove elem.attr.attributes.tooltip

function Span(elem)
  tooltip = elem.attr.attributes.tooltip
  if tooltip then
    if elem.classes[1] then
      elem.classes = elem.classes.extend({'tooltip'})
    else
      elem.classes = {'tooltip'}
    end
    elem.attributes['aria-label'] = tooltip
    --elem.attributes = removeKey(elem.attributes, 'tooltip')
    return elem
  end
end
