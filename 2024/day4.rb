# frozen_string_literal: true

class Day4
  def initialize(input)
    @crossword = parse(input)
  end

  def parse(input)
    input.lines.map { |l| l.chomp.split('') }
  end

  def xmas_count(arr)
    arr.join('').scan(/XMAS/).size + arr.join('').scan(/SAMX/).size
  end

  def grid_height
    # Zero-indexed grid size, assuming square, for ranges
    @crossword.size - 1
  end

  def crossword_across
    @crossword
  end

  def crossword_down
    @crossword.transpose
  end

  def crossword_negative_diagonal
    grid_height.downto(-grid_height).map do |y|
      (0..grid_height).map do |x|
        @crossword[y + x][x] if (y + x).between?(0, grid_height) && x.between?(0, grid_height)
      end.compact
    end
  end

  def crossword_positive_diagonal
    (-grid_height..grid_height).map do |x|
      grid_height.downto(0).map do |y|
        @crossword[y][x + (grid_height - y)] if y.between?(0, grid_height) && (x + grid_height - y).between?(0, grid_height)
      end.compact
    end
  end

  def part1
    (crossword_across + crossword_down + crossword_negative_diagonal + crossword_positive_diagonal).map do |line|
      xmas_count(line)
    end.sum
  end

  def x_mas?(x, y)
    return false unless @crossword[y][x] == 'A' && x.between?(1, grid_height-1) && y.between?(1, grid_height-1)

    "#{@crossword[y - 1][x - 1]}#{@crossword[y][x]}#{@crossword[y + 1][x + 1]}".match?(/MAS|SAM/) &&
      "#{@crossword[y + 1][x - 1]}#{@crossword[y][x]}#{@crossword[y - 1][x + 1]}".match?(/MAS|SAM/)
  end

  def part2
    @crossword.map.with_index do |row, y|
      row.select.with_index do |_, x|
        x_mas?(x, y)
      end.size
    end.sum
  end
end

if __FILE__ == $PROGRAM_NAME
  input = DATA.read
  puts Day4.new(input).part1
  puts Day4.new(input).part2
end

__END__
MSSMSAMXSAMASMSMSAMMMMMMMXSXSMMSAMXSSSMXMSMMSMXMXSXMMSAMXMSSSSSSMSASMSSMSAMXMSMXSXSMMMXSSMAMXXMXSXMAMSAMXXMXAXXSASAMXMMAMMSSXSXMMXSMMXSXXMXX
AAMAMXAMMAMSAAAAMAMAAAAMMAMMSAAXAAMAAAMAXAMAAAAAASAMXSXMASMAXMAAMMASMAAAMAMAMAAMSAXAAXMXAXMASXSAMASAMXSSMMSSSMASAAAXMASMMAAMMMAMSMSASMSXAMAM
MMSSXSSSSSMAMSMSMMMXXSSSMXSAMMMMAXMMAMSXSSSXMSMMXSAMXMAMXXMMMMSMMXAXMXMSMASASMSMXASMMXMSAMMAMXMASAMXSMXMXAAAAXMXASMMMMSAMMXXAMAMAASAMAXSAMXA
XXAXAXAAAMXMXXAXAMSSMMXAMAMASASAMXMXAXAAAAAMXAMSASXMASMMMMAMAXAXMMMSSXMXMXSXSAMXXAMMAXMAMMSSSXSAMMXXAMXAASMXMMXMMMMASXSAMXSSSSSSMXMAMSMSMAMX
XXMMMMMMMMMXMMMMSMAAAASAMXSXMAXMAXMSSSMMMMMMSASMMXAXASAAXXSSSXSASXMAXAMMSMMAMAMASXMXSXXAXAXAAXMASXSSSSMSMXSSXAAXAASAMXSXMMAAAAMAXSXXXAAXAAXA
SMXSXXXAAAAAXSMAMMSXMMSAMXAMMMMXAAMAMAXMXMAMSXMAMSSMASXMSMXAXAMSMAMASXMAXAXMMAMXMXASAMSSMMMMMMXXMAAAAMAXXAMXXSMSSMMXSXMAXAMMMMMMMMAXSSXMSASM
SASMMAASXSSMAAMXMAXSXMSAMAXMASXMSSMASXMAMSMXSASXMAMMAXAXSXMAMSMASXMXMMMMSXMMSSSSSSMMAXAXAASMASXSMMMMMMMMMSSMMAXAXXSMAAXAMSMMXMXXAMXMAMMMAAAX
XXAAMXMMAMMMSXMXMASAMXSASMMSASXMAXMAMMASAMMASAMXMAXMMSMXMASXMASMMXMMMMAAXMMXAXMAAAMMXMAXMMAXAMXMAXXASAMXAMAMSAMXSXAXSSMXMXASXMMSMMXMASAMMMMX
MSSXMSXMASXMMASXMMXASASXMAXMXMAMXSMXMSAMASXXMMMXMSXSMXXASAMSSXMMSAMAAMMSMMXMASMMXMMMAMXMSAMMMSMMASMMSAXAXSAMMASAMMMMXXAMSMMMAAAAAMXMASASXXXX
XAAXSXXSAMAXXAMXASXMMAXXMSMMMSMMAXMAMMAMAMXAAMMSAXAMMMSMXMSMXAMASMSSSSSXMMAMSMXMSXMSAMXAMMXMXAMXAAAASMMMMSAMXAMMSAXSAMXMAAASMMMSSMAMASMMMXMM
MAXMSAMMMSMMMSMSAMAMMMMXMASAAAXXSAMXMMSMSSSSSMMSAMXMAAAAXSAMSMMASAAAXMAXMAMMMMAMAXMMSMMAASAMMXMMSSMMMXAAAMXSAMXXSXSAMXSSSSMSMSAAXMXMAXMAXASX
AMSAMXMAMAMAXAAMXSXMAAXMMASMSSSMMXSXXSXAAAXXAAAXASASMMSSMMAMXXMASMMSMMAMSAMAAXSSMMSAAXMMMMASAMXAAAAMXSSXXXAXAMMMMMMAAAXMAMAMAMMSSMSSXMSMSASM
MSAMSMSMSASXSMXMASAMSMSAMMSAAAAAAASMMXAMMSMSSMMMXMAXAXXMAMSMMSMMXAMXMAMXSASMSSMAXAMMSSMAXSAMXAMMSSMMMXMASMMMAXSAAAMAMSMSSMSMAMMAAAAAAMAAMAMX
XAAXXASAMMSAAMXMASAMASMXMAMMMSMMMXSASASMSXAAMAMXSMAMSAMXSAAAXAXXXXMSSSSMSAMMMAMAMXSAAAXXMMAMXSSMMAMMAMXAMAMMSXSSSSSMAMAXMAMXMXSMMMMSSMMSMAMM
MMAMMMMAMAMXSMMMXSAMXSMXMAXMAMXXMXSAMAXXXMMMMSMAXAXAMASAXMSMMSSMSSXAAAXXMAMXSAMXAXMMXSMSMXSMMXAXSAMMSAMSSMSAXAMAMAAAAMSMMSMMSASXXMAMAMXAMAXM
XMMMAAAAMASXXAXSMMASAMXXSMMMAXMXSMMAMXMAASXMAXMMMMMASXMASAXXMASMAMMMSMMMSAMMXMSSSXXSSXMXMAXAXSMMSXMXMAXMAXMASMMAMSMMMSMASAMAMASXAMXSAMXAMXSM
XMASMMSSSXSAMXMXAAXMXSAXAMASMXSASASAMMMSMXAMAXAXAXXASASAMXMMMMSMAMAXAXAXSASMAAXAXAXSAXSAMXSMMMSMXMSSMSSSSMMAMASXXMXMMAXMMASAMSMMXSMSASMXSMAX
SSMSAMXAMXMXMASMMMMMXSXSMSASAAMASAMXMXAMXSMMASXMMSMASAMXAMXSAXXMASXSSMMXMMAXXMMAMXMMAMSMSXAAAAAXAAMAAAAXMAMXSAMXMXAXMMXSSMMMMMXMASXMAXAAAAXS
XAXMAMMASAAMSMXAAMAXMXMAMMXMMSMMMAMMSMASAXAAXXMAAAMMMAMXXMSMXSAMXMAAXAXAMMSXSAMSMXXXMMSAMXMXMSSSXSMMMMSMSSMMMMSASXMMASMMAXXAAMAMASAMXMMXSSMA
MSMMAMXAMXMXAMSMMMMSMSSMXSSMXMASXXMAXMAMASAMSMSMMMXAMSMAMSAMMSXSMSMMMSMAXAXAXMXAXMXMXAXAAXXXMXMXAMMSSMAASMMAAASMSAXSAAASXMSMXXAMAXMAXAMAMXAM
AAXXSAMXSASXXMAMMSXAMAAXMAAXMXAAMMMSSMXSASAXAXAMXMMMMAMSXSASAXASAAXXAXSSMAMAMXSSSMAXMSSSMMMMSAMMSMAAASMSMSMMMXSMSAMXMSMMMMAXMSMMMMXSSSMASMSM
SASXMASASASAXXASAMSSMSSMMXSMMMSMMAAMAMAMASMSSXMSSMASXMSXAMXMMMSMSMSMMMAXMXMAMXXXAMAMMMAAMSMAMAMAXMMSMMXMXAXSSMSAMMMMMMMAMSAXXASAMXMMAASAXAAS
MASXMASAMXMAMSAMXMAXMAMXSAMMSAXASMXSAMXMXMAAAASAMAAXAMMMXMMMXMMAAXXAMAMXMASASXMSMMSSMAXMMMMXSSMSSXXXAXMMXXXMAXMMMSSXAXSAMMXXSASMSAMMSMMXXSAS
MAMXMXXAXXMAMAXAMMXSSSSMMASAMSSMMAASXSXMXMMMSMMASMMSSMAASXSMAXMSMSMMMAXAMASMSAMXAAAAXXMMXSMAAAAAAXMSXMASMSAXSMMMMAXXXMSAXSAMMXMASMSMMXSSXMAS
MMMMSMSSMMXMSMMMMMMMMAMASAMAMAXXMMMMASMXAXMXMAMXMAMXXSMXMAASASMMAMAASXXSAMXASXMMMMSSMSAMAAMMSMMMSMMAMASXAXXAMXXAMXSXSAMAMMAXSAMXMXXMMAMXXMXM
XXMAAAAASXXMAXAAAAAAMAMAMXSXMSSSXSXMSMMSSMSAMXMMMSASAMXMMMMMXAAMMMMMSAAMXSMMMMSXAXMXAXAMSSXMXXXMAXXAXSXXMASMXMXASAMXSAMSXSMMXXSAAXSAMASXXMAS
XSXSMMMSXXASMSXSMSSXSAMAXMXMMMAAXSAMAAAAXMMAMSMMAXAAXMAXSSSSSSXXXAXAMXMMSXMXAAMXMMMMSMAXXXMXMMMSMXSMSXXASAMMAMASMXMAMMMMAAXXMASASMSMSASMASAM
MAMMAMSXMSAMXXAXAAAAAXMSMMAXSMMMMSAMSMMSSSMAAAMSMMXMXMXSAAAMAMXSSMSMSMASMAMSMMSASAMXAMXMMMMAAAAAMXXSAXSMMMMSAMMAAXSMMAAMMMAXMXMXMASXMAXXAMAS
AMASAMMMMSAMASAMMMMMMMXMASXMXXAAAMAMXAMAAASMSXMXXXAMMASMMSSMMMSXSAAAMXXAXAMAMXSASAXSAXXMAASXSMSSMAMAMMXXAMAMMSXMXMSASXMXSMMXXASMSMMAMXMMMSSM
XXMAXSAAASAMXAAMXXMAAXASAMASXMMMSSSMSMMMSMXMXMMMXXXXAMXXAXAXXMXAMSMSMMSMSXXASMMMMXMMAMXSSXSXXMAXMAXMXAMXMMAMMAMXMASAMXSAAASMSASMSAMXMXMAMXXX
SSSMASXSMSMMSMASXXXXAXXMASAMAXXAMXMXXXSXXXMMMAAXMAMASMMMMSMMMMMAMAXAXAXXAMXMXXAAMASXXSAMXASASASMSMSXXSMASMMMMAMMAMMMMAMMSMAAMASASAMASAMMXMXM
SAAAASAMAXXAMXAXMASMAMAMAMMSAMASMMSSMAMASMMASXMXAAAXXAAAXAAASMMMSXSSMSSMMMASMSMMSASAMMASMMMAMXMAXMAXMXMAXAAXXAMXXMAXMAMMMXMXMAMMMASXMAMSASMA
MSMMMSAMAMMSSMMSAMAAXAAMMSAMAMXMAXAAMMMXMAXAMAAXSXSAMSSMMMMMXAAASMXAAAXAXMXSAAAXMASAXSXMAMMMMSMXMXMAXAMSSMMXSAMSASXMASAMXASXMASMSAMMMAMSAMAS
AASAAMMMXMAMAMAAMSXSMSMSMMASXMSSXMSMSASASXMSSMMMMAAAXAXXSSSSSSMMSASMMMSXMASMMMMMMXSXMAXMAMXMXMAMMMSSMXXAAXAXMAMXAMASAMXAXSMXSAXXAAASXSAMXMSM
SMSMMSASXMASXMMMXXAMAAXMXSAMXMAAXXMASMSAMMSMAAMAXMSAMXSXSAAAMXAAXMASAAAAXXMASMMSMAXAAMSSMAMMAAXMAMXXXMASXMSSMSMXXSAMAMXSXMAXMASAMXXAAMMXAMAM
AXXAMMAAMSXMAXXXSSSSSXXMAMXAAXSMMXMASMMXMMAMSMMSMXMAAXAMMMMMMMXMXXAXMSMMMSAMXAASMSMSSXAAMSASXSSSSSMAXMAXAAXXAXAXXMMXXMAMMMSMMASXAMMMSMMSMSAS
MMMSMMAMXMASXMSXAAAAXXMMSSMMAMXXMXMMMMAAXXAXAAXAAAMAMMXSAMXMASMSSMSMMMASAXXAMAMSAAAXMMSXMMMAMXXAASMMSXAXMSMMXMXMXMAMSMXSAXMAXAXXSXAAXAXSXSXS
XSAMAXXXAMAMAAAMMMMMMASAMAXSSXSAMXXMAMSSMMXSAMXMXSAMXMASASXXMASAXAAXASAMSMSXMSXMMMSMSAXASMSMMMMMMMXASMXSAXMSASMSAAAAXAMMMSSMMXSMMXMSSMMMMMMS
XMAXAMXSXMXSMSMMAAAAXMMAXAMAMXMAMAASXMXAXAMMMXAXAMXSMMASAMMXXMMSMSMSXMAMXXSAAMAMSXAAMASMMAAXMXAXAXMAXAMMAMSAMXASMSMSMXXAAMAAMSAMXXSAMXAAAAAX
MMSMASXMMMAMXMASXMSSMXSSMSXMAMSAMXXAASMMMXSAASMMXXMAXMASXAMSXSAXMMASAMXMMASXMXAMXSMSMAMMMSMSSSMXMSASMSMMAMXMXMXMXXXMASMASXSMMASAMMMAMSSSSSSM
MAXSAXAXAMAMASMMSAXXAMAMAMMXSMSASXMXAMAAAASXMASMXSAMXMAXXAAXXMASASASMMMAMMMMMSSXMASAMXSXAAXAAAXSXXAXAXMSMSMXMSAXSXAMMASXMAMXSMMMSASAMXMAAAAA
MAMMXSMMSSSSMSAAXMAMMMAMAMXAMXSAMMSASMSMMMSMMASXAXSXSMSXSMSMMMAXAMAMAASAMXMAAAXSAMMXSAMXMXMMSMMAAMSMAMAAMSAMAMMSMMMXMAMMMSMMXAAAXMSAMAMMMMMS
MMSMAMMAMMMAMXMMMXAMXSASAXMASXMXMAAAXAXASXSXMASMMMMMXXAXXAXMAXXMMMMMSMSASASMSSSSXXMAMASAMSSMAAXMXAAMXXSMMXSMXMXAAXMAMASAAAXASMMMXXXMXSMXAAXX
MSAXAMAMMAXAMMMMMSASASASASMMMXSXMSMSMMSXMASAMASASAMASMMAMAMSSSMMXAAMAMXASASMAMMMSMMASXMXSAAXMXMXMSASMMMSAAXMSMSSSMXASMMMSSXMASAMMMXMAXXSXSSM
MSASXSMSSSSMSAAMASXMASAXXAAXASAMMAXXAASXSMSAMASXMAXAXAXMASXMAAXMAMMSXXMAMMMMASASMMSASAAXMMSMMSXXXMXAAAAAMMMAAAXAAASXXMXMAMAXAMXSAAMMASASMMAX
MMAMXMAXAXMASXSMASAMMMAMMXAMXAMXSAMMXMMASASAMXSASXMSMSMXAAAMMMMMXSXMMSMMMXSSMSXSAAMAMMMMMAXAAAASXMXSSMSXMSXMMXMAMXMMXSAXMSMMMSASASMXXMAMXSAM
MMAMXMXMSMMAMXXMMSXSAMXXAXMAMXXAMMSMMAMAMMSAMXSAMXAAAMXMMSXMMSAXAMAAAXAASAAAMMMSMMSMSMXAMSSMMMSMASAMXMXXAMXMSXSAMXMAASXMMAMMMSMXMAXMXXAXMMSS
ASMMXMMMMSMXXSXMASMMXMXMMXMAMSMMSAAMSSMAXXXXMAMAMMMMSMASAMAXAXMMMSSMSSSMSMSAMAAMAMAAAAMSMMAMXXAMXMMMAMAMSAMASAMXSAMMXSAMMASAAMXMXMAXMSMSAAAS
XMXSAAXXAXXAMMAMASASAMXMAASAMXMSAMXMAASXSSMAMASMMMAMMMMMASMMMSMMMAXMAMAAXMMASMSSMMMMMSMXASXMMMSSMXXMAMXMXAAAMAMAXXMAMSAXSASMMXAXXSAAXAMXMMSS
MAAMMMMMMSMXXMAMXMAMSAAMMMXASAMSAMXMMMXMAXSXSAMXAMAMMAXMMMAMAAMAMMMMASMMMXSAMAMAXXXXXMASAMXAXAXAMSXSASMSSXMASMMSXMMAMMAMMAMASASMXMSXMASXXMAM
MMMXMAAAMXMAASMMSMXMXSSSSMSXMAXSAMSSSMMXMMSXMASXMSXSMMMSMMAMSSSSXSASXSMMSAMAMMSAMSAASMMMSSXMMXSAMMASASMAMASMMMAAASMSMMXMMMMMMAMAXMXXSAMAMMMS
XXMASMSXSAMMXAXAAMXSXAXAAMSASXMSAMAAXAASXAMXMAMAAAXSMXAAASXMMMAAAXAXXMAXMAMAMXMMXXXMSAXMASAMXMSAMMAMMMMASAMAAMMMSMAXXXMAAXMXMXMXXXAAMSMMAAMA
XMMMXAAAMMMXMXMSXSAAMXMMMMSAMXXSAMMSMMSAMMSMMASMMMXMAMSSMAMSSMMMSMSMSSSMSAMASXAMSSMXSMMMAXMSMASAMMXSAASXMMSMMMMXMMXMSMASMXSAMMSMMMSSMMSASMSA
MAAMMSMMMMASMAAMAMMSMSMSXXMAMMMMSMAMASAMXMAXSASMXSMMMMAAMMAAAASAMXAAXAAAMXXAMMXMAAAAMMMMMSAAXMXMXMAXMMSMSMSAMXSMMMAMAXMXAAMASAAAAMAXAAXMXMAM
SSXMAAXSXXAASMSMAMSAXXAAXXXXAXXAAMASXMMXSMSXMASMASMMXMAMMXMSSMMASXMSMSSMSMSSSSMXMMXMSAAAMAMASMMMAMMXSAMXAAMXMMXASMMSSSMMMMSSMXSSSMASMMMXMXAM
MASMXSMSAMMXXMMMSMSMAMAMSSMSMSMSMSXSMXSAMAXXMSMMAXASMMMMSMMXAASMMMXXAMAAAAAAAAASXSAMXMXMXAMXAAASMSASMAMSMSMAXSMMMAXAMAAXXXXXAAMAMMAMAMMSSMSA
MAMMAMMMAXSASMSAXAXXXSAMXAAAAAAMASXMAAAAMAMAXXAMMSSMMAAAAAMSMMXMAMAMXMMSMSMMMMXXAXMSSSSMXSXSXSMSASXSMSMXSAMXSXAMSMMMXSAMXSMMMMMMMMMSMMAAMAAM
MASMMSASMMAAAXMASASMXSASMMSMSMSMAMAMSMXSMMXXMSSMMXMASMMSMMXAMSMSSMMSAMXMAMXMXSSMMXSAMXAAAMMMAXAMAMASAMSMXMMMMXMMAXXAXXSMMAMXMASASAMAXMMSSSMX
MASAAMXMMAMAMXMXMAMXXSMMMXMAMMAMASAMXXAMMMSAMAXXMMXAMMAMAMMAMSAAXASXMXMMXMXMAMXAMXMASXMMAXAMAMMMXMAMAXMMASAAXAMMMMMSSMAMSASMSASMSAXAXXAMMXXS
MAMXMXSAMSXSXXXAMXMXXMMXXXMAMSXSASMMMMXSAASAMAMMMMSMMMAMMMSAMMMMSMMSSXSAAMAMASMSMXSAMXXMASMMSSXMSMSSMMXSASMMMASMAMAMAMMMSASAMAMXXXMSMMXSAMMM
MMSMXXSASAAXMMSMSMMMSAASXXMXMAXMMXXAAMMMMMMXMASAAAAAAMASMAMAMXMASAMAMMMSMSASAXMAXMMASXXMAXXAXMASAAAMAAMMASAMSAMXAMASMMXXMAMMMSMSXMXMAMXXMAAX
SAAXMASXMMMMMAAAAASASXMSMXSAMSSSMAXSXMASXMSSSMSMSSSXMSASMSMSMXSXSMMASAAAXMAMXMMXMXSAMXMMSMMMMXMAMXMSMMAMXMAMMASXXSAXMMXSMMMXAMAMMXAXAXMASMSX
MSSXSMMASAAAMSSSMSMASMMXXASXSAAAMMXMMSMSAAAAAASAMXMMAMXXMXAXXAMMSASXSMMSMMAMMMSAMAMMSMMAMAAXAMMXXMAXAXSAMMAMMXMXMMMMSXAXAMXMASAMAMSSSMMMMMMM
XAXXSASAMSSMXAMXMAMXMAAAMXSSMMSMXSAMXMASMMMMMMMXMASMSMSMAMAMMASASXMAXAAAASAMAMMAMSXMAAMASXMMSSXSASXMAXXAXSMSMAMXMASAMMSSMMXSASAMMSAAMXMAAAAA
MSMMSAMXXAMXMMSAMXSXSMMXSAMASXXXAMASMMXMSASMSMSXMAMXXAAMXMAMXXMXSXMASMMSMMAMMMXAXXMSSSMAMAAXAAXSAMXXSAMMMSAAXXSASAMAMXMAAAAMMMMMXSMMMASMSMSS
AAAMXXSSMASAMXMMSMMXMSMAMASAMMXMMSXMASAAXXSAMASAMMSSMSMSXMXMSMMMXXMXXMXXMSXMASXMMXAXAMMSSSMMMSMMAMXMMXMAAMSAMXMASXSSMASXMMSSSSXXAMXXSXXXAAAX
SXSMSXMASAMMAXMMAAMAMAMASAMMAMMXXSASXSMSMMMMMAMAAAAMAAXXXXASAAXMAXXMASXSXMAMASASMMMMAMAAMXMXXAXSAMMXMAAMXXMXXXXAMXAASMSMXSAAAAAASAMMSXMSMMMS
MSMXMASXMXXXMSAXSXSASASXMXSSMXAMMSASAXMAMMAAMAMXMMMSSMSSMSXSXSAMSXMAMXMMASAMXSAASAXSAMXSXSXSSMXSASXMMMSMMXXMAMXMMAXAMXXMSMMXMMMMMASASAXMASMS
SAXMXAMXMSXSASMAMASXSASAMXMAXMXXAMMMMMSAXMXMSMSSMSXAXXAMAAAMAXAMMAMSMSASAMAMXMMMASASASXMAMMMASAXMSASAAXMMSSMSMSMASMMMSAXMASXSXMXSAMASAMMMSAM
MMMSMAXSAMAMAMXAMAMMMMMMXSSSMSMMMMAAAAMASMXXAAAAAAMMSMSXSMSMSMSXMAMMAMXMXSAMAMAXMMXMMMMMAMASAMMMMSAMMMMAAMXAAAAXAMAAAXXXSMMAMAMAMAMXMXMAMSAX
XXASXSMSAMXMMMSSMAMAAAAXMMAAAAAMSMSXSSMXMAASMSMMMMSAMAXAXAAAMAMMSXSMAMAXMSASMSSSXSAXAAXXAMXMMMMAMMXMAMSMMSMMMSMSXSSMMXSMASMASAMASXMAMAXAMSSM
MMMSAMAMAMXMXAAAMXSSXSMMXMMMSMXMMAXXMXMAMXMMAMXMXAXAMSMSMAMXMAMAXMXMAMMSASAMXAAXAXAMSXSSSSXSAASXXMXSXMAAMXMAXMAMXAMAMAAXXMSAXMSXMXSAMAXSMMXM
ASMSMMSSSMASMMSXSXAAAMMSMMSAXMMMMAMAMAXXMMXXXSAMMXSXMXAMXXMASXSMMAMMMAAMXSAXMASMSMSMXAAAAXAMMXXMASAMXXXSMASMSMMMAMSAMSXMSMMMSMXASMSAMSMMAMSS
SMAMXSXAMMASAXAASMMMXMAAAMMAMXAXMASXMMXSMMSSMMAMMMMAMMSMMMSXSXMASMSAMMXSAMXSXAAXMAMAMMMMMMMMMSMSAMASAMSXMXXMAAAXMXMMMMAMXAASAXXAXAMMMMASXMAS
MMAAXAMMMXMSMMMSMAMSMMSMSSMAMSSMMXXMASAAAAAASMXMAAAAXAAXAXAMXXMAAASMSSMMASMMMMSMMMMAMAXAMXMAXAMMASXMASMAXMXSSMMMXSMXASAMMSMSASMAMXMXAXMMSMXS
XSXSMMMAAAXMMSSMMSMAXXAXXAMXXAXAXMAMAMSSMMMAMXMSSXXSMSMSSXMMMXMMMMMAAXASASAXAXAXAMMXSMXMSSSSSMXMAMXXSAMMMMAMAAXXAXAMXMAMXXAMAMXXSAMMMSAAMMAM
MAMXAXSMSXSAAXAXAMSMMMMSAMXSMASMMSAMSXMXXXMSMXMMASXXMXXAMSMAMASMXMMMMXMMASMMSSMSASXXMAXMAMMXAXMXSSMMXXXMAMASXMMMSSSMSSSMAMAMAXMAXAMASAMXMMXS
XMASMMMAAAMMMSAMMXSXMXAAMXAAMXMMASAXMAMMMXMMASAMAMMAAMMASASXSASMAAXASMSMXMXAAAXMAMMAMXSMASMMSMSAMAASXSXSAMXMXAAXMAAAMAMMMSSMMXAMXSMXXXAAXXAA
MMMXMSMMMSMAXXAXMAMAMMMSSMSMSMSMAMXMSSMMMAAMAMMMMSSMMXSMSXSXMAMXASXXMAMXMXMMMXXMAMSXMAXXAMXAAAMMSMMMAMASMSSMSMMSMMMMMMMAAXAAMXSMAXXSMASMSMSS
MASAMSAMXAMSMSAMMMSAMASAXAAXMAXMSSMMAMAASMMMSMXAAXXXMXAASAMXMAMASMMSMAMSAMMSMSAXSAMXMXSMMMXSMSMXSAMMXMAMXAAXMXMXXMAAXXMMXSXMMSMMMSAAMAXAAAAX
SAXAXSMMSAMXAMAXMASASXSXMMMSMSMXMAXSAMMMXAAAMASMSMSAMSSMMMXXMMMMXAASMMMXSXAAASMMMAMXSAMXMAMXXXAASAMAAMXSMSMMMSMAMMSMSMMSASXMXSAAXMXMSMMXMMMM
MMXSMMXMAMMMSMSMMASXMXMASMMMAAAAXXMMASMXSXMMSAXXAASXXAAAASMSXSAXSMMSASXMMMXMMMAMSSMMXXMASMXSAMXXSAMMMSAMMXAXAAMASAMAXAXMASASMSSMSAAMAXSSSMSX
XAAXAMASXMAAAXMAMASAAXMAMAASMSSSSXXSAMXMXAXMMMMSSMMXMSSMMSAAASMXMMSXMMAAXAMMSASXAAAMAMXMAXAXMMSAMMSAAXMSASAMSMSMSAXSSSSMAMAXAXXXSMMSAASAAAMX
MMMSASASAMMSSXSAMXSMXSMSMSMXAXAAXXMMMSXMSSMAAAMXMAMAMMMXMMMMMMXSXXAMSXSMMMMXMAMMXXMMAMAMAMAMXXMASASMSMSMMMXAXMAXMXMXXAAMAXMMSMMMMAXMMMMSMMMA
MSASMMMXMXAAMXSAXXXXAMAMAXAMSMMMMSASASAMAXMSMSXAXASXSMSXMASMXMAMXMSASAXAAMMAMAMXSSXSASASMXASMMSMMASAXXSAXXSSSSSSSXSXMXMAMAMXXAAAMXSMMXXMSMXS
SMMMMMMMSMMSXMSXMSAMMSAMSMXMXAAAASAMASMMMSAMXMXSMMSMAXSASASASMAXXXMAMAMMMASMSXAAASASXXMAXMMMMASAMXMMMASMMXXAMAMXAAAMAAXAMSAMMXSSSMXMAXSAMXAX
SAMSMSAAXAAMAMXAXSAMXMXSXASXXMMXXMAMAMAAASXSASAMAMXMAMSAMXSAXSXMSAMAMAMASXSAMXMXMMMMMMMMSMSAMMSAMMASMXMAXXXMMMMMMMMASASXMXAMXAMAMAXXAMMXMMSS
SAMAASMMSMASAMSSMMXSMMMAMMMMXSSSXSAMXSMMMSASXMASMSSXMAMAMAMXMMMMMXSASXMAXXXAMXMMXAAAAXAMMAMXSAXASXAXMASXMMMXXASMAMXMMMMAMMAMMXMAMSMMMSMAXAMA
SAMMXMAMXMAMAMAXAMAXAXMAAAAXSAAMASXSMMMMAMMMMMMMXAXAXMAMMXSSMSAAAXSASXMSSSSMMXMAXXXSSSMSMMMSMMSAMMXXMMMMAAMMSMMSAXSMSASAMSSMMAMAMAXAAAMAMSSM
XAMSASAMXMASASMSXMASXMXMXSXSMMAMAMXXAAAMAMSASAAAXMSMMSSMXXMAAMSMSXMAMXAXAMXMAMXSSSMAXAAAMXXXAMMAMMMMXAAMMSAAASMMMSXASASAXXMAXSSMSXSMSSMMXMAX
SSMSASMMMXMAAXXSAMXSAAMSMXXXAASMSSXSXMSSSXSASMMXAXAMXAAMXAMMMMMXXXMAMMAMXMMMAMXAAAAMMMSMSSMMXMSAAASXSSMSAMMSMSMMMAMMMAMXMXXSMAAAAXMAXMAXXSAM
XAAMAMMSSMSMXMAMSAMXMSAAASMSXMXAXXXSAMXAXMMXMAXSMXSSMSSMMASXAXXAMMSMXMAMMAASASXMSMMXAXAAXMASAMXSMAAAAAAMMMMXASMSMMAXMAMASXAMMXMMMMXMSSMMXMAS
SMMMMMXXAAXXAMMSASAMXMXMSMAAMMMMMSAMXSMMMXMMMMMASMMXXMAMXAMXMMMXMAAMASASMSMMASMXMAXSSSSXMSAMASXXSSMMMMMMMAAMXMAAAXSXSSSMSMXSAMXMAAAXMAMSMMAM
SAMXMSXSMMMSXXSAMXXXXMXXXAXXAXAMAMMSMAMXSAASAMXAMMSMXSASXXMASAAXMSMXAMAMAMXMMMMAMSMAMMXAXMMSAMXAMMAXXXSSSMSMSMSMSXXMMASXXAMXMXMSMSXXSAMASXAS
SAMSSSMXXAXAXMXMASXMSMASMMMSSSMSXMAAMXXAMMSMAXMASXAAAMASMXAXXXSXMASMXSAMAMXMAAMAMMAXSASXMAXMMSMXMSMXSAAAMMMMMAXAXMSASAMXMMMMAAXXAMXXMASASXMM
SMMXAMMMMMXSXSAXXXAAAXMXAAXAAMXAMMSMSMMXSXMXAMXSMMMSMMXMAAMMSAXXSAMXAAXSXSSSSSSXSAXXMASXXXMAXMASAAMAMMMMMASAMSMAMASXMASMMMAASXSSSXSMSXMASAMX
SMMSXMASASMMASMSMSMSMSMSSMMMMMMSSMAAAAMAMAMMMSXAAXXMAMMMXXAAMXAAMASMMMMSMMAAMAAMXMAMMMMAMSSSMSAMAAMASAAXSAXAMAMXMXMAMSMMAAMMXXAMXAMXAXXASMMA
XAASASXMMMAMXMAAXAAXXAXAMXXMASXMAXXSSSMASAMAAMMMMMXSAMMMAMMXSMMMSXMAMAAXAXMMMMMMSSMSAMMAMMAXAMXSXXSASXSMMMSSMMMMMMMMXXASMXSAXMMMMSMMMMSAMAAA
SMMSAMAMSMXMAMXMXMAMXMASMSMSAMASMMMMMMMMXXSMXSAMMSAXASAXSMXAAXXXXAMAMMSSSMAASAAXMAXMAMSSXMAMSMMXMASAXXMASAAXAXMAAAXXMSAMAXMASAXMXMASAAMAMSMS
AAAMAMSMSAASXSAAMXSXXMAMAMMMMSMSASASASMXSASXAMAASMSSMMMXMAASMMSSMMMSXMMAMASMSSSSMMMSSMMXAMAMAAXXMXMXMXXAMMXXXMSSSSSXMMMMAMXSXXXMAXMMMXXAMAAX
SMMSAMAAXSMMASMSMAXASXAMAMXAXAASASASASAAMAMMSSMMMAXXAASXMMMXAMMMASAXAMMXMAMXXXXMMXAAMAXMMSASXSMMMAMXSSMSMSASAXAAXXXMSAMSMSMMAMMMSMAMAMSSSMSM
AAXSXSMMMAMXMXAMMXMASXXSSXXASMMMAMMMMMMMMAMAXXMAMSMXMASXAXSSXMASAMAXAMSAMXSXMXMSXMXSSSMSAAMSAMAMSMSAXAAAAASAAMMMMMXAMAXAAAAMSMAAAXAMMMAMAXAA
MSMMXMXXMXMAMMMMMAMMMMMAMAAXMMXMXMXAXXXMSMMMSAMXSAAXMSXXXMMAMSASAMASXMSASAAMMAMASMMMAMXMMSSMAMSMAAMXMMMMSMAMAXAAAAASXMMMSMXMXSMSSMXSSMXXMMMS
XXASASXMXAMMXAAMMASAAMMAMXMAAXXSAMSASMSAMAXMMAMXSASMXMAMXXMSMMAXXMASMASAMMSMXAXXSMAMAMMSMMAXXMMMXSASXSAMMMMXMSSSMSMMXASXXMSMXMMAXMMXMXMASXXM
MSAXAXAXMSMAXSSMSASMSXSSSMMSMMMSAMXMXMXASMMSMMSMSMMMXMXMAMMAAMAMXAMXMAMAMXAMSXSAMASMSMMAMMAMXXXMXAAMMSASAAXAMAMXMMMSSXMASAAMAAMMSMSASASAMAAM
MMMMSMMMAMMSMAAAMXSXMXXMAXAXAAASMMAXMSSXMXAMSAAASAAAAXMSAMSAMMAXXAMXMMSSMMMXAMMAMAMMAAXAXSMSXSMSXMAMASXMXSSXASXSXSAAAAMAMMMSSSMXAXMAMAMMMSAM
MSMAMAASMSAMMMMXMASXMAMXMMMSSMXSASXMAMMMAMSMXSMMMSMSMSAXSMXAXSASXMSAAAAAMMXMASAMXASXMSMAXSAXAXAAMXXMAXXMAMMMMMAAAMMMSMMXSSXXAAMMXXMSMSMSXMAS
AAMMSMXSXMAMXMASMMXXAAXSXMXAAMASXMAASAAAMAMXMASAXXMAAMMMMXMMMMASAAXXMMSSMMXSMMMMSMXXAMXSAMXMSMSMSSSMSXMMAXAAXMMMMMXXMAXAMMXMSMMMSMXMAMAAASMM
SMXXAAAMAXAMXXAXAAXMMXSXAMMSSMASMAAMASXSXXAMSASXSXMMMMASXAMAAMMMMXMXXMAMAXAXXAAXAMMMSMAMXAAXAAAAXXAMMASXSSSSSXXAXXMMSSMSXSXMASAAXMAMAMXMAMXA
AAASMSXMAMSAMXXMAMXAXMMMMMXAXMMXAXMXXMMMMXAXMASAAMXMMMASXXMASXSXXMAMAMAXMMMSSSSSMSAAMXAMSSXMMSMSMSMMSXMAMXMAXMSXSXMAXMXMAMXSASMSAMMSMMAXMMSX
MAMXAXMASXXASASXSMSSXMAAXAMXXSAMSXMAMMAAMMSMMXMXMASMSMASASXAMASMASASXSMSAAXXAAXXAMMMMMAMAMXAMAMAAAMASASXSAMAMMMAMAMMXSAMXMMMASXXAMAAAXMSAAMA
SSSMSMSAMAXAMASXXAAAAMSSMMSMXMMSMAXSMSMMSAAXXXAMXMXAAMXMAMMXMAMSXMAXMAAXMMSMMSMSSMSASMXMASMXMASMSMMASASAMAMMMAMXMAXSMXAXXMAXAMASXMSMXMAMMMSX
AAAAXAMXSMMSMMMMMMMSXMMMMMAAAMXAMMMXAAAXMMSMMMSMXMMSMSASAXXXMXMXXMSSMMMXSXAMAAAMAASASXAMSMMMSXMXAXMMSAMMMAMXSXSSXSAAASXMSMXMASMXMAMASMSMXMAA
MSMMMMMXMAMMAAXAAMXXAXAAASMXMSSMMSASXSSMMSAAMAAAASAXXXXMXSASXSMXXAAAXXMASXMMXSSSMMMXMASXAAAXAMSMMMSAMMMXSASMSMAXAMSMMMSXAAASAMXMMAMMSAAXSMSM
XMXXMAMXXXSXSMSSXMASMXMSMSXXSXXAAAMAAAMAXSXSMSMMXMASMSXXAAAXMASAMMSSMMMMMXXMAXXAXSXAASXSMSMSAMXAAAMASASMSASAXMAMXMASAAXSMSMMAMXASXSAMXMMMAAX
MSMSSSMMSMAAXXMASMAMAAXMMMXXXAMMMMMMMMMMMSXMMXXMAMSMAAXSMMSMMSAMXAAMMMASXSMSXXAXAMSXSAAMXAAXXMSMMMSSMMXAMMMMMMXXAMAXMMXXXMASXMSMXMMMSMXSMSMS
AAAXAXXAAMMMXAMAMMAMMMSAAAXSMMMSAXXAMAXSAMAXMAXXAMXMMMMXAAXXSAMXXMMSMSMSASASAASMSASMMMSMSMXMAASXSMMMAXMSMMAMXMMXSMXXAXSASAMXAAXSASMXAAAMAMAS
XMSMXMMSXSXMXMMMMSMSXXXMMSXMAMAMXSXMSASMAMXMMAMSSSXSAXSMMMSMMAMASMXSAAMMMMXMSMXAMAMAXAMAMXASAMXAMASXXMAXMXMSSSMAAAASMMMASXSSMMMSXMXMMMMAAMMM
SSMAAAXMXSAMXSAMASAMMSMMXXASAMXSASAXMMSXSMMAMAXXAMASMMMAAAAASXMAXXAMSMSSSXSAMXMAMASXMASAMSMSAAXMSAMXAXSXSAMXAAMAMMMAAMMAMMXAMMAMAMAXXASXMSSS
XMASXSMMXSAMMSASAMAAAMAMAMMXAXAMAMSSSSXAMAMSMMSMAMAMMASXMXSMMAMXSMXMAMAAAMXMMXMXSAMMMMSAMXAMMMMXMASXMAMAMXSMMMMXXASMMMMMSAMXMMASASASMXXAMXAS
MMAMMMASASAMAXAMASMMXSAMXSMSSMSMSMAMXAMXMAMXAAXXAMASMASAAAMMSXMAXXMMSSMMMAXSAMXAMASASAXXMMMMAAXMSMMMMMSAMXXMASXMSXSAMXMMMXMAMXASASASXMXSMMMM
AMASASXMASAMMSSSMMMMMSXSMMAAXMAAAMAMMSMMSSSSMMMSMSASMASMMMSASXSMSMXAXXXXXSMAXXMMXMMAMASXMAXMSXSXMASXSASASXASMSAMAMSAMXSAMMSASMMMMMXMMSAMXSAM
MMASASXMAMXMMAMXMAASMMXMAMMSSXMMMSASXAAXAAXXAAAXXMXSMAXAMXMAMAXAAAMSSMSAMXAXMSXSAMMSMXAAMSSMASAAMXAAMASAMMMMMSXMAASAMAMASMMMXMXAAMXXAMASXSAS
MSMMMMXMXMAXMAXXSSMSAMXMAMXAXXXAAMAMXSMMMSXSSMSAXMXXMXMSMXMSMXMMMSMMAMSAXXMXASASASAXMMSMMAAAMAMMSAMXMXMMMSAAMXASMMSAMAMXXXAMMMSSMSMSAMAMXSAM
MAAAAMAXMMAMSSMAMAMSAMASMSMSSMSMMSASAAAXAXMMXAMXMASMXXXMASAAAASMAMMSSMMMSMMSAMAMSMXSSXXAMSMMXMAAXAXXXXAAAXSMMXXXMAMMMSAAMSMXAAMAXXAMXMMXMMMM
SSSMSXSSXMXMAAAMXSASMMMSAAMMAMXAXSXMXSMMMMAASXMAMXMXXMASAMAMSMMASXMAMAASAAASAMXMAXXAXASMMXAAXXMSSMSSMSSMSMMMSSSSMMSXAAMXMAAMXSMMMMXMAMMAMAMX
XAAAAAXAMMXMXSMAMXAXXXAMMMMSAMMXMSMMAXXASXMMSASXMSMASMAMAMXXXAMAMAMXSSMSMSMSAMXSSMMAMMMAASXMMXAMAXAAXAXAMXXSAAMMAAAMXSMSMMXXAAXMAAMSXSAMSASM
XSAMMXMASXMAXXXMAMMMMMMMAMMSASXMAMAMASMMMAXXMAMMAAMXSMXMAMSSSMMXSXMAXMASMMMSAMXAAASMMXSMMXXAMXMSXMSXMMSMASXMMSMSMMSSXAASMAAMXMMSMSXXAMAXSAMA
MXMASXMMMASMMMSXSAASMXSSXMMSAXMAXSAMXSAASXMSMMMMSMSAXMSMMMAAAMSMMAAMXMASXAASMMMMMMAAAXMASXMAMXXMMMMMMXAMXASXAAAAAXAXMMAMMMSMSAXSAMMMMMSMSMSM
MAMAXMAMXXMASMSAMSSSXAMASAAMMMMSMSXSMSMMMMAAAASMAAMMSAAAAMMMMMAASASMSMASXMXMSAAXXMMXMMSAMMSAMXXSASAAMAXSAMXMSSSSSMMSMMMSASAAXMMMXMXXMAMXXAAX
XXSMMSMMSASXXAMAMXMMMMSAXMXMXASAXXMAMXAXSXSSSMMSXXSXSXSMMSXASMSMMAMAMMAMXMAMSSSSXXXXSAMAMXSASMXXXSMSSMXMAXXMMMXXMASXXAASMSMAMSASAMMMMSSSMSMS
XMAMAAAASXSMSSMMMSAAAMMMMXAMMXMMSSSMMMMMMAMAAAMMSXSAMAXAMXXXSAMAMMMAMMMMXMAMMAMAXXASMXSSMASMMMMMXMAXAXAXAMXMAMSXSSMSSMXSXMASMSASMSAAMXAAAAMX
XMAASMMMSAMAAXAXASMSMXAAAMAXMAMSXMAXMAMAMAMSMMAAMXMMMAMXMAMMMAMAXSSXSASASMSSMAMAMMMMAAAXMXMXSAASASXXASXSMMXSASMAMXAMXMAMASMMAMAMASMSSMMMSXSX
XMAMMAMSMAMMMSMMXXAXXSMSXSAASAMXASMMSMSASAXXAXMAMAMAMXSSMASXMMMXMMAASASAMAAAMAMAMXXXMMSMSMMAMSMSASAMXMMAAXASXMMAMMMMAMASMMXMMMAMXMAMXMSXAMSX
XXXXXMMASAMXXSXXXMSMMMAAAMXMXAMSMMXMAASXSMSMMMSAMMSASAAXSAXMXXSXSMAMMXMAMXMASXSAMXXAXMXAAAMXXMXMMMMMMASXMSMSSXSASAASMSASAXXMXSMSSMXMASAMXSMA
XXAMXXSXSMMXXMAMXMAAXMXMMAMMSAMAAAXSMXSAXAMXSASASAAMSMSXMXMMSAXASMXSMXSXMMSAMXSMSMSXMSSSSSMXMASXSAMXSMMAAMXMAMSAXAMMAMASMMMSAXSAAMSSMMMAMAMX
SSMMXXAMMMXMXMAMMMSSMASMXSAXMASMMMMXXAMXMSAXMASAMXSMXAMXXMSAAMMMMXMAMAMASMMSMMSAAASAMAAXMAXXSXSASMSMMAMMAMSSMMMMSXSMSMAMAAMMASMSMSAMMAXAXAMX
MAMSMMMMASAMASASXAAAMASMAMMSAMXAASMMMMSAMXAXMAMXMAXXMSMMSAMXSMSASXSAMXSAMAAXMAMSMMSAMXSMMXMMAMMAMXAMSSMMSMAAAXMASAAAXMSMSSSMXMAXMMASMSSMSSSM
MMMAAAXSASASASMSXMSSMASMXMXMASMSMMAAAAXXAASMSAMXMSSXMAAXMAMAAASASASXSAMXSMMSMMXXXXSAMAXAXAXAAMMAMSMXAMSAAMSSMMSAMSMMMMAAMAXMMSAXXMAMAAAAAMXA
SXSSSMXMASXMXSXMAMXAMXSAMXXXSXXMXSSMMSAXSAMAXXMXMMSXSMSMSAMSSXMXMAMSMXSAXMSXXXMXAMSMMXSSMSMSASMMMXSMXSMSSMMAMXMAXAMXSSMSMSMMMMMSMMASMSMMMSAS
