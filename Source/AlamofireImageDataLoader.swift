// The MIT License (MIT)
//
// Copyright (c) 2015 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import Nuke

public class AlamofireImageDataLoader: ImageDataLoading {
    public let manager: Alamofire.Manager
    
    public init(manager: Alamofire.Manager = Alamofire.Manager.sharedInstance) {
        manager.startRequestsImmediately = false
        self.manager = manager
    }
    
    // MARK: ImageDataLoading
    
    public func taskWith(request: ImageRequest, progress: ImageDataLoadingProgress, completion: ImageDataLoadingCompletion) -> NSURLSessionTask {
        let task = self.manager.request(request.URLRequest).response { (_, response, data, error) -> Void in
            completion(data: data, response: response, error: error)
        }.progress { (_, totalBytesReceived, totalBytesExpected) -> Void in
            progress(completed: totalBytesReceived, total: totalBytesExpected)
        }
        return task.task
    }
    
    public func invalidate() {
        self.manager.session.invalidateAndCancel()
    }
    
    public func removeAllCachedImages() {
        self.manager.session.configuration.URLCache?.removeAllCachedResponses()
    }
}
