import std;


void main()
{
	"day1input.txt".File.byLine.map!(line => line.to!int).array.day1part1.writeln;
  "day1input.txt".File.byLine.map!(line => line.to!int).array.day1part2.writeln;
}

unittest
{
  auto heights = [199,200,208,210,200,207,240,269,260,263];
  assert(heights.day1part1 == 7);
}
auto day1part1(int[] input)
{
  return input.zip(input[1..$]).count!(i => i[0] < i[1]);
}

unittest
{
  auto heights = [199,200,208,210,200,207,240,269,260,263];
  assert(heights.day1part2 == 5);
}
auto day1part2(int[] input)
{
  auto windows = input.slide(3).map!(w => w.sum).array;
  return windows.day1part1;
}