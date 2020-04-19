function CodeBlock(elem)
  if elem.classes and elem.classes:find("details") then
    local open = ""
    if elem.classes:find("open") then
      open = " open"
    end
    local summary = "Code"
    if elem.attributes.summary then
      summary = elem.attributes.summary
    end
    return{
      pandoc.RawBlock(
        "html", "<details class=rmd" .. open .. "><summary class=rmd>" .. summary .. "</summary>"
      ),
      elem,
      pandoc.RawBlock("html", "</details>")
    }
  end
end
