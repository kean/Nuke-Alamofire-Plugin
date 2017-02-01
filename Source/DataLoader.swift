// The MIT License (MIT)
//
// Copyright (c) 2016 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

/// Implements data loading using Alamofire framework.
public class DataLoader: Nuke.DataLoading {
    public let manager: Alamofire.SessionManager
    private let scheduler: Nuke.AsyncScheduler

    /// Initializes the receiver with a given Alamofire.SessionManager.
    /// - parameter manager: Alamofire.SessionManager.default by default.
    /// - parameter scheduler: `QueueScheduler` with `maxConcurrentOperationCount` 6 by default.
    /// Scheduler is wrapped in a `RateLimiter`.
    public init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default, scheduler: Nuke.AsyncScheduler = Nuke.RateLimiter(scheduler: Nuke.OperationQueueScheduler(maxConcurrentOperationCount: 6))) {
        self.manager = manager
        self.scheduler = scheduler
    }

    // MARK: DataLoading
    
    /// Loads data using Alamofire.SessionManager.
    public func loadData(with request: Nuke.Request, token: CancellationToken?, completion: @escaping (Nuke.Result<(Data, URLResponse)>) -> Void) {
        scheduler.execute(token: token) { finish in
            // Alamofire.SessionManager automatically starts requests as soon as they are created (see `startRequestsImmediately`)
            let task = self.manager.request(request.urlRequest).response(completionHandler: { (response) in
                if let data = response.data, let response: URLResponse = response.response {
                    completion(.success((data, response)))
                } else {
                    completion(.failure(response.error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
                }
                finish()
            })
            token?.register {
                task.cancel()
                finish()
            }
        }
    }
}
