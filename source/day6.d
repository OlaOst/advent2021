module day6;

import std;


unittest
{
  string input = "3,4,3,1,2";
  
  assert(input.parseday6input == [3:2, 4:1, 1:1, 2:1]);
}
int[int] parseday6input(string input)
{
  return input.strip.split(",").map!(n => n.strip.to!int).array.sort.group.map!(g => tuple(g[0], cast(int)g[1])).assocArray;
}

unittest
{
  auto day1 = [3:2,4:1,1:1,2:1].increment;
  //day1.writeln;
  assert(day1 == [2:2, 3:1, 0:1, 1:1]);
  
  auto day2 = day1.increment;
  //day2.writeln;
  assert(day2 == [1:2, 2:1, 6:1, 0:1, 8:1]);
  
  auto day3 = day2.increment;
  //day3.writeln;
  assert(day3 == [0:2, 1:1, 5:1, 6:1, 7:1, 8:1]);
  
  auto day4 = day3.increment;
  //day4.writeln;
  assert(day4 == [6:3, 0:1, 4:1, 5:1, 7:1, 8:2]);
}
// fishes: key is timer, value is number of fish with timer value
int[int] increment(int[int] fishes)
{
  int[int] nextDay;
  
  foreach (timerKey, numberValue; fishes)
  {
    if (timerKey == 0)
    {
      nextDay[6] += numberValue;
      nextDay[8] += numberValue;
    }
    else
    {
      nextDay[timerKey - 1] += numberValue;
    }
  }
  
  return nextDay;
}

unittest
{
  auto input = [3:2, 4:1, 1:1, 2:1];
  
  auto day18number = input.dup.day6part1(18);
  assert(day18number == 26, "Expected 26, got " ~ day18number.to!string);
  
  auto result = input.day6part1;
  assert(result == 5934, "Expected 5934, got " ~ result.to!string);
}
long day6part1(int[int] input, int days = 80)
{
  auto result = input.dup;
  
  for (int day = 0; day < days; day++)
  {
    result = result.increment;
    //result.writeln;
  }
    
  return result.byValue.sum;
}
