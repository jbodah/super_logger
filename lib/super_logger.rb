require "super_logger/version"
require "colorized_string"
require "logger"

class SuperLogger < Logger
  module Color
    def self.next
      color_loop.next
    end

    def self.color_loop
      @color_loop ||= Enumerator.new do |y|
        loop do
          colors.each { |c| y << c }
        end
      end
    end

    def self.colors
      @colors ||= begin
                    colors = ColorizedString.colors.shuffle
                    colors.delete(:default)
                    colors
                  end
    end
  end

  def initialize(*a, prefix: nil, use_color: true)
    super *a
    @color = SuperLogger::Color.next if use_color
    @prefix = prefix
  end

  %i(debug info warn error fatal unknown).each do |sym|
    define_method sym do |msg|
      msg = "[#{@prefix}] #{msg}" if @prefix
      msg = ColorizedString[msg].colorize(@color) if @color
      super msg
    end
  end
end
