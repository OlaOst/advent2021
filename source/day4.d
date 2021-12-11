module day4;

import std;


unittest
{
  string input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7";
 
  auto parsed = input.parseday4input;
  //parsed[0].writeln;
  //parsed[1].each!writeln;
  assert(parsed[0] == [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]);
  assert(parsed[1][0][0] == [22,13,17,11,0]);
  assert(parsed[1][2][4] == [2,0,12,3,7]);
}
auto parseday4input(string input)
{
  auto lines = input.split("\n");
  
  auto drawNumbers = lines.front.strip.split(",").filter!(n => n.strip.length > 0).map!(n => n.to!int).array;
  
  int[][][] boards;
  foreach (line; lines[1..$])
  {
    if (line.strip == "")
      boards.length++;
    else
      boards[boards.length-1] ~= line.strip.split(" ").filter!(n => n.strip.length > 0).map!(n => n.to!int).array;
  }
  
  return tuple(drawNumbers, boards);
}

unittest
{
  string input = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7";
 
  auto parsed = input.parseday4input;
  
  assert(parsed.day4part1 == 4512, "Expected 4512, got " ~ parsed.day4part1.to!string);
}
long day4part1(Range)(Range input)
{
  auto drawNumbers = input[0];
  auto boards = input[1];
  
  foreach (drawNumber; drawNumbers)
  {
    foreach (boardIndex, board; boards)
    {
      foreach (lineIndex, line; board)
      foreach (numberIndex, number; line)
      {
        if (number == drawNumber)
          boards[boardIndex][lineIndex][numberIndex] = -1;
      }
      
      //writeln("draw number ", drawNumber, ", current board:");
      //board.each!writeln;
      
      if (board.dup.any!(line => line.all!(number => number < 0)) || board.dup.transposed.any!(line => line.all!(number => number < 0)))
      {
        writeln("found winning board: ");
        board.each!writeln;
        
        auto boardSum = board.join.filter!(number => number >= 0).sum;
        return boardSum * drawNumber;
      }
    }
  }
  
  return -1;
}
