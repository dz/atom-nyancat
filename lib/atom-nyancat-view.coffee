module.exports =
class AtomNyancatView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('inline-block', 'atom-nyancat')

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @unmount()
    @element.remove()

  mount: (statusBar, priority) ->
    @statusBarTile = statusBar.addLeftTile(item: @element, priority: priority)

  unmount: ->
    @statusBarTile?.destroy()
    @statusbarTile = null

  getElement: ->
    @element

  clear: ->
    while @element.firstChild?
      @element.removeChild(@element.firstChild)

  # percentage should be number between 0 and 1
  updateScroll: (progress) ->
    # round percentage up
    if progress + .000001 > 1
      progress = 1
    percentage = 100 * parseFloat(progress)

    catHeadSize = 18
    catArseSize = 9
    catSize = catArseSize + catHeadSize
    maxWidth = 200
    trailSize = (maxWidth - catHeadSize) * progress + catArseSize
    @element.style.width = maxWidth + "px"

    catTrail = document.createElement('span')
    catTrail.classList.add('atom-nyancat-trail')
    catTrail.style.width = Math.min(trailSize, maxWidth - catHeadSize) + "px"

    catHead = document.createElement('span')
    catHead.classList.add('atom-nyancat-head')

    catArse = document.createElement('span')
    catArse.classList.add('atom-nyancat-arse')

    catTrail.appendChild(catArse)
    @element.appendChild(catTrail)
    @element.appendChild(catHead)
