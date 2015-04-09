require 'httparty'
require 'colorize'

class Feed

	def news type

		if type == "Mashable"
			m = Mashable.new 
			aux = m.noticia
			return aux
		elsif type == "Reddit"
			r = Reddit.new
			aux = r.noticia
			return aux
		elsif type == "Digg"
			d = Digg.new
			aux = d.noticia
			return aux
		end		
	end
end	

class Notice

	attr_accessor :title, :author, :date, :link, :type

	def initialize title, author, date, link, type

		@title = title
		@author = author
		@date = date
		@link = link
    @type = type

	end	
end	

class Mashable 
	include HTTParty
	# base_uri  'http://mashable.com/stories.json'

	def noticia
		not_mas = []
		news = HTTParty.get("http://mashable.com/stories.json")
		news["rising"].each do |notice|
    	  title =  "#{notice["title"]}"
    	  author =  "#{notice["author"]}"
    	  link =  "#{notice["link"]}"
    	  date =  Time.at(("#{notice["post_date"]}")
        type = "Mashable"
    	  notice = Notice.new(title, author, link, date, type)
    	  not_mas.push(notice)
    		# "==================M"
		end

		return not_mas
	end	
end	

class Reddit 
	include HTTParty

	def noticia
		not_red = []
		news = HTTParty.get("http://www.reddit.com/.json")
		  news["data"]["children"].each do |notice|
    	  title =  "#{notice["data"]["title"]}"
    	  author =  "#{notice["data"]["author"]}"
    	  link =  "#{notice["data"]["url"]}"
    	  date =  Time.at(("#{notice["data"]["created"]}").to_i)
        type = "Reddit"
    	  notice = Notice.new(title, author, link, date, type)
    	  not_red.push(notice)
    		# "=================R"
		end

		return not_red
	end	
end	

class Digg 
	include HTTParty

	def noticia
		not_digg = []
 		news = HTTParty.get("https://digg.com/api/news/popular.json")
    	news["data"]["feed"].each do |notice|
   		  title =  "#{notice["content"]["title_alt"]}"
   		  author =  "#{notice["content"]["author"]}"
   		  link =  "#{notice["content"]["url"]}"
   		  date = Time.at(("#{notice["date_published"]}").to_i)
        type = "Digg"
   		  notice = Notice.new(title, author, link, date, type)
   		  not_digg.push(notice)
   			# "===================D"
		end

		return not_digg
	end	
end	

def main
	while true

    puts "Desea ver las noticias de que paginas"
		puts "1. Mashable"
		puts "2. Reddit"
		puts "3. Digg"
		puts "Indique el numero de la opcion"
		sw = gets.to_i
	
		if sw != 1 && sw != 2 && sw != 3 
			puts "opcion no valida"
    end
      
		if sw == 1
			m = Feed.new
			aux = m.news("Mashable")
			break
		elsif sw == 2
			r = Feed.new
			aux = r.news("Reddit")
			break
		else
			d = Feed.new
			aux = d.news("Digg")
      break
    end				

	end	

  for i in 0...aux.length 
    puts "===============================".colorize(:blue)
	  puts aux[i].title
    puts aux[i].author
    puts aux[i].date
    puts aux[i].link
    puts aux[i].type
  end
end

main