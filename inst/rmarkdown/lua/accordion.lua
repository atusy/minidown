collapse = 0 -- n-th collapse in the doc
level = 0 -- Header.level of the current accordion
menu = 0 -- n-th menu in the doc
open_div = pandoc.RawBlock("html", "<div class=collapse>")
close_div = pandoc.RawBlock("html", "</div>")

function not_collapse(x)
  return x ~= "collapse"
end

function Header(elem)
  if collapse == 1 and elem.level <= level then
    collapse = 0
    level = 0
    return {close_div, elem}
  elseif elem.classes and elem.classes:find("collapse") then
    collapse = 1
    level = elem.level
    elem.classes = elem.classes:filter(not_collapse)
    return {elem, open_div}
  end
end

function Pandoc(doc)
  if collapse == 1 then
    table.insert(doc.blocks, close_div)
    return pandoc.Pandoc(doc.blocks, doc.meta)
  end
end

function Div(elem)
  if elem.attr.attributes.menu then
    menu = menu + 1
    local id = 'accordion-menu-' .. menu
    local checked = ''
    if elem.classes:find('show') then
      checked = ' checked'
    end
    return {
      pandoc.RawBlock(
        "html",
        '<input type=checkbox id=' .. id .. checked .. ' aria-hidden=true>'
        ..
        '<label for=' .. id .. ' aria-hidden=true>'
        ..
        elem.attr.attributes.menu
        ..
        '</label>'
      ),
      elem
    }
  end
end
