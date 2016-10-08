import XCTest
import Hamcrest
import SwiftString

class SwiftStringTests: XCTestCase {
    
    func testBetween() {
        assertThat("<a>foo</a>".between("<a>", "</a>"), presentAnd(equalTo("foo")))
        assertThat("<a><a>foo</a></a>".between("<a>", "</a>"), presentAnd(equalTo("<a>foo</a>")))
        assertThat("<a>foo".between("<a>", "</a>"), nilValue())
        assertThat("Some strings } are very {weird}, dont you think?".between("{", "}"), presentAnd(equalTo("weird")))
        assertThat("<a></a>".between("<a>", "</a>"), nilValue())
        assertThat("<a>foo</a>".between("<a>", "<a>"), nilValue())
    }
    
    func testCamelize() {
        assertThat("os version".camelize() == "osVersion")
        assertThat("HelloWorld".camelize() == "helloWorld")
        assertThat("someword With Characters".camelize() == "somewordWithCharacters")
        assertThat("data_rate".camelize() == "dataRate")
        assertThat("background-color".camelize() == "backgroundColor")
    }
    
    func testCapitalize() {
        assertThat("hello world".capitalize() == "Hello World")
    }
    
    func testChompLeft() {
        assertThat("foobar".chompLeft("foo") == "bar")
        assertThat("foobar".chompLeft("bar") == "foo")
    }
    
    func testChompRight() {
        assertThat("foobar".chompRight("bar") == "foo")
        assertThat("foobar".chompRight("foo") == "bar")
    }
    
    func testClean() {
        assertThat("thisoneistwoathreetest".clean(with: " ", allOf: "one", "two", "three") == "this is a test")
    }
    
    func testCollapseWhitespace() {
        assertThat("  String   \t libraries are   \n\n\t fun\n!  ".collapseWhitespace() == "String libraries are fun !")
    }
    
    func testContains() {
        assertThat("foobar".contains("foo") == true)
        assertThat("foobar".contains("ba") == true)
        assertThat("foobar".contains("something") == false)
    }
    
    func testCount() {
        assertThat("hi hi ho hey hihey".count("hi") == 3)
    }
    
    func testEndsWith() {
        assertThat("hello world".endsWith("world") == true)
        assertThat("hello world".endsWith("foo") == false)
    }
    
    func testEnsureLeft() {
        assertThat("/subdir".ensureLeft("/") == "/subdir")
        assertThat("subdir".ensureLeft("/") == "/subdir")
    }
    
    func testEnsureRight() {
        assertThat("subdir/".ensureRight("/") == "subdir/")
        assertThat("subdir".ensureRight("/") == "subdir/")
    }
    
    func testIndexOf() {
        assertThat("hello".indexOf("hell"), presentAnd(equalTo(0)))
        assertThat("hello".indexOf("lo"), presentAnd(equalTo(3)))
        assertThat("hello".indexOf("world"), nilValue())
    }

    func testRindexOf() {
        assertThat("hello".rindexOf("hell"), presentAnd(equalTo(0)))
        assertThat("helloll".rindexOf("ll"), presentAnd(equalTo(5)))
        assertThat("hellolloll".rindexOf("ll"), presentAnd(equalTo(8)))
        assertThat("hello".rindexOf("world"), nilValue())
    }
    
    func testInitials() {
        assertThat("First".initials() == "F")
        assertThat("First Last".initials() == "FL")
        assertThat("First Middle1 Middle2 Middle3 Last".initials() == "FMMML")
    }
    
    func testInitialsFirstAndLast() {
        assertThat("First Last".initialsFirstAndLast() == "FL")
        assertThat("First Middle1 Middle2 Middle3 Last".initialsFirstAndLast() == "FL")
    }
    
    func testIsAlpha() {
        assertThat("fdafaf3".isAlpha() == false)
        assertThat("afaf".isAlpha() == true)
        assertThat("dfdf--dfd".isAlpha() == false)
    }
    
    func testIsAlphaNumeric() {
        assertThat("afaf35353afaf".isAlphaNumeric() == true)
        assertThat("FFFF99fff".isAlphaNumeric() == true)
        assertThat("99".isAlphaNumeric() == true)
        assertThat("afff".isAlphaNumeric() == true)
        assertThat("-33".isAlphaNumeric() == false)
        assertThat("aaff..".isAlphaNumeric() == false)
    }
    
    func testIsEmpty() {
        assertThat("".isEmpty() == true)
        assertThat(" ".isEmpty() == true)
        assertThat("\t\t\t ".isEmpty() == true)
        assertThat("\n\n".isEmpty() == true)
        assertThat("helo".isEmpty() == false)
    }
    
    func testIsNumeric() {
        assertThat("abc".isNumeric() == false)
        assertThat("123a".isNumeric() == false)
        assertThat("1".isNumeric() == true)
        assertThat("22".isNumeric() == true)
        assertThat("33.0".isNumeric() == true)
        assertThat("-63.0".isNumeric() == true)
    }
    
    func testJoin() {
        assertThat(",".join([1,2,3]) == "1,2,3")
        assertThat(",".join([]) == "")
        assertThat(",".join(["a","b","c"]) == "a,b,c")
        assertThat("! ".join(["hey","who are you?"]) == "hey! who are you?")
    }
    
    func testLatinize() {
        assertThat("šÜįéïöç".latinize() == "sUieioc")
        assertThat("crème brûlée".latinize() == "creme brulee")
    }
    
    func testLines() {
        assertThat("test".lines() == ["test"])
        assertThat("test\nsentence".lines() == ["test", "sentence"])
        assertThat("test \nsentence".lines() == ["test ", "sentence"])
        //Test Carriage return instead of just newlines
        assertThat("test\rsentence".lines() == ["test", "sentence"])
    }

    func testPad() {
        assertThat("hello".pad(2) == "  hello  ")
        assertThat("hello".pad(1, "\t") == "\thello\t")
    }
    
    func testPadLeft() {
        assertThat("hello".padLeft(10) == "          hello")
        assertThat("what?".padLeft(2, "!") == "!!what?")
    }
    
    func testPadRight() {
        assertThat("hello".padRight(10) == "hello          ")
        assertThat("hello".padRight(2, "!") == "hello!!")
    }
    
    func testStartsWith() {
        assertThat("hello world".startsWith("hello") == true)
        assertThat("hello world".startsWith("foo") == false)
    }
    
    func testSplit() {
        assertThat("hello world".split(" ")[0] == "hello")
        assertThat("hello world".split(" ")[1] == "world")
        assertThat("helloworld".split(" ")[0] == "helloworld")
    }
    
    func testTimes() {
        assertThat("hi".times(3) == "hihihi")
        assertThat(" ".times(10) == "          ")
    }
    
    func testTrimmedLeft() {
        assertThat("        How are you? ".trimmedLeft() == "How are you? ")
    }
    
    func testTrimmedRight() {
        assertThat(" How are you?   ".trimmedRight() == " How are you?")
    }
    
    func testTrimmed() {
        assertThat("    How are you?   ".trimmed() == "How are you?")
        //Added per Issue #9 - https://github.com/amayne/SwiftString/issues/9
        assertThat(" ".trimmed().characters.count == 0)
        assertThat("  ".trimmed().characters.count == 0)
        assertThat("   ".trimmed().characters.count == 0)
    }
    
    func testToBool() {
        assertThat("asdwads".toBool(), nilValue())
        assertThat("true".toBool(), presentAnd(equalTo(true)))
        assertThat("false".toBool(), presentAnd(equalTo(false)))
    }
    
    func testToFloat() {
        assertThat("asdwads".toFloat(), nilValue())
        assertThat("2.00".toFloat(), presentAnd(equalTo(2.0)))
        assertThat("2".toFloat(), presentAnd(equalTo(2.0)))
    }
    
    func testToInt() {
        assertThat("asdwads".toInt(), nilValue())
        assertThat("2.00".toInt(), presentAnd(equalTo(2)))
        assertThat("2".toInt(), presentAnd(equalTo(2)))
    }
    
    func testToDate() {
        assertThat("asdwads".toDate(), nilValue())
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: "2014-06-03".toDate()!)
        
        assertThat(components.year == 2014)
        assertThat(components.month == 6)
        assertThat(components.day == 3)
    }
    
    func testToDateTime() {
        assertThat("asdwads".toDateTime(), nilValue())
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year, .Hour, .Minute, .Second], fromDate: "2014-06-03 13:15:01".toDateTime()!)
        
        assertThat(components.year == 2014)
        assertThat(components.month == 6)
        assertThat(components.day == 3)
        assertThat(components.hour == 13)
        assertThat(components.minute == 15)
        assertThat(components.second == 1)
    }
    
    func testToDouble() {
        assertThat("asdwads".toDouble(), nilValue())
        assertThat("2.00".toDouble(), presentAnd(equalTo(2.0)))
        assertThat("2".toDouble(), presentAnd(equalTo(2.0)))
    }
    
    func testSlugify() {
        assertThat("Global Thermonuclear Warfare".slugify() == "global-thermonuclear-warfare")
        assertThat("Global Thermonuclear Warfare".slugify(withSeparator: "_") == "global_thermonuclear_warfare")
        assertThat("Crème brûlée".slugify() == "creme-brulee")
    }
    
    func testStripPunctuation() {
        assertThat("My, st[ring] *full* of %punct)".stripPunctuation() == "My string full of punct")
    }
    
    func testSubstring() {
        let subject = "hello world"
        assertThat(subject.substring(0, length: 1) == "h")
        assertThat(subject.substring(0, length: 11) == "hello world")
    }
    
    func testSubscripts() {
        let subject = "hello world"
        assertThat(subject[0...1] == "he")
        assertThat(subject[0..<1] == "h")
        assertThat(subject[0] == "h")
        assertThat(subject[0...10] == "hello world")
    }
    
}
