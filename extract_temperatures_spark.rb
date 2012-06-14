# exiftool * | grep Temperature > ../filesizes/vis-temp.txt
output = []
input = File.open("ir-temp.txt","r").read.split("\n")
input.each_with_index do |line,i|
	output << line.split(': ')[1].split(' ')[0]
end
puts output.join(' ')
