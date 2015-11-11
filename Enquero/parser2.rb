require 'rexml/document'
require 'rexml/streamlistener'
include REXML

info = Hash.new
class Map
  @@path = Array.new
  @@id =""
def initialize(path,id)
    @@path= path
    @@id=id
end
end
class MyListener
  @@xmlHash = Hash.new
  @@data = ""
  @@path = Array.new
  @@id=1
  @@startCount=0
  @@endCount=0
  @signal = false
  @@tag =[]
  include REXML::StreamListener
  def tag_start(*args)
    
    #puts "#{@@xmlHash.keys}"
    #puts "-----------------------"
   #check for current tag if its already in the path update id
   #
   #
   #
    @@startCount +=1
    if @@endCount > 1
      if @@xmlHash.has_key?(args[0])
         #puts "#{args[0]}"
         @@id+=1
      else
         #puts"#{args[0]}"  
      end
    end
    #puts "#{@@id}"
    @@endCount=0 
    @@xmlHash[args[0]]=args[1..args.size]
    @@path.push(args[0])
    @@signal = false
    @@tag.push(Map.new(@@path,@@id))
    #puts "#{@@id}"
  end
  def tag_end(*args)
    puts " path #{@@path}"
    #puts "#{args[0]}"
  #puts "#{@@path}"
 # puts "#{args[0]}"
    #tag = Tag.new(@@path)
    @@endCount +=1
    if @@endCount > 1
        #@@id +=1
        @@signal = true
    else
    end
    #puts "#{args}"
    @@startCount=0
    @@path.pop
  end
  def text(data)
    return if data =~ /^\w*$/     # whitespace only
    abbrev = data[0..data.size]
    @@data =abbrev
 end
  def output
    @@tag.each do |x|
      puts "#{x.path} #{x.id}"
    end 
  end
end

list = MyListener.new
x = "testfile.xml"
xmlfile = File.new(x)
Document.parse_stream(xmlfile, list)

