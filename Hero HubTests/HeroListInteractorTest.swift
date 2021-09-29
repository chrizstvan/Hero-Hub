//
//  HeroListInteractorTest.swift
//  Hero HubTests
//
//  Created by Chris on 29/09/21.
//

import XCTest
@testable import Hero_Hub

class HeroListInteractorTest: XCTestCase {
    var presnter: HeroListPresenterMock!
    var service: HeroServiceMock!
    var sut: IHeroListInteractor!
        
    override func setUp() {
        presnter = HeroListPresenterMock()
        service = HeroServiceMock()
        sut = HeroListInteractor(presenter: presnter, service: service, localDB: LocalDBWorker())
    }
    
    override func tearDown() {
        presnter = nil
        service = nil
        sut = nil
    }
    
    func testFetchHeroList() {
        sut.fetchHeroList()
        XCTAssertTrue(service.isRequestHeroList)
    }
    
    func testGetHeroesByRole() {
        sut.getHeroesByRole(role: "Test")
        XCTAssertTrue(presnter.isPresentSuccessGetHeroes)
    }
    
    func testPrepareToNavigate() {
        sut.prepareToNavigate(hero: Hero())
        XCTAssertTrue(presnter.isPrepareToNavigateFinished)
    }
}

class HeroListPresenterMock: IHeroListPresenter {
    var isPresentSuccessGetHeroes = false
    var isPrepareToNavigateFinished = false
    var isPresentFailedGetHeros = false
    
    func presentSuccessGetHeroes() {
        isPresentSuccessGetHeroes = true
    }
    
    func prepareToNavigateFinished(hero: Hero, similarHeroes: [Hero]) {
        isPrepareToNavigateFinished = true
    }
    
    func presentFailedGetHeros(strError: String) {
        isPresentFailedGetHeros = true
    }
}

class HeroServiceMock: IHeroService {
    var isRequestHeroList = false
    var heroes: [Hero]?
    var error: ErrorResult?
    
    func requestHeroList(completion: ((Result<[Hero], ErrorResult>) -> Void)?) {
        heroes = [Hero]()
        error = ErrorResult.generalError(message: "error test")
        completion?(.success(heroes!))
        completion?(.failure(error!))
        isRequestHeroList = true
    }
}

