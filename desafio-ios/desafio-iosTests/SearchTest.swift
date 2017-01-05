//
//  SearchTest.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/5/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import desafio_ios

class SearchTest: XCTestCase {
    
    func testSearchParse() {
        let jsonString = "{ \"total_count\": 2673420, \"items\": [ { \"id\": 1, \"name\": \"RxJava\", \"description\": \"RxJava – Reactive Extensions for the JVM\", \"owner\": { \"login\": \"ReactiveX\", \"id\": 6407041, \"avatar_url\": \"https://avatars.githubusercontent.com/u/6407041?v=3\" }, \"stargazers_count\": 20207, \"forks\": 3559 }, { \"id\": 2, \"name\": \"Android\", \"description\": \"Google-Android: Mock\", \"owner\": { \"login\": \"Google\", \"id\": 6407042, \"avatar_url\": \"https://avatars.githubusercontent.com/u/6407042?v=3\" }, \"stargazers_count\": 123213, \"forks\": 123 }, { \"id\": 3, \"name\": \"Sax\", \"description\": \"Teste Sax\", \"owner\": { \"login\": \"Sax\", \"id\": 123, \"avatar_url\": \"https://avatars.githubusercontent.com/u/123?v=3\" }, \"stargazers_count\": 8506, \"forks\": 555 } ] }"
        
        let search = Mapper<Search>().map(JSONString: jsonString)
        XCTAssertEqual(search?.total_count, 2673420)
        XCTAssertEqual(search?.repositories?[0].id, 1)
        XCTAssertEqual(search?.repositories?[0].name, "RxJava")
        XCTAssertEqual(search?.repositories?[0].repoDescription, "RxJava – Reactive Extensions for the JVM")
        XCTAssertEqual(search?.repositories?[0].owner?.id, 6407041)
        XCTAssertEqual(search?.repositories?[0].owner?.login, "ReactiveX")
        XCTAssertEqual(search?.repositories?[0].owner?.avatarURLString, "https://avatars.githubusercontent.com/u/6407041?v=3")
    }
    
}
