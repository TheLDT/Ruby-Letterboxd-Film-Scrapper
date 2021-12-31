require_relative 'FileSave'
require_relative 'Graph'

#FileSave has 2 variables:
#Username
#File name to save the array (default: m.txt)
#[For save_diary] Year when the diary started (default: current year)
FileSave.new("your Username here").save_films
#Graph has 3 variables:
#Where the vertical bars are going to be (default: 10)
#File name to be read (default: m.txt)
#File name to save the graph (default: graph.txt)
graph = Graph.new()
#Creates the graph.txt file
#[Optional] File name to save the graph
graph.make
graph.makeJSON("json.txt")
#Prints the graph.txt file to the console
#[Optional] File name to be shown
graph.show
graph.show("json.txt")
