#Exercise 1
#Create a program that asks the user to enter their name and their age. Print out a message addressed to them that tells them the year that they will turn 100 years old. Note: for this exercise, the expectation is that you explicitly write out the year (and therefore be out of date the next year). If you want to do this in a generic way, see exercise 39.

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
#The exercise comes first (with a few extras if you want the extra challenge or want to spend more time), followed by a discussion. Enjoy!
#Ask the user for a number. Depending on whether the number is even or odd, print out an appropriate message to the user. Hint: how does an even / odd number react differently when divided by 2?

#Extras:
#    If the number is a multiple of 4, print out a different message.
#    Ask the user for two numbers: one number to check (call it num) and one number to divide by (check). If check divides evenly into num, tell that to the user. If not, print a different appropriate message.
