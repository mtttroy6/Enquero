require 'rexml/document'
require 'rexml/streamlistener'
include REXML

info = Hash.new
class Map
  @@path = Array.new
  @@id =""
  @@data=""
def initialize(path,id)
    @@path= path
    @@id=id
end
end
class MyListener
  @@xmlHash = Hash.new #dictionay for data
  @@data = "" # grabs data from tags
  @@path = Array.new #keep track of path
  @@id=1 #id used for mapping
  @@startCount=0 #count for start tags
  @@endCount=0 # count for endtags
  @@tag =[]
  @@idpath = Array.new
  @@currentid=1
  @@currenttag=""
  include REXML::StreamListener
  #this methdos is calls for starting tags <tag>
  def tag_start(*args)
    @@startCount +=1
    if @@endCount > 1
      if @@xmlHash.has_key?(args[0])
         @@currentid+=1
      end
    end
    @@idpath.push(@@currentid)
    @@endCount=0 
    @@xmlHash[args[0]]=args[1..args.size]
    @@path.push(args[0])
    @@tag.push(Map.new(@@path,@@id))
    @@currenttag = args[0]
    #puts "#{@@path} #{args[0]}"
  end
  #this method is called on closing tags </tag>
  def tag_end(*args)
    #puts "#{@@idpath} #{args[0]}"
    @@endCount +=1
    @@startCount=0
    @@idpath.pop
    @@curentid = @@path.pop
  end
  #called when ecourtering dta betwwen tags <tag>data</tag>
  #the if statment is to ignor the tags with no data <tag></tag>
  def text(data)
  	if data =~ /^\n*$/ 
  	else    
    puts "  text   :   #{data.inspect}"
  end
  end
end

list = MyListener.new
x = "testfile.xml"
xmlfile = File.new(x)
Document.parse_stream(xmlfile, list)
