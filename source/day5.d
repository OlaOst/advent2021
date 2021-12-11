module day5;

import std;


unittest
{
  auto input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
";

  assert(input.parseday5input == [[[0,9],[5,9]], [[8,0],[0,8]], [[9,4],[3,4]], [[2,2],[2,1]], [[7,0],[7,4]], [[6,4],[2,0]], [[0,9],[2,9]], [[3,4],[1,4]], [[0,0],[8,8]], [[5,5],[8,2]]]);
}
auto parseday5input(string input)
{
  return input.strip.split("\n").map!(line => line.strip.split(" -> ").map!(part => part.strip.split(",").map!(n => n.strip.to!int).array).array).array;
}

unittest
{
  auto input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2";

  assert(input.parseday5input.day5part1 == 5);
}
auto day5part1(Range)(Range segments)
{
  //segments.each!writeln;
  
  auto minX = segments.map!(segment => segment.map!(coord => coord[0])).join.minElement;
  auto maxX = segments.map!(segment => segment.map!(coord => coord[0])).join.maxElement;
  auto minY = segments.map!(segment => segment.map!(coord => coord[1])).join.minElement;
  auto maxY = segments.map!(segment => segment.map!(coord => coord[1])).join.maxElement;
  
  //writeln("min/max coords: ", [minX,minY], " -> ", [maxX,maxY]);
  
  assert(minX < maxX);
  assert(minY < maxY);
  
  auto grid = new int[][](maxY+1, maxX+1);
  
  auto straightSegments = segments.filter!(segment => (segment[0][0] == segment[1][0]) || (segment[0][1] == segment[1][1]));
  
  foreach (segment; straightSegments)
  {
    //writeln("checking segment ", segment[0], " -> ", segment[1]);
  
    // vertical line
    if (segment[0][0] == segment[1][0])
    {
      auto x = segment[0][0];
      auto startY = min(segment[0][1], segment[1][1]);
      auto endY = max(segment[0][1], segment[1][1]);
      for (int y = startY; y <= endY; y++)
        grid[y][x]++;
    }
    // horizontal line
    else if (segment[0][1] == segment[1][1])
    {
      auto y = segment[0][1];
      auto startX = min(segment[0][0], segment[1][0]);
      auto endX = max(segment[0][0], segment[1][0]);
      for (int x = startX; x <= endX; x++)
        grid[y][x]++;
    }
  }
  
  //grid.each!writeln;
  
  return grid.join.count!(n => n > 1);
}
