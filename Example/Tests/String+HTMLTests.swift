import XCTest
import Hamcrest
import SwiftString

class StringHTMLTests: XCTestCase {

    func testDecodeHTML() {
        assertThat("The Weekend &#8216;King Of The Fall&#8217;".decodeHTML(), presentAnd(equalTo("The Weekend ‘King Of The Fall’")))
        assertThat("<strong> 4 &lt; 5 &amp; 3 &gt; 2 .</strong> Price: 12 &#x20ac;.  &#64; ".decodeHTML(), presentAnd(equalTo("<strong> 4 < 5 & 3 > 2 .</strong> Price: 12 €.  @ ")))
        assertThat("this is so &quot;good&quot;".decodeHTML(), presentAnd(equalTo("this is so \"good\"")))
    }

}
