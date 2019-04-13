//  OrderDetailsVC.swift
//  maged
//  Created by Ahmed Ashraf on 2/27/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subTitle:String?
    init(pinTitle:String,pinSubTitle:String,location:CLLocationCoordinate2D) {
        self.coordinate = location
        self.title = pinTitle
        self.subTitle = pinSubTitle
    }
    
}

class OrderDetailsVC: BaseViewController,MKMapViewDelegate {
    
    @IBOutlet weak var statusLbl    : UILabel!
    @IBOutlet weak var dateLbl      : UILabel!
    @IBOutlet weak var durationLbl  : UILabel!
    @IBOutlet weak var timeLbl      : UILabel!
    @IBOutlet weak var distanceLbl  : UILabel!
    @IBOutlet weak var waitingLbl   : UILabel!
    @IBOutlet weak var counterLbl   : UILabel!
    @IBOutlet weak var MapView      : MKMapView!
    static var order_id = ""
    static var   client_latitude:Double = 0
   static var   client_longitude:Double = 0
   static var   suber_lat:Double        = 0
   static var   suber_long:Double       = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("C-LAT",OrderDetailsVC.client_latitude)
        print("C-LON",OrderDetailsVC.client_longitude)
        print("S-LAT",OrderDetailsVC.suber_lat)
        print("S-LON",OrderDetailsVC.suber_long)
        
        zoomLevel(location: userLocation)
        let sourceLocation = CLLocationCoordinate2D(latitude: OrderDetailsVC.client_latitude, longitude: OrderDetailsVC.client_longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: OrderDetailsVC.suber_lat, longitude: OrderDetailsVC.suber_long)
        let sourcePin = CustomPin(pinTitle: "Suber", pinSubTitle: " ", location: sourceLocation)
        let destinationPin = CustomPin(pinTitle: "Client", pinSubTitle: " ", location: destinationLocation)
        self.MapView.addAnnotation(sourcePin)
        self.MapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType  = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate{ (response,error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("ERROR: \(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.MapView.add(route.polyline,level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.MapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        self.MapView.delegate = self
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 0.9
        return renderer
    }
    
    let userLocation = CLLocationCoordinate2D(latitude: OrderDetailsVC.client_latitude, longitude: OrderDetailsVC.client_longitude)
    func zoomLevel(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let mapCoordinates = MKCoordinateRegion(center: userLocation, span: span)
        self.MapView.setRegion(mapCoordinates, animated: true)
    }
 
    @IBAction func exitTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

