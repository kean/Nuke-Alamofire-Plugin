// The MIT License (MIT)
//
// Copyright (c) 2016-2021 Alexander Grebenyuk (github.com/kean).

import Foundation
@preconcurrency import Alamofire
import Nuke

/// Implements data loading using Alamofire framework.
public final class AlamofireDataLoader: Nuke.DataLoading {
    public let session: Alamofire.Session

    /// Initializes the receiver with a given Alamofire.SessionManager.
    /// - parameter session: Alamofire.Session.default by default.
    public init(session: Alamofire.Session = Alamofire.Session.default) {
        self.session = session
    }

    // MARK: DataLoading

    /// Loads data using Alamofire.SessionManager.
    public func loadData(with request: URLRequest, didReceiveData: @escaping (Data, URLResponse) -> Void, completion: @escaping (Error?) -> Void) -> Cancellable {
        // Alamofire.SessionManager automatically starts requests as soon as they are created (see `startRequestsImmediately`)
        let task = self.session.streamRequest(request)
        task.responseStream { [weak task] stream in
            switch stream.event {
            case let .stream(result):
                switch result {
                case let .success(data):
                    guard let response = task?.response else { return } // Never nil
                    didReceiveData(data, response)
                }
            case let .complete(response):
                completion(response.error)
            }
        }
        return AnyCancellable {
            task.cancel()
        }
    }
}

private final class AnyCancellable: Nuke.Cancellable {
    let closure: @Sendable () -> Void

    init(_ closure: @Sendable @escaping () -> Void) {
        self.closure = closure
    }

    func cancel() {
        closure()
    }
}
