//
//  MapViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/20.
//

import UIKit
import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUI

class MapViewController: UIViewController {
    
    

    @IBOutlet weak var cinemaSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        
        cinemaSegmentedControl.setTitle("롯데시네마", forSegmentAt: 0)
        cinemaSegmentedControl.setTitle("메가박스", forSegmentAt: 1)
        cinemaSegmentedControl.setTitle("CGV", forSegmentAt: 2)
        
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[0].latitude, longitude: mapAnnotations[0].longitude), mapAnnotations[0].location)
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[1].latitude, longitude: mapAnnotations[1].longitude), mapAnnotations[1].location)
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[2].latitude, longitude: mapAnnotations[2].longitude), mapAnnotations[2].location)
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[3].latitude, longitude: mapAnnotations[3].longitude), mapAnnotations[3].location)
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[4].latitude, longitude: mapAnnotations[4].longitude), mapAnnotations[4].location)
        TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[5].latitude, longitude: mapAnnotations[5].longitude), mapAnnotations[5].location)
        
        
        
        firstRegionSetting()
        
    }
    
    
    func firstRegionSetting() {
        
        //서울시청: 37.56721585217902, 126.9778526452839
            
        let cityHalllocation = CLLocationCoordinate2D(latitude: 37.56721585217902, longitude: 126.9778526452839)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: cityHalllocation, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    func TheaterAnnotationSetting(_ annotation: MKPointAnnotation, _ location: CLLocationCoordinate2D, _ title: String) {
        
        annotation.title = title
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        }
    
    
    @IBAction func theaterSegmentedControlClicked(_ sender: UISegmentedControl) {
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        if cinemaSegmentedControl.selectedSegmentIndex == 0 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[0].latitude, longitude: mapAnnotations[0].longitude), mapAnnotations[0].location)
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[1].latitude, longitude: mapAnnotations[1].longitude), mapAnnotations[1].location)
        } else if cinemaSegmentedControl.selectedSegmentIndex == 1 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[2].latitude, longitude: mapAnnotations[2].longitude), mapAnnotations[2].location)
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[3].latitude, longitude: mapAnnotations[3].longitude), mapAnnotations[3].location)
        } else {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[4].latitude, longitude: mapAnnotations[4].longitude), mapAnnotations[4].location)
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[5].latitude, longitude: mapAnnotations[5].longitude), mapAnnotations[5].location)
        }
        
    }
        
}
    

extension MapViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServicesAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요!")
        }
    }
    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("거부됨. 설정으로")
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Default")
        }
        
        //정확도 체크.. 왜 하는걸까 설명을 들었는데 아직 잘 모르겠다.
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("Reduce")
            @unknown default:
                print("Default")
            }
            
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()
            
        } else {
            print("Location Cannot Find")
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServicesAuthorization()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    
}
