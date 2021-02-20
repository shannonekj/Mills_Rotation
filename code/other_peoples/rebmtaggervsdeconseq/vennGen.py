import matplotlib as mpl
mpl.use('TKAgg')
from matplotlib import pyplot as plt 
from matplotlib.backends.backend_pdf import PdfPages
import csv
from matplotlib_venn import venn2
import numpy as np

pp = PdfPages('venn.pdf')
decS=0
bmtS=0
bothS=0
with open('lineMatch/lineMatch.csv','rb') as csvfile:
	lmReader = csv.reader(csvfile)
	for row in lmReader:
		numbers=row[1:]
		numbers = [int(x) for x in numbers]
		name=row[0]
		bmt=numbers[0]-numbers[2]
		bmtS=bmtS+bmt
		dec=numbers[1]-numbers[2]
		decS=decS+dec
		bothS=bothS+numbers[2]
		
		plt.figure()
		plt.title(name+' Contaminant')
		c=venn2(subsets=(bmt,dec,numbers[2]),set_labels=('BMTagger','Deconseq','Both'))
		c.get_patch_by_id('01').set_color('blue')
		c.get_patch_by_id('11').set_color('magenta')
		c.get_patch_by_id('11').set_edgecolor('none')
		c.get_patch_by_id('11').set_alpha(0.4)
		pp.savefig()
		plt.close()

plt.figure()
plt.title('Total Set Contaminant')
c=venn2(subsets=(bmtS,decS,bothS),set_labels=('BMTagger','Deconseq','Both'))
c.get_patch_by_id('01').set_color('blue')
c.get_patch_by_id('11').set_color('magenta')
c.get_patch_by_id('11').set_edgecolor('none')
c.get_patch_by_id('11').set_alpha(0.4)
pp.savefig()
plt.close()

pp.close()


