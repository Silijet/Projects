#The goal should be to search a text file and find the largest word and print it out with the length of the word.
#Input the text file
file = input("Enter text file: ")
  try:
    fhandle = open(file)
   except:
     print("Could not open file.")
     quit()

#Next, we should take the text and arrange it so each word is separated into a list. Then will need to use len function to return the number of characters in each string. Will have to assign variables to record both the word and the length.
