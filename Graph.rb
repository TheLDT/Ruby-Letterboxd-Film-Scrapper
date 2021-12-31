class Graph
  public
  def initialize(bar_each = 10, read = "m.txt", write = "graph.txt")
    @bar_each = bar_each
    @read = read
    @write = write
  end

  def make(otherwrite = @write)
    str = File.open(@read).read

    data = eval(str)
    hash = Hash[data.sort]
    arr = Array.new
    total = 0
    for i in hash.min[0].to_i..Time.now.strftime("%Y").to_i
      if i % 10 == 0 || total == 0
        arr.push("====\'"+i.to_s[2]+"0s====")
      end
      total = total + count(hash[i]).to_i
      arr.push(i.to_s + "\t(" + count(hash[i]) + ")\t" + dashes(hash[i]))
    end
    arr.push("Total:\t" + total.to_s)
    save(arr, otherwrite)
  end

  def makeJSON(otherwrite = @write)
    str = File.open(@read).read

    data = eval(str)
    hash = Hash[data.sort]
    arr = Array.new
    total = 0
    arr.push("[")
    for i in hash.min[0].to_i..Time.now.strftime("%Y").to_i
      arr.push("{\"year\": #{i} , \"count\": #{hash[i]||0}},")
    end
    arr.push("]")
    save(arr, otherwrite)
  end

  def show(otherwrite = @write)
    puts File.open(otherwrite).read
  end

  private
  def count(num)
    ('%03d' % (num || 0)).to_s
  end

  def dashes(num)
    (1..num.to_i).collect {|i| i % @bar_each == 0 ? "|" : "-"}.join
  end

  def save(arr, otherwrite = @write)
    File.open(otherwrite, "w") do |f|
      arr.each {|year| f.puts(year)}
    end
  end
end
