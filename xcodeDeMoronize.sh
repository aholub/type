# This script is a filter (copies stdin to stdout) that compensates
# for the fact that you can't disable auto indent in Xcode. Xcode positions
# the first nonwhite character of every line the first nonwhite character
# on the previous line. The only way around that is to backspace from
# the default position to where you want to be.
#
# To prepare the file for type.scpt, you need to:
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
#   is translated to:
#
#   func f(x: Bool) {
#       if x == true {
#     doSomethingElse()
#   \b\b}
#   \b\b\b\b}

java -jar ~/bin/type/xcodeDeMoronize.jar
