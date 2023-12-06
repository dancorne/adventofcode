# frozen_string_literal: true

require 'matrix'

class Day3
  def initialize(input)
    @matrix = Matrix[*input.lines.map { |line| line.chomp.chars }]
  end

  def find_symbols
    symbol_coordinates = []
    @matrix.each_with_index do |e, row, col|
      symbol_coordinates << [row, col] unless e =~ /[\d.]/
    end
    symbol_coordinates
  end

  def find_part_numbers
    numbers = []
    @matrix.each_with_index do |e, _row, _col|
      skip if e =~ /[\D.]/
    end
  end
end
