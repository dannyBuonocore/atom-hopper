AtomHopperView = require './atom-hopper-view'
{CompositeDisposable} = require 'atom'
{SymbolFinder} = require './symbol-finder'

module.exports = AtomHopper =
  atomHopperView: null
  symbolFinder: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomHopperView = new AtomHopperView(state.atomHopperViewState)
    @symbolFinder = new SymbolFinder('JS Symbol Finder')
    @modalPanel = atom.workspace.addBottomPanel(item: @atomHopperView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add('atom-workspace', 'atom-hopper:toggle': => @toggle())

    # Register command to search usages of current word
    @subscriptions.add atom.commands.add('atom-workspace', 'atom-hopper:search': => @search())

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomHopperView.destroy()

  serialize: ->
    atomHopperViewState: @atomHopperView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  search: ->
    if not @modalPanel.isVisible()
      @modalPanel.show()
    @atomHopperView.addSymbols @symbolFinder.getCurrentSymbol()
