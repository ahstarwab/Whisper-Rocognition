#include <iostream>

double mul(double x, double y)
{

	return x * y; // return°ª = x*y

}

double div(double x, double y)
{
	return x / y;
}

double add(double x, double y)
{
	return x + y;
}

void readMe()
{
	printf("1st DP git Test pjt");
}

int main() {
	
	readMe(); // Yong

	int a, b;
	cin >> a >> b;
	cout << add(a,b)<<endl;
	cout << sub(a,b)<<endl;
	cout << mul(a,b)<<endl;
	cout << div(a,b)<<endl;



	return 0;
}
