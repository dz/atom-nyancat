AtomNyancatView = require './atom-nyancat-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomNyancat =
  atomNyancatView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    console.log "nyancat enabled"

    @view = new AtomNyancatView()
    @subs = new CompositeDisposable

    @subs.add atom.workspace.observeActivePaneItem =>
      @unsubLastActive()
      @subActive()
      @update()

  deactivate: ->
    @unsubLastActive()
    @subs.dispose()
    @view.destroy()
    @statusBar = null

  consumeStatusBar: (statusBar) ->
    @statusBar = statusBar
    priority = 500
    @view.mount(@statusBar, priority)

  subActive: ->
    editor = atom.workspace.getActiveTextEditor()
    if not editor?
      return
    editorElement = editor.getElement()
    @editor_subs = new CompositeDisposable
    @editor_subs.add editorElement.onDidChangeScrollTop (top) =>
      @update()
    @update() # update once regardles

  unsubLastActive: ->
    if @editor_subs?
      @editor_subs.dispose()
    @editor_subs = null

  update: ->
    editor = atom.workspace.getActiveTextEditor()
    @view.clear()
    if editor?
      lastVisibleRow = editor.firstVisibleScreenRow
      lastScreenLine = editor.getLineCount() - editor.rowsPerPage
      percent = lastVisibleRow/parseFloat(lastScreenLine)
    else
      precent = 1
    @view.updateScroll(percent)
