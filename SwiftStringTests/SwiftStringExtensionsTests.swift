//
//  SwiftStringExtensionsTests.swift
//  SwiftString
//
//  Created by Andrés Catalán on 2016–03–16.
//  Copyright © 2016 Ayre. All rights reserved.
//

import XCTest

class SwiftStringExtensionsTests: XCTestCase {

    func testBetween() {
        XCTAssertEqual("abcdefgh".between("ab", "fg"), "cde")
        
        XCTAssertEqual("<a>foo</a>".between("<a>", "</a>"), "foo")
        XCTAssertEqual("<a><a>foo</a></a>".between("<a>", "</a>"), "<a>foo</a>")
        XCTAssertEqual("<a>foo".between("<a>", "</a>"), nil)
        XCTAssertEqual("Some strings } are very {weird}, dont you think?".between("{", "}"), "weird")
        XCTAssertEqual("<a></a>".between("<a>", "</a>"), nil)
        XCTAssertEqual("<a>foo</a>".between("<a>", "<a>"), nil)
    }

    func testCamelize() {
        XCTAssertEqual("os version".camelize(), "osVersion")
        XCTAssertEqual("HelloWorld".camelize(), "helloWorld")
        XCTAssertEqual("someword With Characters".camelize(), "somewordWithCharacters")
        XCTAssertEqual("data_rate".camelize(), "dataRate")
        XCTAssertEqual("background-color".camelize(), "backgroundColor")
    }
    
    
    func testCapitalize() {
        XCTAssertEqual("hello world".capitalize(), "Hello World")
    }
    
    
    func testChompLeft() {
        XCTAssertEqual("foobar".chompLeft("foo"), "bar")
        XCTAssertEqual("foobar".chompLeft("bar"), "foo")
    }
    
    func testChompRight() {
        XCTAssertEqual("foobar".chompRight("bar"), "foo")
        XCTAssertEqual("foobar".chompRight("foo"), "bar")
    }
    
    func testCollapseWhitespace() {
        XCTAssertEqual("  String   \t libraries are   \n\n\t fun\n!  ".collapseWhitespace(), "String libraries are fun !")
    }
    
    func testContains() {
        XCTAssertEqual("foobar".contains("foo"), true)
        XCTAssertEqual("foobar".contains("bar"), true)
        XCTAssertEqual("foobar".contains("something"), false)
    }
    
    func testCount() {
        XCTAssertEqual("hi hi ho hey hihey".count("hi"), 3)
    }
    
    func testDecodeHTML() {
        XCTAssertEqual("The Weekend &#8216;King Of The Fall&#8217;".decodeHTML(), "The Weekend ‘King Of The Fall’")
        XCTAssertEqual("<strong> 4 &lt; 5 &amp; 3 &gt; 2 .</strong> Price: 12 &#x20ac;.  &#64; ".decodeHTML(), "<strong> 4 < 5 & 3 > 2 .</strong> Price: 12 €.  @ ")
        XCTAssertEqual("this is so &quot;good&quot;".decodeHTML(), "this is so \"good\"")
    }
    
    func testEndsWith() {
        XCTAssertEqual("hello world".endsWith("world"), true)
        XCTAssertEqual("hello world".endsWith("foo"), false)
    }
    
    func testEnsureLeft() {
        XCTAssertEqual("/subdir".ensureLeft("/"), "/subdir")
        XCTAssertEqual("subdir".ensureLeft("/"), "/subdir")
    }
    
    func testEnsureRight() {
        XCTAssertEqual("subdir/".ensureRight("/"), "subdir/")
        XCTAssertEqual("subdir".ensureRight("/"), "subdir/")
    }
    
    func testIndexOf() {
        XCTAssertEqual("hello".indexOf("hell"), 0)
        XCTAssertEqual("hello".indexOf("lo"), 3)
        XCTAssertEqual("hello".indexOf("world"), nil)
    }
    
    func testInitials() {
        XCTAssertEqual("First".initials(), "F")
        XCTAssertEqual("First Last".initials(), "FL")
        XCTAssertEqual("First Middle1 Middle2 Middle3 Last".initials(), "FMMML")
    }
    
    func testInitialsFirstAndLast() {
        XCTAssertEqual("First Last".initialsFirstAndLast(), "FL")
        XCTAssertEqual("First Middle1 Middle2 Middle3 Last".initialsFirstAndLast(), "FL")
    }
    
    func testIsAlpha() {
        XCTAssertEqual("fdafaf3".isAlpha(), false)
        XCTAssertEqual("afaf".isAlpha(), true)
        XCTAssertEqual("dfdf--dfd".isAlpha(), false)
    }
    
    func testIsAlphaNumeric() {
        XCTAssertEqual("afaf35353afaf".isAlphaNumeric(), true)
        XCTAssertEqual("FFFF99fff".isAlphaNumeric(), true)
        XCTAssertEqual("99".isAlphaNumeric(), true)
        XCTAssertEqual("afff".isAlphaNumeric(), true)
        XCTAssertEqual("-33".isAlphaNumeric(), false)
        XCTAssertEqual("aaff..".isAlphaNumeric(), false)
    }
    
    func testIsEmpty() {
        XCTAssertEqual(" ".isEmpty(), true)
        XCTAssertEqual("\t\t\t ".isEmpty(), true)
        XCTAssertEqual("\n\n".isEmpty(), true)
        XCTAssertEqual("helo".isEmpty(), false)
    }
    
    func testIsNumeric() {
        XCTAssertEqual("abc".isNumeric(), false)
        XCTAssertEqual("123a".isNumeric(), false)
        XCTAssertEqual("1".isNumeric(), true)
        XCTAssertEqual("22".isNumeric(), true)
        XCTAssertEqual("33.0".isNumeric(), true)
        XCTAssertEqual("-63.0".isNumeric(), true)
    }
    
    func testJoin() {
        XCTAssertEqual(",".join([1,2,3]), "1,2,3")
        XCTAssertEqual(",".join([]), "")
        XCTAssertEqual(",".join(["a","b","c"]), "a,b,c")
        XCTAssertEqual("! ".join(["hey","who are you?"]), "hey! who are you?")
    }
    
    func testLatinize() {
        XCTAssertEqual("šÜįéïöç".latinize(), "sUieioc")
        XCTAssertEqual("crème brûlée".latinize(), "creme brulee")
    }
    
    func testLines() {
        XCTAssertEqual("test".lines(), ["test"])
        XCTAssertEqual("test\nsentence".lines(), ["test", "sentence"])
        XCTAssertEqual("test \nsentence".lines(), ["test ", "sentence"])
    }
    
    func testPad() {
        XCTAssertEqual("hello".pad(2), "  hello  ")
        XCTAssertEqual("hello".pad(1, "\t"), "\thello\t")
    }
    
    func testPadLeft() {
        XCTAssertEqual("hello".padLeft(10), "          hello")
        XCTAssertEqual("what?".padLeft(2, "!"), "!!what?")
    }
    
    func testPadRight() {
        XCTAssertEqual("hello".padRight(10), "hello          ")
        XCTAssertEqual("hello".padRight(2, "!"), "hello!!")
    }
    
    func testStartsWith() {
        XCTAssertEqual("hello world".startsWith("hello"), true)
        XCTAssertEqual("hello world".startsWith("foo"), false)
    }
    
    func testSplit() {
        XCTAssertEqual("hello world".split(" ")[0], "hello")
        XCTAssertEqual("hello world".split(" ")[1], "world")
        XCTAssertEqual("helloworld".split(" ")[0], "helloworld")
    }
    
    func testTimes() {
        XCTAssertEqual("hi".times(3), "hihihi")
        XCTAssertEqual(" ".times(10), "          ")
    }
    
    func testToBool() {
        XCTAssertEqual("asdwads".toBool(), nil)
        XCTAssertEqual("true".toBool(), true)
        XCTAssertEqual("false".toBool(), false)
    }
    
    func testToFloat() {
        XCTAssertEqual("asdwads".toFloat(), nil)
        XCTAssertEqual("2.00".toFloat(), 2.0)
        XCTAssertEqual("2".toFloat(), 2.0)
    }
    
    func testToInt() {
        XCTAssertEqual("asdwads".toInt(), nil)
        XCTAssertEqual("2.00".toInt(), 2)
        XCTAssertEqual("2".toInt(), 2)
    }
    
    func testToDate() {
        XCTAssertEqual("asdwads".toDate(), nil)
//        XCTAssertEqual("2014-06-03".toDate(), NSDate)
    }
    
    func testToDateTime() {
        XCTAssertEqual("asdwads".toDateTime(), nil)
//        XCTAssertEqual("2014-06-03 13:15:01".toDateTime(), NSDate
    }
    
    func testToDouble() {
        XCTAssertEqual("asdwads".toDouble(), nil)
        XCTAssertEqual("2.00".toDouble(), 2.0)
        XCTAssertEqual("2".toDouble(), 2.0)
    }
    
    func testTrimmedLeft() {
        XCTAssertEqual("        How are you? ".trimmedLeft(), "How are you? ")
    }
    
    func testTrimmedRight() {
        XCTAssertEqual(" How are you?   ".trimmedRight(), " How are you?")
    }
    
    func testTrimmed() {
        XCTAssertEqual("    How are you?   ".trimmed(), "How are you?")
    }
    
    func testSlugify() {
        XCTAssertEqual("Global Thermonuclear Warfare".slugify(), "global-thermonuclear-warfare")
        XCTAssertEqual("Crème brûlée".slugify(), "creme-brulee")
    }
    
    func testStripPunctuation() {
        XCTAssertEqual("My, st[ring] *full* of %punct)".stripPunctuation(), "My string full of punct")
    }
    
    func testSubstring() {
        XCTAssertEqual("hello world".substring(0, length: 1), "h")
        XCTAssertEqual("hello world".substring(0, length: 11), "hello world")
    }
    
    func testSubscript() {
        XCTAssertEqual("hello world"[0...1], "he")
        XCTAssertEqual("hello world"[0..<1], "h")
        XCTAssertEqual("hello world"[0], "h")
        XCTAssertEqual("hello world"[0...10], "hello world")
    }
}
