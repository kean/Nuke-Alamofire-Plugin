// The MIT License (MIT)
//
// Copyright (c) 2016 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

/** Implements image data loading using Alamofire framework.
 */
public class AlamofireImageDataLoader: ImageDataLoading {
    /** The Alamofire.Manager that the receiver was initialized with.
     */
    public let manager: Alamofire.Manager

    /**
     Initializes the receiver with a given Alamofire.Manager. Default value is Alamofire.Manager.sharedInstance.
     
     - warning: The receiver sets of the Alamofire.Manager startRequestsImmediately to false.
     */
    public init(manager: Alamofire.Manager = Alamofire.Manager.sharedInstance) {
        manager.startRequestsImmediately = false
        self.manager = manager
    }

    /**
     Initializes the receiver with a Alamofire.Manager created with a given session configuration.

     - warning: The receiver sets of the Alamofire.Manager startRequestsImmediately to false.
     */
    public convenience init(configuration: NSURLSessionConfiguration) {
        self.init(manager: Alamofire.Manager(configuration: configuration))
    }
    
    // MARK: ImageDataLoading

    /** Creates a request using Alamofire.Manager and returns an NSURLSessionTask which is managed by Alamofire.Manager.
     */
    public func taskWith(request: ImageRequest, progress: ImageDataLoadingProgress, completion: ImageDataLoadingCompletion) -> NSURLSessionTask {
        let task = self.manager.request(request.URLRequest).response { (_, response, data, error) -> Void in
            completion(data: data, response: response, error: error)
        }.progress { (_, totalBytesReceived, totalBytesExpected) -> Void in
            progress(completed: totalBytesReceived, total: totalBytesExpected)
        }
        return task.task
    }

    /** Invalidates NSURLSession that Alamofire.Manager was initializd with.
     */
    public func invalidate() {
        self.manager.session.invalidateAndCancel()
    }

    /** Removes all cached responses from NSURLSession's URL cache.
     */
    public func removeAllCachedImages() {
        self.manager.session.configuration.URLCache?.removeAllCachedResponses()
    }
}
