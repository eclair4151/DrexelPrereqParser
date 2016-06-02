prereq = "or FASH 629 [Min Grade: B], FASH 251 [Min Grade: C] or FASH 629 [Min Grade: B]"

if prereq.start_with?('or ')
  prereq.sub!('or ', '') #get rid of things that start with or.
end

prereq.gsub!('(Can be taken Concurrently) or ','$concurrent_or$') # first replace this where the or is visible. ors always appear
prereq.gsub!(/\(Can be taken Concurrently\)\Z/,'$concurrent_end$') # then replace all where it is at the end of string
prereq.gsub!('(Can be taken Concurrently)','$concurrent_and$') # the rest seem to be stuck with nothing so i assume it should be an and

prereq.gsub!(', ','|and|') # i assume commas are supposed to be ands
prereq.gsub!(/([()])/, '|\1|') # then replace the normal things with |X| so we can split without losing the delimiter
prereq.gsub!(' and ', '|and|') # do the same for 'or' and 'and' but we also need to delete the white space
prereq.gsub!(' or ', '|or|')
prereq.gsub!('$concurrent_or$', '(Can be taken Concurrently)|or|') # then replace then or one with the or
prereq.gsub!('$concurrent_and$', '(Can be taken Concurrently)|and|') # replace the and one with an and
prereq.gsub!('$concurrent_end$', '(Can be taken Concurrently)') # replace the end one with just itself

tokens = prereq.split('|').reject { |s| s.empty? } # split but throw away anything empty

puts tokens