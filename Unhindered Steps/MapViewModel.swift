//
//  MapViewModel.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import Foundation

protocol MapViewModelInterface {
    var view: MapViewController? {get set}
}

class MapViewModel:MapViewModelInterface {
    weak var view: MapViewController?
    
    
}
    
