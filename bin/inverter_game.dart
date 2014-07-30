import '../lib/inverter.dart';
import 'dart:io' show stdin;
import 'dart:math' show Point;

typedef bool Test(arg);
Game g;

main() {
  g = new Game(getNumber("Please enter a game size", (n) => n >= 1));
  while(!g.won) {
    print(g);
    var coordinate = getCoordinate();
    g.step(coordinate.x, coordinate.y);
  }
  print(g);
  print("You won with ${g.moves} moves");
}

Point getCoordinate() {
  int x, y;
  do {
    x = getNumber("Enter x coordinate");
    y = getNumber("Enter y coordinate");
  } while(!g.withinBounds(x, y));
  return new Point(x, y);
}

int getNumber(String prompt, [Test function]) {
  var result = null;
  while (result == null) {
    print(prompt);
    result = int.parse(stdin.readLineSync(), onError: (_) => null);
    if (result != null && function!= null && !function(result)) result = null;
  }
  return result;
}