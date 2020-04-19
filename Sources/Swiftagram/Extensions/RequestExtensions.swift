//
//  RequestExtensions.swift
//  Swiftagram
//
//  Created by Stefano Bertagno on 05/04/2020.
//

import Foundation

import ComposableRequest

/// **Instagram** specific accessories for `Composable`.
public extension Composable {
    /// Append to `headerFields`.
    func defaultHeader() -> Self {
        return header([
            "User-Agent": Device.default.apiUserAgent,
            "X-Ads-Opt-Out": "0",
            "X-CM-Bandwidth-KBPS": "-1.000",
            "X-CM-Latency": "-1.000",
            "X-IG-App-Locale": "en_US",
            "X-IG-Device-Locale": "en_US",
            "X-Pigeon-Session-Id": UUID().uuidString,
            "X-Pigeon-Rawclienttime": "\(Int(Date().timeIntervalSince1970/1000)).000",
            "X-IG-Connection-Speed": "\(Int.random(in: 1000...3700))kbps",
            "X-IG-Bandwidth-Speed-KBPS": "-1.000",
            "X-IG-Bandwidth-TotalBytes-B": "0",
            "X-IG-Bandwidth-TotalTime-MS": "0",
            "X-IG-EU-DC-ENABLED": "0",
            "X-IG-Extended-CDN-Thumbnail-Cache-Busting-Value": "1000",
            "X-Bloks-Version-Id": "1b030ce63a06c25f3e4de6aaaf6802fe1e76401bc5ab6e5fb85ed6c2d333e0c7",
            "X-IG-WWW-Claim": "0",
            "X-Bloks-Is-Layout-RTL": "false",
            "X-IG-Connection-Type": "WIFI",
            "X-IG-Capabilities": "3brTvwE=",
            "X-IG-App-ID": "567067343352427",
            "X-IG-Device-ID": Device.default.deviceGUID.uuidString,
            "X-IG-Android-ID": Device.default.deviceIdentifier,
            "Accept-Language": "en-US",
            "X-FB-HTTP-Engine": "Liger",
            "Host": "i.instagram.com",
            "Accept-Encoding": "gzip",
            "Connection": "close"
        ])
    }
}

/// **Instagram** specific accessories for `Requester`.
public extension Requester {
    /// An **Instagram** `Requester` matching `.default` with a longer, safer, `waiting` range.
    static let instagram = Requester(configuration: .init(sessionConfiguration: .default,
                                                          dispatcher: .init(),
                                                          waiting: 0.5...1.5))
}

/// `Unlockable` extension.
public extension Unlockable {
    /// Unlock using `Key`.
    /// - parameter key: A valid `Key`.
    /// - returns: The authenticated `Locked`.
    /// - warning: `authenticating` will be removed in the next minor.
    @available(*, deprecated, renamed: "unlocking")
    func authenticating(with key: Key) -> Locked {
        return unlocking(with: key)
    }
}

/// `Requestable & Paginatable` extension.
public extension Requestable where Self: Paginatable, Self: Composable {
    /// Prepare a pagination `Requester.Task`.
    /// - parameters:
    ///     - maxLength: The maximum amount of pages that should be returned. Pass `.max` to keep fetching until no next requet is found.
    ///     - requester: A valid `Requester`. Defaults to `.default`.
    ///     - onComplete: An optional block called when `maxLength` is reached or no next endpoint is provided.
    ///     - onChange: A block called everytime a new page is fetched.
    /// - returns: A `Requester.Task`. You need to `resume` it for it to start.
    @available(*, deprecated, renamed: "task")
    func cycleTask(maxLength: Int,
                   by requester: Requester = .default,
                   onComplete: ((_ length: Int) -> Void)? = nil,
                   onChange: @escaping (Result<Response, Error>) -> Void) -> Requester.Task {
        return self.task(maxLength: maxLength, by: requester, onComplete: onComplete, onChange: onChange)
    }
}
