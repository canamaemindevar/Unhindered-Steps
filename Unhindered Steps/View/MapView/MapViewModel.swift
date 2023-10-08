//
//  MapViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import CoreLocation
import Foundation
import MapKit

protocol MapViewModelInterface {
    var view: MapView? { get set }
    var networkManager: QueryMakeble & FavoriteMakeble { get }
    var dbManager: CoreDataManagerInterface { get }
    func viewDidLoad()
}

final class MapViewModel: MapViewModelInterface {
    weak var view: MapView?
    var location = CLLocationCoordinate2D()
    var items = [MKAnnotation]()
    var id = ""
    var user: UserModel?
    var networkManager: QueryMakeble & FavoriteMakeble
    var dbManager: CoreDataManagerInterface

    init(networkManager: NetworkManager = NetworkManager(),
         dbManager: CoreDataManagerInterface = CoreDataManager())
    {
        self.networkManager = networkManager
        self.dbManager = dbManager
    }

    func viewDidLoad() {
        view?.setupMapConts()
        view?.mapView.showsUserLocation = true
        view?.startQuery()
    }

    func viewDidAppear() {
        dbManager.getDataForFavs { response in
            switch response {
            case let .success(success):
                self.id = success.last?.id ?? ""
                self.user = success.last
            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }

    func updateSearchResults(query: String, completion: @escaping (MKLocalSearch.Response) -> Void) {
        let request = MKLocalSearch.Request()
        let queryWord = query
        request.naturalLanguageQuery = queryWord
        let coordinate = location
        request.region = MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }

            self.networkManager.makeQuery(id: self.id, query: queryWord) { response in
                switch response {
                case .success:
                    self.view?.presentAlert(status: .succes, message: "succes".localized)
                case .failure:
                    self.view?.presentAlert(status: .error, message: "errorShown".localized)
                }
            }
            completion(response)
        }
    }

    func makeFavorite() {
        networkManager.makeFavorite(id: id, query: view?.title ?? "") { response in
            switch response {
            case .success:
                self.view?.presentAlert(status: .succes, message: "succes".localized)
            case .failure:
                self.view?.presentAlert(status: .error, message: "errorShown".localized)
            }
        }
    }
}
