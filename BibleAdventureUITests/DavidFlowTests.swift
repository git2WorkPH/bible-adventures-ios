import XCTest

final class DavidFlowTests: XCTestCase {
    override func setUpWithError() throws { continueAfterFailure = false }

    @MainActor private func tap(_ element: XCUIElement, in app: XCUIApplication, file: StaticString = #filePath, line: UInt = #line) {
        for _ in 0..<30 {
            if element.exists && element.isEnabled {
                let visible = element.frame.intersection(app.frame)
                if visible.width >= 44 && visible.height >= 44 { element.tap(); return }
            }
            app.swipeUp(velocity: .slow)
        }
        XCTFail("Unreachable control: \(element)", file: file, line: line)
    }

    @MainActor private func tap(_ label: String, in app: XCUIApplication) {
        tap(app.buttons[label].firstMatch, in: app)
    }

    @MainActor func testFullDavidFlowAndRelaunch() throws {
        let app = XCUIApplication()
        app.launchEnvironment["BIBLE_ADVENTURE_UI_TEST"] = "1"
        app.launch()

        tap(app.segmentedControls.buttons["David and Goliath"], in: app)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Explore David and Goliath'")).firstMatch.waitForExistence(timeout: 5))
        tap("New Adventure", in: app)
        tap("Continue", in: app)

        for provision in ["Grain", "Bread", "Cheese"] {
            let pair = app.buttons.matching(NSPredicate(format: "label == %@", provision))
            tap(pair.element(boundBy: 0), in: app)
            XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label == %@ AND value == 'Selected'", provision)).firstMatch.waitForExistence(timeout: 3))
            tap(app.buttons.matching(NSPredicate(format: "label == %@ AND value == 'Not selected'", provision)).firstMatch, in: app)
            XCTAssertEqual(XCTWaiter.wait(for: [XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: pair.firstMatch)], timeout: 3), .completed)
        }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        tap("The LORD", in: app)
        tap("Continue story", in: app)
        tap("Continue", in: app)
        tap("He had not tested it", in: app)
        tap("Continue story", in: app)
        tap("Five", in: app)
        tap("Continue story", in: app)
        tap("Continue", in: app)
        tap("Not with sword and spear", in: app)
        tap("Continue story", in: app)
        tap("Continue", in: app)
        XCTAssertTrue(app.staticTexts["Reflect on David and Goliath"].waitForExistence(timeout: 5))
        tap("Finish reflection", in: app)

        app.terminate()
        app.launch()
        tap(app.segmentedControls.buttons["David and Goliath"], in: app)
        tap("Continue adventure", in: app)
        XCTAssertTrue(app.staticTexts["Adventure complete"].waitForExistence(timeout: 5))
    }
}
