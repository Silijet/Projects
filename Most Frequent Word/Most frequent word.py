#Input text file to read. If it can't be opened then it will stop.
filename = input('Enter file name: ')
try:
    fhandle = open(filename)
except:
    print('Could not open file.')
    quit()

#Setup empty dictionary. For each line in the opened file, split the line into individual words based on spaces. For each word in the list of words, the get method will assign 0 as default and increase by 1 whenever it encounters new word.
counts = dict()
for line in fhandle:
    wordlist = line.split()
    for iword in wordlist:
        counts[iword] = counts.get(iword,0)+1

#New variables bigcount and bigword to store the most frequent word thus far.
bigcount = None
bigword = None
#Assigns two variables to the key and values of the dictionary. Item method shows key-value pairs as tuples. Conditional to set the bigword and bigcount to the current iteration if the count is the largest seen.
for word,count in counts.items():
    if bigcount is None or bigcount < count:
        bigword = word
        bigcount = count

print(bigword, bigcount)