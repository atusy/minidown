function Note(note)
  return pandoc.Span(note, {title = pandoc.utils.stringify(note.content)})
end

