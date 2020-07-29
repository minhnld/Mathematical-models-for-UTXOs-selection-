/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Tanaka Kai
 * Creation Date: Apr 21, 2019 at 2:43:14 PM
 *********************************************/
 {string} datFiles = ...;
 
 float k = ...;
 
 float Y = ...;
 
 main {
 	var file = new IloOplOutputFile("output.txt"); 
 	file.writeln("ID, NumUTXO, OTS_MD1, NumUTXOUsed_MD1, Time_MD1, NumUTXOUsed_25%, TS_25%, Time_25%, NumUTXOUsed_50%, TS_50%, Time_50%, NumUTXOUsed_75%, TS_75%, Time_75%")
 
 	var source = new IloOplModelSource("sub.mod");
 	var cplex = new IloCplex();
 	var def = new IloOplModelDefinition(source);
 	
 	for (var datFile in thisOplModel.datFiles) { 	
 	
 		var opl = new IloOplModel(def, cplex);
 		var data = new IloOplDataSource(datFile+".dat");
 		opl.addDataSource(data);
 		opl.generate();
 		if (cplex.solve()) {
 			opl.postProcess();
 			
 			file.write(datFile+", ");
 			file.write(opl.input.n+", ");
 			file.write(cplex.getObjValue()+", ");
 			file.write(opl.numUTXO+", ");
 			file.write(cplex.getSolvedTime()+", ");
 			
 			var optValue = cplex.getObjValue();
 			writeln("OBJ = "+ cplex.getObjValue());
 			
 			//k = 10
 			var source2 = new IloOplModelSource("sub_2.mod");
 			var cplex = new IloCplex();
 			var def2 = new IloOplModelDefinition(source2);
 			var opl2 = new IloOplModel(def2, cplex);
 			var data2 = new IloOplDataElements();
 			data2.k = 0.25;
 			data2.Y = optValue;
 			opl2.addDataSource(data);
 			opl2.addDataSource(data2);
 			
 			opl2.generate();
 			
 			if (cplex.solve()) {
 				file.write(opl2.selected+", ");
 				file.write(opl2.transactionSize+", ");
 				file.write(cplex.getSolvedTime()+", ");
 			}
 			else {
 				writeln("No solution") 			
 			}
 			
 			//k = 25
 			var source2 = new IloOplModelSource("sub_2.mod");
 			var cplex = new IloCplex();
 			var def2 = new IloOplModelDefinition(source2);
 			var opl2 = new IloOplModel(def2, cplex);
 			var data2 = new IloOplDataElements();
 			data2.k = 0.5;
 			data2.Y = optValue;
 			opl2.addDataSource(data);
 			opl2.addDataSource(data2);
 			
 			opl2.generate();
 			
 			if (cplex.solve()) {
 				file.write(opl2.selected+", ");
 				file.write(opl2.transactionSize+", ");
 				file.write(cplex.getSolvedTime()+", ");
 			}
 			else {
 				writeln("No solution") 			
 			}
 			
 			//k = 50
 			var source2 = new IloOplModelSource("sub_2.mod");
 			var cplex = new IloCplex();
 			var def2 = new IloOplModelDefinition(source2);
 			var opl2 = new IloOplModel(def2, cplex);
 			var data2 = new IloOplDataElements();
 			data2.k = 0.75;
 			data2.Y = optValue;
 			opl2.addDataSource(data);
 			opl2.addDataSource(data2);
 			
 			opl2.generate();
 			
 			if (cplex.solve()) {
 				file.write(opl2.selected+", ");
 				file.write(opl2.transactionSize+", ");
 				file.writeln(cplex.getSolvedTime()+", ");
 			}
 			else {
 				writeln("No solution") 			
 			}
 		}	
 		else {
 			writeln("No solution"); 		
 		}
 		opl.end();
 	} 
 }