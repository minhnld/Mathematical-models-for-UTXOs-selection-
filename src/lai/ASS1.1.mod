/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Tanaka Kai
 * Creation Date: Apr 21, 2019 at 2:43:14 PM
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

int outputSize = sum(e in output) e.vsize;

dvar boolean a[UTXOs];
dvar int+ zsize;
/*range n = 1..input.n;*/
//dexpr float minv=min(forall(e in UTXOs, a[e] diff 0)) a[e]*e.vsize;
dexpr int inputSize = sum(e in UTXOs) a[e]*e.vsize;
dexpr int inputValue = sum(e in UTXOs) a[e]*e.vValue;

dexpr int transactionSize = inputSize + outputSize + zsize;
dexpr float zvalue = inputValue - (input.outValue + input.alpha*transactionSize);
minimize transactionSize;

subject to {
	cons0:
		(zvalue <= input.epsilon - 0.1) => (zsize == 0);
		(zvalue >= input.epsilon) => (zsize == input.beta);
		
	cons1:
		inputSize + outputSize + zsize <= input.M;
	cons2: 
		forall (out in output)
			out.vValue >= input.T;
	cons3:
		zvalue >= 0;
}

execute {
	writeln(input);
	writeln(UTXOs);
	//writeln(minv);
}
main{

//var cplex = new IloCplex();
var opl = thisOplModel;
var iteration=0;  

   while(iteration<=132){
        var opl = thisOplModel
        var filename="tus"+iteration;
        var data = new IloOplDataSource(filename+".dat");
        opl.addDataSource(data);
        var details=opl.dataElements;
        opl.generate();
        if(cplex.solve()){
            writeln(filename+"->"+1);
            //writeln(cplex.printRelaxation());
            writeln(opl.printSolution());
        }
        else{
            writeln(filename+"->"+0);
        }
        iteration++
        data.end();
        //opl.end();
        //cplex.end();     
   }
}