# This script is a filter (copies stdin to stdout) that compensates
# for the fact that you can't disable auto indent in Xcode. Xcode positions
# the first character of every line under the first nonwhite character of the
# previous line. If you line starts with whitespace, that whitespace is
# *added* to the auto-indent spacing. If you want an indent level less than
# the previous line, you have to type backspace characters to get to the
# desired column.
#
# This script should:
#
# - detab the input
#
# - remove from every line any leading whitespace that reflects the added
#   indent. If the previous line was indented 8 spaces, you need to remove
#   8 spaces from the beginning of the current line.
#
# - if a line is indented less than the previous line, remove all leading
#   whitespace, then prefix as many backspace characters ("\b", 0x08) as you
#   need to get the cursor in the right place. type.scpt will emit a
#   left-arrow keystroke for each backspace. For example, this input
#   
#   func f(x: Bool) {
#       if x == true {
#         doSomethingElse()
#       }
#   }
#
#   should be translated to:
#
#   func f(x: Bool) {
#       if x == true {
#     doSomethingElse()
#   \b\b}
#   \b\b\b\b}
#
# The following java program does all that:

java -jar ~/bin/type/xcodeDeMoronize.jar
