require 'rubygems'
require 'utility_belt'
require 'irb/completion'

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000000

IRB.conf[:PROMPT_MODE] = :DEFAULT
IRB.conf[:AUTO_INDENT] = true
