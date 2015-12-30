
flowContainer = $ '#flow-container'

engine = flowContainer.data('render-engine')

createBase$Element = (engine)->
  switch engine
    when 'svg' then $('<svg width="700" height="100">')
    when 'canvas' then $('<canvas width="700" height="100">')

createRenderer = ($element, engine)->
  switch engine
    when 'svg' then new Vex.Flow.Renderer($element[0], Vex.Flow.Renderer.Backends.RAPHAEL)
    when 'canvas' then new Vex.Flow.Renderer($element[0], Vex.Flow.Renderer.Backends.CANVAS)

$element = createBase$Element engine

flowContainer.append($element)

renderer = createRenderer($element, engine)

ctx = renderer.getContext()
stave = new Vex.Flow.Stave(10, 0, 680)
stave.addClef('treble').setContext(ctx).draw()
