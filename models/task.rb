class Task
  include DataMapper::Resource

#  attr_accessor 
  property :id, Serial
  property :name, Text, :lazy => false
  property :description, Text, :lazy => false
  property :due, EpochTime, :lazy => false
  property :looseness, Integer  #minutes
  property :duration, Integer  # minutes
  property :priority, Integer
  property :startTime, EpochTime
  property :category, Text
  property :done, Boolean, :default => false

  belongs_to :category, :required => false

  has n, :steps
  has n, :locations, :through => Resource

  def duration_confidence
    0.9
  end

  def self.scheduled_events
    all(:startTime.not => nil)
  end

  def scheduled_event?
    startTime != nil
  end

  def pretty_print
    puts "Task #{name}. Start Time: #{startTime}. Due #{due}. Priority #{priority}. Duration (estimate?): #{duration}"
  end

  def end_time_event
    if(scheduled_event?)
      startTime + 60 * duration
    end
  end

  def hours_between_now_and_due(now)
    (due - now)/60.0
  end

  def minutes_per_hour_need_to_work_from_now(now)
    duration/hours_between_now_and_due(now)
  end
end