#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <string>

static constexpr int biggest_value{10};

int main(int argc, char* argv[]) {
   // seed
   std::srand(std::time(nullptr));

   if (argc != 2) {
      std::cerr << "No files inputted.\n";
      return 1;
   }
   std::string file_name{argv[1]};

   std::ifstream in_file{file_name};
   if (!in_file) {
      std::cerr << "Couldn't open file: " << file_name << '\n';
      return 1;
   }

   std::string input{};
   std::getline(in_file, input);
   int data_points{std::stoi(input)};

   for (int i{}; i < data_points; ++i)
      std::cout << std::rand() % (biggest_value + 1) << '\n';

   return 0;
}
