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
    @editor_subs = new CompositeDisposable
    @editor_subs.add editor.onDidChangeScrollTop (top) =>
      @update()

  unsubLastActive: ->
    if @editor_subs?
      @editor_subs.dispose()
    @editor_subs = null

  update: (refresh=false) ->
    editor = atom.workspace.getActiveTextEditor()
    @view.clear()
    if not editor?
      return
    lastVisibleRow = editor.getVisibleRowRange()[1]
    lastScreenLine = editor.getScreenLineCount()
    @view.updateScroll(lastVisibleRow/parseFloat(lastScreenLine))
