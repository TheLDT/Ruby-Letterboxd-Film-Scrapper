require 'open-uri'
require 'nokogiri'

class WatchedPerYear
  def initialize(user, year = Time.now.strftime("%Y").to_i)
    @user = user
    @year = year
  end

  def get_counts_diary
    count = 1; arr = Array.new
    xpath = "//*[@id=\"diary-table\"]//tbody//tr//td[@class=\"td-released center\"]//span"
    loop do
      document = Nokogiri::HTML
        .parse(URI
        .open("https://letterboxd.com/#{@user}/films/diary/for/#{@year}/page/#{count}/"))

      lookup = document.xpath(xpath)
      break if lookup.length == 0
      lookup.each do |n|
        arr.push(n.text.to_i)
      end

      count += 1
    end

    arr.group_by(&:itself).transform_values(&:count)
  end

  def get_counts_film
    h = Hash.new
    xpath = " //*[@id=\"profile-header\"]//div//div[2]//div[3]//h4[1]//a//span[1]"
    document = Nokogiri::HTML
        .parse(URI
        .open("https://letterboxd.com/#{@user}/"))
    totalmovies = document.css(".profile-statistic.statistic")[0].css(".value").text
    # totalmovies[","] = ""
    totalmovies = totalmovies.sub(",","").to_i
    countmovies = 0
    yearCountdown = Time.now.strftime("%Y").to_i #current year
    loop do
      document = Nokogiri::HTML
        .parse(URI
        .open("https://letterboxd.com/#{@user}/films/year/#{yearCountdown}/"))


      str = document.css(".ui-block-heading").text.split(" ")
      # for some reason letterboxd uses a different type of whitespace
      # so split that too
      curcount = str[str.length-4].split(" ")[0].to_i
      countmovies += curcount
      h[yearCountdown] = curcount.to_s
      break if countmovies >= totalmovies

      yearCountdown-=1
    end
    return h
  end
end
