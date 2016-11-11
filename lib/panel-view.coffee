class PanelView extends HTMLElement
  initialize: ->

    @classList.add("hopper-panel", "tool-panel", "panel-bottom")

    # panel body
    panelBody = document.createElement("div")
    panelBody.setAttribute("style", "height: 200px;")
    panelBody.classList.add("panel-body")
    @appendChild(panelBody)

  destroy: ->
    @remove() if @parentNode

  toggle: ->
    if @parentNode
      @remove()
    else
      atom.workspace.addBottomPanel(item: this)

module.exports = document.registerElement(
  'hopper-panel-view', prototype: PanelView.prototype, extends: 'div')
