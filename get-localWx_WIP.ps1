# This script will fetch weather information and output to an HTML file for local viewing

# Idea source: http://www.reddit.com/r/beginnerprojects/comments/1dzbu7/project_whats_the_weather/
# OpenWeatherMap: http://openweathermap.org/current

# Capture user input (City, st)
$userCityST = Read-Host "Enter your City and State like City,st"

# GET the JSON response and store in an object
$wxJSON = Invoke-RestMethod -URI "http://api.openweathermap.org/data/2.5/weather?q=$userCityST"

# Calculate: Kelvin to Fahrenheit: (((K - 273.15)* 1.8000) + 32)
$kelvin = $wxJSON.main.temp 

$fahrenheit = (($kelvin - 273.15) * 1.8000) + 32

# Print out weather data in HTML format for simple display
"The temperature is $fahrenheit F."