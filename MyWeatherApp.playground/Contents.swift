import UIKit
import CoreLocation

struct Forecast: Codable {
    struct Daily: Codable {
        let dt: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
        let humidity : Int
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
            var weatherIconURL: URL {
                let urlString = "http://openweathermap.org/img/wn\(icon)@2x.png"
                return URL(string: urlString)!
            }
        }
        let weather: [Weather]
        let clouds: Int
        let pop: Double
    }
        let daily : [Daily]
  }
let apiService = APIService.shared

apiService.getJSON(urlString:
                    "https://api.openweathermap.org/data/2.5/onecall?lat=50.500206&lon=30.579119&exclude=current,minutely,hourly,alerts&appid=fc277603a294d0d76453e7485c58d862") { (result: Result<Forecast,APIService.APIError>)
    in
    switch result {
        case .success(let forecast):
            for day in forecast.daily {
                print(day.dt)
            }
    case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
                print(errorString)
            }
    }
}
                
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "E, MMM, d"
CLGeocoder().geocodeAddressString("Kyiv") { (placemarks, error) in
    if let error = error {
        print(error.localizedDescription)
    }
    if let lat = placemarks?.first?.location?.coordinate.latitude,
       let lon = placemarks?.first?.location?.coordinate.longitude {
       apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat).500206&lon=\(lon).579119&exclude=current,minutely,hourly,alerts&appid=fc277603a294d0d76453e7485c58d862",
                   dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>) in
    switch result {
    case .success(let forecast):
        for day in forecast.daily {
            print(dateFormatter.string(from: day.dt))
            print(" Max: ", day.temp.max)
            print(" Min: ", day.temp.min)
            print(" humidity : ", day.humidity )
            print(" Description: ", day.weather[0].description)
            print(" Clouds ", day.clouds)
            print(" Pop ", day.pop)
            print(" IconURL ", day.weather[0].weatherIconURL)
        }
    case .failure(let apiError):
        switch apiError {
        case .error(let errorString):
            print(errorString)
        }
      }
    }
  }
}
