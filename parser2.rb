require 'rexml/document'
require 'rexml/streamlistener'
include REXML

info = Hash.new
class MyListener
  @@xmlHash = Hash.new
  @@xpath = Hash.new 
  @@countStart=0
  @@countEnd=0
  #@@previous path=[]
  #@@currentpath =[]
  #@@nextpath = []
  include REXML::StreamListener
  def tag_start(*args)
  	#puts "tag_start: #{args[0]}"	
    #$x = args[0]   
   @@xmlHash[args[0]]= args[1..5]
   @@countStart += 1
   #puts "#{args[0]} #{@@xmlHash[args[0]]}"
      if(@@countStart >1)
        puts "new path" + " #{args[0]} #{@@xmlHash[args[0]]}"
        #@@countStart=0
      else
        puts "same path" + " #{args[0]} #{@@xmlHash[args[0]]}"
      end
   @@countEnd = 0
   # info["#{args[0]}"] = "args[1..10]"

  end
  def tag_end(*args)
    @@countStart=0
    @@countEnd +=1
    if (@@countEnd > 1)
      puts "break path"
      #a trigger to break path
      @@countEnd =0
    end
    #puts "tag end"

  end
  def text(data)
    return if data =~ /^\w*$/     # whitespace only
    abbrev = data[0..200]
   #puts data 
 end
  def output
  end
end

list = MyListener.new
x = "testfile.xml"
xmlfile = File.new(x)
Document.parse_stream(xmlfile, list)
#list.output
