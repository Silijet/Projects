#Input text file to read. If it can't be opened then it will stop.
filename = input('Enter file name: ')
try:
    fhandle = open(filename)
except:
    print('Could not open file.')
    quit()
topwords = input('How many words do you want to return? (Only input integers) ')
try:
    top = int(topwords)
except:
    print('Not a number.')
    quit()
    
#Setup empty dictionary. For each line in the opened file, split the line into individual words based on spaces. For each word in the list of words, the get method will assign 0 as default and increase by 1 whenever it encounters new word.
counts = dict()
for line in fhandle:
    wordlist = line.split()
    for iword in wordlist:
        #Idiom: retrieve, create, update counter
        counts[iword] = counts.get(iword,0)+1

tmplist = list()
#Assigning the tuple to another variable 'oldtup'
oldtup = counts.items()
#For each pair of key and value in oldtup, switch the placements and put them into newtup. Then append it to the newly created list tmplist.
for k, v in oldtup:
    newtup = (v,k)
    tmplist.append(newtup)
#Using newtup, sort from highest to lowest and put it into newcounts. Now the list is sorted from highest frequency to lowest frequency.
newcounts = sorted(tmplist, reverse=True)

for v,k in newcounts[:top]:
    print(k,v)
