//
//  Homegate_tTests.swift
//  Homegate_tTests
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import XCTest
@testable import Homegate_t

class Homegate_tTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchHomesVMFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")

        Homegate_tTests.fetchMOCHomes { (homes) in
            XCTAssert(homes.count == 10)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Helper
    static func fetchMOCHomes(delay: Int = 0, completion: @escaping ([HomeVM]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "homesMOC"
            loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let homesResponse = try JSONDecoder().decode(HomeResponse.self, from: json)
                        let homesVMs = homesResponse.items.map { HomeVM(homeItemResponse: $0) }
                        completion(homesVMs)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }

    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch {
                completion(nil)
            }
        }
    }
    
    // HomeVM
    func testInitHomeVMWithHome() {
        
        let home1 = Home(id: 1, price: "123", title: "Title 1", address: "Address 1", imageUrl: nil, isFavourite: true, currency: "CHF")
        
        let home2 = Home(id: 1, price: "bal bla", title: "Title 2", address: "Address 2", imageUrl: nil, isFavourite: true, currency: "CHF")
        
        let vm1 = HomeVM(home: home1)
        let vm2 = HomeVM(home: home2)

        XCTAssert(vm1.price == "123")
        XCTAssert(vm1.title == "Title 1")
        XCTAssert(vm1.address == "Address 1")
        XCTAssert(vm1.currency == "CHF")
        XCTAssert(vm1.priceDescription == "123 CHF")
        
        XCTAssert(vm2.price == "bal bla")
        XCTAssert(vm2.title == "Title 2")
        XCTAssert(vm2.address == "Address 2")
        XCTAssert(vm2.currency == "CHF")
        XCTAssert(vm2.priceDescription == "NONE")
    }
    
    func testInitHomeVMWithHomeItemResponse() {
        
        let homeItemResponse1 = HomeItemResponse(advertisementId: 116237026, title: "neu renovierte 3-Zimmer Wohnung", pictures: [""], city: "Riehen", country: "CH", offerType: "RENT", objectCategory: "APPT", description: " neu renovierte Wohnung sep. WC / Bad, Kellerabteil + Estrichabteil, grosse Räume, Einbauschrank Velokeller vorhanden gute Anbindung an ÖV Einkaufsmöglichkeiten in Fussdistanz ", street: "Käppeligasse 6", priceUnit: "MONTHLY", price: 1690, currency: "CHF")
        
        let homeItemResponse2 = HomeItemResponse(advertisementId: 116137453, title: "Ruhig - zentral und zu einem fairen Preis", pictures: [""], city: "Berg TG", country: "CH", offerType: "RENT", objectCategory: "APPT", description: "Immokanzlei AG – Ihr Partner für Immobilien im Kanton Thurgau am Bodensee. Kauf, Verkauf, Vermietung, Verwaltung, Schätzung, Immobilienberatung. Kompetent und fair – mit besten Referenzen. Gemütliche 3.5 Zi.-Wohung im 2. OG. Balkon mit Abendsonne und Weitsicht. Abstellplatz kann für CHF 50.- dazu gemietet werden. weitere Angaben Stockwerk: 2. Stock Anzahl Bäder: 1 Böden: Platten (Küche/Bad) und...", street: "Breitestrasse 4", priceUnit: "MONTHLY", price: 1590, currency: "CHF")
        
        let homeItemResponse3 = HomeItemResponse(advertisementId: 116137453, title: "Ruhig - zentral und zu einem fairen Preis", pictures: [""], city: "Berg TG", country: "CH", offerType: "RENT", objectCategory: "APPT", description: "Immokanzlei AG – Ihr Partner für Immobilien im Kanton Thurgau am Bodensee. Kauf, Verkauf, Vermietung, Verwaltung, Schätzung, Immobilienberatung. Kompetent und fair – mit besten Referenzen. Gemütliche 3.5 Zi.-Wohung im 2. OG. Balkon mit Abendsonne und Weitsicht. Abstellplatz kann für CHF 50.- dazu gemietet werden. weitere Angaben Stockwerk: 2. Stock Anzahl Bäder: 1 Böden: Platten (Küche/Bad) und...", street: "Breitestrasse 4", priceUnit: "MONTHLY", price: nil, currency: "CHF")
        
        let vm1 = HomeVM(homeItemResponse: homeItemResponse1)
        let vm2 = HomeVM(homeItemResponse: homeItemResponse2)
        let vm3 = HomeVM(homeItemResponse: homeItemResponse3)

        XCTAssert(vm1.price == "1690")
        XCTAssert(vm1.title == "Neu Renovierte 3-Zimmer Wohnung")
        XCTAssert(vm1.address == "CH, Riehen, Käppeligasse 6")
        XCTAssert(vm1.currency == "CHF")
        XCTAssert(vm1.priceDescription == "1690 CHF")
        
        XCTAssert(vm2.price == "1590")
        XCTAssert(vm2.title == "Ruhig - Zentral Und Zu Einem Fairen Preis")
        XCTAssert(vm2.address == "CH, Berg TG, Breitestrasse 4")
        XCTAssert(vm2.currency == "CHF")
        XCTAssert(vm2.priceDescription == "1590 CHF")

        XCTAssert(vm3.price == "Price not yet defined")
        XCTAssert(vm3.title == "Ruhig - Zentral Und Zu Einem Fairen Preis")
        XCTAssert(vm3.address == "CH, Berg TG, Breitestrasse 4")
        XCTAssert(vm3.currency == "CHF")
        XCTAssert(vm3.priceDescription == "NONE")
    }
    
    //Home
    func testInitHomeWithHomeVM() {
        
        let asyncExpectation = expectation(description: "Async block executed")

        Homegate_tTests.fetchMOCHomes { (homes) in
            
            let hVM1 = homes.first!
            let hVM2 = homes[1]

            let h1 = Home(homeVM: hVM1)
            let h2 = Home(homeVM: hVM2)

            XCTAssert(h1.id == hVM1.id)
            XCTAssert(h1.price == hVM1.price)
            XCTAssert(h1.title == hVM1.title)
            XCTAssert(h1.address == hVM1.address)
            XCTAssert(h1.isFavourite == hVM1.isFavourite)
            XCTAssert(h1.currency == hVM1.currency)

            XCTAssert(h2.id == hVM2.id)
            XCTAssert(h2.price == hVM2.price)
            XCTAssert(h2.title == hVM2.title)
            XCTAssert(h2.address == hVM2.address)
            XCTAssert(h2.isFavourite == hVM2.isFavourite)
            XCTAssert(h2.currency == hVM2.currency)
            
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
