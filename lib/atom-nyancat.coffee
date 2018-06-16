AtomNyancatView = require './atom-nyancat-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomNyancat =

  activate: (state) ->
    console.log "nyancat enabled"

    @view = new AtomNyancatView()
    @subs = new CompositeDisposable

    @subs.add atom.workspace.onDidChangeActiveTextEditor =>
      @attachToActiveTextEditor()
    @attachToActiveTextEditor()

  attachToActiveTextEditor: ->
    @scrollBind?.dispose()
    editor = atom.workspace.getActiveTextEditor()
    @scrollBind = editor?.element.onDidChangeScrollTop(@update.bind(this))
    if editor?
      @view.unhide()
      @update()
    else
      @view.hide()

  deactivate: ->
    @subs.dispose()
    @scrollBind?.dispose()
    @view.destroy()
    @statusBar = null

  consumeStatusBar: (statusBar) ->
    @statusBar = statusBar
    priority = 500
    @view.mount(@statusBar, priority)

  update: ->
    editor = atom.workspace.getActiveTextEditor()

    maxScrollTop = editor?.element.getMaxScrollTop()
    if maxScrollTop > 0
      percent = editor.element.getScrollTop() / maxScrollTop
    else
      percent = 1
    @view.updateScroll(percent)
