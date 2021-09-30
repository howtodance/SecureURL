//
//  URL+SecureTests.swift
//  Tests iOS
//
//  Created by Yauheni Baranouski on 27/05/2021.
//

import XCTest

class URL_SecureTests: XCTestCase {

    func test_urlSecure_not_nil_correct_url_scheme() throws {
        let urlString = "abcd://externalurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_nil_incorrect_url_scheme() throws {
        let urlString = "qwer://externalurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_nil_no_protocol() throws {
        let urlString = "netguru.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_not_nil_uppercased() throws {
        let urlString = "HTTPS://WWW.NETGURU.COM"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_nil_host_not_in_list() throws {
        let urlString = "https://www.google.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_not_nil_host_in_list() throws {
        let urlString = "https://www.netguru.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_just_domain() throws {
        let urlString = "https://www.companyurl.pl"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_just_domain_without_www() throws {
        let urlString = "https://companyurl.pl"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_onesubdomain() throws {
        let urlString = "https://www.onesubdomain.companyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_path_looks_like_correct_url() throws {
        let urlString = "https://www.fakeurl.com/companyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_last_part_correct() throws {
        let urlString = "https://www.onesubdomain.companyurl.pl"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_last_part_incorrect() throws {
        let urlString = "https://www.onesubdomain.companyurl.in"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_domainname_end_with_whitelist_url() throws {
        let urlString = "https://www.fakedomaincompanyurl.in"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_append_fakedomain() throws {
        let urlString = "https://companyurl.com.fakedomain.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_no_subdomain() throws {
        let urlString = "https://www.companyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_twosubdomain() throws {
        let urlString = "https://www.two.one.companyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_not_nil_host_in_matchRexExp_threesubdomain() throws {
        let urlString = "https://www.three.two.one.companyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNotNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_threesubdomain_failcompanyurl() throws {
        let urlString = "https://www.three.two.one.failcompanyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }

    func test_urlSecure_nil_host_in_matchRexExp_failcompanyurl() throws {
        let urlString = "https://failcompanyurl.com"
        let url = URL.init(secureUrlString: urlString)

        XCTAssertNil(url)
    }
}
