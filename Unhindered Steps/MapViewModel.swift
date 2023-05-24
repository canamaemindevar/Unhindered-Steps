//
//  MapViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewModelInterface {
    var view: MapViewController? {get set}
    func viewDidLoad()
}

class MapViewModel:MapViewModelInterface {
    
    weak var view: MapViewController?
    var location = CLLocationCoordinate2D()
    var items = [MKAnnotation]()
    var id = ""
    
    
    func viewDidLoad() {
        view?.setupMapConts()
        view?.mapView.showsUserLocation = true
        view?.startQuery()
        CoreDataManager.shared.getDataForFavs { response in
            switch response {
            case .success(let success):
                self.id = success.first?.id ?? ""
            case .failure(let failure):
                print(failure)
            }
        }
    }

    
    
    func updateSearchResults(query: PlaceEnums, completion: @escaping(MKLocalSearch.Response)-> Void)  {
        
        let request = MKLocalSearch.Request()
        let queryWord = query.rawValue
        request.naturalLanguageQuery = queryWord
        
        // var coordinate = CLLocationCoordinate2D(latitude: 40.766666, longitude: 29.916668)
        let coordinate = location
        request.region = MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
          //  print(response)
            
            // TODO: - id fetch
            
          //  print(self.id)
          //  print(queryWord)
            NetworkManager.shared.makeQuery(id: self.id, query: queryWord) { response in
                switch response {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
            completion(response)

        }
    }
}



enum PlaceEnums: String {
    case pharmacy = "Eczane"
    case hospital = "Hastane"
    case medikal = "Medikal"
    case tuvalet = "Engelli Tuvaleti"
}
