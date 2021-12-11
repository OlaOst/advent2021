import std;


void main()
{
  import day1;
	auto day1input = "day1input.txt".slurp!int("%s").array;
  day1input.day1part1.writeln;
  day1input.day1part2.writeln;
  
  import day2;
  auto day2input = "day2input.txt".slurp!(string, int)("%s %s").array;
  day2input.day2part1.writeln;
  day2input.day2part2.writeln;
  
  import day3;
  auto day3input = "day3input.txt".readText.parseday3input.array;
  //day3input.day3part1.writeln;
  day3input.day3part2.writeln;
  
  import day4;
  auto day4input = "day4input.txt".readText.parseday4input;
  //day4input.day4part1.writeln;
  day4input.day4part2.writeln;
  
  import day5;
  auto day5input = "day5input.txt".readText.parseday5input;
  //day5input.day5part1.writeln;
  day5input.day5part2.writeln;
  
  import day6;
  auto day6input = "day6input.txt".readText.parseday6input;
  day6input.day6part1.writeln;
  day6input.day6part1(256).writeln;
}
