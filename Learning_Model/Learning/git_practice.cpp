#include <iostream>
#include "stdafx.h"
using namespace std;
double mul1(double x, double y)
{

	return x * y; // return°ª = x*y

}


double div1(double x, double y)
{
	return x / y;
}


double sub1(double x, double y)
{
	return x - y;
}


double add1(double x, double y)
{
	return x + y;
}

int main() {

	int a, b;
	cin >> a >> b;
	cout << add1(a, b) << endl;
	cout << sub1(a, b) << endl;
	cout << mul1(a, b) << endl;
	cout << div1(a, b) << endl;




	
	
	
	
	return 0;
}
