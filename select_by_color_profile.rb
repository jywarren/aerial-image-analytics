# syntax is select_by_color_profile.rb <samples-per-img> <ideal_img> <radius> <target_directory> <results_dir>

require 'rubygems'
require 'RMagick'
require 'fileutils'

samples = ARGV[0].to_i
ideal_img = ARGV[1]
radius = ARGV[2].to_i
target_dir = ARGV[3]
results_dir = ARGV[4]
count = 0

def generate_profile(item,samples)
	pixels = []
	image = Magick::Image::read(item).first

	(0..(image.columns/samples).to_i-1).each do |px|
		x = px*samples
		(0..(image.rows/samples).to_i-1).each do |py|
			y = py*samples
			pixels << image.pixel_color(x, y)
		end
	end

	r = 0; g = 0; b = 0

	pixels.each do |px|
		r += px.red
		g += px.green
		b += px.blue
	end

	r = (r/pixels.length).to_i
	g = (g/pixels.length).to_i
	b = (b/pixels.length).to_i

	puts pixels.length.to_s+" pixels scanned"
	[r,g,b]
end

ideal_profile = generate_profile(ideal_img,samples)

Dir.foreach(target_dir) do |item|
	next if item == '.' or item == '..' or item[0] == '.'

	item_profile = generate_profile(target_dir+'/'+item,samples)
	r_score = (item_profile[0]-ideal_profile[0]).abs
	g_score = (item_profile[1]-ideal_profile[1]).abs
	b_score = (item_profile[2]-ideal_profile[2]).abs
	puts item
	puts "Scores: " + [r_score,g_score,b_score].join(',')

	if (r_score < radius && g_score < radius && b_score < radius)
		FileUtils.cp(target_dir+'/'+item,results_dir+'/')
		puts "## SELECTED "+item
		count += 1
	end

end

puts count.to_s = ' chosen'
