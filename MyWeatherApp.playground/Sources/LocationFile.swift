import UIKit
import CoreLocation


class ViewControler: UIViewController {
    
//    Properties
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    

override func viewDidLoad() {
     super.viewDidLoad()
    
// Trigger location services function upon loading
//            checkLocationServices()
  }
    
}

// MARK: - LocationManager Delegate and Helper Functions
extension ViewControler: CLLocationManagerDelegate {
    func checkLocationAuthorization(){
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
// do GPS location stuff
                getUserCoordinates()
                locationManager.startUpdatingLocation()
                break
            case .denied:
// Show an alert instructing user how to turn on permission
                break
            case.notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
// Show an alert instructing user how to turn on permission
                break
            default:
                break
            }
        }
    
// Setup Location Manager function
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
// Check when location services are enabled
    func checkLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
// Inform the user how to enable locaiton services in iOS Settings
        }
    }
}

// Get user's GPS coordinates
    func getUserCoordinates() {
        if let coordinates = locationManager.location?.coordinate.first {
                    print("Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)")
                    
        
// Implement network request passing in user's coordinates
        DispatchQueue.main.async {
           
        }
    }

// Check for GPS permission authorization
    func checkLocationAuthorization() {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                checkLocationAuthorization()
            }
        }
            

 
// Method to trigger when user's location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
// get latest location
                
// update location when user has moved
 
    }

// Method to trigger when GPS location permission changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            
        }

    }
