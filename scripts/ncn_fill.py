import pandas as pd
import numpy as np
from bs4 import BeautifulSoup
from requests import get

import pandas as pd
import numpy as np
from bs4 import BeautifulSoup
from requests import get



def get_project_content(page_url):
    page = get(page_url)
    page_soup = BeautifulSoup(page.content, 'html.parser')
    id = page_soup.find('div', {"class": "important"}).p.text
    title = page_soup.find('div', {"class":"important"}).h2.text
    tmp = page_soup.findAll('p', {"class": "wciecie"})
    institution = tmp[1].text
    tmp3 = page_soup.findAll('div', {"class": "strona"})[-1].findAll('p')
    project_status = tmp3[3].text

    return [id,title, institution, project_status]


if __name__ == "__main__":
    all_projects_links = ['https://projekty.ncn.gov.pl/index.php?s=' + str(j) for j in range(1,17923)]
    data = pd.DataFrame({"id":[],"title":[],"institution":[],"project_status":[]})

    for i in all_projects_links:
        features = get_project_content(i)
        tmp = pd.DataFrame(features, index = ('id','title', 'institution','project_status')).T
        data = data.append(tmp)
    data.index = np.arange(1, data.shape[0] + 1)


    data.to_csv("ncn_fill.csv")
