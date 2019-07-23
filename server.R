library(shiny)
library(shinyjs)
library(shiny)
library(shinyjs)
library(leaflet.extras)
library(dplyr)

shinyServer(function(input, output) {


       output$map <- renderLeaflet({
        print('render map')
        leaflet(FULL) %>% 
          addProviderTiles("OpenTopoMap") %>%
          addProviderTiles("OpenStreetMap.Mapnik", group = "OpenStreetmap") %>%
          addProviderTiles("Esri.WorldImagery", group = "Esri.WorldImagery") %>%
          addProviderTiles("Esri.WorldGrayCanvas", group = "Esri.WorldGrayCanvas") %>%
          addProviderTiles("Esri.NatGeoWorldMap", group = "Esri.NatGeoWorldMap") %>%
          addProviderTiles("Esri.OceanBasemap", group = "Esri.OceanBasemap") %>%
          addProviderTiles("CartoDB.DarkMatter", group = "DarkMatter (CartoDB)") %>%
          addHeatmap(lng = ~lng, lat = ~lat, radius = 5) %>%
          setView(lng = 0, lat = 50, zoom = 2) %>%
          addLayersControl(baseGroups = c("OpenStreetmap","OpenTopoMap",'Esri.WorldImagery',"Esri.WorldGrayCanvas","Esri.NatGeoWorldMap","Esri.OceanBasemap",'DarkMatter (CartoDB)' ),
                           options = layersControlOptions(collapsed = TRUE, autoZIndex = F, position = 'bottomleft' ))
        
        
      })
      
      
            df <- datasets[['FULL']]
      makeReactiveBinding('df')
      
      observeEvent(input$dataset,{
        print('dataset')
        leafletProxy('map')%>%clearShapes()
        df <<- datasets[[input$dataset]]  
        i.active <<- NULL
        
      })
      
      
      coords <- reactive({
        print('coords')
        
        crds <- data.frame(coordinates(df))
        leafletProxy('map')%>%fitBounds(lng1=min(crds[,1]),lng2=max(crds[,1]),
                                        lat1=min(crds[,2]),lat2=max(crds[,2]))
        
        crds
        
      })
      
      
      output$yvar <- renderUI(selectInput('yvar',label='Environmental variable B',choices =  list("Physical terrain"= c("NASA: SRTM elevation (m)","USGS:GTOPO30 Topography (m)", "Bedrock topography (meters)",	"Distance to the coast (Km)"),"Coordinates" = c("Latitude (degrees)"="lat", "Longitude (degrees)"="lng"), "NASA: MOPITT" = c("CO Spring (ppbv)" , "CO Summer (ppbv)"), "NASA: OMI"= c("NO2 Spring (billion molecules/mm2)", "NO2 Summer (billion molecules/mm2)",	"O3 Spring (Dobson Units)",	"O3 Summer (Dobson Units)",
                                                                                                  "UV index spring",	"UV index summer"), "SiB3 Modeled Global Atmosphere Carbon Flux" = c("Carbon flux spring (mol/m2/seg)"="SIB3 carbon flux spring (mol/m2/seg)", "Carbon flux summer (mol/m2/seg)"=	"SIB3 carbon flux summer (mol/m2/seg)"), "NASA: CERES"= c("Solar insolation spring (W/m2)","Solar insolation summer (W/m2)"), "NASA: FLASHFlux"= c("Net radiation spring (W/m2)",	
                                                                                                  "Net radiation summer (W/m2)"),	"NASA: GRACE"=c("Water eq. anomaly spring (cm)",	"Water eq. anomaly summer (cm)"), "Tropical Rainfall Monitoring Mission (TRMM)" = c("Rainfall spring (mm)",	"Rainfall summer (mm)"),"NASA: MOD05L2"= c("Precipitable water spring (cm)",	"Precipitable water summer (cm)"),
                                                                                                  "NASA: MOD11C3"= c("Land Temp day spring (°C)"="LTemp day spring (°C)",	"Land Temp day summer (°C)" = "LTemp day summer (°C)",	"Land Temp night spring (°C)" = "LTemp night spring (°C)",	"Land Temp night summer (°C)" = "LTemp night summer (°C)"), "NASA: MOD13Q1" =c("NDVI Spring",	"NDVI Summer"),"NASA: MOD15A2"=c("LAI Spring (m2/m2)","LAI Summer (m2/m2)"),"NASA: MOD16A2"=c("Potential evaporation (mm/yr)"="PET (mm/yr)","Evaporation (mm/yr)" ="ET (mm/yr)",
                                                                                                  "Latent heat (W/m2)"="LE (W/m2)",	"Aridity index",	"Climatic water deficit (mm/yr)",	"Number of dry months (days)"), "NASA: MOD17A2"= c("GPP Spring (gC/m2/day)",	"GPP Summer (gC/m2/day)",	"NPP Spring (gC/m2/day)",	"NPP Summer (gC/m2/day)"),  "AVHRR Vegetation Health Product (NOAA STAR)"= c("Smoothed Brightness Temperature spring"="AVHRR Smoothed Brightness Temperature spring",	"Smoothed Brightness Temperature summer"="AVHRR Smoothed Brightness Temperature summer", "Smoothed NDVI spring"="AVHRR Smoothed NDVI spring","Smoothed NDVI summer"=	"AVHRR Smoothed NDVI summer","Temperature Condition Index spring"="AVHRR Temperature Condition Index spring",
                                                                                                  "Temperature Condition Index summer"= "AVHRR Temperature Condition Index summer",	"Vegetation Condition Index spring"="AVHRR Vegetation Condition Index spring","Vegetation Condition Index summer"="AVHRR Vegetation Condition Index summer",	"Vegetation Health Index spring"="AVHRR Vegetation Health Index spring", "Vegetation Health Index summer"="AVHRR Vegetation Health Index summer"),	
                                                                                                  "WORLD BANK Global Solar Atlas" = c("Photovoltaic power potential (kWh/kWp)"="WB PVOUT (kWh/kWp)","Global horizontal irradiation (kWh/m2)"="WB GHI (kWh/m2)","Diffuse horizontal irradiation (kWh/m2)"=	"WB DIF (kWh/m2)","Global irradiation for optimally tilted surface (kWh/m2)"=	"WB GTI (kWh/m2)","Optimum tilt to maximize yearly yield (kWh/m2)" = "WB OPTA (degrees)", "Direct normal irradiation (kWh/m2)"= "WB DNI (kWh/m2)","Air temperature at 2 m above ground level (°C)" ="WB TEMP (°C)","Terrain elevation above sea level (m)"="WB ELE (m)"),	"GPCC Global Precipitation Climatology Centre" = c("GPCC Spring (mm)",	"GPCC Summer (mm)"),
                                                                                                  "WorldClim 2.0" = c("Tmin spring (°C)"="WC2 Tmin spring (°C)", "Tmin summer (°C)"="WC2 Tmin summer (°C)",	"Tmax spring (°C)"="WC2 Tmax spring (°C)","Tmax summer (°C)"="WC2 Tmax summer (°C)","Average temperature spring (°C)"="WC2 Average temperature spring (°C)","Average temperature summer (°C)"="WC2 Average temperature summer (°C)",	"Pre spring (mm)"="WC2 Pre spring (mm)","Pre summer (mm)"= "WC2 Pre summer (mm)",
                                                                                                  "Water vapor pressure spring (kPa)"=	"WC2 Water vapor pressure spring (kPa)","Water vapor pressure summer (kPa)"="WC2 Water vapor pressure summer (kPa)","Solar radiation spring (kJ m-2 day-1)"="WC2 Solar radiation spring (kJ m-2 day-1)",	"Solar radiation summer (kJ m-2 day-1)" = "WC2 Solar radiation summer (kJ m-2 day-1)", "BIO1 (°C)"= "WC BIO1 (°C)","BIO2 (°C)"="WC2_BIO2 (°C)","BIO3 (°C)"="WC2_BIO3 (°C)","BIO4 (°C)"="WC2 BIO4 (°C)","BIO5 (°C)"="WC2 BIO5 (°C)",
                                                                                                  "BIO6 (°C)"="WC2 BIO6 (°C)", "BIO7 (°C)"="WC2 BIO7 (°C)","BIO8 (°C)"="WC2 BIO8 (°C)",	"BIO9 (°C)"="WC2 BIO9 (°C)", "BIO10 (°C)"="WC2 BIO10 (°C)", "BIO11 (°C)"="WC2 BIO11 (°C)","BIO12 (mm)"="WC2 BIO12 (mm)",	"BIO13 (mm)"="WC2 BIO13 (mm)", "BIO14 (mm)"="WC2 BIO14 (mm)", "BIO15 (mm)"="WC2 BIO15 (mm)", "BIO16 (mm)"="WC2 BIO16 (mm)",	"BIO17 (mm)"= "WC2 BIO17 (mm)",	"BIO18 (mm)"="WC2 BIO18 (mm)",	
                                                                                                  "BIO19 (mm)"="WC2 BIO19 (mm)"),"CHELSA (Climatologies at high resolution for the earth’s land surface areas) "=c("Tmin Spring (°C)"="CHELSA Tmin Spring (°C)", "Tmin spring (°C)"="CHELSA Tmin spring (°C)",	"Tmax spring (°C)"="CHELSA Tmax spring (°C)", "Tmax summer (°C)"="CHELSA Tmax summer (°C)","Tmean spring (°C)"="CHELSA Tmean spring (°C)", "Tmean summer (°C)"= "CHELSA Tmean summer (°C)",	"Interann_Temp (°C)"="CHELSA Interann_Temp (°C)",	"Pre spring (mm)"="CHELSA Pre spring (mm)",	
                                                                                                  "Pre summer (mm)"="CHELSA Pre summer (mm)",	"Interann pre (mm)"="CHELSA Interann pre (mm)","BIO1 (°C)"="CHELSA BIO1 (°C) ","BIO2 (°C)"="CHELSA BIO2 (°C)","BIO3 (°C)"="CHELSA BIO3 (°C)","BIO4 (°C)"="CHELSA BIO4 (°C)","BIO5 (°C)"="CHELSA BIO5 (°C)", "BIO6 (°C)"="CHELSA BIO6 (°C)","BIO7 (°C)"="CHELSA BIO7 (°C)",	"BIO8 (°C)"="CHELSA BIO8 (°C)",	"BIO9 (°C)"="CHELSA BIO9 (°C)",
                                                                                                  "BIO10 (°C)"="CHELSA BIO10 (°C)",	"BIO11 (°C)"="CHELSA BIO11 (°C)",	"BIO12 (mm)"="CHELSA BIO12 (mm)",	"BIO13 (mm)"="CHELSA BIO13 (mm)", "BIO14 (mm)"="CHELSA BIO14 (mm)",	"BIO15 (mm)"="CHELSA BIO15 (mm)",	"BIO16 (mm)"="CHELSA BIO16 (mm)",	"BIO17 (mm)"="CHELSA BIO17 (mm)",  "BIO18 (mm)"="CHELSA BIO18 (mm)", "BIO19 (mm)"="CHELSA BIO19 (mm)"),
                                                                                                  "CRU-TS v3.10.01"= c("Cloud cover spring (%)"="CRU Cld spring (%)",	"Cloud cover summer (%)"="CRU Cld summer (%)", "Diurnal temperature range spring (°C)"="CRU Dtr spring (°C)", "Diurnal temperature range summer (°C)"="CRU Dtr summer (°C)", "Frost day frequency spring (days)"= "CRU Frs spring (days)",	"Frost day frequency summer (days)"="CRU Frs summer (days)","Precipitation spring (mm)"= "CRU Pre spring (mm)",	"Precipitation summer (mm)"="CRU Pre summer (mm)", "Daily mean temperature spring (°C)"= "CRU Tmp spring (°C)",	"Daily mean temperature summer (°C)"="CRU Tmp summer (°C)",	
                                                                                                  "Monthly average daily min temperature spring (°C)"="CRU Tmn spring (°C)",	"Monthly average daily min temperature summer (°C)"="CRU Tmn summer (°C)","Monthly average daily max temperature spring (°C)"= "CRU Tmx spring (°C)","Monthly average daily max temperature summer (°C)"=	"CRU Tmx summer (°C)",
                                                                                                  "Vapour pressure spring (hPa)"=	"CRU Vap spring (hPa)","Vapour pressure summer (hPa)"="CRUVap_summer (hPa)", "Wet day frequency spring (days)"=	"CRU Wet spring (days)","Wet day frequency summer (days)"=	"CRU Wet summer (days)", "Potential evapotranspiration spring (mm)"=	"CRU PET Spring (mm)","Potential evapotranspiration summer (mm)"=	"CRU PET Summer (mm)","Growing degree (days)"),	
                                                                                                  "FAO World maps of climatological net primary production of biomass" = c("dNPPdP (g/m2/mm)",	"dNPPdT (g/m2/ºC)",	"CRU NPP (g/m2)",	"NPP based on GPCP (g/m2)",	"NPP based on GPCP VASClimO  (g/m2)"), "FAO Koeppen Climatology"=c("GPCC VASClimO Precipitation (mm)" ,	"CRU Precipitation (mm)",	"CRU_Temperature (ºC)",		
                                                                                                  "Griesser_Precip_GPCC (mm)",	"GPCC Fulldata Precipitation",	"Aridity index of De Martonne GPCC Fulldata",	"Aridity index of De Martonne GPCC VASClimO",	"Aridity index of De Martonne CRU"),"Harmonized World Soil Database v 1.2"=c("Topsoil ref bulk dens (kg/dm3)"="HWSD Topsoil ref bulk dens (kg/dm3)",
                                                                                                  "Topsoil clay fraction (%)"="HWSD Topsoil clay fraction (%)",	"Topsoil gravel content (%)"="HWSD Topsoil gravel content (%)",	"Topsoil silt fraction (%)"="HWSD Topsoil silt fraction (%)",	"Topsoil sand fraction (%)"="HWSD Topsoil sand fraction (%)",	"Topsoil organic carbon (%)"="HWSD Topsoil organic carbon (%)",	"Topsoil pH (-log(H+))"="HWSD Topsoil pH (-log(H+))",	"Subsoil ref bulk dens (kg/dm3)"="HWSD Subsoil ref bulk dens (kg/dm3)",	
                                                                                                  "Subsoil clay fraction (%)"="HWSD Subsoil clay fraction (%)",	"Subsoil gravel content (%)"="HWSD Subsoil gravel content (%)",	"Subsoil silt fraction (%)"="HWSD Subsoil silt fraction (%)",	"Subsoil sand fraction (%)"="HWSD Subsoil sand fraction (%)",	"Subsoil organic carbon (%)"="HWSD Subsoil organic carbon (%)",	"Subsoil pH (-log(H+))"="HWSD Subsoil pH (-log(H+))",	"Spatially dominan major soil group FAO"="HWSD Spatially dominan major soil group FAO"),
                                                                                                  "Global data set of derived soil properties (ISRIC WISE)" = c("SoilCarbonate Carbon Dens (kg C/m)"="ISRIC WISE SoilCarbonate Carbon Dens (kg C/m)",	"Soil Org Carbon Dens (kg C/m)"="ISRIC WISE Soil Org Carbon Dens (kg C/m)",	"Soil pH (log(H+))"= "ISRIC WISE Soil pH (log(H+))", "Total Avail Water cap (mm)"="ISRIC WISE Total AvailWater cap (mm)"), "ISRIC Soilgrids"= c("Absolute depth to bedrock (cm)"="SoilGrids absolute depth to bedrock (cm)",	"Bulk density (kg/m3)"=	"SoilGrids bulk density (kg/m3)",	
                                                                                                  "Cation exchange capacity of soil (meq/100 g)"="SoilGrids cation exchange capacity of soil (meq/100 g)", "Clay content (%)"=	"SoilGrids clay content (%)",	"Course fragments volumetric (%)"="SoilGrids course fragments volumetric (%)",	"Soil organic carbon stock per ha (kg/m3)"="SoilGrids soil organic carbon stock per ha (kg/m3)",	"Soil organic carbon content (‰)"="SoilGrids soil organic carbon content (‰)",	
                                                                                                  "Soil pH H2O (log(H+))"="SoilGrids soil pH H2O (log(H+))",	"Soil pH KCL (log(H+))"="SoilGrids soil pH KCL (log(H+))","Silt content (%)"="SoilGrids silt content (%)",	"Sand content (%)"="SoilGrids sand content (%)"),	
                                                                                                  "FAO Global Agro-ecological Zones Assessment for Agriculture (GAEZ 2008)"=c("Nutrient availability" = "GAEZ Nutrient availability","Nutrient retention capacity"="GAEZ Nutrient retention capacity",	"Rooting conditions"="GAEZ Rooting conditions",	"Oxygen availability to roots"="GAEZ Oxygen availability to roots",	"Excess_salts"="GAEZ Excess salts",	"Toxicity"="GAEZ Toxicity","Suitability for Agriculture (index)"), "Other"	= c("Dunne and Willmott 2000 Plant extractable water capacity of Soil (cm/cm)"="Plant extractable water capacity of Soil (cm/cm)",	
                                                                                                  "IGBP DIS Soil pH (-log(H+))", "ISLSCP II CO2 EMISSIONS (C/cm2/sec)"))))
      output$xvar <- renderUI(selectInput('color',label='Environmental variable A (mapped)',choices = list( "NASA: CERES"= c("Solar insolation spring (W/m2)","Solar insolation summer (W/m2)"),"Physical terrain"= c("USGS:GTOPO30 Topography (m)", "NASA: SRTM elevation (m)","Bedrock topography (meters)",	"Distance to the coast (Km)"),"Coordinates" = c("Longitude (degrees)" ="lng", "Latitude (degrees)"="lat"), "NASA: MOPITT" = c("CO Spring (ppbv)" , "CO Summer (ppbv)"), "NASA: OMI"= c("NO2 Spring (billion molecules/mm2)", "NO2 Summer (billion molecules/mm2)",	"O3 Spring (Dobson Units)",	"O3 Summer (Dobson Units)",
                                                                                                          "UV index spring",	"UV index summer"), "SiB3 Modeled Global Atmosphere Carbon Flux" = c("Carbon flux spring (mol/m2/seg)"="SIB3 carbon flux spring (mol/m2/seg)", "Carbon flux summer (mol/m2/seg)"=	"SIB3 carbon flux summer (mol/m2/seg)"), "NASA: FLASHFlux"= c("Net radiation spring (W/m2)",	
                                                                                                          "Net radiation summer (W/m2)"),	"NASA: GRACE"=c("Water eq. anomaly spring (cm)",	"Water eq. anomaly summer (cm)"), "Tropical Rainfall Monitoring Mission (TRMM)" = c("Rainfall spring (mm)",	"Rainfall summer (mm)"),"NASA: MOD05L2"= c("Precipitable water spring (cm)",	"Precipitable water summer (cm)"),
                                                                                                          "NASA: MOD11C3"= c("Land Temp day spring (°C)"="LTemp day spring (°C)",	"Land Temp day summer (°C)" = "LTemp day summer (°C)",	"Land Temp night spring (°C)" = "LTemp night spring (°C)",	"Land Temp night summer (°C)" = "LTemp night summer (°C)"), "NASA: MOD13Q1" =c("NDVI Spring",	"NDVI Summer"),"NASA: MOD15A2"=c("LAI Spring (m2/m2)","LAI Summer (m2/m2)"),"NASA: MOD16A2"=c("Potential evaporation (mm/yr)"="PET (mm/yr)","Evaporation (mm/yr)" ="ET (mm/yr)",
                                                                                                          "Latent heat (W/m2)"="LE (W/m2)",	"Aridity index",	"Climatic water deficit (mm/yr)",	"Number of dry months (days)"), "NASA: MOD17A2"= c("GPP Spring (gC/m2/day)",	"GPP Summer (gC/m2/day)",	"NPP Spring (gC/m2/day)",	"NPP Summer (gC/m2/day)"),  "AVHRR Vegetation Health Product (NOAA STAR)"= c("Smoothed Brightness Temperature spring"="AVHRR Smoothed Brightness Temperature spring",	"Smoothed Brightness Temperature summer"="AVHRR Smoothed Brightness Temperature summer", "Smoothed NDVI spring"="AVHRR Smoothed NDVI spring","Smoothed NDVI summer"=	"AVHRR Smoothed NDVI summer","Temperature Condition Index spring"="AVHRR Temperature Condition Index spring",
                                                                                                          "Temperature Condition Index summer"= "AVHRR Temperature Condition Index summer",	"Vegetation Condition Index spring"="AVHRR Vegetation Condition Index spring","Vegetation Condition Index summer"="AVHRR Vegetation Condition Index summer",	"Vegetation Health Index spring"="AVHRR Vegetation Health Index spring", "Vegetation Health Index summer"="AVHRR Vegetation Health Index summer"),	
                                                                                                          "WORLD BANK Global Solar Atlas" = c("Photovoltaic power potential (kWh/kWp)"="WB PVOUT (kWh/kWp)","Global horizontal irradiation (kWh/m2)"="WB GHI (kWh/m2)","Diffuse horizontal irradiation (kWh/m2)"=	"WB DIF (kWh/m2)","Global irradiation for optimally tilted surface (kWh/m2)"=	"WB GTI (kWh/m2)","Optimum tilt to maximize yearly yield (kWh/m2)" = "WB OPTA (degrees)", "Direct normal irradiation (kWh/m2)"= "WB DNI (kWh/m2)","Air temperature at 2 m above ground level (°C)" ="WB TEMP (°C)","Terrain elevation above sea level (m)"="WB ELE (m)"),	"GPCC Global Precipitation Climatology Centre" = c("GPCC Spring (mm)",	"GPCC Summer (mm)"),
                                                                                                          "WorldClim 2.0" = c("Tmin spring (°C)"="WC2 Tmin spring (°C)", "Tmin summer (°C)"="WC2 Tmin summer (°C)",	"Tmax spring (°C)"="WC2 Tmax spring (°C)","Tmax summer (°C)"="WC2 Tmax summer (°C)","Average temperature spring (°C)"="WC2 Average temperature spring (°C)","Average temperature summer (°C)"="WC2 Average temperature summer (°C)",	"Pre spring (mm)"="WC2 Pre spring (mm)","Pre summer (mm)"= "WC2 Pre summer (mm)",
                                                                                                          "Water vapor pressure spring (kPa)"=	"WC2 Water vapor pressure spring (kPa)","Water vapor pressure summer (kPa)"="WC2 Water vapor pressure summer (kPa)","Solar radiation spring (kJ m-2 day-1)"="WC2 Solar radiation spring (kJ m-2 day-1)",	"Solar radiation summer (kJ m-2 day-1)" = "WC2 Solar radiation summer (kJ m-2 day-1)", "BIO1 (°C)"= "WC BIO1 (°C)","BIO2 (°C)"="WC2_BIO2 (°C)","BIO3 (°C)"="WC2_BIO3 (°C)","BIO4 (°C)"="WC2 BIO4 (°C)","BIO5 (°C)"="WC2 BIO5 (°C)",
                                                                                                          "BIO6 (°C)"="WC2 BIO6 (°C)", "BIO7 (°C)"="WC2 BIO7 (°C)","BIO8 (°C)"="WC2 BIO8 (°C)",	"BIO9 (°C)"="WC2 BIO9 (°C)", "BIO10 (°C)"="WC2 BIO10 (°C)", "BIO11 (°C)"="WC2 BIO11 (°C)","BIO12 (mm)"="WC2 BIO12 (mm)",	"BIO13 (mm)"="WC2 BIO13 (mm)", "BIO14 (mm)"="WC2 BIO14 (mm)", "BIO15 (mm)"="WC2 BIO15 (mm)", "BIO16 (mm)"="WC2 BIO16 (mm)",	"BIO17 (mm)"= "WC2 BIO17 (mm)",	"BIO18 (mm)"="WC2 BIO18 (mm)",	
                                                                                                          "BIO19 (mm)"="WC2 BIO19 (mm)"),"CHELSA (Climatologies at high resolution for the earth’s land surface areas) "=c("Tmin Spring (°C)"="CHELSA Tmin Spring (°C)", "Tmin spring (°C)"="CHELSA Tmin spring (°C)",	"Tmax spring (°C)"="CHELSA Tmax spring (°C)", "Tmax summer (°C)"="CHELSA Tmax summer (°C)","Tmean spring (°C)"="CHELSA Tmean spring (°C)", "Tmean summer (°C)"= "CHELSA Tmean summer (°C)",	"Interann_Temp (°C)"="CHELSA Interann_Temp (°C)",	"Pre spring (mm)"="CHELSA Pre spring (mm)",	
                                                                                                          "Pre summer (mm)"="CHELSA Pre summer (mm)",	"Interann pre (mm)"="CHELSA Interann pre (mm)","BIO1 (°C)"="CHELSA BIO1 (°C) ","BIO2 (°C)"="CHELSA BIO2 (°C)","BIO3 (°C)"="CHELSA BIO3 (°C)","BIO4 (°C)"="CHELSA BIO4 (°C)","BIO5 (°C)"="CHELSA BIO5 (°C)", "BIO6 (°C)"="CHELSA BIO6 (°C)","BIO7 (°C)"="CHELSA BIO7 (°C)",	"BIO8 (°C)"="CHELSA BIO8 (°C)",	"BIO9 (°C)"="CHELSA BIO9 (°C)",
                                                                                                          "BIO10 (°C)"="CHELSA BIO10 (°C)",	"BIO11 (°C)"="CHELSA BIO11 (°C)",	"BIO12 (mm)"="CHELSA BIO12 (mm)",	"BIO13 (mm)"="CHELSA BIO13 (mm)", "BIO14 (mm)"="CHELSA BIO14 (mm)",	"BIO15 (mm)"="CHELSA BIO15 (mm)",	"BIO16 (mm)"="CHELSA BIO16 (mm)",	"BIO17 (mm)"="CHELSA BIO17 (mm)",  "BIO18 (mm)"="CHELSA BIO18 (mm)", "BIO19 (mm)"="CHELSA BIO19 (mm)"),
                                                                                                          "CRU-TS v3.10.01"= c("Cloud cover spring (%)"="CRU Cld spring (%)",	"Cloud cover summer (%)"="CRU Cld summer (%)", "Diurnal temperature range spring (°C)"="CRU Dtr spring (°C)", "Diurnal temperature range summer (°C)"="CRU Dtr summer (°C)", "Frost day frequency spring (days)"= "CRU Frs spring (days)",	"Frost day frequency summer (days)"="CRU Frs summer (days)","Precipitation spring (mm)"= "CRU Pre spring (mm)",	"Precipitation summer (mm)"="CRU Pre summer (mm)", "Daily mean temperature spring (°C)"= "CRU Tmp spring (°C)",	"Daily mean temperature summer (°C)"="CRU Tmp summer (°C)",	
                                                                                                          "Monthly average daily min temperature spring (°C)"="CRU Tmn spring (°C)",	"Monthly average daily min temperature summer (°C)"="CRU Tmn summer (°C)","Monthly average daily max temperature spring (°C)"= "CRU Tmx spring (°C)","Monthly average daily max temperature summer (°C)"=	"CRU Tmx summer (°C)",
                                                                                                          "Vapour pressure spring (hPa)"=	"CRU Vap spring (hPa)","Vapour pressure summer (hPa)"="CRUVap_summer (hPa)", "Wet day frequency spring (days)"=	"CRU Wet spring (days)","Wet day frequency summer (days)"=	"CRU Wet summer (days)", "Potential evapotranspiration spring (mm)"=	"CRU PET Spring (mm)","Potential evapotranspiration summer (mm)"=	"CRU PET Summer (mm)","Growing degree (days)"),	
                                                                                                          "FAO World maps of climatological net primary production of biomass" = c("dNPPdP (g/m2/mm)",	"dNPPdT (g/m2/ºC)",	"CRU NPP (g/m2)",	"NPP based on GPCP (g/m2)",	"NPP based on GPCP VASClimO  (g/m2)"), "FAO Koeppen Climatology"=c("GPCC VASClimO Precipitation (mm)" ,	"CRU Precipitation (mm)",	"CRU_Temperature (ºC)",		
                                                                                                          "Griesser_Precip_GPCC (mm)",	"GPCC Fulldata Precipitation",	"Aridity index of De Martonne GPCC Fulldata",	"Aridity index of De Martonne GPCC VASClimO",	"Aridity index of De Martonne CRU"),"Harmonized World Soil Database v 1.2"=c("Topsoil ref bulk dens (kg/dm3)"="HWSD Topsoil ref bulk dens (kg/dm3)",
                                                                                                          "Topsoil clay fraction (%)"="HWSD Topsoil clay fraction (%)",	"Topsoil gravel content (%)"="HWSD Topsoil gravel content (%)",	"Topsoil silt fraction (%)"="HWSD Topsoil silt fraction (%)",	"Topsoil sand fraction (%)"="HWSD Topsoil sand fraction (%)",	"Topsoil organic carbon (%)"="HWSD Topsoil organic carbon (%)",	"Topsoil pH (-log(H+))"="HWSD Topsoil pH (-log(H+))",	"Subsoil ref bulk dens (kg/dm3)"="HWSD Subsoil ref bulk dens (kg/dm3)",	
                                                                                                          "Subsoil clay fraction (%)"="HWSD Subsoil clay fraction (%)",	"Subsoil gravel content (%)"="HWSD Subsoil gravel content (%)",	"Subsoil silt fraction (%)"="HWSD Subsoil silt fraction (%)",	"Subsoil sand fraction (%)"="HWSD Subsoil sand fraction (%)",	"Subsoil organic carbon (%)"="HWSD Subsoil organic carbon (%)",	"Subsoil pH (-log(H+))"="HWSD Subsoil pH (-log(H+))",	"Spatially dominan major soil group FAO"="HWSD Spatially dominan major soil group FAO"),
                                                                                                          "Global data set of derived soil properties (ISRIC WISE)" = c("SoilCarbonate Carbon Dens (kg C/m)"="ISRIC WISE SoilCarbonate Carbon Dens (kg C/m)",	"Soil Org Carbon Dens (kg C/m)"="ISRIC WISE Soil Org Carbon Dens (kg C/m)",	"Soil pH (log(H+))"= "ISRIC WISE Soil pH (log(H+))", "Total Avail Water cap (mm)"="ISRIC WISE Total AvailWater cap (mm)"), "ISRIC Soilgrids"= c("Absolute depth to bedrock (cm)"="SoilGrids absolute depth to bedrock (cm)",	"Bulk density (kg/m3)"=	"SoilGrids bulk density (kg/m3)",	
                                                                                                          "Cation exchange capacity of soil (meq/100 g)"="SoilGrids cation exchange capacity of soil (meq/100 g)", "Clay content (%)"=	"SoilGrids clay content (%)",	"Course fragments volumetric (%)"="SoilGrids course fragments volumetric (%)",	"Soil organic carbon stock per ha (kg/m3)"="SoilGrids soil organic carbon stock per ha (kg/m3)",	"Soil organic carbon content (‰)"="SoilGrids soil organic carbon content (‰)",	
                                                                                                          "Soil pH H2O (log(H+))"="SoilGrids soil pH H2O (log(H+))",	"Soil pH KCL (log(H+))"="SoilGrids soil pH KCL (log(H+))","Silt content (%)"="SoilGrids silt content (%)",	"Sand content (%)"="SoilGrids sand content (%)"),	
                                                                                                          "FAO Global Agro-ecological Zones Assessment for Agriculture (GAEZ 2008)"=c("Nutrient availability" = "GAEZ Nutrient availability","Nutrient retention capacity"="GAEZ Nutrient retention capacity",	"Rooting conditions"="GAEZ Rooting conditions",	"Oxygen availability to roots"="GAEZ Oxygen availability to roots",	"Excess_salts"="GAEZ Excess salts",	"Toxicity"="GAEZ Toxicity","Suitability for Agriculture (index)"), "Other"	= c("Dunne and Willmott 2000 Plant extractable water capacity of Soil (cm/cm)"="Plant extractable water capacity of Soil (cm/cm)",	
                                                                                                          "IGBP DIS Soil pH (-log(H+))", "ISLSCP II CO2 EMISSIONS (C/cm2/sec)"))))
      

      
      xVar <- reactive({
        print('xVar')
        if(is.null(input$xvar)) return(names(df)[1])
        # xvar_ <<- input$xvar
        input$xvar})
      
      yVar <- reactive({
        if(is.null(input$yvar)) return(names(df)[2])
        input$yvar})
      xVar <- reactive({
        print('colVar')
        if(is.null(input$color)) return(names(df)[2])
        input$color})
      
      
      
      IDVar <- reactive({
        print('ID')
        if(is.null(input$color)) return(names(df)[3])
        input$color})
      
      
      
      
      ggvisdf <- reactive({
        print('ggvesdf1')
        df1 <- df@data
        gdf <- df1[, c(xVar(), yVar(), "lng", "lat")]
        names(gdf) <- c("x", "y", "lng", "lat")
        gdf
      })  
      
      colorData <- reactive({
        print(names(input))
        print('colData')
        df1 <- df@data
        df1[,xVar()]})
      colorpal <- reactive(colorNumeric(input$pal, colorData()))
      
      pal <- reactive({colorpal()(colorData())})
      
      
      
      observe({
        
        print('update map size/opa/color')
        x <- coords()[,1]
        y <- coords()[,2]
        leafletProxy('map')%>%
          addCircleMarkers(lng=x,fillColor = pal(),
                           lat=y,
                           stroke = F,
                           layerId = as.character(1:length(x)),
                           radius = input$size/10, 
                           color = 'red',
                           fillOpacity = 1, 
                           
                           popup = paste("ID:", FULL$id, "<br>",
                                         "Name: ", FULL$name, "<br>",
                                         "Country: ", FULL$country, "<br>",
                                         "CS number: ", FULL$CS_number, "<br>",
                                         "Admixture group: ", FULL$group)  ) 
        
      })
      
      
      
      observe({
        print('legend')
        leafletProxy("map")%>%
          clearControls() %>% 
          addLegend(opacity = 1,position = "bottomright",title = xVar(),
                    pal = colorpal(), values = rev(colorData()))
        
      })
      
      
      mapData <- reactive({
        print('mapdata')
        
        mb <- input$map_bounds
        
        if(is.null(mb))
          return(1)#as.vector(rep(1,nrow(coords()))))
        if(nrow(coords())!=nrow((ggvisdf())))
          return(1)
        
        as.numeric(coords()[,1]>mb$west&coords()[,1]<mb$east&
                     coords()[,2]>mb$south&coords()[,2]<mb$north)+0.1
        
      })
      
      
      tooltip <- function(x) {
        ggvisHover <<- x
        if(is.null(x)) return(NULL)
        tt<<-paste0(c(xVar(),yVar()), ": ", format(x[1:2]), collapse = "<br/>")
        leafletProxy('map') %>%addControl(tt,layerId = 'tt',position = 'topright')
        tt
      }
      
      click_tooltip <- function(x) {
        point <- ggvisdf()[ggvisdf()$x == x$x & ggvisdf()$y == x$y, ]
        if(nrow(point) == 1) {
          leafletProxy('map') %>%
            removeMarker('hover') %>%
            addCircleMarkers(lat=point$lat, opacity = 1,
                             fillOpacity = 0,
                             radius = (input$size/5),
                             lng=point$lng,
                             layerId = 'hover',weight = 6,
                             color = 'red',fill = FALSE)
        }
        NULL
      }
      
      
      ggvisHover <- NULL
      makeReactiveBinding('ggvisHover')
      i.active <- NULL
      makeReactiveBinding('i.active')
      
      
      observeEvent(ggvisHover,{
        h <- ggvisHover[1:2]
        i.active <<- ggvisdf()[,'x']==h[[1]]&ggvisdf()[,'y']==h[[2]]
      })
      
      observeEvent(input$map_marker_mouseover,{
        id <- as.numeric(input$map_marker_mouseover$id)
        if(!is.na(id)){
          i.active <<- id
        }
      })
      
      
      
      observeEvent(i.active,{
        leafletProxy('map') %>%
          removeMarker('hover') %>%
          addCircleMarkers(lat=coords()[i.active,2],opacity = 1,
                           fillOpacity = 0,
                           radius = (input$size/5),
                           lng=coords()[i.active,1],
                           layerId = 'hover',weight = 6,
                           color = 'red',fill = FALSE) 
      })
      
      mouseOver <- reactive({
        
        p <- ggvisdf()[i.active,c('x','y')]
        if(class(i.active)=='numeric'){tooltip(p)}
        p
      })
      
      
      ####reactive text
   #   output$selected_var <- renderText({ 
    #    paste(input$color)
    #  })
      
   #   output$selected_both <- renderText({ 
      #      paste("var. A:", input$color, "vs. var. B:", input$yvar)
      #   })
      #   output$selected_bothb <- renderText({ 
      #     paste(input$color)
      #   })
      
      # output$selected_bothc <- renderText({ 
        #     paste(input$yvar)
      #     })
      
    
      #######Table
      output$a <- DT::renderDataTable(descriptiondataset, filter = 'top', options = list(
        pageLength = 25, autoWidth = TRUE))
      output$FULL <- DT::renderDataTable(FULL.val, filter = 'top', options = list(
        pageLength = 25, autoWidth = TRUE))
      
      #Xx<-input$xvar
      #Yy<-input$yvar
      
      ######Big plot X vs y
      reactive({
        ggvisdf %>% 
          ggvis(~x,~y) %>%
          set_options(width = "auto", height = "auto", resizable=TRUE) %>%    
          # add_axis("x", title = xVar())  %>% 
          add_axis("x", title = xVar(), grid = TRUE, title_offset = 40,  properties = axis_props(
            axis = list(stroke = "red"),title = list(fontSize = 20),
            labels = list(fontSize = 16)))  %>% 
          add_axis("y", title = yVar(), grid = TRUE, title_offset = 60,  properties = axis_props(
            axis = list(stroke = "blue"),title = list(fontSize = 20),
            labels = list(fontSize = 16)))  %>%      
          layer_points(size := input_slider(1, 100, value = 50,id='size',label = 'Size'),
                       opacity := 1,
                       fill := pal) %>% 
          
          add_tooltip(tooltip, "hover") %>%
          add_tooltip(click_tooltip, "click") %>%
          
          layer_points(data =mouseOver,stroke:='red',size := 150,fillOpacity=0,strokeWidth:=5) %>%
          layer_model_predictions(model = "lm", se = TRUE)
      }) %>% bind_shiny("p",'ui')
      
        
      
      #####density plot X
      ggvisdf %>% 
        ggvis(~x) %>%
        set_options(width = "auto", height = "auto", resizable=TRUE) %>%    
        add_axis("x", title = "Environmental variable A (mapped)",properties = axis_props(
          axis = list(stroke = "red"),
          title = list(fontSize = 20),
          labels = list(fontSize = 10)))  %>% 
        add_axis("y", title = 'count', properties = axis_props(
          axis = list(stroke = "red"),
          title = list(fontSize = 20),
          labels = list(fontSize = 10)))  %>%   
        
        layer_histograms(width = 0.5, center = 20, fill := "red") %>%     
        layer_points(data =mouseOver,stroke:='black',shape := "triangle-down", size := 50) %>%
        bind_shiny("p2")
      
      #####density plot y
      ggvisdf %>% 
        ggvis(~y) %>%
        set_options(width = "auto", height = "auto", resizable=TRUE) %>%    
        add_axis("x", title = 'Environmental variable B', properties = axis_props(
          axis = list(stroke = "blue"),
          title = list(fontSize = 20),
          labels = list(fontSize = 10)))  %>%   
        
        add_axis("y", title = 'count', properties = axis_props(
              axis = list(stroke = "blue"),
              title = list(fontSize = 20),
              labels = list(fontSize = 10)))  %>%  
        layer_histograms(width = 0.5, center = 20, fill := "blue") %>%   
        layer_points(data =mouseOver,stroke:='black',shape := "triangle-down", size := 50) %>%
        bind_shiny("p3")

      
      
    })
  
  

