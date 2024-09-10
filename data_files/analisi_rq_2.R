library(readxl)
library(dplyr)

# RQ2: How indicative are the identified symptoms of the presence of community smells?

column_names <- c("Timestamp","Prolific_ID","Experience_LoneWolf","Impact_HRM_LoneWolf","LoneWolfQ1","LoneWolfQ2","LoneWolfOF","Experience_PrimaDonna","Impact_HRM_PrimaDonna","PrimaDonnaQ1","PrimaDonnaQ2","PrimaDonnaOF","Experience_BlackCloud","Impact_HRM_BlackCloud","BlackCloudQ1","BlackCloudQ2","BlackCloudQ3","BlackCloudOF","Experience_LonesomeArch","Impact_HRM_LonesomeArch","LonesomeArchQ1","LonesomeArchQ2","LonesomeArchQ3","LonesomeArchOF","OtherSmells1","OtherSmells2","OthersCSExperienced")
practitioners_response <- read_excel("An Empirical Study on Community Smells within Project Teams - Answers.xlsx", col_names = column_names, skip=1)

#-----LONE WOLF-----

lone_wolf_frequency_experience <- practitioners_response[3] %>% mutate(Experience_LoneWolf = case_when(
  Experience_LoneWolf == "Never" ~ 0.2,
  Experience_LoneWolf == "Rarely" ~ 0.4,
  Experience_LoneWolf == "Sometimes" ~ 0.6,
  Experience_LoneWolf == "Often" ~ 0.8,
  Experience_LoneWolf == "Always" ~ 1, 
))

exp_LW <- practitioners_response[3] %>% mutate(Experience_LoneWolf = case_when(
  Experience_LoneWolf == "Never" ~ 1,
  Experience_LoneWolf == "Rarely" ~ 2,
  Experience_LoneWolf == "Sometimes" ~ 3,
  Experience_LoneWolf == "Often" ~ 4,
  Experience_LoneWolf == "Always" ~ 5, 
))

mean(exp_LW$Experience_LoneWolf)

#LW Weights
weights_lw <- lone_wolf_frequency_experience$Experience_LoneWolf

#LW EXPRPlot
pie_value_converted <- practitioners_response[3]

scala_likert <- c("Never", "Rarely", "Sometimes", "Often", "Always")

ni <- sum(pie_value_converted$Experience_LoneWolf == "Never")
si <- sum(pie_value_converted$Experience_LoneWolf == "Rarely")
mi <- sum(pie_value_converted$Experience_LoneWolf == "Sometimes")
qi <- sum(pie_value_converted$Experience_LoneWolf == "Often")
ei <- sum(pie_value_converted$Experience_LoneWolf == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "In your experience, how much have you encountered a Lone Wolf in the past?", cex.main = 0.9)


#LW HRM Mean
values <- practitioners_response$Impact_HRM_LoneWolf
media_pesata_lw_hrm <- weighted.mean(values, weights_lw)

varianza <- sum((values - media_pesata_lw_hrm)^2) / length(values)
deviazione_standard <- sqrt(varianza)

#LW HRM  Plot
pie_value_converted <- practitioners_response[4] %>% mutate(Impact_HRM_LoneWolf = case_when(
  Impact_HRM_LoneWolf == 1 ~ "Never",
  Impact_HRM_LoneWolf == 2 ~ "Rarely",
  Impact_HRM_LoneWolf == 3 ~ "Sometimes",
  Impact_HRM_LoneWolf == 4 ~ "Often",
  Impact_HRM_LoneWolf == 5 ~ "Always", 
))



ni <- sum(pie_value_converted$Impact_HRM_LoneWolf == "Never")
si <- sum(pie_value_converted$Impact_HRM_LoneWolf == "Rarely")
mi <- sum(pie_value_converted$Impact_HRM_LoneWolf == "Sometimes")
qi <- sum(pie_value_converted$Impact_HRM_LoneWolf == "Often")
ei <- sum(pie_value_converted$Impact_HRM_LoneWolf == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "How much do you agree with the following sentence \n'The described behavior (Lone Wolf) negatively impacts\n human resources management.'", cex.main = 0.9)

#LW Weights
weights_lw <- lone_wolf_frequency_experience$Experience_LoneWolf

#LW Q1 Mean
values <- practitioners_response$LoneWolfQ1
media_pesata_lw_q1 <- weighted.mean(values, weights_lw)

#LW Q1 DEV.ST
varianza <- sum((values - media_pesata_lw_q1)^2) / length(values)
dev_st_lw_q1 <- sqrt(varianza)

#LW Q1  Plot
pie_value_converted <- practitioners_response[5] %>% mutate(LoneWolfQ1 = case_when(
  LoneWolfQ1 == 1 ~ "Not Indicative at all",
  LoneWolfQ1 == 2 ~ "Slightly Indicative",
  LoneWolfQ1 == 3 ~ "Moderately Indicative",
  LoneWolfQ1 == 4 ~ "Quite Indicative",
  LoneWolfQ1 == 5 ~ "Extremely Indicative", 
))

scala_indicative <- c("Not Indicative\n at all", "Slightly\nIndicative", "Moderately\nIndicative", "Quite\nIndicative", "Extremely\nIndicative") 
colori_gradiente <- colorRampPalette(c("lightblue", "darkblue"))(5)

ni <- sum(pie_value_converted$LoneWolfQ1 == "Not Indicative at all")
si <- sum(pie_value_converted$LoneWolfQ1 == "Slightly Indicative")
mi <- sum(pie_value_converted$LoneWolfQ1 == "Moderately Indicative")
qi <- sum(pie_value_converted$LoneWolfQ1 == "Quite Indicative")
ei <- sum(pie_value_converted$LoneWolfQ1 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
par(bg=NA)

barplot(tt, names.arg = scala_indicative, col = colori_gradiente, cex.main = 0.8, main = "How significantly does 'The contributor has insufficient communication with the team'\n indicates the presence of the Lone Wolf Community Smell in your experience?")
dev.copy(png,'lw.png')
dev.off()

#LW Q2 Mean
values <- practitioners_response$LoneWolfQ2
media_pesata_lw_q2 <- weighted.mean(values, weights_lw)

#LW Q2 Varianza
varianza <- sum((values - media_pesata_lw_q2)^2) / length(values)
dev_st_lw_q2 <- sqrt(varianza)

#LW Q2  Plot
pie_value_converted <- practitioners_response[6] %>% mutate(LoneWolfQ2 = case_when(
  LoneWolfQ2 == 1 ~ "Not Indicative at all",
  LoneWolfQ2 == 2 ~ "Slightly Indicative",
  LoneWolfQ2 == 3 ~ "Moderately Indicative",
  LoneWolfQ2 == 4 ~ "Quite Indicative",
  LoneWolfQ2 == 5 ~ "Extremely Indicative", 
))

ni <- sum(pie_value_converted$LoneWolfQ2 == "Not Indicative at all")
si <- sum(pie_value_converted$LoneWolfQ2 == "Slightly Indicative")
mi <- sum(pie_value_converted$LoneWolfQ2 == "Moderately Indicative")
qi <- sum(pie_value_converted$LoneWolfQ2 == "Quite Indicative")
ei <- sum(pie_value_converted$LoneWolfQ2 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, col = colori_gradiente, cex.main = 0.8, main = "How significantly does 'The contributor has insufficient communication with the team'\n indicates the presence of the Lone Wolf Community Smell in your experience?")

#-----PRIMA DONNA -----

prima_donna_frequency_experience <- practitioners_response[8] %>% mutate(Experience_PrimaDonna = case_when(
  Experience_PrimaDonna == "Never" ~ 0.2,
  Experience_PrimaDonna == "Rarely" ~ 0.4,
  Experience_PrimaDonna == "Sometimes" ~ 0.6,
  Experience_PrimaDonna == "Often" ~ 0.8,
  Experience_PrimaDonna == "Always" ~ 1, 
))


#PD Weights
weights_pd <- prima_donna_frequency_experience$Experience_PrimaDonna

exp_PD <- practitioners_response[8] %>% mutate(Experience_PrimaDonna = case_when(
  Experience_PrimaDonna == "Never" ~ 1,
  Experience_PrimaDonna == "Rarely" ~ 2,
  Experience_PrimaDonna == "Sometimes" ~ 3,
  Experience_PrimaDonna == "Often" ~ 4,
  Experience_PrimaDonna == "Always" ~ 5, 
))

mean(exp_PD$Experience_PrimaDonna)

#PD EXPR  Plot
pie_value_converted <- practitioners_response[8]



ni <- sum(pie_value_converted$Experience_PrimaDonna == "Never")
si <- sum(pie_value_converted$Experience_PrimaDonna == "Rarely")
mi <- sum(pie_value_converted$Experience_PrimaDonna == "Sometimes")
qi <- sum(pie_value_converted$Experience_PrimaDonna == "Often")
ei <- sum(pie_value_converted$Experience_PrimaDonna == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "In your experience, how much have you encountered a Prima Donna in the past?", cex.main = 0.9)



#PD HRM Mean
values <- practitioners_response$Impact_HRM_PrimaDonna
media_pesata_pd_hrm <- weighted.mean(values, weights_pd)

#PD HRM  Plot
pie_value_converted <- practitioners_response[9] %>% mutate(Impact_HRM_PrimaDonna = case_when(
  Impact_HRM_PrimaDonna == 1 ~ "Never",
  Impact_HRM_PrimaDonna == 2 ~ "Rarely",
  Impact_HRM_PrimaDonna == 3 ~ "Sometimes",
  Impact_HRM_PrimaDonna == 4 ~ "Often",
  Impact_HRM_PrimaDonna == 5 ~ "Always", 
))

ni <- sum(pie_value_converted$Impact_HRM_PrimaDonna == "Never")
si <- sum(pie_value_converted$Impact_HRM_PrimaDonna == "Rarely")
mi <- sum(pie_value_converted$Impact_HRM_PrimaDonna == "Sometimes")
qi <- sum(pie_value_converted$Impact_HRM_PrimaDonna == "Often")
ei <- sum(pie_value_converted$Impact_HRM_PrimaDonna == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "How much do you agree with the following sentence \n'The described behavior (Prima Donna) negatively impacts\n human resources management.'", cex.main = 0.9, ylim = c(0,20))


#PD Q1 Mean
values <- practitioners_response$PrimaDonnaQ1
media_pesata_pd_q1 <- weighted.mean(values, weights_pd)

#PD Q1 Varianza
varianza <- sum((values - media_pesata_pd_q1)^2) / length(values)
dev_st_pd_q1 <- sqrt(varianza)



#PD Q1  Plot
pie_value_converted <- practitioners_response[10] %>% mutate(PrimaDonnaQ1 = case_when(
  PrimaDonnaQ1 == 1 ~ "Not Indicative at all",
  PrimaDonnaQ1 == 2 ~ "Slightly Indicative",
  PrimaDonnaQ1 == 3 ~ "Moderately Indicative",
  PrimaDonnaQ1 == 4 ~ "Quite Indicative",
  PrimaDonnaQ1 == 5 ~ "Extremely Indicative", 
))

ni <- sum(pie_value_converted$PrimaDonnaQ1 == "Not Indicative at all")
si <- sum(pie_value_converted$PrimaDonnaQ1 == "Slightly Indicative")
mi <- sum(pie_value_converted$PrimaDonnaQ1 == "Moderately Indicative")
qi <- sum(pie_value_converted$PrimaDonnaQ1 == "Quite Indicative")
ei <- sum(pie_value_converted$PrimaDonnaQ1 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, col = colori_gradiente, cex.main = 0.9, main = "How significantly does 'The contributor has an unwillingness to accept help or support\nfrom peers' indicates the presence of the Prima Donna Community Smell\n in your experience?", ylim = c(0,12))


#PD Q2 Mean
values <- practitioners_response$PrimaDonnaQ2[0:10]
media_pesata_pd_q2 <- weighted.mean(values, weights_pd[0:10])

#PD Q2 Varianza
varianza <- sum((values - media_pesata_pd_q2)^2) / length(values)
dev_st_pd_q2 <- sqrt(varianza)

#PD Q2  Plot
pie_value_converted <- practitioners_response[11] %>% mutate(PrimaDonnaQ2 = case_when(
  PrimaDonnaQ2 == 1 ~ "Not Indicative at all",
  PrimaDonnaQ2 == 2 ~ "Slightly Indicative",
  PrimaDonnaQ2 == 3 ~ "Moderately Indicative",
  PrimaDonnaQ2 == 4 ~ "Quite Indicative",
  PrimaDonnaQ2 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$PrimaDonnaQ2 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$PrimaDonnaQ2 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$PrimaDonnaQ2 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$PrimaDonnaQ2 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$PrimaDonnaQ2 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative,cex.main = 0.9, col = colori_gradiente, main = "How significantly does 'The contributor refuses to listen to the ideas or opinions of peers'\n indicates the presence of the Prima Donna Community Smell in your experience?", ylim = c(0,6))


#-----BLACK CLOUD-----

black_cloud_frequency_experience <- practitioners_response[13] %>% mutate(Experience_BlackCloud= case_when(
  Experience_BlackCloud == "Never" ~ 0.2,
  Experience_BlackCloud == "Rarely" ~ 0.4,
  Experience_BlackCloud == "Sometimes" ~ 0.6,
  Experience_BlackCloud == "Often" ~ 0.8,
  Experience_BlackCloud == "Always" ~ 1, 
))


#BC Weights
weights_bc <- black_cloud_frequency_experience$Experience_BlackCloud

exp_BC <- practitioners_response[13] %>% mutate(Experience_BlackCloud = case_when(
  Experience_BlackCloud == "Never" ~ 1,
  Experience_BlackCloud == "Rarely" ~ 2,
  Experience_BlackCloud == "Sometimes" ~ 3,
  Experience_BlackCloud == "Often" ~ 4,
  Experience_BlackCloud == "Always" ~ 5, 
))

mean(exp_BC$Experience_BlackCloud)
#BC EXPR Plot
pie_value_converted <- practitioners_response[13]



ni <- sum(pie_value_converted$Experience_BlackCloud == "Never")
si <- sum(pie_value_converted$Experience_BlackCloud == "Rarely")
mi <- sum(pie_value_converted$Experience_BlackCloud == "Sometimes")
qi <- sum(pie_value_converted$Experience_BlackCloud == "Often")
ei <- sum(pie_value_converted$Experience_BlackCloud == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "In your experience, how much have you encountered a Black Cloud in the past?", cex.main = 0.9)

#BC HRM Mean
values <- practitioners_response$Impact_HRM_BlackCloud
media_pesata_pd_hrm <- weighted.mean(values, weights_bc)

#BC HRM  Plot
pie_value_converted <- practitioners_response[14] %>% mutate(Impact_HRM_BlackCloud = case_when(
  Impact_HRM_BlackCloud == 1 ~ "Never",
  Impact_HRM_BlackCloud == 2 ~ "Rarely",
  Impact_HRM_BlackCloud == 3 ~ "Sometimes",
  Impact_HRM_BlackCloud == 4 ~ "Often",
  Impact_HRM_BlackCloud == 5 ~ "Always", 
))


ni <- sum(pie_value_converted$Impact_HRM_BlackCloud == "Never")
si <- sum(pie_value_converted$Impact_HRM_BlackCloud == "Rarely")
mi <- sum(pie_value_converted$Impact_HRM_BlackCloud == "Sometimes")
qi <- sum(pie_value_converted$Impact_HRM_BlackCloud == "Often")
ei <- sum(pie_value_converted$Impact_HRM_BlackCloud == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "How much do you agree with the following sentence \n'The described behavior (Black Cloud) negatively impacts\n human resources management.'", cex.main = 0.9, ylim = c(0,12))


#BC Q1 Mean
values <- practitioners_response$BlackCloudQ1
media_pesata_bc_q1 <- weighted.mean(values, weights_bc)

#BC Q1 Varianza
varianza <- sum((values - media_pesata_bc_q1)^2) / length(values)
dev_st_bc_q1 <- sqrt(varianza)

#BC Q1  Plot
pie_value_converted <- practitioners_response[15] %>% mutate(BlackCloudQ1 = case_when(
  BlackCloudQ1 == 1 ~ "Not Indicative at all",
  BlackCloudQ1 == 2 ~ "Slightly Indicative",
  BlackCloudQ1 == 3 ~ "Moderately Indicative",
  BlackCloudQ1 == 4 ~ "Quite Indicative",
  BlackCloudQ1 == 5 ~ "Extremely Indicative", 
))


ni <- sum(na.omit(pie_value_converted)$BlackCloudQ1 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$BlackCloudQ1 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$BlackCloudQ1 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$BlackCloudQ1 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$BlackCloudQ1 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, cex.main = 0.9, col = colori_gradiente, main = "How significantly does 'People taking matters and decisions in their own hands'\n indicates the presence of the Black Cloud Community Smell in your experience?", ylim = c(0,10))


#BC Q2 Mean
values <- practitioners_response$BlackCloudQ2[0:10]
media_pesata_bc_q2 <- weighted.mean(values, weights_bc[0:10])


#BC Q2 Varianza
varianza <- sum((values - media_pesata_bc_q2)^2) / length(values)
dev_st_bc_q2 <- sqrt(varianza)

#BC Q2  Plot
pie_value_converted <- practitioners_response[16] %>% mutate(BlackCloudQ2 = case_when(
  BlackCloudQ2 == 1 ~ "Not Indicative at all",
  BlackCloudQ2 == 2 ~ "Slightly Indicative",
  BlackCloudQ2 == 3 ~ "Moderately Indicative",
  BlackCloudQ2 == 4 ~ "Quite Indicative",
  BlackCloudQ2 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$BlackCloudQ2 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$BlackCloudQ2 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$BlackCloudQ2 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$BlackCloudQ2 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$BlackCloudQ2 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, col = colori_gradiente,cex.main = 0.9, main = "How significantly does 'The contributor hoard critical knowledge and not share it'\n indicates the presence of the Black Cloud Community Smell in your experience?", ylim = c(0,5))


#BC Q3 Mean
values <- practitioners_response$BlackCloudQ3[0:10]
media_pesata_bc_q3 <- weighted.mean(values, weights_bc[0:10])

#BC Q3 Varianza
varianza <- sum((values - media_pesata_bc_q3)^2) / length(values)
dev_st_bc_q3 <- sqrt(varianza)

#BC Q3  Plot
pie_value_converted <- practitioners_response[17] %>% mutate(BlackCloudQ3 = case_when(
  BlackCloudQ3 == 1 ~ "Not Indicative at all",
  BlackCloudQ3 == 2 ~ "Slightly Indicative",
  BlackCloudQ3 == 3 ~ "Moderately Indicative",
  BlackCloudQ3 == 4 ~ "Quite Indicative",
  BlackCloudQ3 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$BlackCloudQ3 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$BlackCloudQ3 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$BlackCloudQ3 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$BlackCloudQ3 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$BlackCloudQ3 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, cex.main = 0.8, col = colori_gradiente, main = "How significantly does 'The contributor does not communicate effectively with other peers'\n indicates the presence of the Black Cloud Community Smell in your experience?", ylim = c(0,5))

#-----LONESOME ARCHITECTING -----

lonesome_arch_frequency_experience <- practitioners_response[19] %>% mutate(Experience_LonesomeArch= case_when(
  Experience_LonesomeArch == "Never" ~ 0.2,
  Experience_LonesomeArch == "Rarely" ~ 0.4,
  Experience_LonesomeArch == "Sometimes" ~ 0.6,
  Experience_LonesomeArch == "Often" ~ 0.8,
  Experience_LonesomeArch == "Always" ~ 1, 
))


#LA Weights
weights_la <- lonesome_arch_frequency_experience$Experience_LonesomeArch

#LA EXPR Plot
pie_value_converted <- practitioners_response[19]

ni <- sum(pie_value_converted$Experience_LonesomeArch == "Never")
si <- sum(pie_value_converted$Experience_LonesomeArch == "Rarely")
mi <- sum(pie_value_converted$Experience_LonesomeArch == "Sometimes")
qi <- sum(pie_value_converted$Experience_LonesomeArch == "Often")
ei <- sum(pie_value_converted$Experience_LonesomeArch == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "In your experience, how much have you encountered a Lonesome Architecting\n in the past?", cex.main = 0.9, ylim = c(0,12))

#LA HRM Mean
values <- practitioners_response$Impact_HRM_LonesomeArch
media_pesata_la_hrm <- weighted.mean(values, weights_la)

#LA HRM  Plot
pie_value_converted <- practitioners_response[20] %>% mutate(Impact_HRM_LonesomeArch = case_when(
  Impact_HRM_LonesomeArch == 1 ~ "Never",
  Impact_HRM_LonesomeArch == 2 ~ "Rarely",
  Impact_HRM_LonesomeArch == 3 ~ "Sometimes",
  Impact_HRM_LonesomeArch == 4 ~ "Often",
  Impact_HRM_LonesomeArch == 5 ~ "Always", 
))


ni <- sum(pie_value_converted$Impact_HRM_LonesomeArch == "Never")
si <- sum(pie_value_converted$Impact_HRM_LonesomeArch == "Rarely")
mi <- sum(pie_value_converted$Impact_HRM_LonesomeArch == "Sometimes")
qi <- sum(pie_value_converted$Impact_HRM_LonesomeArch == "Often")
ei <- sum(pie_value_converted$Impact_HRM_LonesomeArch == "Always")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_likert, col = colori_gradiente, main = "How much do you agree with the following sentence \n'The described behavior (Lonesome Architecting) negatively impacts\n human resources management.'", cex.main = 0.9, ylim = c(0,11))

#LA Q1 Mean
values <- practitioners_response$LonesomeArchQ1
media_pesata_la_q1 <- weighted.mean(values, weights_bc)

#LA Q1 Varianza
varianza <- sum((values - media_pesata_la_q1)^2) / length(values)
dev_st_la_q1 <- sqrt(varianza)

#LA Q1  Plot
pie_value_converted <- practitioners_response[21] %>% mutate(LonesomeArchQ1 = case_when(
  LonesomeArchQ1 == 1 ~ "Not Indicative at all",
  LonesomeArchQ1 == 2 ~ "Slightly Indicative",
  LonesomeArchQ1 == 3 ~ "Moderately Indicative",
  LonesomeArchQ1 == 4 ~ "Quite Indicative",
  LonesomeArchQ1 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$LonesomeArchQ1 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$LonesomeArchQ1 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$LonesomeArchQ1 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$LonesomeArchQ1 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$LonesomeArchQ1 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, cex.main = 0.8, col = colori_gradiente, main = "How significantly does\n 'The contributor complained of a lack of knowledge of the product requirements'\n indicates the presence of the Lonesome Architecting Community Smell in your experience?", ylim = c(0,10))

#LA Q2 Mean
values <- practitioners_response$LonesomeArchQ2
media_pesata_la_q2 <- weighted.mean(values, weights_bc)

#LA Q2 Varianza
varianza <- sum((values - media_pesata_la_q2)^2) / length(values)
dev_st_la_q2 <- sqrt(varianza)

#LA Q2  Plot
pie_value_converted <- practitioners_response[22] %>% mutate(LonesomeArchQ2 = case_when(
  LonesomeArchQ2 == 1 ~ "Not Indicative at all",
  LonesomeArchQ2 == 2 ~ "Slightly Indicative",
  LonesomeArchQ2 == 3 ~ "Moderately Indicative",
  LonesomeArchQ2 == 4 ~ "Quite Indicative",
  LonesomeArchQ2 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$LonesomeArchQ2 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$LonesomeArchQ2 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$LonesomeArchQ2 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$LonesomeArchQ2 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$LonesomeArchQ2 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, cex.main = 0.8, col = colori_gradiente, main = "How significantly does\n 'The contributor complained of a loss of general vision of the product'\n indicates the presence of the Lonesome Architecting Community Smell\n in your experience?", ylim = c(0,10))

#LA Q3 Mean
values <- practitioners_response$LonesomeArchQ3[11:25]
media_pesata_la_q3 <- weighted.mean(values, weights_bc[11:25])

#LA Q3 Varianza
varianza <- sum((values - media_pesata_la_q3)^2) / length(values)
dev_st_la_q3 <- sqrt(varianza)

#LA Q3  Plot
pie_value_converted <- practitioners_response[23] %>% mutate(LonesomeArchQ3 = case_when(
  LonesomeArchQ3 == 1 ~ "Not Indicative at all",
  LonesomeArchQ3 == 2 ~ "Slightly Indicative",
  LonesomeArchQ3 == 3 ~ "Moderately Indicative",
  LonesomeArchQ3 == 4 ~ "Quite Indicative",
  LonesomeArchQ3 == 5 ~ "Extremely Indicative", 
))

ni <- sum(na.omit(pie_value_converted)$LonesomeArchQ3 == "Not Indicative at all")
si <- sum(na.omit(pie_value_converted)$LonesomeArchQ3 == "Slightly Indicative")
mi <- sum(na.omit(pie_value_converted)$LonesomeArchQ3 == "Moderately Indicative")
qi <- sum(na.omit(pie_value_converted)$LonesomeArchQ3 == "Quite Indicative")
ei <- sum(na.omit(pie_value_converted)$LonesomeArchQ3 == "Extremely Indicative")
tt <- c(ni,si,mi,qi,ei)
barplot(tt, names.arg = scala_indicative, cex.main = 0.8, col = colori_gradiente, main = "How significantly does\n 'The contributor complained of a loss of general vision of the product'\n indicates the presence of the Lonesome Architecting Community Smell\n in your experience?", ylim = c(0,6))

print(media_pesata_lw_q1)
print(dev_st_lw_q1)
pesoLW1 <- media_pesata_lw_q1/dev_st_lw_q1
print(pesoLW1)

print(media_pesata_lw_q2)
print(dev_st_lw_q2)
pesoLW2 <- media_pesata_lw_q2/dev_st_lw_q2
print(pesoLW2)

print(media_pesata_pd_q1)
print(dev_st_pd_q1)
pesoPD1 <- media_pesata_pd_q1/dev_st_pd_q1
print(pesoPD1)

print(media_pesata_pd_q2)
print(dev_st_pd_q2)
pesoPD2 <- media_pesata_pd_q2/dev_st_pd_q2
print(pesoPD2)

print(media_pesata_bc_q1)
print(dev_st_bc_q1)
pesoBC1 <- media_pesata_bc_q1/dev_st_bc_q1
print(pesoBC1)

print(media_pesata_bc_q2)
print(dev_st_bc_q2)
pesoBC2 <- media_pesata_bc_q2/dev_st_bc_q2
print(pesoBC2)

print(media_pesata_bc_q3)
print(dev_st_bc_q3)
pesoBC3 <- media_pesata_bc_q3/dev_st_bc_q3
print(pesoBC3)

print(media_pesata_la_q1)
print(dev_st_la_q1)
pesoLA1 <- media_pesata_la_q1/dev_st_la_q1
print(pesoLA1)

print(media_pesata_la_q2)
print(dev_st_la_q2)
pesoLA2 <- media_pesata_la_q2/dev_st_la_q2
print(pesoLA2)

print(media_pesata_la_q3)
print(dev_st_la_q3)
pesoLA3 <- media_pesata_la_q3/dev_st_la_q3
print(pesoLA3)

