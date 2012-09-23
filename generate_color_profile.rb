require 'rubygems'
require 'RMagick'

samples = 10
pixels = []

image = Magick::Image::read(ARGV[0]).first

(0..(image.columns/samples).to_i-1).each do |px|
	x = px*samples
	(0..(image.rows/samples).to_i-1).each do |py|
		y = py*samples
		a = image.export_pixels(x, y, 1, 1, "RGB");
		pixels << [a[0],a[1],a[2]] # r,g,b
		puts [a[0],a[1],a[2]] # r,g,b
	end
end

r = 0
g = 0
b = 0

pixels.each do |px|
	r += px[0]
	g += px[1]
	b += px[2]
end

r = (r/pixels.length).to_i
g = (g/pixels.length).to_i
b = (b/pixels.length).to_i

puts ([r,g,b]).inspect
