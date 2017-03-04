library(data.table)
library(reshape2)

setwd("C:/Users/hdanish/Documents/Berkeley/W241/Project")

ASF = read.csv(file="Audio_Survey_FINAL.csv", header=TRUE, sep=",")
ASF = data.table(ASF)

DAT = data.frame(user=integer(),
                 bitrate=character(), 
                 song=character(), 
                 enjoyment=integer(), 
                 quality=integer(), 
                 browser=character(), 
                 equipment=integer(), 
                 usual=integer(), 
                 frequency=integer(), 
                 location=integer(), 
                 age=integer(), 
                 stringsAsFactors=FALSE) 

for(i in 1:nrow(ASF)) {
  i_user = i
  i_browser = ASF[i]$Browser.Meta.Info.Browser
  i_equipment = as.numeric(ASF[i]$SpeakType)
  i_usual = as.numeric(ASF[i]$NormalUse)
  i_frequency = as.numeric(ASF[i]$ListFreq)
  i_location = as.numeric(ASF[i]$ListLoc)
  i_age = as.numeric(ASF[i]$Age)
  
  i_AW = "Around the World"
  i_GL = "Get Lucky"
  
  # We will always have groups of observations so we only need to check a single variable
  # First for the first question/observation
  if (!is.na(ASF[i]$X96.AW_1)) {
    i_q1_bitrate = "96"
    i_enjoy_AW1 = ASF[i]$X96.AW_1
    i_quality_AW1 = ASF[i]$X96.AW_2
    i_enjoy_GL1 = ASF[i]$X96.GL_1
    i_quality_GL1 = ASF[i]$X96.GL_2
  } 
  else if (!is.na(ASF[i]$X128.AW_1)) {
    i_q1_bitrate = "128"
    i_enjoy_AW1 = ASF[i]$X128.AW_1
    i_quality_AW1 = ASF[i]$X128.AW_2
    i_enjoy_GL1 = ASF[i]$X128.GL_1
    i_quality_GL1 = ASF[i]$X128.GL_2
  }
  else if (!is.na(ASF[i]$X256.AW_1)) {
    i_q1_bitrate = "256"
    i_enjoy_AW1 = ASF[i]$X256.AW_1
    i_quality_AW1 = ASF[i]$X256.AW_2
    i_enjoy_GL1 = ASF[i]$X256.GL_1
    i_quality_GL1 = ASF[i]$X256.GL_2
  }
  else if (!is.na(ASF[i]$lossle.AW_1)) {
    i_q1_bitrate = "lossless"
    i_enjoy_AW1 = ASF[i]$lossle.AW_1
    i_quality_AW1 = ASF[i]$lossle.AW_2
    i_enjoy_GL1 = ASF[i]$lossle.GL_1
    i_quality_GL1 = ASF[i]$lossle.GL_2
  }
  
  # Now for the second question/observation
  if (!is.na(ASF[i]$X96.AW2_1)) {
    i_q2_bitrate = "96"
    i_enjoy_AW2 = ASF[i]$X96.AW2_1
    i_quality_AW2 = ASF[i]$X96.AW2_2
    i_enjoy_GL2 = ASF[i]$X96.GL2_1
    i_quality_GL2 = ASF[i]$X96.GL2_2
  } 
  else if (!is.na(ASF[i]$X128.AW2_1)) {
    i_q2_bitrate = "128"
    i_enjoy_AW2 = ASF[i]$X128.AW2_1
    i_quality_AW2 = ASF[i]$X128.AW2_2
    i_enjoy_GL2 = ASF[i]$X128.GL2_1
    i_quality_GL2 = ASF[i]$X128.GL2_2
  }
  else if (!is.na(ASF[i]$X256.AW2_1)) {
    i_q2_bitrate = "256"
    i_enjoy_AW2 = ASF[i]$X256.AW2_1
    i_quality_AW2 = ASF[i]$X256.AW2_2
    i_enjoy_GL2 = ASF[i]$X256.GL2_1
    i_quality_GL2 = ASF[i]$X256.GL2_2
  }
  else if (!is.na(ASF[i]$lossle.AW2_1)) {
    i_q2_bitrate = "lossless"
    i_enjoy_AW2 = ASF[i]$lossle.AW2_1
    i_quality_AW2 = ASF[i]$lossle.AW2_2
    i_enjoy_GL2 = ASF[i]$lossle.GL2_1
    i_quality_GL2 = ASF[i]$lossle.GL2_2
  }
  
  # Create four vectors for the four different song/bitrate combinations
  i_v1 = c(i_user,
           i_q1_bitrate,
           i_AW,
           as.numeric(i_enjoy_AW1),
           as.numeric(i_quality_AW1),
           i_browser, i_equipment, i_usual, i_frequency, i_location, i_age)
  
  i_v2 = c(i_user,
           i_q1_bitrate,
           i_GL,
           as.numeric(i_enjoy_GL1),
           as.numeric(i_quality_GL1),
           i_browser, i_equipment, i_usual, i_frequency, i_location, i_age)
  
  i_v3 = c(i_user,
           i_q2_bitrate,
           i_AW,
           as.numeric(i_enjoy_AW2),
           as.numeric(i_quality_AW2),
           i_browser, i_equipment, i_usual, i_frequency, i_location, i_age)
  
  i_v4 = c(i_user,
           i_q2_bitrate,
           i_GL,
           as.numeric(i_enjoy_GL2),
           as.numeric(i_quality_GL2),
           i_browser, i_equipment, i_usual, i_frequency, i_location, i_age)
  
  DAT[nrow(DAT)+1, ] = i_v1
  DAT[nrow(DAT)+1, ] = i_v2
  DAT[nrow(DAT)+1, ] = i_v3
  DAT[nrow(DAT)+1, ] = i_v4
}

DAT = data.table(DAT)

# Fix data types, not sure why they aren't done from above
DAT$user = as.factor(DAT$user)
DAT$enjoyment = as.numeric(DAT$enjoyment)
DAT$quality = as.numeric(DAT$quality)
DAT$browser = as.factor(DAT$browser)
DAT$equipment = as.factor(DAT$equipment)
DAT$usual = as.factor(DAT$usual)
DAT$frequency = as.factor(DAT$frequency)
DAT$location = as.factor(DAT$location)
DAT$age = as.numeric(DAT$age)

# Helper function
sig_stars = function(p)
{
  stars = symnum(p, na = F, cutpoints = c(0, .001, .01, .05, .1, 1), symbols=c("***","**", "*", ".", " "))
  return( paste(round(p, 3), stars) )
}

# Browser comparison
summary(ASF$Browser.Meta.Info.Browser)
summary(DAT$browser)

by(DAT$enjoyment, DAT$browser, mean, na.rm=T)
baove = aov(enjoyment ~ browser, DAT)
summary(baove)
ttbe = pairwise.t.test(DAT$enjoyment, DAT$browser, p.adjust.method = "bonferroni")
ttbe_table = apply(ttbe$p.value, c(1,2), sig_stars)
ttbe_table = noquote(ttbe_table)
ttbe_table[upper.tri(ttbe_table)] = ""
ttbe_table
TukeyHSD(baove, conf.level = 0.95)
# ==> Only four different people on browser 5 (16 obs total) so likely not conclusive

by(DAT$quality, DAT$browser, mean, na.rm=T)
baovq = aov(quality ~ browser, DAT)
summary(baovq)
ttbq = pairwise.t.test(DAT$quality, DAT$browser, p.adjust.method = "bonferroni")
ttbq_table = apply(ttbq$p.value, c(1,2), sig_stars)
ttbq_table = noquote(ttbq_table)
ttbq_table[upper.tri(ttbq_table)] = ""
ttbq_table
TukeyHSD(baovq, conf.level = 0.95)
# ==> Only sixteen different people on browser 4 (52 obs total) so likely not conclusive

# Equipment comparison
by(DAT$enjoyment, DAT$equipment, mean, na.rm=T)
eaove = aov(enjoyment ~ equipment, DAT)
summary(eaove)
ttee = pairwise.t.test(DAT$enjoyment, DAT$equipment, p.adjust.method = "bonferroni")
ttee_table = apply(ttee$p.value, c(1,2), sig_stars)
ttee_table = noquote(ttee_table)
ttee_table[upper.tri(ttee_table)] = ""
ttee_table
TukeyHSD(eaove, conf.level = 0.95)
# ==> No difference between main equipment, curious difference between in-ear heapdhones (one of the highest ratings) and over-ear headphones (one of the lowest ratings)

by(DAT$quality, DAT$equipment, mean, na.rm=T)
eaovq = aov(quality ~ equipment, DAT)
summary(eaovq)
tteq = pairwise.t.test(DAT$quality, DAT$equipment, p.adjust.method = "bonferroni")
tteq_table = apply(tteq$p.value, c(1,2), sig_stars)
tteq_table = noquote(tteq_table)
tteq_table[upper.tri(tteq_table)] = ""
tteq_table
TukeyHSD(eaovq, conf.level = 0.95)
# ==> 10% level difference between in-ear and over-ear

# Bitrate comparison
by(DAT$enjoyment, DAT$bitrate, mean, na.rm=T)
raove = aov(enjoyment ~ bitrate, DAT)
summary(raove)
ttre = pairwise.t.test(DAT$enjoyment, DAT$bitrate, p.adjust.method = "bonferroni")
ttre_table = apply(ttre$p.value, c(1,2), sig_stars)
ttre_table = noquote(ttre_table)
ttre_table[upper.tri(ttre_table)] = ""
ttre_table
TukeyHSD(raove, conf.level = 0.95)
# ==> NO DIFFERENCES AT ALL

by(DAT$quality, DAT$bitrate, mean, na.rm=T)
raovq = aov(quality ~ bitrate, DAT)
summary(raovq)
ttrq = pairwise.t.test(DAT$quality, DAT$bitrate, p.adjust.method = "bonferroni")
ttrq_table = apply(ttrq$p.value, c(1,2), sig_stars)
ttrq_table = noquote(ttrq_table)
ttrq_table[upper.tri(ttrq_table)] = ""
ttrq_table
TukeyHSD(raovq, conf.level = 0.95)
# ==> NO DIFFERENCES AT ALL

# Histograms

# Enjoyment
hist(DAT[bitrate=="96", enjoyment], main="96kbps enjoyment (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,70))
hist(DAT[bitrate=="128", enjoyment], main="128kbps enjoyment (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,70))
hist(DAT[bitrate=="256", enjoyment], main="256kbps enjoyment (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,70))
hist(DAT[bitrate=="lossless", enjoyment], main="Lossless enjoyment (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,70))

# Quality
hist(DAT[bitrate=="96", quality], main="96kbps quality (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,80))
hist(DAT[bitrate=="128", quality], main="128kbps quality (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,80))
hist(DAT[bitrate=="256", quality], main="256kbps quality (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,80))
hist(DAT[bitrate=="lossless", quality], main="Lossless quality (part 1)", xlab="rating", xlim=c(1,7), breaks=7, ylim=c(0,80))

# Linear model?
lme = lm(enjoyment ~ bitrate + equipment + browser + usual + frequency + location + age, DAT)
summary(lme)

lmq = lm(quality ~ bitrate + equipment + browser + usual + frequency + location + age, DAT)
summary(lmq)
