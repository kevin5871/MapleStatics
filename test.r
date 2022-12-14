setwd("C:/Users/msi/Desktop/VSC Projects/MapleStatics")
a <- read.csv("ranking_all.csv",sep=",",encoding="UTF-8",header=TRUE)
luna <- read.csv("ranking_luna.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
scania <- read.csv("ranking_scania.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE)
elysium <- read.csv("ranking_elysium.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
croa <- read.csv("ranking_croa.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
aurora <- read.csv("ranking_aurora.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE)
bera <- read.csv("ranking_bera.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
red <- read.csv("ranking_red.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE)
union <- read.csv("ranking_union.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
zenith <- read.csv("ranking_zenith.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
enosis <- read.csv("ranking_enosis.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
arcane <- read.csv("ranking_arcane.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE) 
nova <- read.csv("ranking_nova.csv", sep=",", encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE)

colnames(luna) <- c("name", "level", "job", "inki", "guild")
colnames(scania) <- c("name", "level", "job", "inki", "guild")
colnames(elysium) <- c("name", "level", "job", "inki", "guild")
colnames(croa) <- c("name", "level", "job", "inki", "guild")
colnames(aurora) <- c("name", "level", "job", "inki", "guild")
colnames(bera) <- c("name", "level", "job", "inki", "guild")
colnames(red) <- c("name", "level", "job", "inki", "guild")
colnames(union) <- c("name", "level", "job", "inki", "guild")
colnames(zenith) <- c("name", "level", "job", "inki", "guild")
colnames(enosis) <- c("name", "level", "job", "inki", "guild")
colnames(arcane) <- c("name", "level", "job", "inki", "guild")
colnames(nova) <- c("name", "level", "job", "inki", "guild")


library("ggplot2")
library("dplyr")
library("knitr")
library(dplyr)
library(gridExtra)
library(sqldf)
library(kableExtra)

server = list("luna", "scania", "elysium", "croa", "aurora", "bera", "red", "'union'", "zenith", "enosis", "arcane", "nova")
serverkor = c("luna" = "루나", "scania" = "스카니아", "elysium" = "엘리시움", "croa" = "크로아", "aurora" = "오로라", "bera" = "베라", "red" = "레드", "'union'" = "유니온", "zenith" = "제니스", "enosis" = "이노시스", "arcane" = "아케인", "nova" = "노바")
result <- data.frame(matrix(nrow=0, ncol=3))
colnames(result) <- c("server", "level", "cnt")
for (i in server) {
  string <- paste("select level from", i)
  temp <- sqldf(string)
  string <- paste("select level, count(*) from", i, "group by level")
  temp2 <- sqldf(string)
  colnames(temp2) <- c("level", "cnt")
  for (j in 1:nrow(temp2))
    result[nrow(result) + 1, ] = list(serverkor[i], temp2[j,]$level, temp2[j,]$cnt)
}
ggplot(data=result, aes(x=level, y=cnt, fill=server, label=cnt)) + geom_bar(stat="identity") + scale_y_continuous(limits=c(0, 7000), expand = c(0, 0)) + scale_x_continuous(breaks = seq(220,291,1),expand = c(0, 0))  + theme(legend.position="bottom", legend.key.size = unit(0.15, "cm"), legend.margin = margin(), legend.title = element_blank(), plot.title = element_text(hjust = 0.5), axis.text.x = element_text(size=4)) + guides(fill=guide_legend(nrow=1,byrow=TRUE)) + ggtitle("서버 통합 레벨 분포") + labs(x="레밸", y="캐릭터 개수 (단위 : 명)") + geom_text(aes(label = cnt), position = position_stack(vjust = 0.5), size = 1.5, color="#ffffff")+geom_text(aes(label = after_stat(y), group = level), stat = 'summary', fun = sum, vjust = -1, size=1.5, color="#555555")