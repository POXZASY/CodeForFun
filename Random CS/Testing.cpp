#include <vector>
#include <iostream>
#include <cstdlib>
#include <algorithm>

using namespace std;

//used to sort possibleMoves array
bool compareDistToCenter(int a, int b){
  return (abs(a - 4) - abs(b - 4)) < 0;
}

int main(){
  vector<int> temp = {1, 2, 3, 4, 5, 6, 7};
  cout << "Before: " << endl;
  for(int i = 0; i < 7; i++){
    cout << temp[i] << ", ";
  }
  cout << "\n";
  sort(temp.begin(), temp.end(), compareDistToCenter);
  cout << "After: " << endl;
  for(int i = 0; i < 7; i++){
    cout << temp[i] << ", ";
  }
  return 0;
}
