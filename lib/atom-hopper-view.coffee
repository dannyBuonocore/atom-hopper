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
  # @param cols:      The list of column headers.
  # @param vals:      A list of arrays representing each row in the table.
  #############################################################################
  createTable: (headers, vals) ->

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

    header_row = tr (th s for s in headers)

    rows = []
    for i in [0..vals.length - 1]
      rows.push tr [
        for j in [0..vals[i].length - 1]
          td vals[i][j]
      ]

    @usageTable.innerHTML = table header_row, rows

  #TODO: Not functional.
  addSymbols: (symbols) ->
    console.log 'Adding symbols ' + symbols
    @createTable(symbols, ['Symbol', 'Definition', 'Usages', 'Description'])

  #############################################################################
  # Adds a symbol to the table in the bottom panel
  # @param symbol:    A JSON object containing information on the symbol.
  #############################################################################
  addSymbol: (symbol) ->
    console.log 'Adding symbol ' + symbol
    @createTable(['Symbol', 'Scope', 'Definition', 'Usages', 'Description'], [[symbol.symbol, symbol.scope]])
