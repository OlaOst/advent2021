module day3;

import std;


unittest
{
  auto text = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010";

  auto input = text.split("\n").map!(line => line.map!(c => [c].to!int).array).array;
  assert(input.day3part1 == 198);
}
auto parseday3input(string text)
{
  return text.split("\n").filter!(line => line.length > 0).map!(line => line.map!(c => [c].to!int).array).array; 
}

auto day3part1(Range)(Range input)
{
  auto flipped = input.transposed.map!(line => line.array).array;
  
  auto gamma = 0;
  auto epsilon = 0;
  
  auto bitSums = flipped.map!sum.array;
  
  foreach (size_t index, int bitCount; bitSums)
  {
    auto bitPos = (bitSums.length-1) - index;
    
    // no lines should have equal number of 0 and 1 bits
    enforce(bitCount != input.length / 2);
    
    if (bitCount > (input.length / 2))
      gamma += 2 ^^ bitPos;
    if (bitCount < (input.length / 2))
      epsilon += 2 ^^ bitPos;
  }
  
  return gamma * epsilon;
}


unittest
{
  auto text = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010";

  auto input = text.split("\n").map!(line => line.map!(c => [c].to!int).array).array;
  
  assert(input.day3part2 == 230);
}
auto day3part2(int[][] input, int checkBit = 0)
{
  auto oxyValue = input.dup.reducer(0, false);
  auto oxy = oxyValue[0].map!(to!string).join.to!int(2);
  auto co2Value = input.dup.reducer(0, true);
  auto co2 = co2Value[0].map!(to!string).join.to!int(2);
  
  //writeln("oxy ", oxy, ", co2 ", co2);
  
  return oxy * co2;
}


int[][] reducer(int[][] input, int checkBit, bool flipCheck)
{
  assert(input.length > 0);
  
  auto flipped = input.dup.transposed.map!(line => line.array).array;
  auto bitSums = flipped.map!sum.array;
  
  //writeln(input);
  //writeln(flipped);
  
  if (input.length == 1)
    return input;
  
  //writeln("input length ", input.length, ", bitSums ", bitSums, ", checkBit ", checkBit, ", checkValue ", bitSums[checkBit]);
  
  auto bitValue = (bitSums[checkBit] >= (input.length+1)/2) ? 1 : 0;  
  if (flipCheck)
    bitValue = (bitSums[checkBit] < (input.length+1)/2) ? 1 : 0;
  
  auto reduced = input.filter!(bits => bits[checkBit] == bitValue).array;
  
  //assert(reduced.length < input.length, "Could not reduce " ~ input.map!(l => l.map!(to!string).join).to!string);
  
  return reduced.reducer(checkBit+1, flipCheck);
}
