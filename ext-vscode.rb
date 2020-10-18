#!/usr/bin/env ruby

FILENAME = "vscode-extensions.txt"

def load
  File.readlines(FILENAME).each do |line|
    line.chomp!
    system "code", "--install-extension", line
  end
end

def save
  ext = `code --list-extensions`.lines.sort.join
  File.write FILENAME, ext
end

def help
  puts %{
usage: #{$0} load
       #{$0} save
}
end

case ARGV[0]
when "load" then load
when "save" then save
else help
end
