library(tercen)
library(dplyr)
library(tidyr)

options("tercen.workflowId" = "0add2df8c4543198d0b9ab7b55003e76")
options("tercen.stepId"     = "d732d42f-cb7d-4402-9639-ca768ccba766")

getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx <- tercenCtx()

val<-ctx$op.value('fill')
val<-1

df <- ctx  %>% 
  select(.ci, .ri, .y) %>% 
  reshape2::acast(.ri ~ .ci, value.var='.y', fill = as.double(val))

min_clust <- 1
if(!is.null(ctx$op.value('min_clust'))) min_clust <- as.numeric(ctx$op.value('min_clust'))
max_clust <- 30
if(!is.null(ctx$op.value('max_clust'))) max_clust <- as.numeric(ctx$op.value('max_clust'))
  
if(min_clust > max_clust) stop("min_clust must be lower than max_clust.")

max_clust <- min(nrow(df), max_clust)

hc <- hclust(dist(df))
r_order = hc$order
clusters <- cutree(hc, k = min_clust:max_clust)#[r_order, ]
colnames(clusters) <- paste0("k_", colnames(clusters))
.ri <- seq(from = 0, to = length(r_order) - 1)#[r_order]

df <-cbind(.ri, r_order, clusters) %>% as_tibble

df_out <- df %>%
  ctx$addNamespace()

df_out_gathered <- df %>% gather(n_cluster, cluster, -.ri, -r_order) %>% 
  mutate(n_cluster = as.double(gsub("k_", "", n_cluster))) %>%
  ctx$addNamespace()

list(df_out, df_out_gathered) %>% ctx$save()
