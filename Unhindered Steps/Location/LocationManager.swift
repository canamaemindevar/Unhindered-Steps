//
//  LocationManager.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var manager = CLLocationManager()
    
    var location: CLLocation?
    
    var completion: ((CLLocation) -> Void)?
   
    
    
    
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        self.location = location
        completion?(location)
        manager.stopUpdatingLocation()
        
        
    }
    
  
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Error:",error)
       }
    
    
     
}
