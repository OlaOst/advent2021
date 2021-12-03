import std;


void main()
{
	auto day1input = "day1input.txt".slurp!int("%s").array;
  day1input.day1part1.writeln;
  day1input.day1part2.writeln;
  
  auto day2input = "day2input.txt".slurp!(string, int)("%s %s").array;
  day2input.day2part1.writeln;
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
