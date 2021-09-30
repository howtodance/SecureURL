//
//  URL+Secure.swift
//  SecureURL
//
//  Created by Yauheni Baranouski on 26/05/2021.
//

import Foundation

extension URL {
    private enum Constant {
        ///Put URL scheme of you project
        static let urlScheme = "abcd"

        static let hostPrefix = "www."
        static let replacingSubstring = ""
    }

    init?(secureUrlString: String) {
        let lowercasedString = secureUrlString.lowercased()

        guard let url = URL.init(string: lowercasedString),
              url.isRemoteURLSecure else {
            return nil
        }

        self.init(string: lowercasedString)
    }

    var isRemoteURLSecure: Bool {
        var isSecure = false

        if scheme == Constant.urlScheme {
            isSecure = true
        } else {
            if let urlHost = host {
                if isProperHost(urlHost) {
                    let clearHost = urlHost.replacingOccurrences(of: Constant.hostPrefix, with: Constant.replacingSubstring)

                    isSecure = isThisHostAllowed(clearHost) || isThisHostAllowedRegExp(clearHost)
                }
            }
        }

        return isSecure
    }

    private func isProperHost(_ host: String) -> Bool {
        return hostContainsOnlyProperCharacters(host)
    }

    private func hostContainsOnlyProperCharacters(_ host: String) -> Bool {
        let urlHostAllowedCharacterSet = CharacterSet.urlHostAllowed
        return urlHostAllowedCharacterSet.isSuperset(of: CharacterSet(charactersIn: host))
    }

    private func isThisHostAllowedRegExp(_ host: String) -> Bool {

        let pattern = URL.allowedRegExpPatternHostsList
            .first { host.range(of: $0, options: .regularExpression) != nil }

        return pattern != nil
    }

    private func isThisHostAllowed(_ host: String) -> Bool {
        return URL.allowedHostsList.contains(host)
    }

    /// Use compile flags to separate hosts for QA and PRODUCTION builds
    private static var allowedHostsList: Set<String> {
        #if DEBUG
        let allowedHosts = [
            "staging.companyurl.com",
            "apps.apple.com",
            "itunes.apple.com",
            "twitter.com",
            "netguru.com"
        ]
        #else
        let allowedHosts = [
            "apps.apple.com",
            "itunes.apple.com",
            "twitter.com",
            "netguru.com"
        ]
        #endif

        let list = Set<String>.init(allowedHosts)
        return list
    }

    /// Use compile flags to separate hosts for QA and PRODUCTION builds
    private static var allowedRegExpPatternHostsList: Set<String> {
        #if DEBUG
        let allowedPatterns = [
            "^(.*\\.)?(companyurl)(\\.com|\\.pl)$" // *(multiple dots allowed).companyurl.com
        ]
        #else
        let allowedPatterns = [
            "^(.*\\.)?(companyurl)(\\.com|\\.pl)$" // *(multiple dots allowed).companyurl.com
        ]
        #endif
        // ^ - it is a start of the string, avoid FAIKcompanyurl.com substitution
        // (.*\\.) - it allows use multiple subdomains, but this part should end with .
        // ? - between (.*\\.) and companyurl - refers that this part (.*\\.) is optional
        // $ - it means "tail" (end) of host
        // | - in case if required multiple top level domain (com, pl)
        let list = Set<String>.init(allowedPatterns)
        return list
    }
}
