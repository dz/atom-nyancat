module.exports =
class AtomNyancatView

  catHeadSize = 18
  catArseSize = 9
  catSize = catArseSize + catHeadSize

  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('inline-block', 'atom-nyancat')

    @catTrail = document.createElement('span')
    @catTrail.classList.add('atom-nyancat-trail')
    @catTrail.style.minWidth = catArseSize + "px";

    catHead = document.createElement('span')
    catHead.classList.add('atom-nyancat-head')

    catArse = document.createElement('span')
    catArse.classList.add('atom-nyancat-arse')

    @catTrail.appendChild(catArse)
    @element.appendChild(@catTrail)
    @element.appendChild(catHead)


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
    progress = Math.min(progress * 100, 100);
    @catTrail.style.width = "calc(" + progress + "% - " + catHeadSize + "px)"

  hide: ->
    @element.classList.add('hide')
  unhide: ->
    @element.classList.remove('hide')
