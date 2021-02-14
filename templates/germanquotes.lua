-- see https://github.com/jgm/pandoc/issues/5470#issuecomment-489158514
function Quoted(el)
    if el.quotetype == 'DoubleQuote' then
      return {pandoc.Str("„"), pandoc.Span(el.content), pandoc.Str("“")}
    end
  end