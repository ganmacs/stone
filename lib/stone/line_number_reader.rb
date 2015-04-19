module Stone
  class LineNumberReader
    def initialize(file_name)
      @file_name = file_name
      @line_no = 0
    end

    def readline
      line_class.new.tap do |line|
        line.no = @line_no
        line.body = next_line
        @line_no += 1
      end
    end

    private

    def next_line
      file.readline.strip
    rescue EOFError
      @file.close
      raise EOFError            # specific error
    end

    # Line class has `Number of Line` and `Body`
    def line_class
      @line ||= Struct.new('Line', :no, :body)
    end

    def file
      @file ||= File.new(@file_name)
    end
  end
end
