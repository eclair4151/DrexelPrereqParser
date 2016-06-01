prereq = "BIO 122 [Min Grade: D] (Can be taken Concurrently) or BIO 141 [Min Grade: D]"

prereq.gsub!('(Can be taken Concurrently) or ','$concurrent_or$') # first replace this where the or is visible. ors always appear
prereq.gsub!(/\(Can be taken Concurrently\)\Z/,'$concurrent_end$') # then replace all where it is at the end of string
prereq.gsub!('(Can be taken Concurrently)','$concurrent_and$') # the rest seem to be stuck with nothing so i assume it should be an and

prereq.gsub!(', ','|and|') # i assume commas are supposed to be ands
prereq.gsub!(/([()]| or | and )/, '|\1|') # then replace the normal things with |X| so we can split without losing the delimiter

prereq.gsub!('$concurrent_or$', '(Can be taken Concurrently)|or|') # then replace then or one with the or
prereq.gsub!('$concurrent_and$', '(Can be taken Concurrently)|and|') # replace the and one with an and
prereq.gsub!('$concurrent_end$', '(Can be taken Concurrently)') # replace the end one with just itself

tokens = prereq.split('|').reject { |s| s.empty? } # split but throw away anything empty

puts tokens