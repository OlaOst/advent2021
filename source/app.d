import std;


void main()
{
	auto day1input = "day1input.txt".slurp!int("%s").array;
  day1input.day1part1.writeln;
  day1input.day1part2.writeln;
  
  auto day2input = "day2input.txt".slurp!(string, int)("%s %s").array;
  day2input.day2part1.writeln;
  day2input.day2part2.writeln;
  
  auto day3input = "day3input.txt".readText.parseday3input;
  day3input.day3part1.writeln;
}

unittest
{
  auto heights = [199,200,208,210,200,207,240,269,260,263];
  assert(heights.day1part1 == 7);
}
auto day1part1(Range)(Range input)
{
  return input.slide(2).count!"a[0]<a[1]";
}

unittest
{
  auto heights = [199,200,208,210,200,207,240,269,260,263];
  assert(heights.day1part2 == 5);
}
auto day1part2(Range)(Range input)
{
  return input.slide(3).map!sum.day1part1;
}

unittest
{
  auto text = "forward 5
down 5
forward 8
up 3
down 8
forward 2";

  auto input = text.split("\n").map!(line => line.split(" ")).map!(line => tuple(line[0], line[1].to!int));
  assert(input.day2part1 == 150);
}
auto day2part1(Range)(Range input)
{
  auto horizontal = 0;
  auto depth = 0;

  // assume sub can fly, do not clamp depth above 0
  foreach (line; input)
  {
    if (line[0] == "forward")
      horizontal += line[1];
    if (line[0] == "down")
      depth += line[1];
    if (line[0] == "up")
      depth -= line[1];
  }    
      
  return horizontal * depth;
}

unittest
{
  auto text = "forward 5
down 5
forward 8
up 3
down 8
forward 2";

  auto input = text.split("\n").map!(line => line.split(" ")).map!(line => tuple(line[0], line[1].to!int));
  assert(input.day2part2 == 900);
 }
auto day2part2(Range)(Range input)
{
  long horizontal = 0;
  long aim = 0;
  long depth = 0;
  
  // assume sub can fly, do not clamp depth above 0
  foreach (line; input)
  {
    if (line[0] == "forward")
    {
      horizontal += line[1];
      depth += aim * line[1];
    }
    if (line[0] == "down")
      aim += line[1];
    if (line[0] == "up")
      aim -= line[1];
  }    
      
  return horizontal * depth;
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
  assert(input.day3part1 == 198);
}
auto parseday3input(string text)
{
  return text.split("\n").map!(line => line.map!(c => [c].to!int).array).array; 
}

auto day3part1(Range)(Range input)
{
  auto flipped = input.transposed.map!(line => line.array).array;
  
  auto gamma = 0;
  auto epsilon = 0;
  
  auto bitSums = flipped.map!sum.array;
  
  foreach (size_t bitPos, int bitCount; bitSums)
  {
    // no lines should have equal number of 0 and 1 bits
    enforce(bitCount != input.length / 2);
    
    if (bitCount > (input.length / 2))
      gamma += 2 ^^ ((bitSums.length-1) - bitPos);
    if (bitCount < (input.length / 2))
      epsilon += 2 ^^ ((bitSums.length-1) - bitPos);
  }
  
  return gamma * epsilon;
}
