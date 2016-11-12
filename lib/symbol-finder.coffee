###############################################################################
# @file:    symbol-finder.coffee
# @author:  Danny Buonocore
# @desc:    This class parses the text to find symbol declarations and usages.
###############################################################################

exports.SymbolFinder =
  class SymbolFinder
    constructor: (@name) ->
      console.log @name

    # Determines the variable or function under the caret.
    # Splits the buffer line in two parts, containing the text to the left and
    # the right of the current buffer position.  A regular expression then
    # parses each half and combines the endpoints to form the symbol name.
    getCurrentSymbol: ->
      editor = atom.workspace.getActiveTextEditor()
      pos = editor.getCursorBufferPosition()
      text = editor.lineTextForBufferRow(pos.row)
      leftText = text.substring 0, pos.column
      rightText = text.substring pos.column

      left = /\s*([A-Za-z0-9_$]+)$/g.exec(leftText)
      right = /^([A-Za-z0-9_$]+)\s*/g.exec(rightText)

      left = if left then left[1] else ''
      right = if right then right[1] else ''

      word = left + right

      console.log 'Current symbol: ' + word

      return word
