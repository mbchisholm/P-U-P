const axios = require("axios");

const LAT = 41.067;
const LON = -73.7076;

async function getWeather(lat, lon) {
  const response = await axios.get(
    "https://api.open-meteo.com/v1/forecast",
    {
      params: {
        latitude: lat,
        longitude: lon,
        current: "temperature_2m,wind_speed_10m,weather_code",
      },
    }
  );
  return response.data.current;
}

getWeather(LAT, LON).then((weather) => {
  console.log(`Temperature : ${weather.temperature_2m}°C`);
  console.log(`Wind speed  : ${weather.wind_speed_10m} km/h`);
  console.log(`Fetched at  : ${weather.time}`);
});
