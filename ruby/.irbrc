require 'rubygems'
require 'irb/completion'

require 'irb/ext/save-history'
IRB.conf[:HISTORY_FILE] = File.expand_path("~/.irb_history")
IRB.conf[:SAVE_HISTORY] = 1000000

IRB.conf[:PROMPT_MODE] = :DEFAULT
IRB.conf[:AUTO_INDENT] = true
