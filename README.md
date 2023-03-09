# CS 207 Final Project

# OutdoorsAdvisor
## Description
This app gives quick and simple advice on how to prepare for the day based on different daily factors like air quality, pollen, and UV levels that vary by day. The app will present users with advice like: “Wear a mask” or “Bundle up” based on these factors. The user can select different locations to track and be given preparation advice for. On a separate “preferences” tab, they can also scale factors that they care more about, which will alter the advice that the app gives. We may also incorporate an interactive map visual with these factors represented.
## The iOS/API technologies we think we will use
* Pollen - Tomorrow.io API
* Air quality - IQAir or Openweather API
* Weather (precipitation, temperature, wind, humidity, fire) - OpenWeatherAPI
* UV - OpenUV API
## List specifically what you think the sources of complexity/difficulty will be
* Handling API calls from multiple sources
* Weighting the user preferences to alter the advice algorithm
* Translating the API responses into map visualizations
