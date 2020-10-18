# Hierarchical clustering operator

##### Description

The `hierarchical_clustering_operator` performs the hierarchical clustering of a set of datapoints based on provided variable values.

##### Usage

Input projection|.
---|---
`y-axis`        | numeric, measurement 
`row`           | character, observations to cluster
`column`        | character, variables used to cluster observations 

Input parameters|.
---|---
`min_clust`        | minimal number of clusters
`max_clust`        | maximal number of clusters

Output relations|.
---|---
`k_n`        | `k_n` represents the cluster membership of the observation for `n` clusters

##### Details

Observations will be assigned to n clusters, n going from `min_clusters` to `max_clusters` as specified in
the input parameters (default are 1 to 20). `max_clusters` is set to be the minimum between the the number of observations and
`max_clusters`.

##### Details

This operator is based on the `hclust` R function.

##### See Also

[hclust_operator](https://github.com/tercen/hclust_operator)
, [pairwise_distance_operator](https://github.com/tercen/pairwise_distance_operator)

