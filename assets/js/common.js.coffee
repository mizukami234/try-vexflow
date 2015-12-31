
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

notes = [
  new Vex.Flow.StaveNote { keys: ["c/4"], duration: "q" }
  new Vex.Flow.StaveNote { keys: ["d/4"], duration: "q" }
  new Vex.Flow.StaveNote { keys: ["b/4"], duration: "qr" }
  new Vex.Flow.StaveNote { keys: ["c/4", "e/4", "g/4"], duration: "q" }
]

voice = new Vex.Flow.Voice {
  num_beats: 4
  beat_value: 4
  resolution: Vex.Flow.RESOLUTION
}

voice.addTickables notes
formatter = new Vex.Flow.Formatter().joinVoices([voice]).format([voice], 680)

voice.draw(ctx, stave)
