import matplotlib
import matplotlib.pyplot as plt
import numpy as np

f = open('toplothist.txt')
n = float(f.readline())	#Number of files to plot

for i in range(0,int(n)):
	infile = f.readline().rstrip('\n');
	g = open(infile)
	outfile = g.readline().rstrip('\n') + '.pdf';
	print outfile
	m = float(g.readline().rstrip('\n'));			# Number og points.

	bins = np.log2(m) + 1			# Number of bins from Sturges formula.
	
	y = np.zeros(int(m))
	for i in range(0,int(m)):
		y[i] = float(g.readline())

	plt.hist(y, 100)
	plt.title("Histogram" + " " + outfile.rstrip('.txt.pdf'))
	plt.xlabel("Value")
	plt.ylabel("Frequency")
	plt.savefig(outfile)
	#plt.show()
	g.close()

raw_input("Press enter to continue")


