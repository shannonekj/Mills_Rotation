import csv
import sys


name=sys.argv[1]
decIn=sys.argv[2]
bmtIn=sys.argv[3]


dec=[]
with open(decIn,'r') as decC:
  for line in decC:
    if line[0]=="@":
      dec.append(line.split()[0][1:])
bmt=[]
with open(bmtIn,'r') as bmtC:
  for line in bmtC:
    bmt.append(line[:-1])


def intersect(a, b):
    return list(set(a) & set(b))

both = intersect(dec, bmt)
with open('/home/sakre/projects/bmt_decon/lineMatch.csv','a') as csvfile:
  row=[name,len(bmt),len(dec),len(both)]
  matchWriter = csv.writer(csvfile)
  matchWriter.writerow(row)
print name