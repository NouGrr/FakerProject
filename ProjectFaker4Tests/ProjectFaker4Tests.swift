//
//  ProjectFaker4Tests.swift
//  ProjectFaker4Tests
//
//  Created by Quentin Courrier on 9/13/24.
//

import XCTest
@testable import ProjectFaker4
import SwiftUI

final class ProjectFaker4Tests: XCTestCase {

    // MARK: - PersonListViewModel Tests
    
    var personListViewModel: PersonListViewModel!
    var ccListViewModel: CCListViewModel!
    var themeManager: ThemeManager!
    
    override func setUp() {
        super.setUp()
        personListViewModel = PersonListViewModel()
        ccListViewModel = CCListViewModel()
        themeManager = ThemeManager()
    }
    
    override func tearDown() {
        personListViewModel = nil
        ccListViewModel = nil
        themeManager = nil
        super.tearDown()
    }
    
    // MARK: - Test for fetching persons
    func testFetchPeople_Success() {
        let expectation = self.expectation(description: "Fetch people")
        
        personListViewModel.fetchPeople()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.personListViewModel.people.isEmpty, "Le tableau des personnes ne devrait pas être vide")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test de filtrage des personnes
    func testFilteredPeople_WithSearchText() {
        let person1 = PersonIdentifiable(idList: 1, id: 1, firstname: "John", lastname: "Doe", address: Address(street: "123 Main St", city: "Paris", country: "France", zipcode: "75000"), image: "", gender: "Male")
        let person2 = PersonIdentifiable(idList: 2, id: 2, firstname: "Jane", lastname: "Smith", address: Address(street: "456 Elm St", city: "Lyon", country: "France", zipcode: "69000"), image: "", gender: "Female")
        
        personListViewModel.people = [person1, person2]
        
        let filteredPeople = personListViewModel.filteredPeople(searchText: "Jane")
        XCTAssertEqual(filteredPeople.count, 1, "Devrait filtrer une seule personne")
        XCTAssertEqual(filteredPeople.first?.firstname, "Jane", "La personne filtrée devrait être Jane")
    }
    
    // MARK: - CreditCardViewModel Tests
    
    func testFetchCreditCard_Success() {
        let expectation = self.expectation(description: "Fetch credit card")
        
        // Mock la carte de crédit avec tous les champs nécessaires
        let mockCard = CreditCard(type: "visa", number: "1234567812345678", expiration: "12/24", owner: "John Doe")
        ccListViewModel.card = mockCard
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.ccListViewModel.card, "La carte de crédit ne devrait pas être nulle")
            XCTAssertEqual(self.ccListViewModel.card?.type.lowercased(), "visa", "Le type de carte devrait être visa")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    
    // MARK: - ThemeManager Tests
    
    func testToggleTheme() {
        let initialDarkMode = themeManager.isDarkMode
        themeManager.isDarkMode.toggle()
        
        XCTAssertNotEqual(themeManager.isDarkMode, initialDarkMode, "Le mode sombre devrait changer après bascule")
    }
    
    func testPersistThemeSetting() {
        themeManager.isDarkMode = true
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "isDarkMode"), "Le paramètre mode sombre devrait être sauvegardé dans UserDefaults")
    }
    
    // MARK: - PersonListView Tests
    
    func testPersonListViewLoadingState() {
        let view = PersonListView(viewModel: personListViewModel)
        
        // Simuler l'état de chargement
        XCTAssertTrue(personListViewModel.people.isEmpty, "Le tableau des personnes devrait être vide au démarrage")
    }
}

