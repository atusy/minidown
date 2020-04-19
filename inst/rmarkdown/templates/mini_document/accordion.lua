function Header(elem)
  if elem.classes and elem.classes:find("menu") then
    local id = elem.identifier .. '-menu'
    local title = pandoc.utils.stringify(elem.content)
    return{
      pandoc.RawBlock(
        "html",
        '<input type="checkbox" id="' .. id .. '" checked aria-hidden="true">'
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
