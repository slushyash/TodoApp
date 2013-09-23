class Step
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :lazy => false
  property :description, Text, :lazy => false
  #property :due, EpochTime, :lazy => false
  property :looseness, Integer  #minutes
  property :duration, Integer  # minutes
  property :ordinal, Integer

  belongs_to :task

  def duration_confidence
    0.9
  end

  def self.scheduled_event
    false  
  end

  def due
    task.due
  end

  def scheduled_event?
    false
  end

  def priority
    task.priority
  end

  def category
    task.category
  end

  def to_s

  end
end