AtomHopperView = require './atom-hopper-view'
{CompositeDisposable} = require 'atom'
{SymbolFinder} = require './symbol-finder'
{ScopeFinder} = require './scope-finder'

module.exports = AtomHopper =
  atomHopperView: null
  symbolFinder: null
  scopeFinder: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomHopperView = new AtomHopperView(state.atomHopperViewState)
    @symbolFinder = new SymbolFinder('JS Symbol Finder')
    @scopeFinder = new ScopeFinder('JS Scope Finder')
    @modalPanel = atom.workspace.addBottomPanel(item: @atomHopperView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add('atom-workspace', 'atom-hopper:toggle': => @toggle())

    # Register command to search usages of current word
    @subscriptions.add atom.commands.add('atom-workspace', 'atom-hopper:search': => @search())

    # Register command to navigate to the definition of the current symbol
    @subscriptions.add atom.commands.add('atom-workspace', 'atom-hopper:gotoDefinition': => @gotoDefinition())

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
    console.log '@Search ---------------'
    if not @modalPanel.isVisible()
      @modalPanel.show()
    @atomHopperView.addSymbols @symbolFinder.getSymbolsOnLine()

  gotoDefinition: ->
    console.log '@gotoDefinition -------'
    if not @modalPanel.isVisible()
      @modalPanel.show()
    @scopeFinder.getEnclosingScope()
    @atomHopperView.addSymbol @symbolFinder.getCurrentSymbol()
