# atom-hopper package

A short description of your package.

# Useful Regular Expressions

### Match the current symbol and all preceding objects via dot-prefix notation.
<a href="https://regex101.com/r/orGSjy/3">View on Regex101</a><br>
This regex assumes the current symbol is at the very end of the string.  This is generally used in conjunction with splitting the input string at the current buffer location, forcing the current symbol to be at the end of the resulting string.<br>

    (([A-Za-z_$][\w$]*)\s*(\(\))?\s*\.\s*)*([A-Za-z_$][\w$]*)$

![A screenshot of your package](https://f.cloud.github.com/assets/69169/2290250/c35d867a-a017-11e3-86be-cd7c5bf3ff9b.gif)
