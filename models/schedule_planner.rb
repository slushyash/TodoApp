schedule = {}
@scheduled_todos = []

class Time
  def format
    self.strftime("%l:%M:%S %p")
  end
end

def free_time_slots(event_ranges_sorted, current_time, start_index=0, current_free_slots=[])
  if(start_index == event_ranges_sorted.length); return current_free_slots; end
  next_event = event_ranges_sorted[start_index]
  distance_between_now_and_next_event = event_ranges_sorted[start_index].first - current_time
  if(distance_between_now_and_next_event >= 5 * 60)
      current_free_slots << (current_time..(event_ranges_sorted[start_index].first - 7 * 60))
  end
  return free_time_slots(event_ranges_sorted, next_event.last, start_index + 1, current_free_slots)
end

now = Time.new(Time.now.year, Time.now.month, Time.now.day - 2, 7)
today_events = Task.all(
  :startTime.lt => Time.new(now.year, now.month, now.day + 1),
  :startTime.not => nil,
  :startTime.gt => Time.new(now.year, now.month, now.day),
  :order => [ :startTime.asc ]
)

today_events = today_events.delete_if do |event|
  event.end_time_event <= now
end

event_times = today_events.map do |event|
  (event.startTime..(event.startTime + event.duration * 60))
end.to_a

#puts event_times
#today_events.each(&:pretty_print)
open_time_slots_today = free_time_slots(event_times, now)
puts open_time_slots_today
#puts Task.all

todos = []

Task.all(
  :startTime => nil,
  :order => [:due.asc ],
  :done => false
).each do |task|
  if(task.steps.length == 0)
    todos << task
  else
    task.steps.each do |step|
      todos << step
    end
  end
end

def total_time_minutes(time_ranges)
  total = 0
  time_ranges.each do |range|
    total = total + (range.last - range.first)/60.0
  end
  total
end

def schedule_todos_short_term(todos_sorted, open_time_slots_today, now=Time.now, slot_index=0)
  if(todos_sorted.length == 0)
    return
  end
  if(total_time_minutes(time_ranges) <= 120 && todo_due_soonest.due > now + 172800)
    return
  end
  if(slot_index > open_time_slots_today.length - 1)
    if(todo_due_soonest.due > now + 172800)
      return
    else
      puts "You have a problem dude. There are no time slots available. Try splitting"
      return
    end
  end
  todo_due_soonest = todos_sorted.first
  first_open_time_slot = open_time_slots_today[slot_index]
  first_open_time_slot_start = first_open_time_slot.first
  first_open_time_slot_end = first_open_time_slot.last
  first_open_time_slot_length_minutes = (first_open_time_slot_end - first_open_time_slot_start)/60.0
  
  if(todo_due_soonest.due < first_open_time_slot_end) #??!
    puts "You have a problem dude. The todo #{todo_due_soonest.name} can't be started until #{first_open_time_slot_start}, which is after it's due. Move some stuff around perhaps or try to break your todo into steps. If something is overdue, reset the due date."
    return
  end
  if(todo_due_soonest.duration <= first_open_time_slot_length_minutes)
    end_of_todo = first_open_time_slot_start+(60*todo_due_soonest.duration)
    @scheduled_todos << [todo_due_soonest, (first_open_time_slot_start..end_of_todo)]
    leftover_time = first_open_time_slot_end - end_of_todo
    if(leftover_time > 7 * 60)
      open_time_slots_today[slot_index] = (end_of_todo..first_open_time_slot_end - 5 * 60)
    else
      open_time_slots_today = open_time_slots_today.delete_at(slot_index)
    end
    schedule_todos_short_term(todos_sorted[1..-1], open_time_slots_today, now) #RECURSION FUCK YES
  else
    schedule_todos_short_term(todos_sorted, open_time_slots_today, now, slot_index + 1)
  end
end

#puts Category.all.first.inspect
schedule_todos_short_term(todos, open_time_slots_today, now)
@scheduled_todos.each do |scheduled_todo|
  puts "#{scheduled_todo[0].name}: #{scheduled_todo[1].first.format}-#{scheduled_todo[1].last.format}"
end