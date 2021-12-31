require_relative 'WatchedPerYear'

class FileSave
  def initialize(user, file_name = "m.txt")
    @user = user
    @file_name = file_name
  end

  def add_arr(arr1, arr2)
    arr2.each do |k, v|
      arr1[k] ||= "0"
      arr1[k] = (arr1[k].to_i + v.to_i).to_s
    end
    arr1
  end

  def save_diary(start)
    prev = WatchedPerYear.new(@user, start).get_counts_diary

    for i in (start+1)..Time.now.strftime("%Y").to_i
     prev = add_arr(prev, WatchedPerYear.new(@user, i).get_counts_diary)
    end

    File.open(@file_name, "w") { |f| f.write prev }
  end

  def save_films
    h = WatchedPerYear.new(@user).get_counts_film
    File.open(@file_name, "w") { |f| f.write h }
  end
end
