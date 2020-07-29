/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Tanaka Kai
 * Creation Date: May 5, 2019 at 8:39:24 PM
 *********************************************/
tuple vin {
 	int vid;
 	int vsize;
 	int vValue; 
 }
 
 tuple vout {
 	int vid;
 	int vsize;
 	int vValue; 
 }
 
tuple inputSet {
	int n;
	int m;
	float outValue;
	float M;
	float alpha;
	float T;
	float epsilon;
	int beta;
	int txsize;
	int iosize;
	float cout;
	float coutValue;
}

inputSet input = ...;

{vin} UTXOs = ...;

{vout} output = ...;

float k = ...;
float Y = ...;

float y_opt = (1 + k) * Y;
int outputSize = sum(e in output) e.vsize;

dvar boolean a[UTXOs];
dvar int+ zsize;

dexpr int inputSize = sum(e in UTXOs) a[e]*e.vsize;
dexpr int inputValue = sum(e in UTXOs) a[e]*e.vValue;
dexpr float zvalue = inputValue - (input.outValue + input.alpha*Y);
dexpr int transactionSize = inputSize + outputSize + zsize;
dexpr int selected = sum(e in UTXOs) a[e];
dexpr float nUTXOs = sum(e in UTXOs) a[e] - zsize/input.beta;

maximize nUTXOs;

subject to {
	cons0:
		(zvalue <= input.epsilon - 0.000001) => (zsize == 0);
		(zvalue >= input.epsilon) => (zsize == input.beta);
	cons1:
		inputSize + outputSize + zsize <= input.M;
	cons2: 
		forall (out in output)
			out.vValue >= input.T;
	cons3:
		zvalue >= 0;
	cons4:
		transactionSize <= y_opt;
}



execute {
	writeln(nUTXOs);
}