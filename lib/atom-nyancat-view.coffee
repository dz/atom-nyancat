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
    if progress > 0.9
      progress = 1
    percentage = 100 * parseFloat(progress)

    max_width = 200

    @element.style.width = max_width + "px"

    catBody = document.createElement('span')
    catBody.classList.add('atom-nyancat-body')
    catBody.style.width = Math.max(Math.ceil(max_width * progress), 40) + "px"

    catHead = document.createElement('span')
    catHead.classList.add('atom-nyancat-head')
    catBody.appendChild(catHead)
    @element.appendChild(catBody)
