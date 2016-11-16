module.exports =
class AtomHopperView
  constructor: (serializedState) ->

    console.log 'Atom-Hopper-View constructor'

    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-hopper')

    # Create title element
    title = document.createElement('div')
    title.textContent = 'Atom Hopper'
    title.classList.add('title')
    @element.appendChild(title)

    # Create the usage table
    @usageTable = document.createElement('div')
    @element.appendChild(@usageTable)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  #############################################################################
  # Creates an html table in the bottom panel containing the symbols.
  # @param symbols:   The list of symbols to populate the table with.
  #############################################################################
  createTable: (symbols) ->

    @usageTable.innerHTML = ''

    table = (header_row, rows) ->
      """
      <table>
      #{header_row}
      #{rows.join '\n'}
      </table>
      """

    tr = (cells) -> "<tr>#{cells.join ''}</tr>"
    th = (s) -> "<th>#{s}</th>"
    td = (s) -> "<td>#{s}</td>"
    rand_n = -> Math.floor Math.random() * 10000

    header_cols = ['Symbol', 'Definition', 'Usages', 'Description']
    header_row = tr (th s for s in header_cols)

    rows = []
    for i in [0..symbols.length - 1]
      rows.push tr [
        th symbols[i]
        td rand_n()
        td rand_n()
        td rand_n()
      ]

    @usageTable.innerHTML = table header_row, rows

  addSymbols: (symbols) ->
    console.log 'Adding symbols ' + symbols
    @createTable(symbols)
