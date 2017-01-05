//
//  PullRequestTest.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/5/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import desafio_ios

class PullRequestTest: XCTestCase {
        
    func testPullRequestParse() {
        let jsonString = "[ { \"url\": \"https://api.github.com/repos/elastic/elasticsearch/pulls/22452\", \"id\": 1, \"title\": \"Disable the Netty recycler and pooled allocator\", \"user\": { \"login\": \"bill\", \"id\": 3, \"avatar_url\": \"https://avatars.githubusercontent.com/u/3?v=3\", \"html_url\": \"https://github.com/bill\" }, \"body\": \"It appears that there are circumstances where the recycler does not recycle quickly #22189\" }, { \"url\": \"https://api.github.com/repos/elastic/elasticsearch/pulls/1231\", \"id\": 2, \"title\": \"Disable the Netty recycler and pooled allocator\", \"user\": { \"login\": \"jasontedor\", \"id\": 4, \"avatar_url\": \"https://avatars.githubusercontent.com/u/4?v=3\", \"html_url\": \"https://github.com/jasontedor\" }, \"body\": \"Netty plays a lot of games with recycling byte buffers in thread local caches#5904, #22406, #22360, #22189\" } ]"
        
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
