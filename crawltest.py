import requests
from bs4 import BeautifulSoup

# 전체 랭킹 1~50000위
list1 = list()

for i in range(1, 2501, 1) :
#or i in range(1, 10, 1) :
    url = 'https://maple.gg/rank/total?page=%s'% i
    response = requests.get(url)
    print(str(i), response.status_code)
    html = response.text
    soup = BeautifulSoup(html, 'html.parser')
    for j in range(1,21,1) :
        nickname = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > span:nth-child(2) > a:nth-child(1)'%j).text
        level = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > div:nth-child(3) > span:nth-child(1)'%j).text
        job = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > div:nth-child(3) > span:nth-child(4)'%j).text
        inki = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(3)'%j).text
        try :
            guild = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(4) > a:nth-child(1)'%j).text
        except :
            guild = '-- 없음 --'
        string = nickname + ',' + level + ',' + job + ',' + inki + ',' + guild.replace(' ','').replace('\n','')
        #print(string)
        list1.append(string)
    #print(list1, len(list1))
a = open('ranking_all.csv', 'w',encoding='utf-8')
for i in range(0, len(list1), 1) :
    a.write(list1[i] + '\n')
a.close()