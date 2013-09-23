class Controller
  
  def initialize
    @handlers = {}
  end

  def loop
    input = ""
    while true
      print "\n"
      print "> "
      input = gets.rstrip!
      @handlers.each do |pattern, block|
        if input.match(pattern)
          block.call(pattern.match(input))
        elsif input == "exit" || input == "quit"
          Kernel.exit(false)
        end
      end
    end
  end

  def match(regex, &block)
    @handlers[regex] = block
  end
end

@controller = Controller.new

require_relative 'main'