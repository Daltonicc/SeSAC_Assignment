//
//  MapViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/20.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var cinemaSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cinemaSegmentedControl.setTitle("메가박스", forSegmentAt: 0)
        cinemaSegmentedControl.setTitle("롯데시네마", forSegmentAt: 1)
        cinemaSegmentedControl.setTitle("CGV", forSegmentAt: 2)
        
        
        
    }
    

    

}
