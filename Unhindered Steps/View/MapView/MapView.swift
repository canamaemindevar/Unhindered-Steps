//
//  MapView.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import MapKit
import UIKit

final class MapView: UIViewController {
    // MARK: - Components

    private lazy var viewModel = MapViewModel()
    let mapView = MKMapView()
    let leftButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
    let button = UIButton(type: UIButton.ButtonType.contactAdd)
    var buttonStrings: [String] = []

    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let size = UIScreen.main.bounds.width
        layout.itemSize = .init(width: size / 3, height: 80)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 5
        collection.backgroundColor = .clear
        collection.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identier)
        return collection
    }()

    private let phoneCallButton: UIButton = {
        let button = UIButton()
        button.setTitle("emergencyCall".localized, for: .normal)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()

    private let healtyhButton: UIButton = {
        let button = UIButton()
        button.setTitle("health".localized, for: .normal)
        button.setImage(UIImage(systemName: "stethoscope"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()

    private let saleAndServiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("supportAndSell".localized, for: .normal)
        button.setImage(UIImage(systemName: "oilcan"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_: Bool) {
        viewModel.viewDidAppear()
    }

    // MARK: - Funcs

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
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
        ])
        view.addSubview(mainCollectionView)
        view.addSubview(phoneCallButton)
        view.addSubview(saleAndServiceButton)
        view.addSubview(healtyhButton)
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
            mainCollectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            mainCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainCollectionView.trailingAnchor, multiplier: 3),
            mainCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

        ])
        NSLayoutConstraint.activate([
            saleAndServiceButton.centerXAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            saleAndServiceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            saleAndServiceButton.heightAnchor.constraint(equalToConstant: 50),
            saleAndServiceButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        NSLayoutConstraint.activate([
            phoneCallButton.leadingAnchor.constraint(equalTo: saleAndServiceButton.leadingAnchor),
            phoneCallButton.trailingAnchor.constraint(equalTo: saleAndServiceButton.trailingAnchor),
            phoneCallButton.topAnchor.constraint(equalTo: saleAndServiceButton.bottomAnchor, constant: 10),
            phoneCallButton.heightAnchor.constraint(equalToConstant: 50),
            phoneCallButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        NSLayoutConstraint.activate([
            healtyhButton.leadingAnchor.constraint(equalTo: saleAndServiceButton.leadingAnchor),
            healtyhButton.trailingAnchor.constraint(equalTo: saleAndServiceButton.trailingAnchor),
            healtyhButton.bottomAnchor.constraint(equalTo: saleAndServiceButton.topAnchor, constant: -10),
            healtyhButton.heightAnchor.constraint(equalToConstant: 50),
            healtyhButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        phoneCallButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
        healtyhButton.addTarget(self, action: #selector(healthList), for: .touchUpInside)
        saleAndServiceButton.addTarget(self, action: #selector(serviceList), for: .touchUpInside)
    }
}

extension MapView {
    func startQuery() {
        LocationManager.shared.getUserLocation { [weak self] location in

            DispatchQueue.main.async {
                self?.viewModel.location = location.coordinate
                self?.mapView.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
    }

    @objc func makePhoneCall() {
        guard let helperPhone = viewModel.user?.helperPhone else { return }
        guard let number = URL(string: "tel://\(helperPhone))") else { return }
        if UIApplication.shared.canOpenURL(number) {
            UIApplication.shared.open(number)
        } else {
            print("Can't open url on this device")
        }
    }

    @objc func healthList() {
        DispatchQueue.main.async {
            self.buttonStrings = ["hospital".localized, "pharmacy".localized, "medical".localized, "disabledToilet".localized]
            self.mainCollectionView.reloadData()
        }
    }

    @objc func serviceList() {
        DispatchQueue.main.async {
            self.buttonStrings = ["wheelchairOutlet".localized, "wheelchairCareCenter".localized]
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

// MARK: - CollectionView Delegates

extension MapView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return buttonStrings.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identier, for: indexPath) as? MyCell else {
            return UICollectionViewCell()
        }
        cell.wordLabel.text = buttonStrings[indexPath.row]

        return cell
    }
}

extension MapView: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = buttonStrings[indexPath.row]
        viewModel.updateSearchResults(query: word) { [weak self] response in
            guard let self = self else {
                return
            }
            self.updateUi(response: response)
        }
    }
}

// MARK: - MapView Delegates

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black

            pinView?.leftCalloutAccessoryView = leftButton
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }

    func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard (view.annotation?.title) != nil else { return }

        if control == leftButton {
            guard let place = view.annotation?.coordinate else { return }
            let requestLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placesMarks, _ in

                if let placeMark = placesMarks {
                    if placeMark.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placeMark[0])
                        let item = MKMapItem(placemark: newPlaceMark)

                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }

        } else {
            viewModel.makeFavorite()
        }
    }
}
