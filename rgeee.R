library(rgee)
ee$Authenticate(auth_mode = 'notebook')
ee$Initialize(project = 'ee-lalitbc9')


number <- ee$Number(100)
print(number)

dem <- ee$Image("USGS/SRTMGL1_003")
print(dem)
dem$getInfo()


vis <- list(
  max = 1000,
  min = 0,
  palette = c('blue','yellow', 'red'))

Map$addLayer(dem, vis, 'Dem world')

# Dem map for Nepal
nep <- ee$FeatureCollection("USDOS/LSIB_SIMPLE/2017")
print(nep)

bang<- nep$filter(ee$Filter$eq('country_na', 'Bangladesh'))

Map$addLayer(bang)
Map$centerObject(bang, 10)

#clip
BangDem <- dem$clip(bang)

Map$addLayer(BangDem, vis, 'BangDem')


# Import satellite images

landsat<- ee$ImageCollection("LANDSAT/LC08/C02/T1_TOA") %>% 
  ee$ImageCollection$filterBounds(bang) %>% 
  ee$ImageCollection$filterDate('2021-01-01', '2021-12-31') %>% 
  ee$ImageCollection$filterMetadata('CLOUD_COVER', 'less_than', 10) %>% 
  ee$ImageCollection$median() %>% 
  ee$Image$clip(bang)

Map$addLayer(landsat)

#Calcualte NDVI

ndvi <- landsat$normalizedDifference(c("B5", "B4"))
viz <- list(min= 0,max= 0.58, palette= c('blue', 'white', 'green')) 
Map$addLayer(ndvi, viz)

















