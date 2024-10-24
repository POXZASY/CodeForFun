//Credit to https://connect4.gamesolver.org/ for much help with time/algo improvements
//minimax
//alphabeta
//searching center columns first to eliminate more trees with a-b
//transmutation table
#include <vector>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <bits/stdc++.h>
#include <algorithm>

using namespace std;
//converts the board to a unique int for transmutation table
string boardToString(vector<vector<int>> board){
  string val = "";
  for(int i = 0; i < 7; i++){
    for(int j = 0; j < 6; j++){
      val = val + to_string(board[i][j]);
    }
  }
  return val;
}

//Table that takes int converted positions
class TransmutationTable{
  private:
    int marker;
    int size;
    vector<string> positions;
    vector<int> values;
  public:
    TransmutationTable(int s){
      size = s;
      marker = 0;
      positions.resize(size, "empty"); //all -1s
      values.resize(size, 0); //all 0s
    }
    //~TransmutationTable()
    void insert(string pos, int val){
      positions[marker] = pos;
      values[marker] = val;
      marker = (marker+1)%size;
    }
    bool contains(string pos){
      return positions.end() != find(positions.begin(), positions.end(), pos);
    }
    int value(string pos){
      return values[find(positions.begin(), positions.end(), pos) - positions.begin()];
    }
    void clear(){
      marker = 0;
      fill(positions.begin(), positions.end(), "empty");
      fill(values.begin(), values.end(), 0);
    }
};
//yeah its in global space, but i don't want to pass more parameters
TransmutationTable* tt = new TransmutationTable(500);


//prints the boardstate
void printBoard(vector<vector<int>> board){
  cout << "------\n";
  for(int j = 5; j >= 0; j--){
    for(int i = 0; i < 7; i++){
      if(board[i][j]==1) cout << "X" << " ";
      else if(board[i][j]==2) cout << "O" << " ";
      else cout << "#" << " ";
    }
    cout << "\n";
  }
  for(int i = 1; i <= 7; i++){
    cout << i << " ";
  }
  cout << "\n";
  cout << "------\n";
}
//checks if board is full
bool fullBoard(vector<vector<int>> board){
  for(int i = 0; i < 7; i++){
    if(board[i][5]==0) return false;
  }
  return true;
}
//returns whether or not a slot is full
bool openSlot(int slot, vector<vector<int>> board){
  return board[slot-1][5]==0;
}
//returns a board with the specified move made
vector<vector<int>> modBoard(int turn, int move, vector<vector<int>> board){
  vector<vector<int>> tempboard = board;
  int y = 0;
  while(tempboard[move-1][y]!=0) y++;
  tempboard[move-1][y] = turn;
  return tempboard;
}
//checks if a team won
bool gameWin(int team, vector<vector<int>> board){
  //horizontal
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 6; j++){
      if(board[i][j]==board[i+1][j] && board[i+1][j]==board[i+2][j] && board[i+2][j]==board[i+3][j] && board[i+3][j]==team) return true;
    }
  }
  //vertical
  for(int i = 0; i < 7; i++){
    for(int j = 0; j < 3; j++){
      if(board[i][j]==board[i][j+1] && board[i][j+1]==board[i][j+2] && board[i][j+2]==board[i][j+3] && board[i][j+3]==team) return true;
    }
  }
  //top left - bottom right
  for(int i = 0; i < 4; i++){
    for(int j = 3; j < 6; j++){
      if(board[i][j]==board[i+1][j-1] && board[i+1][j-1]==board[i+2][j-2] && board[i+2][j-2]==board[i+3][j-3] && board[i+3][j-3]==team) return true;
    }
  }
  //bottom left - top right
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 3; j++){
      if(board[i][j]==board[i+1][j+1] && board[i+1][j+1]==board[i+2][j+2] && board[i+2][j+2]==board[i+3][j+3] && board[i+3][j+3]==team) return true;
    }
  }
  return false;
}
//checks if game is a tie
bool gameTie(vector<vector<int>> arr){
  if(!gameWin(1, arr)&&!gameWin(2, arr)&&fullBoard(arr)) return true;
  return false;
}
//checks if game is complete
bool gameOver(vector<vector<int>> arr){
  return (gameWin(1, arr)||gameWin(2,arr)||gameTie(arr));
}

int attackVal(vector<vector<int>> board, int team){

}

//used to sort possibleMoves array
bool compareDistToCenter(int a, int b){
  return (abs(a - 4) - abs(b - 4)) < 0;
}
//used to sort possibleMoves array
bool compareAttackVal(int a, int b){
  
}

//vector of possible moves
vector<int> possibleMoves(vector<vector<int>> board){
  vector<int> moves;
  for(int i = 1; i <= 7; i++){
    if(openSlot(i, board)) moves.push_back(i);
  }
  //sort by distance from 4
  sort(moves.begin(), moves.end(), compareDistToCenter);
  //sort to favor potential attacks
  sort(moves.begin(), moves.end(), compareAttackVal);
  return moves;
}
//main algorithm
int alphabeta(vector<vector<int>> board, bool maximizingPlayer, int turn, int depth, int alpha, int beta){
  //if(depth > -1) cout << depth << endl;
  if((*tt).contains(boardToString(board))){
    return (*tt).value(boardToString(board));
  }
  //terminal node
  if(depth == 0 && !gameOver(board)){
    (*tt).insert(boardToString(board), 0);
    return 0;
  }
  if(gameOver(board)){
    if(gameTie(board)){
      (*tt).insert(boardToString(board), 0);
      return 0;
    }
    if(maximizingPlayer){
      (*tt).insert(boardToString(board), -1);
      return -1;
    }
    (*tt).insert(boardToString(board), 1);
    return 1;
  }
  if(maximizingPlayer){
    int value = INT_MIN;
    for(int move : possibleMoves(board)){
      value = max(value, alphabeta(modBoard(turn, move, board), false, turn%2+1, depth-1, alpha, beta));
      alpha = max(alpha, value);
      if(alpha > beta) break;
    }
    (*tt).insert(boardToString(board), value);
    return value;
  }
  else{
    int value = INT_MAX;
    for(int move : possibleMoves(board)){
      value = min(value, alphabeta(modBoard(turn, move, board), true, turn%2+1, depth-1, alpha, beta));
      beta = min(beta, value);
      if(alpha > beta) break;
    }
    (*tt).insert(boardToString(board), value);
    return value;
  }
}
//returns a random move from the set of best possible moves
int bestMove(int turn, vector<vector<int>> board){
  int depth = 3;
  vector<int> choices;
  for(int moves : possibleMoves(board)){ //look for winning moves
    if(alphabeta(modBoard(turn, moves, board), false, turn%2+1, depth, INT_MIN, INT_MAX)==1){
      choices.push_back(moves);
      cout << "The computer can win with " << moves << "." << endl;
    }
  }
  if(choices.size()==0){ //no winning moves
    for(int moves : possibleMoves(board)){
      if(alphabeta(modBoard(turn, moves, board), false, turn%2+1, depth, INT_MIN, INT_MAX)==0){
        choices.push_back(moves);
        cout << "The computer can draw with " << moves << "." << endl;
      }
    }
  }
  if(choices.size()==0){ //no neutral moves found, zugszwang
    for(int moves : possibleMoves(board)){
      choices.push_back(moves);
      cout << "The computer can lose with " << moves << "." <<  endl;
    }
  }
  srand(time(NULL));
  int selector = rand() % choices.size();
  cout << "The computer plays " << choices[selector] << "." << endl;
  (*tt).clear();
  return choices[selector];
}
//performs a turn in the game
vector<vector<int>> makeMove(int turn, int cputurn, vector<vector<int>> board){
  int move;
  vector<vector<int>> tempboard = board;
  if(cputurn==turn){
    cout << "The computer will now make a move:\n";
    //do computer turn here
    tempboard = modBoard(turn, bestMove(turn, tempboard), tempboard);
  }
  else{
    bool validMove = false;
    while(!validMove){
      cout << "It is your turn to make a move. Input a number, 1 through 7: " << endl;
      cin >> move;
      cin.clear();
      cin.ignore(1000, '\n');
      if(cin.fail() || move < 1 || move > 7 || !openSlot(move, board)){
        cout << "That is an invalid move." << endl;
      }
      else{
        tempboard=modBoard(turn, move, board);
        validMove=true;
      }
    }
  }
  return tempboard;
}
int main(){
  vector<vector<int>> currentboard = {{0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0}}; //starting board, 0 for empty, 1 for P1, 2 for P2
  cout << "First board: " <<boardToString(currentboard) << endl;
  int playerturn=1;
  //explaining how to play
  cout << "Each space on the board corresponds to a number, 1 through 7. \n";
  //assigning players 1 & 2
  srand(time(NULL));
  int cputurn = rand() % 2 + 1;
  if(cputurn==1) cout << "You are Player 2. The computer will play first.\n";
  else cout << "You are Player 1. The computer will play second.\n";
  //The game plays out here
  while(!gameOver(currentboard)){
    currentboard = makeMove(playerturn, cputurn, currentboard);
    printBoard(currentboard);
    playerturn = playerturn%2+1; //occilates the player's turn between 1 and 2
  }
  //end of the game
  if(gameTie(currentboard)) cout << "The game is over. It ended in a draw.";
  else if(playerturn%2+1==cputurn){
    cout << "The game is over. The computer (Player " << playerturn%2+1 << ") won!";
  }
  else{
    cout << "The game is over. You (Player " << playerturn%2+1 << ") won!";
  }
  return 0;
}
