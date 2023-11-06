#include <iostream>
#include <cling/Interpreter/Interpreter.h>
#include <cling/Interpreter/Value.h>

// g++ embed_cling.cpp -std=c++11 -L/usr/local/lib -lcling -o embed_cling
int main(int argc, char** argv)
{
	const char* LLVMRESDIR = "/usr/local/"; //path to llvm resource directory
	cling::Interpreter interp(argc, argv, LLVMRESDIR);

	interp.declare("int p=123;");
	cling::Value res;
	interp.process("p;", &res);
  	std::cout << "p is " << res.getAs<long long>() << std::endl;
}