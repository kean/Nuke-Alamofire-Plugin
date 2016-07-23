// The MIT License (MIT)
//
// Copyright (c) 2016 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

/** Implements image data loading using Alamofire framework.
 */
public class AlamofireImageDataLoader: Nuke.DataLoading {
    /** The Alamofire.Manager that the receiver was initialized with.
     */
    public let manager: Alamofire.Manager

    /**
     Initializes the receiver with a given Alamofire.Manager. Default value is Alamofire.Manager.sharedInstance.
     
     - warning: The receiver sets of the Alamofire.Manager startRequestsImmediately to false.
     */
    public init(manager: Alamofire.Manager = Alamofire.Manager.sharedInstance) {
        self.manager = manager
    }

    /**
     Initializes the receiver with a Alamofire.Manager created with a given session configuration.

     - warning: The receiver sets of the Alamofire.Manager startRequestsImmediately to false.
     */
    public convenience init(configuration: URLSessionConfiguration) {
        self.init(manager: Alamofire.Manager(configuration: configuration))
    }
    
    // MARK: DataLoading

    /** Creates a request using Alamofire.Manager and returns an NSURLSessionTask which is managed by Alamofire.Manager.
     */
    public func loadData(for request: URLRequest, progress: Nuke.DataLoadingProgress, completion: Nuke.DataLoadingCompletion) -> Cancellable {
        let task = self.manager.request(request).response { _, response, data, error in
            if let data = data, let response: URLResponse = response {
                completion(result: .success((data, response)))
            } else {
                completion(result: .failure(error ?? NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)))
            }
        }.progress { (_, totalBytesReceived, totalBytesExpected) -> Void in
            progress(completed: totalBytesReceived, total: totalBytesExpected)
        }
        return task.task
    }
}

extension Alamofire.Request: Nuke.Cancellable {}
