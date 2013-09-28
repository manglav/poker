class Array

  def my_uniq
    [].tap do |uniq|
      each do |el|
        uniq << el unless uniq.include?(el)
      end
    end
  end

  def two_sum
    pairs = []
    size.times do |first|
      (first...size).each do |second|
        if self[first] + self[second] == 0
          pairs << [first, second]
          break
        end
      end
    end
    pairs
  end

  def my_tranpose
    transposed = Array.new(self[0].size) { Array.new(size) }
    size.times do |row|
      size.times do |col|
        transposed[col][row] = self[row][col]
      end
    end
    transposed
  end

end

class Hanoi

  attr_reader :tower1, :tower2, :tower3

  def initialize(size)
    @size = size
    @tower1 = (1..size).to_a.reverse
    @tower2 = []
    @tower3 = []
    @towers = {1 => @tower1, 2 => @tower2, 3 => @tower3}
  end

  def play
    until game_won?
      begin
        prompt_and_make_move
      rescue ArgumentError => e
        puts e.message
      end
    end
    puts "You won!"
  end

  def prompt_and_make_move
    puts "Tower 1: #{@tower1} Tower2: #{@tower2} Tower 3: #{@tower3}"
    puts "Please select a source tower."
    source = gets.chomp.to_i
    puts "Please select a target tower."
    target = gets.chomp.to_i
    move_disc(source, target)
  end

  def game_won?
    @tower2.size == @size || @tower3.size == @size
  end

  def move_disc(source, target)
    source_disk = @towers[source].last
    target_disk = @towers[target].last
    if !source_disk.nil? && (target_disk.nil? || target_disk > source_disk)
      @towers[target] << @towers[source].pop
    else
      raise ArgumentError.new "You can't make that move."
    end
  end

end