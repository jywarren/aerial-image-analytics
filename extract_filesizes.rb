# first run "ls -l > sizes.txt" in the directory of images
# then run this script, dumping the output into a file: "ruby extract_filesizes.rb > sizestring.txt"
# then copy it into the index.html file to be graphed
output = []
input = File.open("sizes.txt","r").read.split("\n")
input.slice!(0,1)
input.each_with_index do |line,i|
	output << "["+i.to_s+","+line.split(' ')[4]+"]"
end
puts output.join(',')
