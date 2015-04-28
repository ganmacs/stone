# Delegete Enumrator Class
# raise StopIteration if this reader has a next state

module Stone
  class LineNumberReader
    def initialize(filename)
      @filename = filename
    end

    def readline
      Line.new(*line).tap do |line|
        line.body = line.body.strip
      end
    end

    def has_next_line?
      !!peek
    rescue StopIteration
      false
    end

    private

    def line
      file.next
    end

    def peek
      file.peek
    end

    def file
      @file ||= File.new(@filename).each_line.with_index
    end
  end

  class Line
    attr_accessor :body, :no
    def initialize(body, no)
      @body = body
      @no = no
    end
  end
end
