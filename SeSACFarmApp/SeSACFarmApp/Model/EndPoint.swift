//
//  EndPoint.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/02.
//

import Foundation

enum Method: String {
    
    case GET
    case POST
}

extension URL {
    
    static let baseURL = "http://test.monocoding.com:1231"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

enum EndPoint {
    
    case login
    case signUP
    case changePassword
    case getPosts
    case postPost
    case changePost(id: Int)
    case deletePost(id: Int)
    case postComment
    case changeComment(id: Int)
    case deleteComment(id: Int)
}

extension EndPoint {
    
    var url: URL {
        switch self {
        case .login: return URL.makeEndPoint("/auth/local")
        case .signUP: return .makeEndPoint("/auth/local/register")
        case .changePassword: return .makeEndPoint("/custom/change-password")
        case .getPosts: return .makeEndPoint("/posts")
        case .postPost: return .makeEndPoint("/posts")
        case .changePost(id: let id): return .makeEndPoint("/posts/\(id)")
        case .deletePost(id: let id): return .makeEndPoint("/posts/\(id)")
        case .postComment: return .makeEndPoint("/comments")
        case .changeComment(id: let id): return .makeEndPoint("/comments/\(id)")
        case .deleteComment(id: let id): return .makeEndPoint("/comments/\(id)")
        }
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endPoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.customDataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                print(response)
                guard error == nil else {
                    print("9")
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    print("10")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("11")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("12")
                    print(response.statusCode)
                    completion(nil, .failed)
                    return
                }
                
                do {
                    print("do")
                    print(data)
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                } catch {
                    print("실패")
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
