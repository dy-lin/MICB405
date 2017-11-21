#A list to hold the lines of the taxonomy file as strings
tax_list = []

#Prompt the user for the name of the taxonomy file
taxonomy = input("Please enter the name of your taxonomy file.\n")

#open the taxonomy file and add lines to tax_list
with open(taxonomy, "r") as tax_in:
	for line in tax_in:
		tax_list.append(line)

#A list to hold the classifications for each OTU
otu_list = []

#A list to hold the OTU IDs, indices match otu_list
otu_list_key = []

#Parse info in tax_list to build otu_list and otu_list_key
for i, s in enumerate(tax_list):
	if i > 0:
		otu_line = s.replace('\n', '')
		otu_info = otu_line.split('\t')
		parsed_list = []
		otu_list_key.append(otu_info[0])
		taxon_parsed = otu_info[2].split(';')
		for w in taxon_parsed:
			if '_unclassified' in w: taxon_parsed.remove(w)
		tax_size = len(taxon_parsed)
		while tax_size < 8:
			taxon_parsed = list(filter(None, taxon_parsed))
			taxon_parsed.append('unclassified')
			taxon_parsed.append('')
			tax_size = len(taxon_parsed)
		
		for j, x in enumerate(taxon_parsed):
			if j < tax_size - 1:
				par = '('
				if par in x:
				
					par_pos = x.index('(')
					parsed_list.append(x[:par_pos])
				else:
					parsed_list.append(x)
		otu_list.append(parsed_list)


print ("There are " + str(len(otu_list)) + " OTUs in your taxonomy file.")

#print len(otu_list)
#print otu_list[0]
#print otu_list[len(otu_list)-1]
#print len(otu_list_key)
#print otu_list_key[len(otu_list_key)-1]

#taxonomic level
level = int(input("Please enter the number for your taxonomic level of interest.\n" + 
"1 = Phylum\n" + "2 = Class\n" + "3 = Order\n" + "4 = Family\n" + "5 = Genus\n" + 
"6 = Species\n"))

if level == 0:
	tax = 'domain'
elif level == 1:
	tax = 'phylum'
elif level == 2:
	tax = 'class'
elif level == 3:
	tax = 'order'
elif level == 4:
	tax = 'family'
elif level == 5:
	tax = 'genus'
elif level == 6:
	tax = 'species'
else:
	tax = ''

#A list to hold the unique taxa for a given level
taxa = []

#Iterate through the otu_list to find the unique taxa
for i in otu_list:

	if i[level] not in taxa:
		taxa.append(i[level])


print ("There are " + str(len(taxa)) + " distinct groups at the " + tax + " level in your taxonomy file.")

#Construct an empty list of integers of length taxa
#taxa_counts = [0]*len(taxa)
#print len(taxa_counts)
#print taxa_counts

#Initialize the final array of taxa counts for each OTU, indices match otu_list_key
#final_list = [taxa_counts]*len(otu_list_key)
#print len(final_list)
#print final_list[len(final_list)-1]

#Create an empty list to hold the contents of the shared file
shared_file = []

shared = input("Please enter the name of your shared file.\n")

#Open the shared file and add the contents, line by line, to shared_file
with open(shared, "r") as shared_in:
	for line in shared_in:
		shared_file.append(line)

#Determine headers for shared file columns
shared_header = shared_file[0].replace('\n', '').split('\t')
#the following line of code was edited to address a bug introduced, possibly from using mothur v.1.36.1
#shared_header_final = shared_header[:len(shared_header)-1]
shared_header_final = shared_header[:len(shared_header)]

#print shared_header_final[1500:]

#Initialize a list to hold the groups in the shared file
shared_groups = []

#Iterate through shared_file and add groups to shared_groups
for i, s in enumerate(shared_file):
	if i > 0:
		new_s = s.replace('\n', '').split('\t')
		shared_groups.append(new_s[1])

#Initialize the final array of taxa counts for each group, indices match shared_groups
final_list = []
#print len(final_list)
#print final_list[len(final_list)-1]

#print len(shared_file)
#print len(shared_header_final)
#print shared_header_final[len(shared_header_final)-1]
#print otu_list_key[0]

#Initialize list of OTUs in shared file
shared_OTU_list = []

#Initialize a list of group counts for each OTU in the shared file
shared_OTU_counts = []

#Iterate through shared_header_final and add OTUs to shared_OTU_list
for i in range(len(shared_header_final)):
	if i > 2:
		shared_OTU_list.append(shared_header_final[i])

print ("There are " + str(len(shared_groups)) + " unique groups in your shared file.")
print ("There are " + str(len(shared_OTU_list)) + " OTUs in your shared file.")

#print len(shared_OTU_list)
#print shared_OTU_list[0]
#print shared_OTU_list[len(shared_OTU_list)-1]
#print len(shared_OTU_counts)
#print shared_OTU_list[len(shared_OTU_list)-1]

#Initialize a list to hold OTU counts for each group
#group_size = [0]*len(shared_groups)
#print len(group_size)
#print group_size

#Initialize array of group counts by OTU
for i in range(len(shared_OTU_list)):
	shared_OTU_counts.append([0]*len(shared_groups))


#Initialize an array of taxa counts by group
for i in range(len(shared_groups)):
	final_list.append([0]*len(taxa))

#print len(final_list)
#print final_list[0]

#shared_OTU_counts = [group_size]*len(shared_OTU_list)
#print len(shared_OTU_counts)
#print shared_OTU_counts[0]
#print shared_OTU_counts[len(shared_OTU_counts)-1]

#Test
#print shared_OTU_counts[0]
#count = 0
#for i in range(len(shared_OTU_counts[0])):
	#shared_OTU_counts[0][i] = count
	#print count
	#count += 1

#shared_OTU_counts[0][0] = 15
#shared_OTU_counts[1][0] = 25
#shared_OTU_counts[2][0] = 35
#shared_OTU_counts[3][0] = 45
#shared_OTU_counts[4][0] = 55
#shared_OTU_counts[5][0] = 65

#print len(shared_OTU_counts[3])
#print len(shared_OTU_counts[2])

#fill shared_OTU_counts with data from shared_file
for i, line in enumerate(shared_file):
	if i > 0:
		parsed_line = line.replace('\n', '').split('\t')
		for j, item in enumerate(parsed_line):
			#the following line of code was edited to address a bug introduced, possibly from using mothur v.1.36.1
			#if j > 2 and j < len(parsed_line)-1:
			if j > 2 and j < len(parsed_line):
				#print "i = " + str(i)
				#print "j = " + str(j)
				#print item 
				#print shared_OTU_counts[j-3][i-1]
				#print shared_OTU_counts[j-2][i-1]
				shared_OTU_counts[j-3][i-1] = int(item)
				#print shared_OTU_counts[j-3][i-1]
				#print str(j-3)


#print shared_OTU_list[0]
#print shared_OTU_counts[0]
#print shared_OTU_list[1]
#print shared_OTU_counts[1]
#print shared_OTU_list[len(shared_OTU_list)-2]
#print shared_OTU_counts[len(shared_OTU_list)-2]

#Test
#print shared_OTU_counts[shared_OTU_list.index('Otu00097')]

#print len(shared_groups)
#print shared_groups

#Sum counts by taxa for each group
for i, counts_by_group in enumerate(shared_OTU_counts):
	otu_ID = shared_OTU_list[i]
	otu_tax = otu_list[otu_list_key.index(otu_ID)][level]
	tax_index = taxa.index(otu_tax)
	for j, c in enumerate(counts_by_group):
		final_list[j][tax_index] += c

#print taxa
#print shared_groups[29]
#print final_list[29]

header = ['']

for i in shared_groups:
	header.append(i)

header.append('\n')

#print len(header)

with open ("tax_summed.txt", "w") as write_out:
	write_out.write('\t'.join(header))
	for i, taxon in enumerate(taxa):
		#print i
		line = []
		line.append(taxon)
		for j in range(len(shared_groups)):
			line.append('\t' + str(final_list[j][i]))
			if j == len(shared_groups) - 1:
				line.append('\n')
		
		write_out.write(''.join(line))
		
print ("The output file is named tax_summed.txt.")
