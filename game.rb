$LOAD_PATH << './lib'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

c = Control.new
c.go