# rgee_tutorials
# `rgee` - Google Earth Engine R Package

`rgee` is an R package that provides an interface to the Google Earth Engine (GEE) API. It allows R users to access, process, and analyze geospatial data in Google Earth Engine directly from R.

This package is useful for tasks such as remote sensing, environmental monitoring, and spatial analysis on large-scale datasets.

## Installation

To install the `rgee` package, follow these steps:

1. **Install the package from CRAN**:

   ```r
   install.packages("rgee")
   ```

2. **Install the package from GitHub** (for the latest development version):

   ```r
   remotes::install_github("r-spatial/rgee")
   ```

3. **Set up Google Earth Engine**:

   Before using `rgee`, you need to authenticate and initialize your connection to Google Earth Engine.

   - Sign up for Google Earth Engine: [https://signup.earthengine.google.com/](https://signup.earthengine.google.com/)
   - Authenticate your Google Earth Engine account:
   
     ```r
     library(rgee)
     ee_Initialize()
     ```

   Follow the instructions in your console to authenticate with your Google account.


## Example

Here's a complete example to calculate and export NDVI from a Landsat 8 image collection:

```r
library(rgee)
ee_Initialize()

# Define region of interest
aoi <- ee$Geometry$Point(c(-122.292, 37.901))

# Load Landsat 8 image collection
image <- ee$ImageCollection('LANDSAT/LC08/C01/T1_TOA')$
             filterBounds(aoi)$
             filterDate('2020-01-01', '2020-12-31')$
             median()

# Calculate NDVI
ndvi <- image$normalizedDifference(c('B5', 'B4'))$rename('NDVI')

# Visualize NDVI
Map$centerObject(aoi, zoom = 10)
Map$addLayer(ndvi, list(min = -0.1, max = 0.9, palette = c('blue', 'white', 'green')), 'NDVI')

# Export NDVI to Google Drive
task <- ee$batch$Export$image$toDrive(
  image = ndvi,
  description = 'NDVI_Export',
  fileFormat = 'GeoTIFF'
)
task$start()
```
## Troubleshooting
- Ensure that your Google Earth Engine account is correctly authenticated by running `ee_Initialize()`.
- If you encounter issues with exporting data, check if the task has been properly initiated with `task$start()`.
- Refer to the [Google Earth Engine Documentation](https://developers.google.com/earth-engine/) for additional details on API usage and features.

## References
- [Google Earth Engine Documentation](https://developers.google.com/earth-engine/)
- [rgee GitHub Repository](https://github.com/r-spatial/rgee)
- [Google Earth Engine API Documentation](https://developers.google.com/earth-engine/guides)

This is a demo NDVI analysis that uses GEE API for R.
![Rplot](https://github.com/user-attachments/assets/9430fb18-cbf8-4227-9098-b8918d4f96b2)
