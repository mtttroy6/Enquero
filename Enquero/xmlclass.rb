require 'rexml/document'
require 'rexml/streamlistener'
include REXML

class Test
	@@xmldoc
	@@config
	@@outfile
	@@request
	def initialize(xml,config,outfile)
		@@xmldoc = xml
		@@config = config
		@@request = IO.readlines(config)
		@@outfile = outfile 
	end

	def process()
		@@request.each{
			|i| 
		#puts i
 		x = i.gsub!('.','/')
 		valid = false
 		@@xmldoc.elements.each(x) {
   			|e|
     		valid = true
    		@@outfile.write("#{e}\n") #data between tags{e.txt} " out.write("invalid path  #{x}")
  		}
  		if(!valid)
    		@@outfile.write("invalid path  #{x}\n")
  		end
  		@@outfile.write("----------------------\n")
        }
	end
end
xmlfile = File.new("testfile.xml")
xml = Document.new(xmlfile)
config = File.new("config.txt","r")
out = File.new("out.txt","w")
test = Test.new(xml,config,out)
test.process()
