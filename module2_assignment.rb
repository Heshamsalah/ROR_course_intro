class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_count, :highest_wf_words

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency
    @highest_wf_words = []
    @myHash = Hash.new(0)
    @content.split.each do |word|
      @myHash[word.downcase] += 1
    end
    @myHash.each{|key,val| 
      if val == @myHash.values.max
        @highest_wf_words << key
        @highest_wf_count = val
      end
    }
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = analyzers
    @analyzers = []
  end

  def analyze_file
    @currentLineNum = 0
    File.foreach('test.txt') do |line|
      @currentLineNum += 1
      @analyzers << LineAnalyzer.new(line.chomp, @currentLineNum)
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_words_across_lines = []
    @highest_count_across_lines = 0
    @analyzers.sort!{|a,b| a.highest_wf_count <=> b.highest_wf_count}.reverse!
    @analyzers.each do |obj|
      if obj.highest_wf_count >= @highest_count_across_lines then
        @highest_count_across_lines = obj.highest_wf_count
      end
    end
    @highest_count_words_across_lines = @analyzers.select do |obj|
      obj.highest_wf_count == @highest_count_across_lines
    end
  end

  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @analyzers.each do |ob|
      puts "#{ob.highest_wf_words} (appears in line #{ob.line_number})"
    end
  end
end