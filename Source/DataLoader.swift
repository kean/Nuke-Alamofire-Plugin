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
    /// - parameter scheduler: `QueueScheduler` with `maxConcurrentOperationCount` 8 by default.
    /// Scheduler is wrapped in a `RateLimiter`.
    public init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default, scheduler: Nuke.AsyncScheduler = Nuke.RateLimiter(scheduler: Nuke.OperationQueueScheduler(maxConcurrentOperationCount: 8))) {
        self.manager = manager
        self.scheduler = scheduler
    }

    // MARK: DataLoading
    
    /// Loads data using Alamofire.SessionManager.
    public func loadData(with request: URLRequest, token: Nuke.CancellationToken?) -> Nuke.Promise<(Data, URLResponse)> {
        return Promise() { fulfill, reject in
            scheduler.execute(token: token) { finish in
                // Alamofire.SessionManager automatically starts requests as soon as they are created (see `startRequestsImmediately`)
                let task = self.manager.request(request).response(completionHandler: { (response) in
                    if let data = response.data, let response: URLResponse = response.response {
                        fulfill((data, response))
                    } else {
                        reject(response.error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
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
}
