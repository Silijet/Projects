#Get beautiful soup
from bs4 import BeautifulSoup
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

                i = i + 1
            except :
                print ("Unexpected error:", sys.exc_info()[0])
                raise
            # parse based on attribute names
            # and match the format of the header
            # the data struct you store the data in will be the same data struct as the header
            # for row in rows: # rows are what you will get from beautiful soup
            #     # may have to edit to match format
            #     csv.writerow(row)

if __name__ == "__main__":
    main()