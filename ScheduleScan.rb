require 'HTTParty' #Sends HTTP requests
require 'Nokogiri'

class Scraper

    attr_accessor :parse_page
  
    def initialize(link)
      doc = HTTParty.get(link)
      @parse_page = Nokogiri::HTML(doc)
    end
  
    def get_seats
      avSeats = parse_page.css("tr").css(".dddefault").css("td:nth-child(4)").children.map { |seats| seats.text }.compact
    end
  

    classes = { "Web dev" => "https://banner.bsu.edu/ssbprod/bwckschd.p_disp_detail_sched?term_in=201910&crn_in=30024",
                "Theory of Comp" => "https://banner.bsu.edu/ssbprod/bwckschd.p_disp_detail_sched?term_in=201910&crn_in=21805",
                "Programming Languages" => "https://banner.bsu.edu/ssbprod/bwckschd.p_disp_detail_sched?term_in=201910&crn_in=30020",
                "Operating Systems" => "https://banner.bsu.edu/ssbprod/bwckschd.p_disp_detail_sched?term_in=201910&crn_in=30028",
                "Business Info Systems" => "https://banner.bsu.edu/ssbprod/bwckschd.p_disp_detail_sched?term_in=201910&crn_in=24910"
              }
    
    puts "--------------------------------------------"
    puts "---\t Class Seat Tracker - Hunter W \t---"
    puts "--------------------------------------------"
    puts

    classes.each do |key , value|
      scraper = Scraper.new(classes[key])
      seat = scraper.get_seats
      seat.pop #Removes waitlist data
      
      puts "Class: #{key} | Seats open (Open | Waitlist): #{seat}"
      puts "-----------------------------------------"
    end

    puts
    puts
    puts
    puts "\t ...Checking Complete!... \t"
  #contentHolder > div.pagebodydiv > table:nth-child(1) > tbody > tr:nth-child(2) > td > table > tbody > tr:nth-child(2) > td:nth-child(4)
  
  end
  


