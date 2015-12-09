# 改行区切りの数値データを平均する

read_key <- function() {
    return (scan("b",skip=0,what=character(), nlines=1))
}
read_data <- function(){
    return (read.table("b",skip=1))
}

print_zabbix <- function(source_key,postfix,value){
    r_key <- sub("[",paste(".",postfix,"[",sep=""),source_key,fixed=TRUE) 
    if(r_key==source_key){
        r_key <- paste(source_key,postfix,sep=".") 
    }
    cat(paste(r_key,as.integer(Sys.time()),value))
    cat("\n") 
}


key <- read_key()
resource <- read_data()
print_zabbix(key,"mean",mean(resource$V1))

library(base64) 
pngfile <- tempfile("Rtmp","/tmp")
png( pngfile, width = 300, height = 300 )
    boxplot(resource$V1)
graphics.off()
boximg <- (gsub("\n","",(img(pngfile))))

print_zabbix(key,"boxplot",boximg)
