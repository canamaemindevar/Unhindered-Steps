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
    
    let leftButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
    
    let button = UIButton(type: UIButton.ButtonType.contactAdd)
    
    //MARK: - Components
      private let scrollView: UIScrollView = {
          let sView = UIScrollView()
          sView.translatesAutoresizingMaskIntoConstraints = false
          sView.backgroundColor = .clear
          sView.layer.cornerRadius = 5
          sView.alwaysBounceHorizontal = true
          sView.isScrollEnabled = true
          return sView
      }()
      
      private let stackview: UIStackView = {
          let sView = UIStackView()
          sView.translatesAutoresizingMaskIntoConstraints = false
          sView.layer.cornerRadius = 5
          sView.axis = .horizontal
          sView.distribution = .fillEqually
          sView.spacing = 10
          return sView
      }()
      
      private let pharmecyButton: UIButton = {
          let button = UIButton()
          button.setTitle("Eczane", for: .normal)
          button.setTitleColor(.secondaryLabel, for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .secondarySystemBackground
          button.layer.cornerRadius = 5
          return button
      }()
      private let hosptialButton: UIButton = {
          let button = UIButton()
          button.setTitle("Hospital", for: .normal)
          button.setTitleColor(.secondaryLabel, for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .secondarySystemBackground
          button.layer.cornerRadius = 5
          return button
      }()
    
    private let toiletButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tuvalet", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 5
        return button
    }()
    private let phoneCallButton: UIButton = {
        let button = UIButton()
        button.setTitle("Acil Arama", for: .normal)
        button.setImage(.add, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        return button
    }()
      
      /// Mock
      private let medicalButton: UIButton = {
          let button = UIButton()
          button.setTitle("Medical", for: .normal)
          button.setTitleColor(.secondaryLabel, for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .secondarySystemBackground
          button.layer.cornerRadius = 5
          return button
      }()
      private let bbutton: UIButton = {
          let button = UIButton()
          button.setTitle("Hospital", for: .normal)
          button.setTitleColor(.secondaryLabel, for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .secondarySystemBackground
          button.layer.cornerRadius = 5
          return button
      }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Funcs


    func setupMapConts() {
        mapView.showsUserLocation = true
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mapView.bottomAnchor)
        ])

      
          
        view.addSubview(scrollView)
        view.addSubview(phoneCallButton)
        scrollView.addSubview(stackview)
        stackview.addArrangedSubview(pharmecyButton)
        stackview.addArrangedSubview(hosptialButton)
        stackview.addArrangedSubview(medicalButton)
        stackview.addArrangedSubview(toiletButton)
        stackview.addArrangedSubview(phoneCallButton)
        // Note: dummy
        stackview.addArrangedSubview(bbutton)
        
        
        NSLayoutConstraint.activate([
         scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
         scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
         scrollView.heightAnchor.constraint(equalToConstant: (view.frame.height / 10)),
         view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 3),
         scrollView.widthAnchor.constraint(equalToConstant: view.frame.width)

        ])
    
   
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height / 10 )
        hosptialButton.addTarget(self, action: #selector(searchHospital), for: .touchUpInside)
        pharmecyButton.addTarget(self, action: #selector(searchPharmacy), for: .touchUpInside)
        medicalButton.addTarget(self, action: #selector(searchMedical), for: .touchUpInside)
        toiletButton.addTarget(self, action: #selector(searchToilet), for: .touchUpInside)
        phoneCallButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
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
    
    @objc func searchHospital() {
        viewModel.updateSearchResults(query: .hospital) {[weak self]  respones in
            guard let self = self else {
                return
            }
            self.updateUi(response: respones)
        }
    }
    @objc func searchPharmacy() {
        viewModel.updateSearchResults(query: .pharmacy) {[weak self]  response in
            guard let self = self else {
                return
            }
            self.updateUi(response: response)
        }
    }
    @objc func searchMedical() {
        viewModel.updateSearchResults(query: .medikal) {[weak self]  response in
            guard let self = self else {
                return
            }
            self.updateUi(response: response)
        }
    }
    @objc func searchToilet() {
        viewModel.updateSearchResults(query: .tuvalet) {[weak self]  response in
            guard let self = self else {
                return
            }
            self.updateUi(response: response)
        }
    }
    
    @objc func  makePhoneCall() {
        guard let helperPhone = viewModel.user?.helperPhone else {return}
        guard let number = URL(string: "tel://\(helperPhone))") else { return }
             if UIApplication.shared.canOpenURL(number) {
                 UIApplication.shared.open(number)
             } else {
                 print("Can't open url on this device")
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

extension MapViewController: MKMapViewDelegate {
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{return nil}
                
                
                let reuseId = "myAnnotation"
                var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
                
                if pinView == nil {
                    pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                    pinView?.canShowCallout = true
                    pinView?.tintColor = UIColor.black
                    
                   
                    pinView?.leftCalloutAccessoryView = leftButton
                    pinView?.rightCalloutAccessoryView = button
                }else{
                    pinView?.annotation = annotation
                }
                
                return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let title = view.annotation?.title else {
            return
        }
        
        if control == leftButton {
            
            guard let  place = view.annotation?.coordinate else {
                return
            }
            var requestLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placesMarks, error in
                
                if let placeMark = placesMarks{
                    if placeMark.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                        let item = MKMapItem(placemark: newPlaceMark)
                        
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
            
        }else {
            
            NetworkManager.shared.makeFavorite(id: viewModel.id, query: title ?? "") { response in
                switch response {
                case .success(let success):
                    print("Saved as favorite: \(success)")
                case .failure(let failure):
                    print("Error while saving favorite: \(failure)")
                }
            }
            
        }
        
        
    }
}
