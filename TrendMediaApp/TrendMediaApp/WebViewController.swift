//
//  WebViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class WebViewController: UIViewController {

    var tvshowData: TvShow?
    var trendData: TrendModel?
    @IBOutlet weak var videoWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = trendData?.title ?? "없음"
        
        getVideoData()
        
    }
 
    
    func getVideoData() {
        
        let videoUrl = "https://api.themoviedb.org/3/movie/\(trendData!.moiveid)/videos?api_key=0ddf09d4942a5788f4b0857f6895c28c&language=en-US"
        
        AF.request(videoUrl, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let key = json["results"][0]["key"].stringValue
                
                let youtubeVideoaddress = "https://www.youtube.com/watch?v=\(key)"
                let youtubeVideoUrl = URL(string: youtubeVideoaddress)
                
                let request = URLRequest(url: youtubeVideoUrl!)
                
                self.videoWebView.load(request)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}


