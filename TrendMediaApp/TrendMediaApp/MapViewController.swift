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

        cinemaSegmentedControl.setTitle("롯데시네마", forSegmentAt: 0)
        cinemaSegmentedControl.setTitle("메가박스", forSegmentAt: 1)
        cinemaSegmentedControl.setTitle("CGV", forSegmentAt: 2)
        
        mapView.delegate = self
        locationManager.delegate = self
        
        allTheaterSetting()
        filterSetting()
        firstRegionSetting()
        
    }
    
    //최초 지역 세팅
    func firstRegionSetting() {
                    
        let cityHalllocation = CLLocationCoordinate2D(latitude: 37.56721585217902, longitude: 126.9778526452839)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: cityHalllocation, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func filterSetting() {
        
        let filterBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filteraction))
        filterBarButtonItem.tintColor = .systemGray

        navigationItem.rightBarButtonItem = filterBarButtonItem
    
    }
    
    @objc func filteraction() {
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.cgvTheaterSetting()
        }
        
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.megaboxTheaterSetting()
        }
        
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.lotteTheaterSetting()
        }
        
        let allTheater = UIAlertAction(title: "전체 보기", style: .default) { _ in
            self.allTheaterSetting()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cgv)
        alert.addAction(megabox)
        alert.addAction(lotteCinema)
        alert.addAction(allTheater)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //영화관 어노테이션 세팅
    func TheaterAnnotationSetting(_ annotation: MKPointAnnotation, _ location: CLLocationCoordinate2D, _ title: String) {
        
        annotation.title = title
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        }
    
    //각 영화관 세팅
    func allTheaterSetting() {
    
        for i in 0..<6 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude), mapAnnotations[i].location)

        }
    }
    
    func lotteTheaterSetting() {
        for i in 0..<2 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude), mapAnnotations[i].location)

        }
    }
    
    func megaboxTheaterSetting() {
        for i in 2..<4 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude), mapAnnotations[i].location)

        }
    }
    
    func cgvTheaterSetting() {
        for i in 4..<6 {
            TheaterAnnotationSetting(MKPointAnnotation(), CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude), mapAnnotations[i].location)

        }
    }
    
    @IBAction func theaterSegmentedControlClicked(_ sender: UISegmentedControl) {
        
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        if cinemaSegmentedControl.selectedSegmentIndex == 0 {
            lotteTheaterSetting()
        } else if cinemaSegmentedControl.selectedSegmentIndex == 1 {
            megaboxTheaterSetting()
        } else {
            cgvTheaterSetting()
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
        print("2번")
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
        
        //정확도 체크 - 풀 정확도시 정확한 위치, 리듀스 정확도시에는 인근의 주요 관공서나 위치를 찍어줌.
        //왜 필요하냐? 특정 어플의 경우 정확한 위치를 줄경우 신변이나 안전에 위협을 줄 수도 있기 때문. 따라서 그런 어플에는 리듀스 정확도 부여.
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
    
    //사용자 커스텀 위치 함수
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
