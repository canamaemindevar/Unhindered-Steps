//
//  MapViewController.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: - Components
    private lazy var viewModel = MapViewModel()
    let mapView = MKMapView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Funcs


    func setupMapConts() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mapView.bottomAnchor)
        ])
    }
}

extension MapViewController {
    
    func startQuery() {
        LocationManager.shared.getUserLocation {[weak self] location in

            DispatchQueue.main.async {

                self?.viewModel.location = location.coordinate
                self?.mapView.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self?.viewModel.updateSearchResults(query: .pharmacy, completion: { response in
                    self?.updateUi(response: response)
                })
            }
        }
    
    }
    
    
    
    func updateUi(response: MKLocalSearch.Response) {
       
        DispatchQueue.main.async {
            
            self.mapView.removeAnnotations(self.viewModel.items)
            self.viewModel.items = []
            response.mapItems.forEach { item in
                
                self.viewModel.items.append(item.placemark)
            }
            self.mapView.addAnnotations(self.viewModel.items)

        }
    }
}
