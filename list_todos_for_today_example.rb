require 'bundler/setup'
require 'httparty'
require_relative 'lib/collection_json_parser'

stuff_server_url = ENV['STUFF_API_URL'] || 'http://stuff-api.herokuapp.com'

response = HTTParty.get(stuff_server_url)
todo_lists = CollectionJSON.parse(response.body)

today_todo_list = todo_lists.items.find { |list_item| list_item.data['title'].value == 'Today'}

if today_todo_list.nil?
  puts "There's no Today list"
  exit
end

response = HTTParty.get(today_todo_list.href)
todos_for_today = CollectionJSON.parse(response.body)

if todos_for_today.items.empty?
  puts 'Yuppiee! You have nothing else todo today!'
  puts 'Go have some fun and read up on Hypermedia APIs :)'
  exit
end

puts "Stuff Todo Today:"
todos_for_today.items.each do |todo_item|
  checkbox = '[ ]'
  checkbox = '[X]' if todo_item.data['completed'].value
  puts "  #{checkbox} #{todo_item.data['title'].value}"
end
