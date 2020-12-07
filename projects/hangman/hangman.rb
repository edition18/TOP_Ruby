fd = IO.sysopen('./projects/hangman/save_file.txt', 'w+')
# if using repl.it


# fd = IO.sysopen('save_file.txt', 'w+')

test = IO.new(fd)

test.puts "test"

test.close