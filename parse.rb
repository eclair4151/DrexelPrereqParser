class Expression

  def initialize(values, operator)
    if values.kind_of?(Array)
      @values=values
      @operator = operator
    elsif values != nil
      @values=[values]
      @operator = operator
    else
      @values=[]
      @operator = nil
    end
  end

  def add_value(value)
    @values.push(value)
  end

  def get_operator
    @operator
  end
  def set_operator(oper)
    @operator = oper
  end

  def pop_value
    @values.pop
  end
end






def order_operation(token)
  if token == '(' or token == ')'
    3
  elsif token == 'and'
    2
  elsif token == 'or'
    2
  else
    0
  end
end




prereq = "(TDEC 115 [Min Grade: D] and ECES 302 [Min Grade: D] and ECES 304 [Min Grade: D] and BMES 325 [Min Grade: D] and BMES 326 [Min Grade: D]) or PHYS 201 [Min Grade: D] and (BIO 203 [Min Grade: D] or BMES 235 [Min Grade: D]) and (MATH 311 [Min Grade: D] or BMES 310 [Min Grade: D]) and (TDEC 222 [Min Grade: D] or ENGR 231 [Min Grade: D]) and ENGR 232 [Min Grade: D]"

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

root = Expression.new(nil,nil)
node_stack = [root]

for token in tokens
  if order_operation(token) == 0
    node_stack.last.add_value(Expression.new(token,nil))

  elsif order_operation(token) == 3 and token == '('

    new_node = Expression.new(nil,nil)
    node_stack.last.add_value(new_node)
    node_stack.push(new_node)

  elsif order_operation(token) == 3 and token == ')'
    node_stack.pop

  elsif order_operation(token) == 2
    if node_stack.last.get_operator == nil
      node_stack.last.set_operator(token)
    end

    if node_stack.last.get_operator != token
      last = node_stack.last.pop_value
      new_node = Expression.new(last,token)
      node_stack.last.add_value(new_node)
      node_stack.push(new_node)
    end

  end
end

print "ters"
#here root has been parsed