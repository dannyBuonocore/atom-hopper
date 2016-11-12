###############################################################################
# @file:    symbol-finder.coffee
# @author:  Danny Buonocore
# @desc:    This class parses the text to find symbol declarations and usages.
###############################################################################

exports.SymbolFinder =
  class SymbolFinder
    constructor: (@name) ->
      console.log @name

    ###########################################################################
    # Returns the text on the line of the current caret position.
    ###########################################################################
    getLineText: ->
      editor = atom.workspace.getActiveTextEditor()
      pos = editor.getCursorBufferPosition()
      return editor.lineTextForBufferRow pos.row

    ###########################################################################
    # Determines the variable or function under the caret.
    # Splits the buffer line in two parts, containing the text to the left and
    # the right of the current buffer position.  A regular expression then
    # parses each half and combines the endpoints to form the symbol name.
    ###########################################################################
    getCurrentSymbol: ->
      text =  getLineText()
      leftText = text.substring 0, pos.column
      rightText = text.substring pos.column

      left = /\s*([A-Za-z0-9_$]+)$/g.exec(leftText)
      right = /^([A-Za-z0-9_$]+)\s*/g.exec(rightText)

      left = if left then left[1] else ''
      right = if right then right[1] else ''

      word = left + right

      console.log 'Current symbol: ' + word

      return word

    ###########################################################################
    # Collects and returns all the symbols on the current line
    # @returns:   An array containing the symbol strings on the current line.
    ###########################################################################
    getSymbolsOnLine: ->
      text = @getLineText()
      console.log text
      re = /\.*([A-Za-z_$][A-Za-z0-9_$]+)\.*/g
      symbols = []

      while true
        if (m = re.exec(text))
          symbols.push m[1]
        else
          break

      return symbols
