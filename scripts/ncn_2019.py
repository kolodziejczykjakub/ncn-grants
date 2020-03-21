import pandas as pd
import numpy as np
from bs4 import BeautifulSoup
from requests import get


def get_project_links():
    web_urls = {"SONATINA3":"https://projekty.ncn.gov.pl/index.php?jednostka=&jednostka_miasto=&jednostka_wojewodztwo=&kierownik=&kierownik_plec=&kierownik_tytul=&status=&projekt=&kwotaprzyznanaod=&kwotaprzyznanado=&typkonkursu=&konkurs=120&grupa=&panel=&slowokluczowe=&aparatura=",
                "ETIUDA7":"https://projekty.ncn.gov.pl/index.php?jednostka=&jednostka_miasto=&jednostka_wojewodztwo=&kierownik=&kierownik_plec=&kierownik_tytul=&status=&projekt=&kwotaprzyznanaod=&kwotaprzyznanado=&typkonkursu=&konkurs=119&grupa=&panel=&slowokluczowe=&aparatura=",
                "UWERTURA3":"https://projekty.ncn.gov.pl/index.php?jednostka=&jednostka_miasto=&jednostka_wojewodztwo=&kierownik=&kierownik_plec=&kierownik_tytul=&status=&projekt=&kwotaprzyznanaod=&kwotaprzyznanado=&typkonkursu=&konkurs=121&grupa=&panel=&slowokluczowe=&aparatura="}


    all_projects_links = []

    for i in web_urls.keys():
        page = get(web_urls[i])
        page_soup = BeautifulSoup(page.content, 'html.parser')
        #pr_titles_tmp = page_soup.findAll("ol", {"start":"1"})[0].find_all("li")
        pr_titles_tmp = page_soup.find("ol", {"start": "1"}).find_all("li")
        for j in pr_titles_tmp:
            all_projects_links.append('https://projekty.ncn.gov.pl/index.php' + j.a["href"])

    return all_projects_links

def get_project_content(page_url):
    page = get(page_url)
    page_soup = BeautifulSoup(page.content, 'html.parser')
    id = page_soup.find('div', {"class":"important"}).p.text
    title = page_soup.find('div', {"class":"important"}).h2.text
    tmp = page_soup.findAll('p', {"class":"wciecie"})
    subpanel = tmp[0].text
    institution = tmp[1].text
    tmp2 = page_soup.findAll('p', {'class':'row2'})
    grant_type = tmp2[-2].text
    budget = tmp2[-1].text
    tmp3 = page_soup.findAll('div', {"class":"strona"})[-1].findAll('p')
    duration = tmp3[2].text
    project_status = tmp3[3].text
    coinvestigators = page_soup.findAll('div', {"class":"strona"})[-3].findAll('p')[-1].text

    return [id, title, subpanel, institution, grant_type, budget, duration, project_status, coinvestigators]


if __name__ == "__main__":
    all_projects_links = get_project_links()
    data = pd.DataFrame({"id":[], "title":[], "subpanel":[], "institution":[], "grant_type":[], "budget":[],
                         "duration":[], "project_status":[], "coinvestigators":[]})

    for i in all_projects_links:
        features = get_project_content(i)
        tmp = pd.DataFrame(features, index = ('id', 'title', 'subpanel', 'institution', 'grant_type',
                                              'budget', 'duration', 'project_status', 'coinvestigators')).T
        data = data.append(tmp)
    data.index = np.arange(1, data.shape[0] + 1)


    # if "ncn_2019.csv" not i
    data.to_csv("ncn_2019.csv")
    # print(get_project_content('https://projekty.ncn.gov.pl/index.php?s=10039'))