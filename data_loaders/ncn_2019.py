import pandas as pd
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
    subpanel = page_soup.find('p', {"class":"wciecie"}).text

    return id, title, subpanel


if __name__ == "__main__":
    all_projects_links = get_project_links()
    data = pd.DataFrame({"id":[], "title":[], "subpanel":[]})

    for i in all_projects_links:
        id, title, subpanel = get_project_content(i)
        data = data.append({"id": id, "title": title, "subpanel": subpanel}, ignore_index=True)

    data.to_csv("ncn_2019.csv")