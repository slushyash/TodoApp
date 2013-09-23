include DataMapper::Sweatshop::Unique

hash = {
  "CS314" => [[Time.new(2013, 9, 17, 14), 1.5], [Time.new(2013, 9, 19, 14), 1.5]],
  "M408D" => [[Time.new(2013, 9, 16, 9), 1], [Time.new(2013, 9, 18, 9), 1], [Time.new(2013, 9, 20, 9), 1]],
  "CS311" => [[Time.new(2013, 9, 17, 9.5), 1.5], [Time.new(2013, 9, 19, 9.5), 1.5]],
  "UGS" => [[Time.new(2013, 9, 16, 10), 1], [Time.new(2013, 9, 18, 10), 1], [Time.new(2013, 9, 20, 10), 1]]
}

assignments_hash = {}


["CS314", "M408D", "CS311", "UGS"].each do |category|
  course_category = Category.create(:name => category)
  hash[category].each do |class_info|
    time = class_info[0]
    i = 0
    until(i == 20)
      task = Task.create(
        :name => "#{category} class #{i}",
        :duration => (class_info[1] * 60),
        :priority => 80,
        :startTime => time
      )
      course_category.tasks << task
      time = time + 604800 # seconds in a week
      i = i + 1
    end
  end
end

sleep_time = Time.new(2013, 9, 17, 23, 30)
get_ready = Time.new(2013, 9, 17, 6, 30)
lunch = Time.new(2013, 9, 17, 12)
dinner = Time.new(2013, 9, 17, 19)

50.times do |i|
  Task.create(:name => "sleep", :duration => 60 * 7, :startTime => sleep_time, :priority => 95)
  Task.create(:name => "get ready", :duration => 70, :startTime => get_ready, :priority => 90)
  Task.create(:name => "lunch", :duration => 45, :startTime => lunch, :priority => 85)
  Task.create(:name => "dinner", :duration => 45, :startTime => dinner, :priority => 85)
  get_ready = get_ready + 86400
  sleep_time = sleep_time + 86400
  lunch = lunch + 86400
  dinner = dinner + 86400
end

category = Category.all.first
category.tasks << Task.create(:name => "Do stuff", :due => Time.now, :looseness => 60, :duration => 80)
Task.create(:name => "Do stuffarst", :due => Time.now, :looseness => 60, :duration => 20)
Task.create(:name => "Do moar", :due => Time.now, :looseness => 60, :duration => 30)