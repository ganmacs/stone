# Delegete Enumrator Class
# raise StopIteration if this reader has a next state

module Stone
  class LineNumberReader
    def initialize(filename)
      @filename = filename
    end

    def readline
      line_class.new(line[0].strip, line[0])
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

    # Line class has `Body` and `Number of Line`
    def line_class
      @line ||= Struct.new('Line', :body, :no)
    end

    def file
      @file ||= File.new(@filename).each_line.with_index
    end
  end
end
