# if using VS code within projects folder
# fd = IO.sysopen('./hangman/save_file.txt', 'w+')


# if using repl.it
# fd = IO.sysopen('./projects/hangman/save_file.txt')

#ignore w+ if not writing, if you keep it in it will erase data!

# access a file

fd = IO.sysopen('./projects/hangman/save_file.txt')

test = IO.new(fd)

puts test.gets

test.each do |row|
  print row
end

test.close

