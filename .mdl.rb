# Use all the rules by default
all
# Allow some punctuation in the header, as :
rule 'MD026', :punctuation => '.,;!?'
# Enforce classic Markdown style headers
rule 'MD003', :style => :atx
# Enforce ordered list prefix style
rule 'MD029', :style => :ordered
