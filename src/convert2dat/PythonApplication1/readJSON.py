import json

def JSonToTupleSet(jsonfilename,datname):
    with open(jsonfilename) as data_file:    
         data = json.load(data_file)
 
    # write that into a .dat
 
    res = open(datname, "w") 

    quote='"'


    for i in data:
        ii=data[i]
    
        res.write(i);
        res.write("={")
        res.write("\n")

        for j in ii:
      
          res.write("<") 
          for j2 in j:
             jj=j[j2] 
         
             if (jj==jj):
                 if (type(jj)==str):
                   res.write("\"")
                 res.write(str(jj))
                 if (type(jj)==str):
                    res.write("\"")
                 res.write(",")
          res.write(">,")    
          res.write("\n")
    
 
        res.write("};")
   
    res.close()


JSonToTupleSet("C:\Users\Tanaka Kai\Downloads\Nurses.json","C:\Users\Tanaka Kai\Downloads\nurses.dat")
