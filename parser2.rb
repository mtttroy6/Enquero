require 'rexml/document'
require 'rexml/streamlistener'
include REXML

info = Hash.new
class MyListener
  @@xmlHash = Hash.new
  @@data = ""
  @@path = Array.new
  include REXML::StreamListener
  def tag_start(*args)
    puts "#{@@path}"
   @@xmlHash[args[0]]= args[1..5]
   @@path.push(args[0])
  end
  def tag_end(*args)
  	puts "#{@@path}"
   @@path.pop
  end
  def text(data)
    return if data =~ /^\w*$/     # whitespace only
    abbrev = data[0..200]
    @@data =abbrev
 end
  def output
  end
end

list = MyListener.new
x = "testfile.xml"
xmlfile = File.new(x)
Document.parse_stream(xmlfile, list)
