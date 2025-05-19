#Exercise 1
#  Create a program that asks the user to enter their name and their age. Print out a message addressed to them that tells them the year that they will turn 100 years old. Note: for this exercise, the expectation is that you explicitly write out the year (and therefore be out of date the next year). If you want to do this in a generic way, see exercise 39.

#Extras:
#    Add on to the previous program by asking the user for another number and printing out that many copies of the previous message. (Hint: order of operations exists in Python)
#    Print out that many copies of the previous message on separate lines. (Hint: the string "\n is the same as pressing the ENTER button)

from datetime import datetime
current_year = datetime.now().year
name = str(input("What is your name? "))
  print("Your name is " + name)
age = int(input("How old are you? "))
  print("So, you are " + str(age) + " years old.")
number_of_times = int(input("How many times would you like the calculation to be repeated? "))
yearsto100 = int(100 - age)
year_turn_100 = yearsto100 + current_year
  print(number_of_times * ("Therefore, you will turn 100 in " + str(year_turn_100) + "\n"))

#Exercise 2
#Ask the user for a number. Depending on whether the number is even or odd, print out an appropriate message to the user. Hint: how does an even / odd number react differently when divided by 2?

#Extras:
#    If the number is a multiple of 4, print out a different message.
#    Ask the user for two numbers: one number to check (call it num) and one number to divide by (check). If check divides evenly into num, tell that to the user. If not, print a different appropriate message.

try:
  check_number = int(input("What number will be checked? "))
  if check_number % 4 == 0:
    print("This number is divisible by 4 and is even.")
  elif check_number % 2 == 0:
    print("This number is even")
  else: 
    print("This number is odd")
except ValueError:
  print("Please enter a valid integer.")

#Exercise 3
#  Take a list, say for example this one:
#  a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
#  and write a program that prints out all the elements of the list that are less than 5.

#Extras:
#    Instead of printing the elements one by one, make a new list that has all the elements less than 5 from this list in it and print out this new list.
#    Write this in one line of Python.
#    Ask the user for a number and return a list that contains only elements from the original list a that are smaller than that number given by the user.

a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
b = []
less_than = int(input("All elements from the list that are less than this value will be extracted: "))
for element in a:
  if element < less_than:
    b.append(element)
print(b)

#Exercise 4
#  Create a program that asks the user for a number and then prints out a list of all the divisors of that number. 
try:
  input_number = int(input("What number would you like to see all factors? "))
  x = range(1, input_number+1)
  y = []
  
  for elem in x:
    if input_number % elem == 0:
      y.append(elem)
  
  print(f"The factors of {input_number} are: {y}")

except ValueError:
  print("Please enter a valid integer.")

  
#Exercise 5
#  Take two lists and write a program that returns a list that contains only the elements that are common between the lists (without duplicates). Make sure your program works on two lists of different sizes.

a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
c = []
d = []
#Remove duplicates
for elem in a:
  if elem not in c:
    c.append(elem)
    
try:
  for elem in b:
    if elem in c:
      d.append(elem)
  print(f"Common elements: {d}")
except Exception as e:
  print("An error occurred:", e)
#This is just an intersection set problem
return list(set(a) & set(b))

#Exercise 6
#  Ask the user for a string and print out whether this string is a palindrome or not.
check_palindrome = input("What word would you like to check if it is a palindrome? ")
  if check_palindrome[0:] == check_palindrome[::-1]:
    print("Yes this is a palindrome!")
  else: 
    print("No this is not a palindrome.")
