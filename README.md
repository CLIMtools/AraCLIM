[![](https://github.com/CLIMtools/AraCLIM/blob/master/www/picture2.png)](https://github.com/CLIMtools/AraCLIM/blob/master/www/picture2.png)
<img align="right" width="100" height="100" src="https://github.com/CLIMtools/AraCLIM/blob/master/www/picture2.png">

# [AraCLIM](https://rstudio.aws.science.psu.edu:3838/aaf11/AraCLIM/ "AraCLIM")

AraCLIM (https://rstudio.aws.science.psu.edu:3838/aaf11/AraCLIM/ "AraCLIM") is an SHINY component of Arabidopsis CLIMtools (http://www.personal.psu.edu/sma3/CLIMtools.html "Arabidopsis CLIMtools")  that provides an interactive spatial analysis web platform using Leaflet. Data points represent the sites of collection of sequenced accessions in an interactive world map. AraCLIM (https://rstudio.aws.science.psu.edu:3838/aaf11/AraCLIM/ "AraCLIM") allows the inspection of two environment variables simultaneously. The user can first choose an environmental variable (Environmental variable A) that is displayed on the map using a color gradient within the ranges and units detailed in the color palette within the map. Clicking on any of the data points on the map provides information on the selected accession, including its curation details, and the value of the chosen environmental variable for the selected accession.

AraCLIM allows the user to analyze pairwise environmental conditions for these 1,131 accessions using the ggvis package in SHINY. The environmental variable selected on the map (Environmental variable A) can be compared with a second environmental variable that is user-specified (Environmental variable B); the two variables are displayed with a linear correlation provided based on data for the local environments of the 1,131 accessions. We also provide an interactive tabulated database describing the environmental variables available at AraCLIM, including their source, units and period of data collection using the DT package in SHINY.

# [Data availability](https://github.com/CLIMtools/AraCLIM/tree/master/data)

The environmental data compiled in our study is available in the data/ folder. One of the data files contains the data, and the second one contains the description of each of the environmental parameters used. For a more detailed description of these, please check the SI of our study.

# [Citation](https://www.nature.com/articles/s41559-018-0754-5)
Ferrero-Serrano, Á & Assmann SM. Phenotypic and genome-wide association with the local environment of Arabidopsis. Nature Ecology & Evolution. doi: 10.1038/s41559-018-0754-5 (2019)



