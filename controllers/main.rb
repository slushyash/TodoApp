def get_args(input)
  input.scan(/-(\w+)\s((?:\w|\s)+)/).map do |pair|
    [pair[0], pair[1].rstrip]
  end
end

def query_hash(input)
  hash = {}
  get_args(input).each do |pair|
    hash[pair[0].to_sym] = pair[1]
  end
  hash
end

@controller.match(/category list/) do |match_data|
  Category.all.each(&:pretty_print)
end

@controller.match(/category create (.*)/) do |match_data|
  Category.create(query_hash(match_data[0]))
end

@controller.match(/category delete (.*)/) do |match_data|
  Category.all(query_hash(match_data[0])).destroy
end

@controller.match(/category update (\d+) (.*)/) do |match_data|
  Category.all(:id => match_data[1]).update(query_hash(match_data[0]))
end

@controller.match(/task create-with-category (\d+) (.*) locations (.*)/) do |match_data|
  puts query_hash(match_data[2])
  task = Task.new(query_hash(match_data[2]))
  puts match_data[3].split(" ")
  task.locations = Location.all(:id => match_data[3].split(" ").map(&:to_i))
  puts match_data[1]
  task.save
  Category.first(:id => match_data[1].to_i).tasks << task
end

@controller.match(/task list/) do |match_data|
  Task.all.each(&:pretty_print)
end

@controller.match(/location list/) do |match_data|
  Location.all.each(&:pretty_print)
end

@controller.match(/location create (.*)/) do |match_data|
  Location.create(query_hash(match_data[0]))
end

@controller.match(/location delete (.*)/) do |match_data|
  Location.all(query_hash(match_data[0])).destroy
end

def generate_schedule
  
end