fd = IO.sysopen('test.txt', 'w+')

test = IO.new(fd)

test.puts "test"

test.close