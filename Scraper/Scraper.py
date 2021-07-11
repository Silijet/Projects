#Get beautiful soup
from bs4 import BeautifulSoup
from datetime import datetime
#Function that improves connection to URL
s=requests.session()
i = 1920

with open('plane_crash_data.csv', mode='w') as f
    # define header here either as an array or a dict
    csv.writerow() # header, which you only want to write once
    for i <= datetime.now().year:
        # put in try catch
        try:
            response = s.get(f'www.planecrashinfo.com/{i}/{i}')
        # this should be the html skeleton of the page
            soup = BeautifulSoup(response.text, 'html.parser')
            i = i+1
        except:
            print("Response error")
            quit()
        # parse based on attribute names
        # and match the format of the header
        # the data struct you store the data in will be the same data struct as the header
        for row in rows # rows are what you will get from beautiful soup
            # may have to edit to match format
            csv.writerow(row)