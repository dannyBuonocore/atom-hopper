###############################################################################
# @file:    scope-finder.coffee
# @author:  Danny Buonocore
# @desc:    This class parses the text to extract the individual scopes.
###############################################################################

exports.ScopeFinder =
  class ScopeFinder
    constructor: (@name) ->
      console.log @name

    ###########################################################################
    # Returns all the text in the active text editor.
    ###########################################################################
    getEditorText: -> atom.workspace.getActiveTextEditor().getText()

    ###########################################################################
    # Returns all the text to the left of the cursor.
    ###########################################################################
    getLeftText: (buf, pos) -> buf.getTextInRange [[0, 0], [pos.row, @getLineLength(buf, pos)]]

    ###########################################################################
    # Returns all the text to the right of the cursor.
    ###########################################################################
    getRightText: (buf, pos) ->
      len = @getLineLength(buf, pos)
      return buf.getTextInRange [[pos.row, len], buf.getEndPosition()]

    ###########################################################################
    # Returns the length of the current line in the given buffer.
    ###########################################################################
    getLineLength: (buf, pos) -> buf.lineForRow(pos.row).length

    ###########################################################################
    # Extracts and returns all the text included in the scope enclosing the
    # current buffer position.
    ###########################################################################
    getEnclosingScope: ->
      editor = atom.workspace.getActiveTextEditor()
      pos = editor.getCursorBufferPosition()
      text = @getEditorText()
      leftText = @getLeftText(editor.getBuffer(), pos)
      rightText = @getRightText(editor.getBuffer(), pos)

      console.log leftText
      console.log rightText

      bracketBlocksLeft = leftText.split /({|})/g
      bracketBlocksRight = rightText.split /({|})/g

      openB = 0
      closeB = 0

      for i in [bracketBlocksLeft.length..0] by -1
        if bracketBlocksLeft[i] == '{'
          openB++
        else if bracketBlocksLeft[i] == '}'
          closeB++
        if openB == closeB + 1
          break

      leftScope = leftText.split('{')[openB]
