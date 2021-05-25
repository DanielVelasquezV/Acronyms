//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Daniel Velásquez on 23-05-21.
//

import XCTest
@testable import Acronyms

class AcronymsTests: XCTestCase {

    func testLoadItems() {
        // Arrange
        let url = Bundle(for: AcronymsTests.self).url(forResource: "jsonTest", withExtension: "json")
        XCTAssertNotNil(url)
        let data = try? Data(contentsOf: url!)
        XCTAssertNotNil(data)
        
        // Act
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode([Acromine].self, from: data!)
        
        // Assert
        XCTAssertNotNil(decoded)
        let item = decoded!.first!
        XCTAssertTrue(item.sf == "BIT")
        XCTAssertTrue(item.lfs.count == 2)
        XCTAssertTrue(item.lfs.first!.lf == "Behavioural Inattention Test")
    }

    func testSuccessfulResponse() {
        // Arrange
        let session = NetworkSessionMock()
        let manager = NetworkManager(session: session)
        let url = Bundle(for: AcronymsTests.self).url(forResource: "jsonTest", withExtension: "json")
        XCTAssertNotNil(url)
        let data = try? Data(contentsOf: url!)
        XCTAssertNotNil(data)
        session.data = data

        // Act
        var result: Result<[Acromine], LoadingError>?
        manager.load("bit") { result = $0 }
        let value = try? result?.get().last
        
        // Assert
        XCTAssertEqual(value?.sf, "BIT")
        XCTAssertEqual(value?.lfs.last?.freq, 8)
        XCTAssertEqual(value?.lfs.last?.lf, "1,2-benzisothiazolin-3-one")
    }
}
