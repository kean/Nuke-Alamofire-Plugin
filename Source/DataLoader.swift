// The MIT License (MIT)
//
// Copyright (c) 2016 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

/// Implements image data loading using Alamofire framework.
open class DataLoader: Nuke.DataLoading {
    /// The Alamofire.SessionManager that the receiver was initialized with.
    public let manager: Alamofire.SessionManager

    private let scheduler: Nuke.AsyncScheduler

    /// Initializes the receiver with a given Alamofire.SessionManager.
    /// - parameter manager: Alamofire.SessionManager.default by default.
    /// - parameter scheduler: `QueueScheduler` with `maxConcurrentOperationCount` 8 by default.
    public init(manager: Alamofire.SessionManager = Alamofire.SessionManager.default, scheduler: Nuke.AsyncScheduler = Nuke.OperationQueueScheduler(maxConcurrentOperationCount: 8)) {
        self.manager = manager
        self.scheduler = scheduler
    }

    // MARK: DataLoading
    
    /// Loads data using Alamofire.SessionManager.
    public func loadData(with request: URLRequest, token: Nuke.CancellationToken?) -> Nuke.Promise<(Data, URLResponse)> {
        return Promise() { fulfill, reject in
            scheduler.execute(token: token) { finish in
                let task = self.manager.request(request).response { _, response, data, error in
                    if let data = data, let response: URLResponse = response {
                        fulfill((data, response))
                    } else {
                        reject(error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
                    }
                    finish()
                }
                token?.register {
                    task.cancel()
                    finish()
                }
                task.resume()
            }
        }
    }
}
