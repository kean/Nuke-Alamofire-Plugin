// The MIT License (MIT)
//
// Copyright (c) 2016 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

/// Implements data loading using Alamofire framework.
public class DataLoader: Nuke.DataLoading {
    public let manager: Alamofire.SessionManager

    /// Initializes the receiver with a given Alamofire.SessionManager.
    /// - parameter manager: Alamofire.SessionManager.default by default.
    public init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default) {
        self.manager = manager
    }

    // MARK: DataLoading

    /// Loads data using Alamofire.SessionManager.
    public func loadData(with request: URLRequest, token: CancellationToken?, progress: ProgressHandler?, completion: @escaping (Nuke.Result<(Data, URLResponse)>) -> Void) {
        // Alamofire.SessionManager automatically starts requests as soon as they are created (see `startRequestsImmediately`)
        let task = manager.request(request)
            .validate()
            .downloadProgress(closure: { progress?($0.completedUnitCount, $0.totalUnitCount) })
            .response(completionHandler: { (response) in
                if let data = response.data, let response: URLResponse = response.response {
                    completion(.success((data, response)))
                } else {
                    completion(.failure(response.error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
                }
            })
        token?.register { task.cancel() }
    }
}
