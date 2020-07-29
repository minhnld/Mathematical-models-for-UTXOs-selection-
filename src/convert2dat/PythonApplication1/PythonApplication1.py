import os
import glob

def TextToTupleSet(textfilename,datname):
    res = open(datname, "w")
    with open(textfilename) as f:
        f.readline()
        f.readline()
        res.write("input = <\n")
        arr = next(f).split()
        n = int(arr[0])
        m = int(arr[1])

        for i in range(0, len(arr)):
            res.write(arr[i])
            res.write(", \n")

        res.write(">;\n\n")
        f.readline()
        f.readline()
        f.readline()
        
        res.write("UTXOs = { \n")
        for i in range(0, n):
            res.write("<")
            arr = next(f).split()
            res.write(arr[0])
            res.write(", ")
            res.write(arr[1])
            res.write(", ")
            res.write(arr[2])
            res.write(">, \n")
        res.write("};\n\n")
        f.readline()
        f.readline()
        f.readline()
        res.write("output = { \n")
        for i in range(0, m):
            res.write("<")
            arr = next(f).split()
            res.write(arr[0])
            res.write(", ")
            res.write(arr[1])
            res.write(", ")
            res.write(arr[2])
            res.write(">, \n")
        res.write("};")
        
arr = glob.glob("*.txt")
for x in arr:
    name = os.path.splitext(os.path.basename(x))[0] + ".dat"
    TextToTupleSet(x, name)