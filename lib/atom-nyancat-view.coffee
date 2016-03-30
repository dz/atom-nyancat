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

    catHeadSize = 29
    max_width = 200
    tailSize = (max_width-catHeadSize) * progress
    @element.style.width = max_width + "px"

    catBody = document.createElement('span')
    catBody.classList.add('atom-nyancat-body')
    catBody.style.width = Math.min(catHeadSize+tailSize,200) + "px"

    catHead = document.createElement('span')
    catHead.classList.add('atom-nyancat-head')
    catBody.appendChild(catHead)
    @element.appendChild(catBody)
