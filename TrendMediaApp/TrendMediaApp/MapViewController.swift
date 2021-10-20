//
//  MapViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/20.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var cinemaSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        cinemaSegmentedControl.setTitle("메가박스", forSegmentAt: 0)
        cinemaSegmentedControl.setTitle("롯데시네마", forSegmentAt: 1)
        cinemaSegmentedControl.setTitle("CGV", forSegmentAt: 2)
        
        annotationSetting()
        
    }
    
    
    func annotationSetting() {
        
        //서울시청: 37.56721585217902, 126.9778526452839
            
        let cityHalllocation = CLLocationCoordinate2D(latitude: 37.56721585217902, longitude: 126.9778526452839)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: cityHalllocation, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
    

}

extension MapViewController: CLLocationManagerDelegate {
    
    
}

extension MapViewController: MKMapViewDelegate {
    
    
}
