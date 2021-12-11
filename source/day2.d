module day2;

import std;


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
