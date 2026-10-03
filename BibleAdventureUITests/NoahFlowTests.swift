import XCTest

final class NoahFlowTests: XCTestCase {
    override func setUpWithError() throws { continueAfterFailure = false }

    @MainActor private func tap(_ element: XCUIElement, in app: XCUIApplication, file: StaticString = #filePath, line: UInt = #line) {
        for attempt in 0..<40 {
            let scroller = app.scrollViews.firstMatch.exists ? app.scrollViews.firstMatch : app
            let systemConfirmation = element.exists && element.label == "Start new adventure"
            if element.exists && element.isEnabled {
                if systemConfirmation { element.tap(); return }
                let visible = element.frame.intersection(scroller.frame)
                if visible.width >= 44 && visible.height >= 44 {
                    // Use the center of the visible hit region rather than a
                    // clipped control's offscreen center in short landscapes.
                    element.coordinate(withNormalizedOffset: CGVector(
                        dx: (visible.midX - element.frame.minX) / element.frame.width,
                        dy: (visible.midY - element.frame.minY) / element.frame.height
                    )).tap()
                    return
                }
            }
            // Scroll toward known controls; a memory partner can be above the
            // selected card. For lazily materialized controls, search both ways.
            let scrollDown = element.exists ? element.frame.midY < scroller.frame.midY : attempt >= 20
            if element.exists && abs(element.frame.midY - scroller.frame.midY) < scroller.frame.height {
                let start = scroller.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: scrollDown ? 0.35 : 0.65))
                let end = scroller.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: scrollDown ? 0.65 : 0.35))
                start.press(forDuration: 0.05, thenDragTo: end)
            } else if scrollDown { scroller.swipeDown(velocity: .slow) }
            else { scroller.swipeUp(velocity: .slow) }
        }
        screenshot(app, "unreachable-control")
        let tree = XCTAttachment(string: app.debugDescription)
        tree.name = "failure-accessibility-tree"
        tree.lifetime = .keepAlways
        add(tree)
        XCTFail("Unreachable control: \(element)", file: file, line: line)
    }

    @MainActor private func tap(_ label: String, in app: XCUIApplication) {
        tap(app.buttons[label].firstMatch, in: app)
    }

    @MainActor private func screenshot(_ app: XCUIApplication, _ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @MainActor func testFullNoahFlowAndRelaunch() throws { try runFlow(largestText: false) }
    @MainActor func testFullNoahWithLargestTextAndReducedMotion() throws { try runFlow(largestText: true) }
    @MainActor func testFullNoahLandscapeWithLargestTextAndReducedMotion() throws {
        try runFlow(largestText: true, landscape: true)
    }

    @MainActor func testLargestTextAccessibilityAudit() throws {
        let app = XCUIApplication()
        app.launchEnvironment["BIBLE_ADVENTURE_UI_TEST"] = "1"
        app.launchEnvironment["UI_TEST_LARGEST_TEXT"] = "1"
        app.launchEnvironment["UI_TEST_REDUCE_MOTION"] = "1"
        app.launch()
        try app.performAccessibilityAudit(for: [.hitRegion, .textClipped])
        tap("New Adventure", in: app)
        if app.buttons["Start new adventure"].waitForExistence(timeout: 1) { tap("Start new adventure", in: app) }
        tap("Continue", in: app)
        tap("Continue", in: app)
        screenshot(app, "question-accessibility-audit")
        try app.performAccessibilityAudit(for: [.hitRegion, .textClipped])
    }

    @MainActor private func runFlow(largestText: Bool, landscape: Bool = false) throws {
        let app = XCUIApplication()
        app.launchEnvironment["BIBLE_ADVENTURE_UI_TEST"] = "1"
        if largestText {
            app.launchEnvironment["UI_TEST_LARGEST_TEXT"] = "1"
            app.launchEnvironment["UI_TEST_REDUCE_MOTION"] = "1"
        }
        XCUIDevice.shared.orientation = landscape ? .landscapeLeft : .portrait
        app.launch()
        tap("New Adventure", in: app)
        if app.buttons["Start new adventure"].waitForExistence(timeout: 1) { tap("Start new adventure", in: app) }
        tap("Continue", in: app)
        tap("Continue", in: app)
        // Wrong answer and retry preserve the same question and order.
        tap(app.buttons["answer-0"], in: app)
        tap("Try again", in: app)
        tap(app.buttons["answer-1"], in: app)
        screenshot(app, "wood-question")
        tap("Continue story", in: app)
        // Relaunch retains the current dialogue boundary.
        app.terminate()
        app.launch()
        tap("Continue adventure", in: app)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'precise identity is uncertain'")).firstMatch.waitForExistence(timeout: 5))
        XCUIDevice.shared.orientation = .landscapeLeft
        XCTAssertTrue(app.buttons["Continue"].waitForExistence(timeout: 5))
        // Rotate back before continuing; the landscape screenshot is taken after idle.
        screenshot(app, "landscape-resumed-dialogue")
        XCUIDevice.shared.orientation = landscape ? .landscapeLeft : .portrait
        tap("Continue", in: app)
        tap("Collect wood with buttons", in: app)
        for id in ["cypress1", "cypress2", "cypress3"] {
            tap(app.buttons["wood-\(id)"], in: app)
        }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        tap("300 cubits", in: app)
        tap("Next Measurement", in: app)
        tap("50 cubits", in: app)
        tap("Next Measurement", in: app)
        tap("30 cubits", in: app)
        tap("Finish Blueprint", in: app)
        tap("Continue Story", in: app)
        for correctID in [0, 1, 1] {
            tap(app.buttons["answer-\(correctID)"], in: app)
            tap("Continue story", in: app)
        }
        tap("Continue", in: app)
        tap("Assemble with buttons", in: app)
        for piece in ["Ark Base", "Left Wall", "Right Wall", "Middle Deck", "Upper Deck", "Side Door", "Ark Roof"] {
            tap("Select \(piece)", in: app)
            tap("Place selected piece in \(piece) outline", in: app)
        }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        for food in ["Apples", "Bread", "Grain", "Carrots", "Grapes", "Corn"] { tap(food, in: app) }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        for animal in ["Lion", "Elephant", "Giraffe", "Zebra", "Tiger", "Parrot", "Red Fire Ant", "Spider", "Rhino", "Bear", "Sheep", "Dog", "Horse", "Camel", "Frog", "Kangaroo"] {
            let pair = app.buttons.matching(NSPredicate(format: "label == %@", animal))
            tap(pair.element(boundBy: 0), in: app)
            XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label == %@ AND value == 'Selected'", animal)).firstMatch.waitForExistence(timeout: 3), "First card should be selected: \(animal)")
            tap(app.buttons.matching(NSPredicate(format: "label == %@ AND value == 'Not selected'", animal)).firstMatch, in: app)
            let matched = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: pair.firstMatch)
            XCTAssertEqual(XCTWaiter.wait(for: [matched], timeout: 3), .completed, "Matched pair should leave the grid: \(animal)")
        }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        tap("Enter the ark with buttons", in: app)
        for member in ["Noah", "Noah's Wife", "Shem", "Shem's Wife", "Ham", "Ham's Wife", "Japheth", "Japheth's Wife"] {
            tap("Bring \(member) into the ark", in: app)
        }
        tap("Close the Ark", in: app)
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        for action in ["Continue Through the Rain", "Rise With the Waters", "Continue the Journey", "Stay in the Ark", "Wait on GOD"] { tap(action, in: app) }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        for (index, action) in ["Send the Dove", "Send the Dove Again", "Send the Dove One More Time"].enumerated() {
            tap(action, in: app)
            tap(index == 2 ? "Continue" : "Wait Seven Days", in: app)
        }
        tap("Continue Story", in: app)
        tap("Continue", in: app)
        tap("Continue", in: app)
        for color in ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"] { tap(color, in: app) }
        tap("Complete Noah's Adventure", in: app)
        tap("Continue", in: app)
        XCTAssertTrue(app.staticTexts["Reflect on Noah"].waitForExistence(timeout: 5))
        screenshot(app, largestText ? "reflection-accessibility5-reduced-motion" : "reflection-default")
        tap("Finish reflection", in: app)
        app.terminate()
        app.launch()
        tap("Continue adventure", in: app)
        XCTAssertTrue(app.staticTexts["Adventure complete"].waitForExistence(timeout: 5))
        screenshot(app, "completed-after-relaunch")
        XCUIDevice.shared.orientation = .portrait
    }
}
