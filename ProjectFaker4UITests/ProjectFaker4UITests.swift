//
//  ProjectFaker4UITests.swift
//  ProjectFaker4UITests
//
//  Created by Quentin Courrier on 9/13/24.
//

import XCTest

final class ProjectFaker4UITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testPersonListViewAppears() throws {
        // Vérifier que le titre de la navigation est présent
        XCTAssertTrue(app.navigationBars["Personnes"].exists)
        
        // Vérifier qu'au moins une cellule de la liste est présente
        XCTAssertTrue(app.cells.firstMatch.waitForExistence(timeout: 5))
    }

    func testPersonListViewElements() throws {
           // Attendre que la liste soit chargée
           let firstCell = app.cells.firstMatch
           XCTAssertTrue(firstCell.waitForExistence(timeout: 10))
           
           // Vérifier la présence des éléments dans la première cellule
           XCTAssertTrue(firstCell.staticTexts.firstMatch.exists) // Au moins un texte
           XCTAssertTrue(firstCell.images.firstMatch.exists) // Image de la personne
           
           // Vérifier la présence d'un bouton quelconque dans la cellule
           XCTAssertTrue(firstCell.buttons.firstMatch.exists)
       }

       func testNavigationToCreditCardView() throws {
           // Attendre que la liste soit chargée
           let firstCell = app.cells.firstMatch
           XCTAssertTrue(firstCell.waitForExistence(timeout: 10))
           
           // Taper sur le premier bouton trouvé dans la cellule
           firstCell.buttons.firstMatch.tap()
           
           // Vérifier que la vue des cartes de crédit est affichée
           XCTAssertTrue(app.navigationBars["Credit Cards"].waitForExistence(timeout: 10))
       }

       func testLoadingPageAppears() throws {
           // Redémarrer l'application pour voir la page de chargement
           app.terminate()
           app.launch()
           
           // Vérifier qu'une image apparaît au lancement (pas nécessairement nommée "Fa")
           XCTAssertTrue(app.images.firstMatch.waitForExistence(timeout: 5))
       }

       func testCreditCardViewElements() throws {
           // Naviguer vers la vue des cartes de crédit
           app.cells.firstMatch.buttons.firstMatch.tap()
           
           // Attendre que la vue des cartes de crédit soit chargée
           XCTAssertTrue(app.navigationBars["Credit Cards"].waitForExistence(timeout: 10))
           
           // Vérifier la présence des éléments de la carte de crédit
           XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Type'")).firstMatch.exists)
           XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Number'")).firstMatch.exists)
           XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Expiration'")).firstMatch.exists)
       }

       func testLaunchPerformance() throws {
           if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
               measure(metrics: [XCTApplicationLaunchMetric()]) {
                   XCUIApplication().launch()
               }
           }
       }
   }
