library inverter;

class Cell {
  bool active = false;
  List<Cell> neighbours = [];
  
  Cell();
  
  void addNeighbour(Cell cell) => neighbours.add(cell);
  void addNeighbours(List<Cell> cells) => neighbours.addAll(cells);
  
  void toggle() {
    active = !active;
    neighbours.forEach((neighbour) => neighbour.active = !neighbour.active);
  }
  
  String get display => active ? "X" : "0";
}

class Grid {
  List<List<Cell>> rows;
  int size;
  
  Grid(this.size) {
    rows = new List.generate(size, (n) =>
      new List<Cell>.generate(size, (_) => new Cell()));
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        rows[x][y].addNeighbours(getNeighbours(x, y));
      }
    }
  }
  
  bool withinBounds(int x, int y) =>
      !(x < 0 || y < 0 || x >= size || y >= size);
  
  Cell getCell(int x, int y) => rows[x][y];
  
  List<Cell> getCellAsList(int x, int y) => withinBounds(x, y) ? [rows[x][y]] : [];
  
  List<Cell> getNeighbours(int x, int y) =>
      []..addAll(getCellAsList(x-1, y))
        ..addAll(getCellAsList(x+1, y))
        ..addAll(getCellAsList(x, y-1))
        ..addAll(getCellAsList(x, y+1));
  
  bool get allCellsActive =>
      rows.every((row) => row.every((cell) => cell.active));
  
  String get display =>
      rows.map((row) => row.map((cell) => cell.display).join()).join("\n");
}

class Game {
  Grid _grid;
  bool won = false;
  int moves = 0;
  
  Game(int size): _grid = new Grid(size);
  
  bool step(int x, int y) {
    if (!withinBounds(x, y)) return false;
    moves ++;
    _grid.getCell(x, y).toggle();
    won = _grid.allCellsActive;
    return true;
  }
  
  bool withinBounds(int x, int y) => _grid.withinBounds(x, y);
  
  toString() => _grid.display;
}