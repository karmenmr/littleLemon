import Foundation

extension URLSession {
    func itemTask(with url: URL, completionHandler: @escaping (MenuItem?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        codableTask(with: url, completionHandler: completionHandler)
    }
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            completionHandler(try? decoder.decode(T.self, from: data), response, nil)
        }
    }
}
