module day1;

import std;


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
