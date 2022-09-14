import requests
from bs4 import BeautifulSoup

# 서버 별 1~10000위
#serverlist = ['luna', 'elysium', 'croa', 'aurora','bera','red','union','zenith','enosis','arcane','nova']
serverlist = ['scania']
for i in serverlist :
    list1 = list()
    for j in range(1, 501, 1) :
        url = 'https://maple.gg/rank/total/%s?page=%s'% (i, j)
        response = requests.get(url)
        print(str(i), str(j), response.status_code)
        html = response.text
        soup = BeautifulSoup(html, 'html.parser')
        for k in range(1,21,1) :
            nickname = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > span:nth-child(2) > a:nth-child(1)'%k).text
            level = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > div:nth-child(3) > span:nth-child(1)'%k).text
            job = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(2) > div:nth-child(2) > div:nth-child(3) > span:nth-child(4)'%k).text.replace(',','')
            inki = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(3)'%k).text.replace(',','')
            try :
                guild = soup.select_one('.table > tbody:nth-child(3) > tr:nth-child(%s) > td:nth-child(4) > a:nth-child(1)'%k).text
            except :
                guild = '-- 없음 --'
            string = nickname + ',' + level + ',' + job + ',' + inki + ',' + guild.replace(' ','').replace('\n','')
            #print(string)
            list1.append(string)
        #print(list1, len(list1))
    a = open('ranking_%s.csv'% i, 'w',encoding='utf-8')
    for i in range(0, len(list1), 1) :
        a.write(list1[i] + '\n')
    a.close()