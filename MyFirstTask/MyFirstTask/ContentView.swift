//
//  ContentView.swift
//  MyFirstTask
//
//  Created by admin on 10.07.2021.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        getWeatherForecast(for: location)
                    } label: {
                        Image(systemName:
                                "magnifyingglass.circle.fill")
                            .font(.title3)
                   }
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Mobile Weather")
        }
    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
               apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat).500224&lon=\(lon).579190&exclude=current,minutely,hourly,alerts&appid=fc277603a294d0d76453e7485c58d862",
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

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
  }

