#include <stdio.h>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <bits/stdc++.h>
#include <ctime>
#include <algorithm>

using namespace std;

//prints the boardstate
void printBoard(vector<vector<int>> board){
  cout << "------\n";
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      if(board[i][j]==1) cout << "X" << " ";
      else if(board[i][j]==2) cout << "O" << " ";
      else cout << "#" << " ";
    }
    cout << "\n";
  }
  cout << "------\n";
}
//checks if board is full
bool fullBoard(vector<vector<int>> board){
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      if(board[i][j]==0) return false;
    }
  }
  return true;
}
//returns whether or not a square is empty
bool emptySquare(int square, vector<vector<int>> board){
  if(board[(int)((square-1)/3)][(square-1)%3]==0) return true;
  return false;
}
//returns a board with the specified move made
vector<vector<int>> modBoard(int turn, int move, vector<vector<int>> board){
  vector<vector<int>> tempboard = board;
  tempboard[(int)((move-1)/3)][(move-1)%3]=turn;
  return tempboard;
}
//checks if a team won
bool gameWin(int team, vector<vector<int>> arr){
  for(int i = 0; i < 3; i++){
    //horizontal win
    if(arr[i][0]==arr[i][1]&&arr[i][1]==arr[i][2]&&arr[i][2]==team) return true;
    //vertical win
    if(arr[0][i]==arr[1][i]&&arr[1][i]==arr[2][i]&&arr[2][i]==team) return true;
  }
  //diagonal win
  if(arr[0][0]==arr[1][1]&&arr[1][1]==arr[2][2]&&arr[2][2]==team) return true;
  if(arr[0][2]==arr[1][1]&&arr[1][1]==arr[2][0]&&arr[2][0]==team) return true;
  //tie
  return false;
}
//checks if game is a tie
bool gameTie(vector<vector<int>> arr){
  if(!gameWin(1, arr)&&!gameWin(2, arr)&&fullBoard(arr)) return true;
  return false;
}
//checks if game is complete
bool gameOver(vector<vector<int>> arr){
  if(gameWin(1, arr)||gameWin(2,arr)||gameTie(arr)) return true;
  return false;
}
//vector of possible moves
vector<int> possibleMoves(vector<vector<int>> board){
  vector<int> moves;
  for(int i = 1; i < 10; i++){
    if(emptySquare(i, board)) moves.push_back(i);
  }
  return moves;
}
//minimax algorithm
int minimax(vector<vector<int>> board, bool maximizingPlayer, int turn){
  //terminal node
  if(gameOver(board)){
    if(gameTie(board)) return 0;
    if(maximizingPlayer) return -1;
    return 1;
  }
  if(maximizingPlayer){
    int value = INT_MIN;
    for(int move : possibleMoves(board)){
      value = max(value, minimax(modBoard(turn, move, board), false, turn%2+1));
    }
    return value;
  }
  else{
    int value = INT_MAX;
    for(int move : possibleMoves(board)){
      value = min(value, minimax(modBoard(turn, move, board), true, turn%2+1));
    }
    return value;
  }
}
//returns a random move from the set of best possible moves
int bestMove(int turn, vector<vector<int>> board){
  vector<int> choices;
  for(int moves : possibleMoves(board)){ //look for winning moves
    if(minimax(modBoard(turn, moves, board), false, turn%2+1)==1){
      choices.push_back(moves);
      cout << "The computer can win with " << moves << "." << endl;
    }
  }
  if(choices.size()==0){ //no winning moves
    for(int moves : possibleMoves(board)){
      if(minimax(modBoard(turn, moves, board), false, turn%2+1)==0){
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
      cout << "It is your turn to make a move. Input a number, 1 through 9: " << endl;
      cin >> move;
      cin.clear();
      cin.ignore(1000, '\n');
      if(cin.fail() || move < 1 || move > 9 || !emptySquare(move, board)){
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
  vector<vector<int>> currentboard = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}; //starting board, 0 for empty, 1 for P1, 2 for P2
  int playerturn=1;
  //explaining how to play
  cout << "Each space on the board corresponds to a number, 1 through 9, as indicated below:\n";
  vector<vector<int>> exampleboard = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
  cout << "------\n";
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      cout << exampleboard[i][j] << " ";
    }
    cout << "\n";
  }
  cout << "------\n";
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
