#include <cstdlib>

using namespace std;

//returns if a square tuple is on the board
bool onBoard(tuple<int, int> t){
  if(get<0>(t)>=1 && get<0>(t)<=8 && get<1>(t)>=1 && get<1>(t)<=8) return true;
  return false;
}
//returns if a square is occipied by a piece of a particular color
bool isOccupied(int color, tuple<int, int> pos, vector<vector<Piece>> board){
  if(board[get<0>(pos)][get<1>(pos)].getColor() == color) return true;
  return false;
}
class Piece{
  Public:
  tuple<int, int> position;
  vector<tuple<int,int>> possibleMoves;
  int color;
  int getColor(){
    return color;
  }
};
class King : public Piece{
  King(int c, tuple<int, int> pos){
    pos = this->position;
    color = this->color;
  }
  bool validMove(tuple<int, int> m){ //tells whether or not it is a valid move move
    for(tuple t : possibleMoves){
      if(t==m) return true;
    }
    return false;
  }
  void updateMoves(vector<vector<int>> board){ //update the piece's possible moves. should call when moved
    possibleMoves.clear();
    for(int i = -1; i<=1; i++){
      for(int j = -1; j<=1; j++){
        if(i!=0||j!=0){
          tuple<int, int> square = make_tuple(i, j);
          if(onBoard(square)&&!isOccupied(color, square, board)) possibleMoves.push_back(square);
        }
      }
    }
  }
  bool move(tuple<int, int> m){ //make a move
    if(validMove(m)){
      position = m;
      return true;
    }
    return false;
  }
};

vector<vector<Piece>> updateAll(vector<vector<Piece>> board){ //calls updateMoves() on all pieces on the board
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < 8; j++){
      if(board[i][j]!=NULL) board[i][j].updateMoves();
    }
  }
}

int main(){
  vector<vector<Piece>> currentboard = {{},{},{NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL},{NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL}
  ,{NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL},{NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL},{},{}};

  return 0;
}
