import XCTest
#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif
@testable import SwiftString
class SwiftStringTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }

	func testBetween() {
		let s = "The stupid brown fox"
		XCTAssert(((s.between("stupid", "fox")?.characters.count) != nil), "Between is invalid")
	}
	func testCamelize() {
		let s = "The stupid brown fox"
		XCTAssert((s.camelize() != "The Stupid Brown Fox"), "Camelize is invalid")
	}
	func testCapitalize() {
		let s = "the Fox"
		XCTAssert((s.capitalize() != "THE FOX"), "Capitalize is invalid")
	}
	func testChompLeft() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.chompLeft("The "), "stupid brown Fox", "ChompLeft is invalid")
	}

	func testChompRight() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.chompLeft(" Fox"), "The stupid brown", "ChompRight is invalid")
	}

	//collapseWhitespace
	func testcollapseWhitespace() {
		let s = "The  stupid brown    fox"
		XCTAssertEqual(s.collapseWhitespace(), "The stupid brown fox", "collapseWhitespace is invalid")
	}

	//clean
	func testclean() {
		let s = "The stupid brøwn føx"
		XCTAssertEqual(s.clean(with: "o",allOf: "ø"), "The stupid brown fox", "clean is invalid")
	}
	//count
	func testcount() {
		let s = "The stupid brown fox"
		XCTAssertEqual(s.count("o"), 2, "count is invalid")
	}
	//endsWith
	func testendsWith() {
		let s = "The stupid brown fox"
		XCTAssertEqual(s.endsWith("foc"), false, "endsWith is invalid")
		XCTAssertEqual(s.endsWith("fox"), true, "endsWith is invalid")
	}
	//ensureLeft
	func testensureLeft() {
		let s = "The stupid brown fox"
		XCTAssertNotEqual(s.ensureLeft("Tha"), s, "ensureLeft is invalid")
		XCTAssertEqual(s.ensureLeft("The"), "The stupid brown fox", "ensureLeft is invalid")
		XCTAssertEqual(s.ensureLeft("And "), "And The stupid brown fox", "ensureLeft is invalid")
	}
	//ensureRight
	func testensureRight() {
		let s = "The stupid brown fox"
		XCTAssertNotEqual(s.ensureRight("fax"), s, "ensureRight is invalid")
		XCTAssertEqual(s.ensureRight("fox"), "The stupid brown fox", "ensureRight is invalid")
		XCTAssertEqual(s.ensureRight(" died."), "The stupid brown fox died.", "ensureRight is invalid")
	}
	//indexOf
	func testindexOf() {
		let s = "The stupid brøwn føx"
		XCTAssertEqual(s.indexOf("s"), 4, "indexOf is invalid")
		XCTAssertNotEqual(s.indexOf("s"), 7, "indexOf is invalid")
	}
	//initials
	func testinitials() {
		let s = "brown Fox"
		XCTAssertEqual(s.initials(), "bF", "initials is invalid")
		XCTAssertNotEqual(s.initials(), "BS", "initials is invalid")
	}
	//initialsFirstAndLast
	func testinitialsFirstAndLast() {
		let s = "stupid brown Fox"
		XCTAssertEqual(s.initialsFirstAndLast(), "sF", "initialsFirstAndLast is invalid")
		XCTAssertNotEqual(s.initialsFirstAndLast(), "bF", "initialsFirstAndLast is invalid")
	}
	//isAlpha
	func testisAlpha() {
		let s = "stupid brown Fox"
		XCTAssertEqual(s.isAlpha(), false, "isAlpha is invalid")

		let sn = "stupid2Fox"
		XCTAssertEqual(sn.isAlpha(), false, "isAlpha is invalid")

		let ss = "stupidbrownFox"
		XCTAssertEqual(ss.isAlpha(), true, "isAlpha is invalid")
	}
	//isAlphaNumeric
	func testisAlphaNumeric() {
		let s = "stupid brown Fox!"
		XCTAssertEqual(s.isAlphaNumeric(), false, "isAlphaNumeric is invalid")

		let snx = "stupid2Fox!"
		XCTAssertEqual(snx.isAlphaNumeric(), false, "isAlphaNumeric is invalid")

		let sn = "stupid2Fox"
		XCTAssertEqual(sn.isAlphaNumeric(), true, "isAlphaNumeric is invalid")

		let ss = "stupidbrownFox"
		XCTAssertEqual(ss.isAlphaNumeric(), true, "isAlphaNumeric is invalid")
	}
	//isEmpty
	func testisEmpty() {
		let s = "stupid brown Fox!"
		XCTAssertEqual(s.isEmpty(), false, "isEmpty is invalid")

		let snx = ""
		XCTAssertEqual(snx.isEmpty(), true, "isEmpty is invalid")
	}
	//isNumeric
	func testisNumeric() {
		let s = "stupid brown Fox!"
		XCTAssertEqual(s.isNumeric(), false, "isNumeric is invalid")

		let snx = "12"
		XCTAssertEqual(snx.isNumeric(), true, "isNumeric is invalid")
	}
	//latinize
	func testlatinize() {
		let s = "The stüpid brown Fox"
		XCTAssertEqual(s.latinize(), "The stupid brown Fox", "latinize is invalid")
	}
	//lines
	func testlines() {
		let s = "The stupid brown Fox\nis dead."
		XCTAssertEqual(s.lines(), ["The stupid brown Fox","is dead."], "lines is invalid")
	}
	//length
	func testlength() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.length, 20, "length is invalid")
	}
	//pad
	func testpad() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.pad(3,"x"), "xxxThe stupid brown Foxxxx", "pad is invalid")
	}
	//padLeft
	func testpadLeft() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.padLeft(3,"x"), "xxxThe stupid brown Fox", "padLeft is invalid")
	}
	//padRight
	func testpadRight() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.padRight(3,"x"), "The stupid brown Foxxxx", "padRight is invalid")
	}
	//slugify
	func testslugify() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.slugify(), "the-stupid-brown-fox", "slugify is invalid")
	}
	//split
	func testsplit() {
		let s = "The stupid brown Fox - is dead"
		XCTAssertEqual(s.split(), ["The","stupid","brown","Fox","-","is","dead"], "split is invalid")
		XCTAssertEqual(s.split("-"), ["The stupid brown Fox "," is dead"], "split is invalid")
	}
	//startsWith
	func teststartsWith() {
		let s = "The stupid brown Fox"
		XCTAssertEqual(s.startsWith("The stupid"), true, "startsWith is invalid")
		XCTAssertEqual(s.startsWith("The nice"), false, "startsWith is invalid")
	}
	//stripPunctuation
	func teststripPunctuation() {
		let s = "The stupid! brown Fox"
		XCTAssertEqual(s.stripPunctuation(), "The stupid brown Fox", "stripPunctuation is invalid")
	}
	//toFloat
	func testtoFloat() {
		let s = "2.0"
		XCTAssertEqual(s.toFloat(), 2.0, "toFloat is invalid")
	}
	//toInt
	func testtoInt() {
		let s = "2"
		XCTAssertEqual(s.toInt(), 2, "toInt is invalid")
	}
	//toBool
	func testtoBool() {
		let s = "0"
		XCTAssertEqual(s.toBool(), false, "toBool is invalid")
		let s1 = "-1"
		XCTAssertEqual(s1.toBool(), true, "toBool is invalid")
		let s2 = "1"
		XCTAssertEqual(s2.toBool(), true, "toBool is invalid")
		let s3 = "2"
		XCTAssertEqual(s3.toBool(), true, "toBool is invalid")
	}
	//toDate
	func testtoDate() {
		let s = "2016-03-01"
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd"
		let someDateTime = formatter.date(from: "2016-03-01")
		XCTAssertEqual(s.toDate(),someDateTime, "toDate is invalid")
	}
	//toDateTime
	func testtoDateTime() {
		let s = "2016-03-01 18:31:00"
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd HH:mm:SS"
		let someDateTime = formatter.date(from: "2016-03-01 18:31:00")
		XCTAssertEqual(s.toDateTime(),someDateTime, "toDateTime is invalid")
	}
	//trimmedLeft
	func testtrimmedLeft() {
		let s = " The stupid brown fox "
		XCTAssertEqual(s.trimmedLeft(), "The stupid brown fox ", "trimmedLeft is invalid")
	}
	//trimmedRight
	func testtrimmedRight() {
		let s = " The stupid brown fox "
		XCTAssertEqual(s.trimmedRight(), " The stupid brown fox", "trimmedRight is invalid")
	}
	//trimmed
	func testtrimmed() {
		let s = " The stupid brown fox "
		XCTAssertEqual(s.trimmed(), "The stupid brown fox", "trimmed is invalid")
	}
	//substring
	func testsubstring() {
		let s = "The stupid brown fox"
		XCTAssertEqual(s.substring(4,length: 9), "stupid br", "trimmed is invalid")
	}
}
