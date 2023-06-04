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
    
    
    var buttonString:[String] = []
    
    //MARK: - Components

    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let size = UIScreen.main.bounds.width
        layout.itemSize = .init(width: size/3, height: 80)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 5
        collection.backgroundColor = .clear
        collection.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identier)
        return collection
    }()

    private let phoneCallButton: UIButton = {
        let button = UIButton()
        button.setTitle("Acil Arama", for: .normal)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    private let healtyhButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sağlık", for: .normal)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    private let saleAndServiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bakım Ve Satış", for: .normal)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()
      
      /// Mock
      private let medicalButton: UIButton = {
          let button = UIButton()
          button.setTitle("Medical", for: .normal)
          button.setTitleColor(.secondaryLabel, for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .white
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
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
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

       
        view.addSubview(mainCollectionView)
        view.addSubview(phoneCallButton)
        view.addSubview(saleAndServiceButton)
        view.addSubview(healtyhButton)


        NSLayoutConstraint.activate([
         mainCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
         mainCollectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
         mainCollectionView.heightAnchor.constraint(equalToConstant: (view.frame.height / 10)),
         view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainCollectionView.trailingAnchor, multiplier: 3),
         mainCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width)

        ])
    
        NSLayoutConstraint.activate([
            saleAndServiceButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            saleAndServiceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            saleAndServiceButton.heightAnchor.constraint(equalToConstant: 50),
            saleAndServiceButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            phoneCallButton.leadingAnchor.constraint(equalTo: saleAndServiceButton.leadingAnchor),
            phoneCallButton.trailingAnchor.constraint(equalTo: saleAndServiceButton.trailingAnchor),
            phoneCallButton.topAnchor.constraint(equalTo: saleAndServiceButton.bottomAnchor, constant: 10),
            phoneCallButton.heightAnchor.constraint(equalToConstant: 50),
            phoneCallButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            healtyhButton.leadingAnchor.constraint(equalTo: saleAndServiceButton.leadingAnchor),
            healtyhButton.trailingAnchor.constraint(equalTo: saleAndServiceButton.trailingAnchor),
            healtyhButton.bottomAnchor.constraint(equalTo: saleAndServiceButton.topAnchor, constant: -10),
            healtyhButton.heightAnchor.constraint(equalToConstant: 50),
            healtyhButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        phoneCallButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
        healtyhButton.addTarget(self, action: #selector(healthList), for: .touchUpInside)
        saleAndServiceButton.addTarget(self, action:  #selector(serviceList), for: .touchUpInside)
    }
}

extension MapViewController {
    
    func startQuery() {
        LocationManager.shared.getUserLocation {[weak self] location in

            DispatchQueue.main.async {

                self?.viewModel.location = location.coordinate
                self?.mapView.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//                self?.viewModel.updateSearchResults(query: "", completion: { response in
//                    self?.updateUi(response: response)
//                })
            }
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
    @objc func healthList() {
        DispatchQueue.main.async {
            self.buttonString = ["Hastane","Eczane","Medikal","Engelli Tuvaleti"]
            self.mainCollectionView.reloadData()
        }
    }
    @objc func serviceList() {
        DispatchQueue.main.async {
            self.buttonString = ["Tekerlekli Sandalye Satış Mağazası","Tekerlekli Sandalye Bakım Merkezi",]
            self.mainCollectionView.reloadData()
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

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identier, for: indexPath)  as? MyCell else {
            return UICollectionViewCell()
        }
        cell.wordLabel.text = buttonString[indexPath.row]
        
        return cell
    }
    
    
}

extension MapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let word = buttonString[indexPath.row]
        viewModel.updateSearchResults(query: word) {[weak self]  response in
            guard let self = self else {
                return
            }
            self.updateUi(response: response)
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
