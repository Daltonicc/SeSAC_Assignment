//
//  WebViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/19.
//

import UIKit

class WebViewController: UIViewController {

    var tvshowdata: TvShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = tvshowdata?.title ?? "없음"
        
    }
 
}
