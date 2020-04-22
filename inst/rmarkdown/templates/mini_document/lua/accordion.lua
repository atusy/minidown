function Div(elem)
  if elem.attr.attributes.menu then
    local title = elem.attr.attributes.menu
    local id = title .. '-menu'
    local checked = ''
    if elem.classes:find('show') then
      checked = 'checked'
    end
    return{
      pandoc.RawBlock(
        "html",
        '<input type="checkbox" id="' .. id .. '" ' .. checked .. ' aria-hidden="true">'
        ..
        '<label for="' .. id .. '" aria-hidden="true">'
        ..
        title
        ..
        '</label>'
      ),
      elem
    }
  end
end
