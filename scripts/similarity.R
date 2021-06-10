library(ggplot2)

# first: remove all variables etc. from working memory
rm(list=ls(all=TRUE))
# set working directory
setwd(".")

# oberdt.   M347, M345, M351, M353
# mitteldt. M350, M352, M348, M353

text1 <- "M351"
text2 <- "M345"
text3 <- "M347"
text4 <- "M353"
text5 <- "M348"
text6 <- "M352"
text7 <- "M350"
  
texts <- c(text1,text2,text3,text4,text5,text6,text7)

# vectors for recording (= appending) results
rec_text1 <- vector()  # text sigle
rec_text2 <- vector()  # text sigle
rec_overlap <- vector() # perc. overlap
rec_unique <- vector() # length of unique mappings (record for each text1 only)

# - go through all text pairings <t1, t2>
# - build intersection
# - and calculate overlap = intersection/totals
# - record results in indiv. vectors
# number of loops
no_texts <- length(texts)
mypath <- "../datasets/similarity/diatopic/"
suffix <- ".union"

for (i in 1:no_texts) {
  t1 <- texts[i]
  for (j in 1:no_texts) {
    
    #print(c(i, j, texts[i], texts[j]))
    t2 <- texts[j]
    
    if (t1 == t2) {} # skip identity comparison (heatmap colors will be skewed by 100% entry)
    else {

      file1 <- paste(mypath, t1, suffix, sep="")
      file2 <- paste(mypath, t2, suffix, sep="")

      # read in the two files, create unique mappings (= delete duplicates)
      # file1
      mydata1 <- read.table(file=file1, sep="\t", comment.char="", header=FALSE)
      colnames(mydata1) <- c("source", "target", "score")
      # add new column with complete mapping
      mydata1$mapping <- paste(mydata1$source, ":", mydata1$target, sep="")
      # make entries unique
      map1 <- unique(mydata1$mapping)
      
      # file2
      mydata2 <- read.table(file=file2, sep="\t", comment.char="", header=FALSE)
      colnames(mydata2) <- c("source", "target", "score")
      # add new column with complete mapping
      mydata2$mapping <- paste(mydata2$source, ":", mydata2$target, sep="")
      # make entries unique
      map2 <- unique(mydata2$mapping)
      
      # now calculate percent overlap between the two mappings
      shared <- intersect(map1, map2)
      avg_total <- length(map1)
      # record results
      rec_text1 <- c(rec_text1, t1)
      rec_text2 <- c(rec_text2, t2)
      rec_overlap <- c(rec_overlap, length(shared)/avg_total)
      rec_unique <- c(rec_unique, length(map1))
    }
  }
}

##########################################################
# some statistics
mycorrels <- cbind(rec_text1, rec_text2, rec_overlap)
mycorrels <- as.data.frame(mycorrels)
colnames(mycorrels) <- c("Text1", "Text2", "Perc")
# convert factor to numeric
mycorrels$Perc <- as.numeric(levels(mycorrels$Perc))[mycorrels$Perc]
head(mycorrels[order(mycorrels$Perc,decreasing=TRUE), ])

# average simil of each text
sort(round(tapply(mycorrels$Perc, mycorrels$Text1, mean),2))

##########################################################
# plot
# round to two digits for plotting
mycorrels$Perc <- as.numeric(format(round(mycorrels$Perc,digits=2), nsmall=2))

simil.heatmap <- ggplot(data=mycorrels, 
                        mapping=aes(
                         x=rec_text1,
                         y=rec_text2,
                         fill=Perc)) +
  # Hhatmap
  geom_tile() +
  # title
  ggtitle("Statistical similarity between the texts") +
  # label cells, white if Perc>0.19
  #geom_text(aes(label=round(Perc, 2), color=Perc>0.19, size=4)) +
  geom_text(aes(label=Perc, color=Perc>0.2)) + #, size=4)) +
  scale_color_manual(guide=FALSE, values=c("black", "white")) +
  # x-Achse: Labels vertikal
  #theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  # reorder pairs on x- and y-axis
  scale_x_discrete(limits=texts, position="top") +
  scale_y_discrete(limits=rev(texts)) +
  # niedrige Werte: weiss, hohe Werte: dunkelblau
  scale_fill_gradient(name="Simil",
                      low="#FFFFFF",
                      high="#012345") +
  xlab(label="") +
  ylab(label="") +
  theme_bw() +
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank()) # no grid

simil.heatmap
