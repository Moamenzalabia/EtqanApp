//  HomeViewController.swift
//  maged
//  Created by Ahmed Ashraf on 2/6/18.
//  Copyright © 2018 maged. All rights reserved.


import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class HomeViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var locationManager = CLLocationManager()
    var geocoder: GMSGeocoder?
    var myLocation: CLLocation?
    
    var long: String?
    var lat: String?
    
    var didFindMyLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geocoder = GMSGeocoder()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView!.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        mapView!.delegate = self
        locationManager.startUpdatingLocation()
        mapView?.isMyLocationEnabled = true
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController(title: "Location Not allowed", message: "please go to settings and allow location services for the app", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        let url = URL(string: "App-Prefs:path=Medica") //for WIFI setting app
                        let app = UIApplication.shared
                        app.openURL(url!)
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                    }
                }))
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        geocoder!.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            mapView.clear()
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                let markerImage = UIImage(named: "mapMarker")!.withRenderingMode(.alwaysTemplate)
                
                let markerView = UIImageView(image: markerImage)
                markerView.tintColor = UIColor.black
                
                marker.iconView = markerView
                
                
                marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                
              // marker.snippet = result.lines?[1]
                marker.map = mapView
                
                self.lat = "\(cameraPosition.target.latitude)"
                self.long = "\(cameraPosition.target.longitude)"
                Make_order.lat  = self.lat!
                Make_order.lang = self.long!
                Make_order.Address = (result.lines?[0])!
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !didFindMyLocation {
            myLocation = change![NSKeyValueChangeKey.newKey] as! CLLocation
            mapView!.camera = GMSCameraPosition.camera(withTarget: myLocation!.coordinate, zoom: 15.0)
            mapView!.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView!.isMyLocationEnabled = true
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        mapView?.camera = GMSCameraPosition.camera(withTarget: place.coordinate, zoom: 15)
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        Make_order.Address = "\(place.formattedAddress!)"
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainActionsVControllerTable,
            segue.identifier == "homeToContainer" {
            vc.vc = self
        }
    }


}
