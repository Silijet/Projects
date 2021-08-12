#Get beautiful soup
from bs4 import BeautifulSoup, Comment
from datetime import datetime
import requests
import sys
import csv

def main():
    #Function that improves connection to URL
    s=requests.session()

    with open('plane_crash_data.csv', mode='w') as f:
        writer = csv.writer(f)

        # Write the header for your CSV data
        writer.writerow(['Date', 'Location', 'Operator', 'Aircraft Type', 'Registration', 'Fatalities']) # header, which you only want to write once

        for i in range(1920, datetime.now().year + 1):
            # put in try catch
            try:
                response = s.get(f'http://www.planecrashinfo.com/{i}/{i}.htm')
                # this should be the html skeleton of the page
                soup = BeautifulSoup(response.text, 'html.parser')
                # Get the table from the page
                table = soup.html.body.div.center.table
                rows = table.find_all('tr') # Each row of data
                rows.pop(0) # remove table header
                
                # TODO: Iterate rows, populate list, write row to CSV
                # Example: This line currently prints the first incident date from each year
                # Need to get data returning in a row corresponding to the header
                # print(rows[0].find('font').string)

                for row in rows:
                    fonts = row.find_all('font')
                    row_data = [
                        text_clean(fonts[0]), # Date
                        text_clean(fonts[1]).split(' /n ')[0], # Location
                        text_clean(fonts[1]).split(' /n ')[1], # Operator
                        text_clean(fonts[2]).split(' /n ')[0], # Aircraft Type 
                        text_clean(fonts[2]).split(' /n ')[1], # Registration
                        text_clean(fonts[3]) # Fatalities
                        ]
                    writer.writerow(row_data)
                i = i + 1
            except :
                print ("Unexpected error:", sys.exc_info()[0])
                # raise

# Replaces <br> tags with newlines for parsing
# Removes potential html comments and unicode whitespace
def text_clean(soup_node):
    for e in soup_node.findAll('br'):
        e.replace_with('/n')
    text = " ".join(soup_node.find_all(text=lambda t: not isinstance(t, Comment)))
    text = " ".join(text.split())
    return text

if __name__ == "__main__":
    main()