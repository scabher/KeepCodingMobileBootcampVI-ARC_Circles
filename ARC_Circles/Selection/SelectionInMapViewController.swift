//
//  SelectionInMapViewController.swift
//  ARC_Circles
//
//  Created by Sergio Cabrera Hernández on 13/3/18.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class SelectionInMapViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    let mapView = MKMapView()
    let textField = UITextField()

    override func loadView() {
        let backView = UIView()
        
        backView.addSubview(mapView)
        backView.addSubview(textField)
        textField.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
        
        // MARK: Autolayout
        mapView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let dictViews = ["mapView": mapView, "textField": textField]
        
        // Horizontales
        var constraint = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[mapView]-0-|", options: [], metrics: nil, views: dictViews)
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-20-[textField]-20-|", options: [], metrics: nil, views: dictViews))
        
        // Verticals
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mapView]-0-|", options: [], metrics: nil, views: dictViews))
        constraint.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[textField(40)]", options: [], metrics: nil, views: dictViews))
        constraint.append(NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: backView.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 20))
        
        backView.addConstraints(constraint)
        self.view = backView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        //textField.isUserInteractionEnabled = false // Inhabilita el teclado
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Centramos el mapa
        let locationCoordinate = CLLocationCoordinate2D(latitude: 40.42588, longitude: -3.70357)
        let region = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - MapView Delegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoord = mapView.centerCoordinate
        let location = CLLocation(latitude: centerCoord.latitude, longitude: centerCoord.longitude)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarkArray, error) in
            if let places = placeMarkArray {
                let place = places.first
                
                DispatchQueue.main.async {
                    self.textField.text = "\(place!.postalAddress!.street), \(place!.postalAddress!.city)"
                }
            }
        })
    }

    // MARK: - MapView Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mapView.isScrollEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text == nil || textField.text!.isEmpty) {
            return
        }
        
        mapView.isScrollEnabled = false
        
        let geocoder = CLGeocoder()
        let postalAddress = CNMutablePostalAddress()
        
        postalAddress.street = textField.text!
        postalAddress.isoCountryCode = "ES"
        geocoder.geocodePostalAddress(postalAddress, completionHandler: {(placeMarkArray, error) in
            if placeMarkArray != nil && placeMarkArray!.count > 0 {
                let placeMark = placeMarkArray?.first
                
                DispatchQueue.main.async {
                    let region = MKCoordinateRegion(center: placeMark!.location!.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.004, longitudeDelta: 0.004))
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Quita el teclado cuando le damos al intro
        return true
    }
    

}
