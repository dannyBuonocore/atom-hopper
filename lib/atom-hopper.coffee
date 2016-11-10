AtomHopperView = require './atom-hopper-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomHopper =
  atomHopperView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomHopperView = new AtomHopperView(state.atomHopperViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomHopperView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-hopper:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomHopperView.destroy()

  serialize: ->
    atomHopperViewState: @atomHopperView.serialize()

  toggle: ->
    console.log 'AtomHopper was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
