require 'httparty'

class Mashable
	include HTTParty
	# base_uri  'http://mashable.com/stories.json'

	def notices
		news = HTTParty.get("http://mashable.com/stories.json?limit=5")
		news["rising"].each do |notice|
    		puts "#{notice["author"]}"
    		puts "#{notice["title"]}"
    		puts "#{notice["link"]}"
    		puts "#{notice["post_date"]}"
    		puts "==================M"
		end
	end	
end	

class Reddit
	include HTTParty

	def notices
		news = HTTParty.get("http://www.reddit.com/.json?limit=5")
		news["data"]["children"].each do |notice|
    		puts "#{notice["data"]["title"]}"
    		puts "#{notice["data"]["author"]}"
    		puts "#{notice["data"]["url"]}"
    		puts "#{notice["data"]["created"]}"
    		puts "=================R"
		end
	end	
end	

class Digg
	include HTTParty

	def notices
 		news = HTTParty.get("https://digg.com/api/news/popular.json?limit=5")
    	news["data"]["feed"].each do |notice|
   			puts "#{notice["content"]["title_alt"]}"  
   			puts "#{notice["content"]["author"]}"
   			puts "#{notice["content"]["url"]}"
   			puts "#{notice["date_published"]}"
   			puts "===================D"
		end
	end	
end	

def main

	noticias_mashable = Mashable.new
	noticias_mashable.notices
	noticias_reddit = Reddit.new
	noticias_reddit.notices
	noticias_digg = Digg.new
	noticias_digg.notices

end

main