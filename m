Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 77F8D71F50
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Nov 2014 16:51:08 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 05 Nov 2014 08:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,320,1413270000"; d="scan'208";a="617654735"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.154])
	by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2014 08:48:36 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Nov 2014 10:49:11 -0600
Message-Id: <1415206153-22597-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 06 Nov 2014 11:33:24 +0000
Subject: [PATCHv2 1/3] bitbake: Add beautifulsoup 4.3.2
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Nov 2014 16:51:27 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bitbake: Add beutifulsoup 4.3.2 builder module

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>

bitbake: Add beautifulsoup 4.3.2

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bs4/AUTHORS.txt                    |   43 +
 lib/bs4/COPYING.txt                    |   26 +
 lib/bs4/NEWS.txt                       | 1066 +++++++++++++++++++
 lib/bs4/__init__.py                    |  406 +++++++
 lib/bs4/builder/__init__.py            |  321 ++++++
 lib/bs4/builder/_html5lib.py           |  285 +++++
 lib/bs4/builder/_htmlparser.py         |  258 +++++
 lib/bs4/builder/_lxml.py               |  233 ++++
 lib/bs4/dammit.py                      |  829 +++++++++++++++
 lib/bs4/diagnose.py                    |  204 ++++
 lib/bs4/element.py                     | 1611 ++++++++++++++++++++++++++++
 lib/bs4/testing.py                     |  592 +++++++++++
 lib/bs4/tests/__init__.py              |    1 +
 lib/bs4/tests/test_builder_registry.py |  141 +++
 lib/bs4/tests/test_docs.py             |   36 +
 lib/bs4/tests/test_html5lib.py         |   85 ++
 lib/bs4/tests/test_htmlparser.py       |   19 +
 lib/bs4/tests/test_lxml.py             |   91 ++
 lib/bs4/tests/test_soup.py             |  434 ++++++++
 lib/bs4/tests/test_tree.py             | 1829 ++++++++++++++++++++++++++++++++
 20 files changed, 8510 insertions(+)
 create mode 100644 lib/bs4/AUTHORS.txt
 create mode 100644 lib/bs4/COPYING.txt
 create mode 100644 lib/bs4/NEWS.txt
 create mode 100644 lib/bs4/__init__.py
 create mode 100644 lib/bs4/builder/__init__.py
 create mode 100644 lib/bs4/builder/_html5lib.py
 create mode 100644 lib/bs4/builder/_htmlparser.py
 create mode 100644 lib/bs4/builder/_lxml.py
 create mode 100644 lib/bs4/dammit.py
 create mode 100644 lib/bs4/diagnose.py
 create mode 100644 lib/bs4/element.py
 create mode 100644 lib/bs4/testing.py
 create mode 100644 lib/bs4/tests/__init__.py
 create mode 100644 lib/bs4/tests/test_builder_registry.py
 create mode 100644 lib/bs4/tests/test_docs.py
 create mode 100644 lib/bs4/tests/test_html5lib.py
 create mode 100644 lib/bs4/tests/test_htmlparser.py
 create mode 100644 lib/bs4/tests/test_lxml.py
 create mode 100644 lib/bs4/tests/test_soup.py
 create mode 100644 lib/bs4/tests/test_tree.py

diff --git a/lib/bs4/AUTHORS.txt b/lib/bs4/AUTHORS.txt
new file mode 100644
index 0000000..2ac8fcc
--- /dev/null
+++ b/lib/bs4/AUTHORS.txt
@@ -0,0 +1,43 @@
+Behold, mortal, the origins of Beautiful Soup...
+================================================
+
+Leonard Richardson is the primary programmer.
+
+Aaron DeVore is awesome.
+
+Mark Pilgrim provided the encoding detection code that forms the base
+of UnicodeDammit.
+
+Thomas Kluyver and Ezio Melotti finished the work of getting Beautiful
+Soup 4 working under Python 3.
+
+Simon Willison wrote soupselect, which was used to make Beautiful Soup
+support CSS selectors.
+
+Sam Ruby helped with a lot of edge cases.
+
+Jonathan Ellis was awarded the prestigous Beau Potage D'Or for his
+work in solving the nestable tags conundrum.
+
+An incomplete list of people have contributed patches to Beautiful
+Soup:
+
+ Istvan Albert, Andrew Lin, Anthony Baxter, Andrew Boyko, Tony Chang,
+ Zephyr Fang, Fuzzy, Roman Gaufman, Yoni Gilad, Richie Hindle, Peteris
+ Krumins, Kent Johnson, Ben Last, Robert Leftwich, Staffan Malmgren,
+ Ksenia Marasanova, JP Moins, Adam Monsen, John Nagle, "Jon", Ed
+ Oskiewicz, Greg Phillips, Giles Radford, Arthur Rudolph, Marko
+ Samastur, Jouni Sepp�nen, Alexander Schmolck, Andy Theyers, Glyn
+ Webster, Paul Wright, Danny Yoo
+
+An incomplete list of people who made suggestions or found bugs or
+found ways to break Beautiful Soup:
+
+ Hanno B�ck, Matteo Bertini, Chris Curvey, Simon Cusack, Bruce Eckel,
+ Matt Ernst, Michael Foord, Tom Harris, Bill de hOra, Donald Howes,
+ Matt Patterson, Scott Roberts, Steve Strassmann, Mike Williams,
+ warchild at redho dot com, Sami Kuisma, Carlos Rocha, Bob Hutchison,
+ Joren Mc, Michal Migurski, John Kleven, Tim Heaney, Tripp Lilley, Ed
+ Summers, Dennis Sutch, Chris Smith, Aaron Sweep^W Swartz, Stuart
+ Turner, Greg Edwards, Kevin J Kalupson, Nikos Kouremenos, Artur de
+ Sousa Rocha, Yichun Wei, Per Vognsen
diff --git a/lib/bs4/COPYING.txt b/lib/bs4/COPYING.txt
new file mode 100644
index 0000000..d668d13
--- /dev/null
+++ b/lib/bs4/COPYING.txt
@@ -0,0 +1,26 @@
+Beautiful Soup is made available under the MIT license:
+
+ Copyright (c) 2004-2012 Leonard Richardson
+
+ Permission is hereby granted, free of charge, to any person obtaining
+ a copy of this software and associated documentation files (the
+ "Software"), to deal in the Software without restriction, including
+ without limitation the rights to use, copy, modify, merge, publish,
+ distribute, sublicense, and/or sell copies of the Software, and to
+ permit persons to whom the Software is furnished to do so, subject to
+ the following conditions:
+
+ The above copyright notice and this permission notice shall be
+ included in all copies or substantial portions of the Software.
+
+ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ SOFTWARE, DAMMIT.
+
+Beautiful Soup incorporates code from the html5lib library, which is
+also made available under the MIT license.
diff --git a/lib/bs4/NEWS.txt b/lib/bs4/NEWS.txt
new file mode 100644
index 0000000..88a60a2
--- /dev/null
+++ b/lib/bs4/NEWS.txt
@@ -0,0 +1,1066 @@
+= 4.3.2 (20131002) =
+
+* Fixed a bug in which short Unicode input was improperly encoded to
+  ASCII when checking whether or not it was the name of a file on
+  disk. [bug=1227016]
+
+* Fixed a crash when a short input contains data not valid in
+  filenames. [bug=1232604]
+
+* Fixed a bug that caused Unicode data put into UnicodeDammit to
+  return None instead of the original data. [bug=1214983]
+
+* Combined two tests to stop a spurious test failure when tests are
+  run by nosetests. [bug=1212445]
+
+= 4.3.1 (20130815) =
+
+* Fixed yet another problem with the html5lib tree builder, caused by
+  html5lib's tendency to rearrange the tree during
+  parsing. [bug=1189267]
+
+* Fixed a bug that caused the optimized version of find_all() to
+  return nothing. [bug=1212655]
+
+= 4.3.0 (20130812) =
+
+* Instead of converting incoming data to Unicode and feeding it to the
+  lxml tree builder in chunks, Beautiful Soup now makes successive
+  guesses at the encoding of the incoming data, and tells lxml to
+  parse the data as that encoding. Giving lxml more control over the
+  parsing process improves performance and avoids a number of bugs and
+  issues with the lxml parser which had previously required elaborate
+  workarounds:
+
+  - An issue in which lxml refuses to parse Unicode strings on some
+    systems. [bug=1180527]
+
+  - A returning bug that truncated documents longer than a (very
+    small) size. [bug=963880]
+
+  - A returning bug in which extra spaces were added to a document if
+    the document defined a charset other than UTF-8. [bug=972466]
+
+  This required a major overhaul of the tree builder architecture. If
+  you wrote your own tree builder and didn't tell me, you'll need to
+  modify your prepare_markup() method.
+
+* The UnicodeDammit code that makes guesses at encodings has been
+  split into its own class, EncodingDetector. A lot of apparently
+  redundant code has been removed from Unicode, Dammit, and some
+  undocumented features have also been removed.
+
+* Beautiful Soup will issue a warning if instead of markup you pass it
+  a URL or the name of a file on disk (a common beginner's mistake).
+
+* A number of optimizations improve the performance of the lxml tree
+  builder by about 33%, the html.parser tree builder by about 20%, and
+  the html5lib tree builder by about 15%.
+
+* All find_all calls should now return a ResultSet object. Patch by
+  Aaron DeVore. [bug=1194034]
+
+= 4.2.1 (20130531) =
+
+* The default XML formatter will now replace ampersands even if they
+  appear to be part of entities. That is, "&lt;" will become
+  "&amp;lt;". The old code was left over from Beautiful Soup 3, which
+  didn't always turn entities into Unicode characters.
+
+  If you really want the old behavior (maybe because you add new
+  strings to the tree, those strings include entities, and you want
+  the formatter to leave them alone on output), it can be found in
+  EntitySubstitution.substitute_xml_containing_entities(). [bug=1182183]
+
+* Gave new_string() the ability to create subclasses of
+  NavigableString. [bug=1181986]
+
+* Fixed another bug by which the html5lib tree builder could create a
+  disconnected tree. [bug=1182089]
+
+* The .previous_element of a BeautifulSoup object is now always None,
+  not the last element to be parsed. [bug=1182089]
+
+* Fixed test failures when lxml is not installed. [bug=1181589]
+
+* html5lib now supports Python 3. Fixed some Python 2-specific
+  code in the html5lib test suite. [bug=1181624]
+
+* The html.parser treebuilder can now handle numeric attributes in
+  text when the hexidecimal name of the attribute starts with a
+  capital X. Patch by Tim Shirley. [bug=1186242]
+
+= 4.2.0 (20130514) =
+
+* The Tag.select() method now supports a much wider variety of CSS
+  selectors.
+
+ - Added support for the adjacent sibling combinator (+) and the
+   general sibling combinator (~). Tests by "liquider". [bug=1082144]
+
+ - The combinators (>, +, and ~) can now combine with any supported
+   selector, not just one that selects based on tag name.
+
+ - Added limited support for the "nth-of-type" pseudo-class. Code
+   by Sven Slootweg. [bug=1109952]
+
+* The BeautifulSoup class is now aliased to "_s" and "_soup", making
+  it quicker to type the import statement in an interactive session:
+
+  from bs4 import _s
+   or
+  from bs4 import _soup
+
+  The alias may change in the future, so don't use this in code you're
+  going to run more than once.
+
+* Added the 'diagnose' submodule, which includes several useful
+  functions for reporting problems and doing tech support.
+
+  - diagnose(data) tries the given markup on every installed parser,
+    reporting exceptions and displaying successes. If a parser is not
+    installed, diagnose() mentions this fact.
+
+  - lxml_trace(data, html=True) runs the given markup through lxml's
+    XML parser or HTML parser, and prints out the parser events as
+    they happen. This helps you quickly determine whether a given
+    problem occurs in lxml code or Beautiful Soup code.
+
+  - htmlparser_trace(data) is the same thing, but for Python's
+    built-in HTMLParser class.
+
+* In an HTML document, the contents of a <script> or <style> tag will
+  no longer undergo entity substitution by default. XML documents work
+  the same way they did before. [bug=1085953]
+
+* Methods like get_text() and properties like .strings now only give
+  you strings that are visible in the document--no comments or
+  processing commands. [bug=1050164]
+
+* The prettify() method now leaves the contents of <pre> tags
+  alone. [bug=1095654]
+
+* Fix a bug in the html5lib treebuilder which sometimes created
+  disconnected trees. [bug=1039527]
+
+* Fix a bug in the lxml treebuilder which crashed when a tag included
+  an attribute from the predefined "xml:" namespace. [bug=1065617]
+
+* Fix a bug by which keyword arguments to find_parent() were not
+  being passed on. [bug=1126734]
+
+* Stop a crash when unwisely messing with a tag that's been
+  decomposed. [bug=1097699]
+
+* Now that lxml's segfault on invalid doctype has been fixed, fixed a
+  corresponding problem on the Beautiful Soup end that was previously
+  invisible. [bug=984936]
+
+* Fixed an exception when an overspecified CSS selector didn't match
+  anything. Code by Stefaan Lippens. [bug=1168167]
+
+= 4.1.3 (20120820) =
+
+* Skipped a test under Python 2.6 and Python 3.1 to avoid a spurious
+  test failure caused by the lousy HTMLParser in those
+  versions. [bug=1038503]
+
+* Raise a more specific error (FeatureNotFound) when a requested
+  parser or parser feature is not installed. Raise NotImplementedError
+  instead of ValueError when the user calls insert_before() or
+  insert_after() on the BeautifulSoup object itself. Patch by Aaron
+  Devore. [bug=1038301]
+
+= 4.1.2 (20120817) =
+
+* As per PEP-8, allow searching by CSS class using the 'class_'
+  keyword argument. [bug=1037624]
+
+* Display namespace prefixes for namespaced attribute names, instead of
+  the fully-qualified names given by the lxml parser. [bug=1037597]
+
+* Fixed a crash on encoding when an attribute name contained
+  non-ASCII characters.
+
+* When sniffing encodings, if the cchardet library is installed,
+  Beautiful Soup uses it instead of chardet. cchardet is much
+  faster. [bug=1020748]
+
+* Use logging.warning() instead of warning.warn() to notify the user
+  that characters were replaced with REPLACEMENT
+  CHARACTER. [bug=1013862]
+
+= 4.1.1 (20120703) =
+
+* Fixed an html5lib tree builder crash which happened when html5lib
+  moved a tag with a multivalued attribute from one part of the tree
+  to another. [bug=1019603]
+
+* Correctly display closing tags with an XML namespace declared. Patch
+  by Andreas Kostyrka. [bug=1019635]
+
+* Fixed a typo that made parsing significantly slower than it should
+  have been, and also waited too long to close tags with XML
+  namespaces. [bug=1020268]
+
+* get_text() now returns an empty Unicode string if there is no text,
+  rather than an empty bytestring. [bug=1020387]
+
+= 4.1.0 (20120529) =
+
+* Added experimental support for fixing Windows-1252 characters
+  embedded in UTF-8 documents. (UnicodeDammit.detwingle())
+
+* Fixed the handling of &quot; with the built-in parser. [bug=993871]
+
+* Comments, processing instructions, document type declarations, and
+  markup declarations are now treated as preformatted strings, the way
+  CData blocks are. [bug=1001025]
+
+* Fixed a bug with the lxml treebuilder that prevented the user from
+  adding attributes to a tag that didn't originally have
+  attributes. [bug=1002378] Thanks to Oliver Beattie for the patch.
+
+* Fixed some edge-case bugs having to do with inserting an element
+  into a tag it's already inside, and replacing one of a tag's
+  children with another. [bug=997529]
+
+* Added the ability to search for attribute values specified in UTF-8. [bug=1003974]
+
+  This caused a major refactoring of the search code. All the tests
+  pass, but it's possible that some searches will behave differently.
+
+= 4.0.5 (20120427) =
+
+* Added a new method, wrap(), which wraps an element in a tag.
+
+* Renamed replace_with_children() to unwrap(), which is easier to
+  understand and also the jQuery name of the function.
+
+* Made encoding substitution in <meta> tags completely transparent (no
+  more %SOUP-ENCODING%).
+
+* Fixed a bug in decoding data that contained a byte-order mark, such
+  as data encoded in UTF-16LE. [bug=988980]
+
+* Fixed a bug that made the HTMLParser treebuilder generate XML
+  definitions ending with two question marks instead of
+  one. [bug=984258]
+
+* Upon document generation, CData objects are no longer run through
+  the formatter. [bug=988905]
+
+* The test suite now passes when lxml is not installed, whether or not
+  html5lib is installed. [bug=987004]
+
+* Print a warning on HTMLParseErrors to let people know they should
+  install a better parser library.
+
+= 4.0.4 (20120416) =
+
+* Fixed a bug that sometimes created disconnected trees.
+
+* Fixed a bug with the string setter that moved a string around the
+  tree instead of copying it. [bug=983050]
+
+* Attribute values are now run through the provided output formatter.
+  Previously they were always run through the 'minimal' formatter. In
+  the future I may make it possible to specify different formatters
+  for attribute values and strings, but for now, consistent behavior
+  is better than inconsistent behavior. [bug=980237]
+
+* Added the missing renderContents method from Beautiful Soup 3. Also
+  added an encode_contents() method to go along with decode_contents().
+
+* Give a more useful error when the user tries to run the Python 2
+  version of BS under Python 3.
+
+* UnicodeDammit can now convert Microsoft smart quotes to ASCII with
+  UnicodeDammit(markup, smart_quotes_to="ascii").
+
+= 4.0.3 (20120403) =
+
+* Fixed a typo that caused some versions of Python 3 to convert the
+  Beautiful Soup codebase incorrectly.
+
+* Got rid of the 4.0.2 workaround for HTML documents--it was
+  unnecessary and the workaround was triggering a (possibly different,
+  but related) bug in lxml. [bug=972466]
+
+= 4.0.2 (20120326) =
+
+* Worked around a possible bug in lxml that prevents non-tiny XML
+  documents from being parsed. [bug=963880, bug=963936]
+
+* Fixed a bug where specifying `text` while also searching for a tag
+  only worked if `text` wanted an exact string match. [bug=955942]
+
+= 4.0.1 (20120314) =
+
+* This is the first official release of Beautiful Soup 4. There is no
+  4.0.0 release, to eliminate any possibility that packaging software
+  might treat "4.0.0" as being an earlier version than "4.0.0b10".
+
+* Brought BS up to date with the latest release of soupselect, adding
+  CSS selector support for direct descendant matches and multiple CSS
+  class matches.
+
+= 4.0.0b10 (20120302) =
+
+* Added support for simple CSS selectors, taken from the soupselect project.
+
+* Fixed a crash when using html5lib. [bug=943246]
+
+* In HTML5-style <meta charset="foo"> tags, the value of the "charset"
+  attribute is now replaced with the appropriate encoding on
+  output. [bug=942714]
+
+* Fixed a bug that caused calling a tag to sometimes call find_all()
+  with the wrong arguments. [bug=944426]
+
+* For backwards compatibility, brought back the BeautifulStoneSoup
+  class as a deprecated wrapper around BeautifulSoup.
+
+= 4.0.0b9 (20120228) =
+
+* Fixed the string representation of DOCTYPEs that have both a public
+  ID and a system ID.
+
+* Fixed the generated XML declaration.
+
+* Renamed Tag.nsprefix to Tag.prefix, for consistency with
+  NamespacedAttribute.
+
+* Fixed a test failure that occured on Python 3.x when chardet was
+  installed.
+
+* Made prettify() return Unicode by default, so it will look nice on
+  Python 3 when passed into print().
+
+= 4.0.0b8 (20120224) =
+
+* All tree builders now preserve namespace information in the
+  documents they parse. If you use the html5lib parser or lxml's XML
+  parser, you can access the namespace URL for a tag as tag.namespace.
+
+  However, there is no special support for namespace-oriented
+  searching or tree manipulation. When you search the tree, you need
+  to use namespace prefixes exactly as they're used in the original
+  document.
+
+* The string representation of a DOCTYPE always ends in a newline.
+
+* Issue a warning if the user tries to use a SoupStrainer in
+  conjunction with the html5lib tree builder, which doesn't support
+  them.
+
+= 4.0.0b7 (20120223) =
+
+* Upon decoding to string, any characters that can't be represented in
+  your chosen encoding will be converted into numeric XML entity
+  references.
+
+* Issue a warning if characters were replaced with REPLACEMENT
+  CHARACTER during Unicode conversion.
+
+* Restored compatibility with Python 2.6.
+
+* The install process no longer installs docs or auxillary text files.
+
+* It's now possible to deepcopy a BeautifulSoup object created with
+  Python's built-in HTML parser.
+
+* About 100 unit tests that "test" the behavior of various parsers on
+  invalid markup have been removed. Legitimate changes to those
+  parsers caused these tests to fail, indicating that perhaps
+  Beautiful Soup should not test the behavior of foreign
+  libraries.
+
+  The problematic unit tests have been reformulated as informational
+  comparisons generated by the script
+  scripts/demonstrate_parser_differences.py.
+
+  This makes Beautiful Soup compatible with html5lib version 0.95 and
+  future versions of HTMLParser.
+
+= 4.0.0b6 (20120216) =
+
+* Multi-valued attributes like "class" always have a list of values,
+  even if there's only one value in the list.
+
+* Added a number of multi-valued attributes defined in HTML5.
+
+* Stopped generating a space before the slash that closes an
+  empty-element tag. This may come back if I add a special XHTML mode
+  (http://www.w3.org/TR/xhtml1/#C_2), but right now it's pretty
+  useless.
+
+* Passing text along with tag-specific arguments to a find* method:
+
+   find("a", text="Click here")
+
+  will find tags that contain the given text as their
+  .string. Previously, the tag-specific arguments were ignored and
+  only strings were searched.
+
+* Fixed a bug that caused the html5lib tree builder to build a
+  partially disconnected tree. Generally cleaned up the html5lib tree
+  builder.
+
+* If you restrict a multi-valued attribute like "class" to a string
+  that contains spaces, Beautiful Soup will only consider it a match
+  if the values correspond to that specific string.
+
+= 4.0.0b5 (20120209) =
+
+* Rationalized Beautiful Soup's treatment of CSS class. A tag
+  belonging to multiple CSS classes is treated as having a list of
+  values for the 'class' attribute. Searching for a CSS class will
+  match *any* of the CSS classes.
+
+  This actually affects all attributes that the HTML standard defines
+  as taking multiple values (class, rel, rev, archive, accept-charset,
+  and headers), but 'class' is by far the most common. [bug=41034]
+
+* If you pass anything other than a dictionary as the second argument
+  to one of the find* methods, it'll assume you want to use that
+  object to search against a tag's CSS classes. Previously this only
+  worked if you passed in a string.
+
+* Fixed a bug that caused a crash when you passed a dictionary as an
+  attribute value (possibly because you mistyped "attrs"). [bug=842419]
+
+* Unicode, Dammit now detects the encoding in HTML 5-style <meta> tags
+  like <meta charset="utf-8" />. [bug=837268]
+
+* If Unicode, Dammit can't figure out a consistent encoding for a
+  page, it will try each of its guesses again, with errors="replace"
+  instead of errors="strict". This may mean that some data gets
+  replaced with REPLACEMENT CHARACTER, but at least most of it will
+  get turned into Unicode. [bug=754903]
+
+* Patched over a bug in html5lib (?) that was crashing Beautiful Soup
+  on certain kinds of markup. [bug=838800]
+
+* Fixed a bug that wrecked the tree if you replaced an element with an
+  empty string. [bug=728697]
+
+* Improved Unicode, Dammit's behavior when you give it Unicode to
+  begin with.
+
+= 4.0.0b4 (20120208) =
+
+* Added BeautifulSoup.new_string() to go along with BeautifulSoup.new_tag()
+
+* BeautifulSoup.new_tag() will follow the rules of whatever
+  tree-builder was used to create the original BeautifulSoup object. A
+  new <p> tag will look like "<p />" if the soup object was created to
+  parse XML, but it will look like "<p></p>" if the soup object was
+  created to parse HTML.
+
+* We pass in strict=False to html.parser on Python 3, greatly
+  improving html.parser's ability to handle bad HTML.
+
+* We also monkeypatch a serious bug in html.parser that made
+  strict=False disastrous on Python 3.2.2.
+
+* Replaced the "substitute_html_entities" argument with the
+  more general "formatter" argument.
+
+* Bare ampersands and angle brackets are always converted to XML
+  entities unless the user prevents it.
+
+* Added PageElement.insert_before() and PageElement.insert_after(),
+  which let you put an element into the parse tree with respect to
+  some other element.
+
+* Raise an exception when the user tries to do something nonsensical
+  like insert a tag into itself.
+
+
+= 4.0.0b3 (20120203) =
+
+Beautiful Soup 4 is a nearly-complete rewrite that removes Beautiful
+Soup's custom HTML parser in favor of a system that lets you write a
+little glue code and plug in any HTML or XML parser you want.
+
+Beautiful Soup 4.0 comes with glue code for four parsers:
+
+ * Python's standard HTMLParser (html.parser in Python 3)
+ * lxml's HTML and XML parsers
+ * html5lib's HTML parser
+
+HTMLParser is the default, but I recommend you install lxml if you
+can.
+
+For complete documentation, see the Sphinx documentation in
+bs4/doc/source/. What follows is a summary of the changes from
+Beautiful Soup 3.
+
+=== The module name has changed ===
+
+Previously you imported the BeautifulSoup class from a module also
+called BeautifulSoup. To save keystrokes and make it clear which
+version of the API is in use, the module is now called 'bs4':
+
+    >>> from bs4 import BeautifulSoup
+
+=== It works with Python 3 ===
+
+Beautiful Soup 3.1.0 worked with Python 3, but the parser it used was
+so bad that it barely worked at all. Beautiful Soup 4 works with
+Python 3, and since its parser is pluggable, you don't sacrifice
+quality.
+
+Special thanks to Thomas Kluyver and Ezio Melotti for getting Python 3
+support to the finish line. Ezio Melotti is also to thank for greatly
+improving the HTML parser that comes with Python 3.2.
+
+=== CDATA sections are normal text, if they're understood at all. ===
+
+Currently, the lxml and html5lib HTML parsers ignore CDATA sections in
+markup:
+
+ <p><![CDATA[foo]]></p> => <p></p>
+
+A future version of html5lib will turn CDATA sections into text nodes,
+but only within tags like <svg> and <math>:
+
+ <svg><![CDATA[foo]]></svg> => <p>foo</p>
+
+The default XML parser (which uses lxml behind the scenes) turns CDATA
+sections into ordinary text elements:
+
+ <p><![CDATA[foo]]></p> => <p>foo</p>
+
+In theory it's possible to preserve the CDATA sections when using the
+XML parser, but I don't see how to get it to work in practice.
+
+=== Miscellaneous other stuff ===
+
+If the BeautifulSoup instance has .is_xml set to True, an appropriate
+XML declaration will be emitted when the tree is transformed into a
+string:
+
+    <?xml version="1.0" encoding="utf-8">
+    <markup>
+     ...
+    </markup>
+
+The ['lxml', 'xml'] tree builder sets .is_xml to True; the other tree
+builders set it to False. If you want to parse XHTML with an HTML
+parser, you can set it manually.
+
+
+= 3.2.0 =
+
+The 3.1 series wasn't very useful, so I renamed the 3.0 series to 3.2
+to make it obvious which one you should use.
+
+= 3.1.0 =
+
+A hybrid version that supports 2.4 and can be automatically converted
+to run under Python 3.0. There are three backwards-incompatible
+changes you should be aware of, but no new features or deliberate
+behavior changes.
+
+1. str() may no longer do what you want. This is because the meaning
+of str() inverts between Python 2 and 3; in Python 2 it gives you a
+byte string, in Python 3 it gives you a Unicode string.
+
+The effect of this is that you can't pass an encoding to .__str__
+anymore. Use encode() to get a string and decode() to get Unicode, and
+you'll be ready (well, readier) for Python 3.
+
+2. Beautiful Soup is now based on HTMLParser rather than SGMLParser,
+which is gone in Python 3. There's some bad HTML that SGMLParser
+handled but HTMLParser doesn't, usually to do with attribute values
+that aren't closed or have brackets inside them:
+
+  <a href="foo</a>, </a><a href="bar">baz</a>
+  <a b="<a>">', '<a b="&lt;a&gt;"></a><a>"></a>
+
+A later version of Beautiful Soup will allow you to plug in different
+parsers to make tradeoffs between speed and the ability to handle bad
+HTML.
+
+3. In Python 3 (but not Python 2), HTMLParser converts entities within
+attributes to the corresponding Unicode characters. In Python 2 it's
+possible to parse this string and leave the &eacute; intact.
+
+ <a href="http://crummy.com?sacr&eacute;&bleu">
+
+In Python 3, the &eacute; is always converted to \xe9 during
+parsing.
+
+
+= 3.0.7a =
+
+Added an import that makes BS work in Python 2.3.
+
+
+= 3.0.7 =
+
+Fixed a UnicodeDecodeError when unpickling documents that contain
+non-ASCII characters.
+
+Fixed a TypeError that occured in some circumstances when a tag
+contained no text.
+
+Jump through hoops to avoid the use of chardet, which can be extremely
+slow in some circumstances. UTF-8 documents should never trigger the
+use of chardet.
+
+Whitespace is preserved inside <pre> and <textarea> tags that contain
+nothing but whitespace.
+
+Beautiful Soup can now parse a doctype that's scoped to an XML namespace.
+
+
+= 3.0.6 =
+
+Got rid of a very old debug line that prevented chardet from working.
+
+Added a Tag.decompose() method that completely disconnects a tree or a
+subset of a tree, breaking it up into bite-sized pieces that are
+easy for the garbage collecter to collect.
+
+Tag.extract() now returns the tag that was extracted.
+
+Tag.findNext() now does something with the keyword arguments you pass
+it instead of dropping them on the floor.
+
+Fixed a Unicode conversion bug.
+
+Fixed a bug that garbled some <meta> tags when rewriting them.
+
+
+= 3.0.5 =
+
+Soup objects can now be pickled, and copied with copy.deepcopy.
+
+Tag.append now works properly on existing BS objects. (It wasn't
+originally intended for outside use, but it can be now.) (Giles
+Radford)
+
+Passing in a nonexistent encoding will no longer crash the parser on
+Python 2.4 (John Nagle).
+
+Fixed an underlying bug in SGMLParser that thinks ASCII has 255
+characters instead of 127 (John Nagle).
+
+Entities are converted more consistently to Unicode characters.
+
+Entity references in attribute values are now converted to Unicode
+characters when appropriate. Numeric entities are always converted,
+because SGMLParser always converts them outside of attribute values.
+
+ALL_ENTITIES happens to just be the XHTML entities, so I renamed it to
+XHTML_ENTITIES.
+
+The regular expression for bare ampersands was too loose. In some
+cases ampersands were not being escaped. (Sam Ruby?)
+
+Non-breaking spaces and other special Unicode space characters are no
+longer folded to ASCII spaces. (Robert Leftwich)
+
+Information inside a TEXTAREA tag is now parsed literally, not as HTML
+tags. TEXTAREA now works exactly the same way as SCRIPT. (Zephyr Fang)
+
+= 3.0.4 =
+
+Fixed a bug that crashed Unicode conversion in some cases.
+
+Fixed a bug that prevented UnicodeDammit from being used as a
+general-purpose data scrubber.
+
+Fixed some unit test failures when running against Python 2.5.
+
+When considering whether to convert smart quotes, UnicodeDammit now
+looks at the original encoding in a case-insensitive way.
+
+= 3.0.3 (20060606) =
+
+Beautiful Soup is now usable as a way to clean up invalid XML/HTML (be
+sure to pass in an appropriate value for convertEntities, or XML/HTML
+entities might stick around that aren't valid in HTML/XML). The result
+may not validate, but it should be good enough to not choke a
+real-world XML parser. Specifically, the output of a properly
+constructed soup object should always be valid as part of an XML
+document, but parts may be missing if they were missing in the
+original. As always, if the input is valid XML, the output will also
+be valid.
+
+= 3.0.2 (20060602) =
+
+Previously, Beautiful Soup correctly handled attribute values that
+contained embedded quotes (sometimes by escaping), but not other kinds
+of XML character. Now, it correctly handles or escapes all special XML
+characters in attribute values.
+
+I aliased methods to the 2.x names (fetch, find, findText, etc.) for
+backwards compatibility purposes. Those names are deprecated and if I
+ever do a 4.0 I will remove them. I will, I tell you!
+
+Fixed a bug where the findAll method wasn't passing along any keyword
+arguments.
+
+When run from the command line, Beautiful Soup now acts as an HTML
+pretty-printer, not an XML pretty-printer.
+
+= 3.0.1 (20060530) =
+
+Reintroduced the "fetch by CSS class" shortcut. I thought keyword
+arguments would replace it, but they don't. You can't call soup('a',
+class='foo') because class is a Python keyword.
+
+If Beautiful Soup encounters a meta tag that declares the encoding,
+but a SoupStrainer tells it not to parse that tag, Beautiful Soup will
+no longer try to rewrite the meta tag to mention the new
+encoding. Basically, this makes SoupStrainers work in real-world
+applications instead of crashing the parser.
+
+= 3.0.0 "Who would not give all else for two p" (20060528) =
+
+This release is not backward-compatible with previous releases. If
+you've got code written with a previous version of the library, go
+ahead and keep using it, unless one of the features mentioned here
+really makes your life easier. Since the library is self-contained,
+you can include an old copy of the library in your old applications,
+and use the new version for everything else.
+
+The documentation has been rewritten and greatly expanded with many
+more examples.
+
+Beautiful Soup autodetects the encoding of a document (or uses the one
+you specify), and converts it from its native encoding to
+Unicode. Internally, it only deals with Unicode strings. When you
+print out the document, it converts to UTF-8 (or another encoding you
+specify). [Doc reference]
+
+It's now easy to make large-scale changes to the parse tree without
+screwing up the navigation members. The methods are extract,
+replaceWith, and insert. [Doc reference. See also Improving Memory
+Usage with extract]
+
+Passing True in as an attribute value gives you tags that have any
+value for that attribute. You don't have to create a regular
+expression. Passing None for an attribute value gives you tags that
+don't have that attribute at all.
+
+Tag objects now know whether or not they're self-closing. This avoids
+the problem where Beautiful Soup thought that tags like <BR /> were
+self-closing even in XML documents. You can customize the self-closing
+tags for a parser object by passing them in as a list of
+selfClosingTags: you don't have to subclass anymore.
+
+There's a new built-in parser, MinimalSoup, which has most of
+BeautifulSoup's HTML-specific rules, but no tag nesting rules. [Doc
+reference]
+
+You can use a SoupStrainer to tell Beautiful Soup to parse only part
+of a document. This saves time and memory, often making Beautiful Soup
+about as fast as a custom-built SGMLParser subclass. [Doc reference,
+SoupStrainer reference]
+
+You can (usually) use keyword arguments instead of passing a
+dictionary of attributes to a search method. That is, you can replace
+soup(args={"id" : "5"}) with soup(id="5"). You can still use args if
+(for instance) you need to find an attribute whose name clashes with
+the name of an argument to findAll. [Doc reference: **kwargs attrs]
+
+The method names have changed to the better method names used in
+Rubyful Soup. Instead of find methods and fetch methods, there are
+only find methods. Instead of a scheme where you can't remember which
+method finds one element and which one finds them all, we have find
+and findAll. In general, if the method name mentions All or a plural
+noun (eg. findNextSiblings), then it finds many elements
+method. Otherwise, it only finds one element. [Doc reference]
+
+Some of the argument names have been renamed for clarity. For instance
+avoidParserProblems is now parserMassage.
+
+Beautiful Soup no longer implements a feed method. You need to pass a
+string or a filehandle into the soup constructor, not with feed after
+the soup has been created. There is still a feed method, but it's the
+feed method implemented by SGMLParser and calling it will bypass
+Beautiful Soup and cause problems.
+
+The NavigableText class has been renamed to NavigableString. There is
+no NavigableUnicodeString anymore, because every string inside a
+Beautiful Soup parse tree is a Unicode string.
+
+findText and fetchText are gone. Just pass a text argument into find
+or findAll.
+
+Null was more trouble than it was worth, so I got rid of it. Anything
+that used to return Null now returns None.
+
+Special XML constructs like comments and CDATA now have their own
+NavigableString subclasses, instead of being treated as oddly-formed
+data. If you parse a document that contains CDATA and write it back
+out, the CDATA will still be there.
+
+When you're parsing a document, you can get Beautiful Soup to convert
+XML or HTML entities into the corresponding Unicode characters. [Doc
+reference]
+
+= 2.1.1 (20050918) =
+
+Fixed a serious performance bug in BeautifulStoneSoup which was
+causing parsing to be incredibly slow.
+
+Corrected several entities that were previously being incorrectly
+translated from Microsoft smart-quote-like characters.
+
+Fixed a bug that was breaking text fetch.
+
+Fixed a bug that crashed the parser when text chunks that look like
+HTML tag names showed up within a SCRIPT tag.
+
+THEAD, TBODY, and TFOOT tags are now nestable within TABLE
+tags. Nested tables should parse more sensibly now.
+
+BASE is now considered a self-closing tag.
+
+= 2.1.0 "Game, or any other dish?" (20050504) =
+
+Added a wide variety of new search methods which, given a starting
+point inside the tree, follow a particular navigation member (like
+nextSibling) over and over again, looking for Tag and NavigableText
+objects that match certain criteria. The new methods are findNext,
+fetchNext, findPrevious, fetchPrevious, findNextSibling,
+fetchNextSiblings, findPreviousSibling, fetchPreviousSiblings,
+findParent, and fetchParents. All of these use the same basic code
+used by first and fetch, so you can pass your weird ways of matching
+things into these methods.
+
+The fetch method and its derivatives now accept a limit argument.
+
+You can now pass keyword arguments when calling a Tag object as though
+it were a method.
+
+Fixed a bug that caused all hand-created tags to share a single set of
+attributes.
+
+= 2.0.3 (20050501) =
+
+Fixed Python 2.2 support for iterators.
+
+Fixed a bug that gave the wrong representation to tags within quote
+tags like <script>.
+
+Took some code from Mark Pilgrim that treats CDATA declarations as
+data instead of ignoring them.
+
+Beautiful Soup's setup.py will now do an install even if the unit
+tests fail. It won't build a source distribution if the unit tests
+fail, so I can't release a new version unless they pass.
+
+= 2.0.2 (20050416) =
+
+Added the unit tests in a separate module, and packaged it with
+distutils.
+
+Fixed a bug that sometimes caused renderContents() to return a Unicode
+string even if there was no Unicode in the original string.
+
+Added the done() method, which closes all of the parser's open
+tags. It gets called automatically when you pass in some text to the
+constructor of a parser class; otherwise you must call it yourself.
+
+Reinstated some backwards compatibility with 1.x versions: referencing
+the string member of a NavigableText object returns the NavigableText
+object instead of throwing an error.
+
+= 2.0.1 (20050412) =
+
+Fixed a bug that caused bad results when you tried to reference a tag
+name shorter than 3 characters as a member of a Tag, eg. tag.table.td.
+
+Made sure all Tags have the 'hidden' attribute so that an attempt to
+access tag.hidden doesn't spawn an attempt to find a tag named
+'hidden'.
+
+Fixed a bug in the comparison operator.
+
+= 2.0.0 "Who cares for fish?" (20050410)
+
+Beautiful Soup version 1 was very useful but also pretty stupid. I
+originally wrote it without noticing any of the problems inherent in
+trying to build a parse tree out of ambiguous HTML tags. This version
+solves all of those problems to my satisfaction. It also adds many new
+clever things to make up for the removal of the stupid things.
+
+== Parsing ==
+
+The parser logic has been greatly improved, and the BeautifulSoup
+class should much more reliably yield a parse tree that looks like
+what the page author intended. For a particular class of odd edge
+cases that now causes problems, there is a new class,
+ICantBelieveItsBeautifulSoup.
+
+By default, Beautiful Soup now performs some cleanup operations on
+text before parsing it. This is to avoid common problems with bad
+definitions and self-closing tags that crash SGMLParser. You can
+provide your own set of cleanup operations, or turn it off
+altogether. The cleanup operations include fixing self-closing tags
+that don't close, and replacing Microsoft smart quotes and similar
+characters with their HTML entity equivalents.
+
+You can now get a pretty-print version of parsed HTML to get a visual
+picture of how Beautiful Soup parses it, with the Tag.prettify()
+method.
+
+== Strings and Unicode ==
+
+There are separate NavigableText subclasses for ASCII and Unicode
+strings. These classes directly subclass the corresponding base data
+types. This means you can treat NavigableText objects as strings
+instead of having to call methods on them to get the strings.
+
+str() on a Tag always returns a string, and unicode() always returns
+Unicode. Previously it was inconsistent.
+
+== Tree traversal ==
+
+In a first() or fetch() call, the tag name or the desired value of an
+attribute can now be any of the following:
+
+ * A string (matches that specific tag or that specific attribute value)
+ * A list of strings (matches any tag or attribute value in the list)
+ * A compiled regular expression object (matches any tag or attribute
+   value that matches the regular expression)
+ * A callable object that takes the Tag object or attribute value as a
+   string. It returns None/false/empty string if the given string
+   doesn't match, and any other value if it does.
+
+This is much easier to use than SQL-style wildcards (see, regular
+expressions are good for something). Because of this, I took out
+SQL-style wildcards. I'll put them back if someone complains, but
+their removal simplifies the code a lot.
+
+You can use fetch() and first() to search for text in the parse tree,
+not just tags. There are new alias methods fetchText() and firstText()
+designed for this purpose. As with searching for tags, you can pass in
+a string, a regular expression object, or a method to match your text.
+
+If you pass in something besides a map to the attrs argument of
+fetch() or first(), Beautiful Soup will assume you want to match that
+thing against the "class" attribute. When you're scraping
+well-structured HTML, this makes your code a lot cleaner.
+
+1.x and 2.x both let you call a Tag object as a shorthand for
+fetch(). For instance, foo("bar") is a shorthand for
+foo.fetch("bar"). In 2.x, you can also access a specially-named member
+of a Tag object as a shorthand for first(). For instance, foo.barTag
+is a shorthand for foo.first("bar"). By chaining these shortcuts you
+traverse a tree in very little code: for header in
+soup.bodyTag.pTag.tableTag('th'):
+
+If an element relationship (like parent or next) doesn't apply to a
+tag, it'll now show up Null instead of None. first() will also return
+Null if you ask it for a nonexistent tag. Null is an object that's
+just like None, except you can do whatever you want to it and it'll
+give you Null instead of throwing an error.
+
+This lets you do tree traversals like soup.htmlTag.headTag.titleTag
+without having to worry if the intermediate stages are actually
+there. Previously, if there was no 'head' tag in the document, headTag
+in that instance would have been None, and accessing its 'titleTag'
+member would have thrown an AttributeError. Now, you can get what you
+want when it exists, and get Null when it doesn't, without having to
+do a lot of conditionals checking to see if every stage is None.
+
+There are two new relations between page elements: previousSibling and
+nextSibling. They reference the previous and next element at the same
+level of the parse tree. For instance, if you have HTML like this:
+
+  <p><ul><li>Foo<br /><li>Bar</ul>
+
+The first 'li' tag has a previousSibling of Null and its nextSibling
+is the second 'li' tag. The second 'li' tag has a nextSibling of Null
+and its previousSibling is the first 'li' tag. The previousSibling of
+the 'ul' tag is the first 'p' tag. The nextSibling of 'Foo' is the
+'br' tag.
+
+I took out the ability to use fetch() to find tags that have a
+specific list of contents. See, I can't even explain it well. It was
+really difficult to use, I never used it, and I don't think anyone
+else ever used it. To the extent anyone did, they can probably use
+fetchText() instead. If it turns out someone needs it I'll think of
+another solution.
+
+== Tree manipulation ==
+
+You can add new attributes to a tag, and delete attributes from a
+tag. In 1.x you could only change a tag's existing attributes.
+
+== Porting Considerations ==
+
+There are three changes in 2.0 that break old code:
+
+In the post-1.2 release you could pass in a function into fetch(). The
+function took a string, the tag name. In 2.0, the function takes the
+actual Tag object.
+
+It's no longer to pass in SQL-style wildcards to fetch(). Use a
+regular expression instead.
+
+The different parsing algorithm means the parse tree may not be shaped
+like you expect. This will only actually affect you if your code uses
+one of the affected parts. I haven't run into this problem yet while
+porting my code.
+
+= Between 1.2 and 2.0 =
+
+This is the release to get if you want Python 1.5 compatibility.
+
+The desired value of an attribute can now be any of the following:
+
+ * A string
+ * A string with SQL-style wildcards
+ * A compiled RE object
+ * A callable that returns None/false/empty string if the given value
+   doesn't match, and any other value otherwise.
+
+This is much easier to use than SQL-style wildcards (see, regular
+expressions are good for something). Because of this, I no longer
+recommend you use SQL-style wildcards. They may go away in a future
+release to clean up the code.
+
+Made Beautiful Soup handle processing instructions as text instead of
+ignoring them.
+
+Applied patch from Richie Hindle (richie at entrian dot com) that
+makes tag.string a shorthand for tag.contents[0].string when the tag
+has only one string-owning child.
+
+Added still more nestable tags. The nestable tags thing won't work in
+a lot of cases and needs to be rethought.
+
+Fixed an edge case where searching for "%foo" would match any string
+shorter than "foo".
+
+= 1.2 "Who for such dainties would not stoop?" (20040708) =
+
+Applied patch from Ben Last (ben at benlast dot com) that made
+Tag.renderContents() correctly handle Unicode.
+
+Made BeautifulStoneSoup even dumber by making it not implicitly close
+a tag when another tag of the same type is encountered; only when an
+actual closing tag is encountered. This change courtesy of Fuzzy (mike
+at pcblokes dot com). BeautifulSoup still works as before.
+
+= 1.1 "Swimming in a hot tureen" =
+
+Added more 'nestable' tags. Changed popping semantics so that when a
+nestable tag is encountered, tags are popped up to the previously
+encountered nestable tag (of whatever kind). I will revert this if
+enough people complain, but it should make more people's lives easier
+than harder. This enhancement was suggested by Anthony Baxter (anthony
+at interlink dot com dot au).
+
+= 1.0 "So rich and green" (20040420) =
+
+Initial release.
diff --git a/lib/bs4/__init__.py b/lib/bs4/__init__.py
new file mode 100644
index 0000000..7ba3426
--- /dev/null
+++ b/lib/bs4/__init__.py
@@ -0,0 +1,406 @@
+"""Beautiful Soup
+Elixir and Tonic
+"The Screen-Scraper's Friend"
+http://www.crummy.com/software/BeautifulSoup/
+
+Beautiful Soup uses a pluggable XML or HTML parser to parse a
+(possibly invalid) document into a tree representation. Beautiful Soup
+provides provides methods and Pythonic idioms that make it easy to
+navigate, search, and modify the parse tree.
+
+Beautiful Soup works with Python 2.6 and up. It works better if lxml
+and/or html5lib is installed.
+
+For more than you ever wanted to know about Beautiful Soup, see the
+documentation:
+http://www.crummy.com/software/BeautifulSoup/bs4/doc/
+"""
+
+__author__ = "Leonard Richardson (leonardr@segfault.org)"
+__version__ = "4.3.2"
+__copyright__ = "Copyright (c) 2004-2013 Leonard Richardson"
+__license__ = "MIT"
+
+__all__ = ['BeautifulSoup']
+
+import os
+import re
+import warnings
+
+from .builder import builder_registry, ParserRejectedMarkup
+from .dammit import UnicodeDammit
+from .element import (
+    CData,
+    Comment,
+    DEFAULT_OUTPUT_ENCODING,
+    Declaration,
+    Doctype,
+    NavigableString,
+    PageElement,
+    ProcessingInstruction,
+    ResultSet,
+    SoupStrainer,
+    Tag,
+    )
+
+# The very first thing we do is give a useful error if someone is
+# running this code under Python 3 without converting it.
+syntax_error = u'You are trying to run the Python 2 version of Beautiful Soup under Python 3. This will not work. You need to convert the code, either by installing it (`python setup.py install`) or by running 2to3 (`2to3 -w bs4`).'
+
+class BeautifulSoup(Tag):
+    """
+    This class defines the basic interface called by the tree builders.
+
+    These methods will be called by the parser:
+      reset()
+      feed(markup)
+
+    The tree builder may call these methods from its feed() implementation:
+      handle_starttag(name, attrs) # See note about return value
+      handle_endtag(name)
+      handle_data(data) # Appends to the current data node
+      endData(containerClass=NavigableString) # Ends the current data node
+
+    No matter how complicated the underlying parser is, you should be
+    able to build a tree using 'start tag' events, 'end tag' events,
+    'data' events, and "done with data" events.
+
+    If you encounter an empty-element tag (aka a self-closing tag,
+    like HTML's <br> tag), call handle_starttag and then
+    handle_endtag.
+    """
+    ROOT_TAG_NAME = u'[document]'
+
+    # If the end-user gives no indication which tree builder they
+    # want, look for one with these features.
+    DEFAULT_BUILDER_FEATURES = ['html', 'fast']
+
+    ASCII_SPACES = '\x20\x0a\x09\x0c\x0d'
+
+    def __init__(self, markup="", features=None, builder=None,
+                 parse_only=None, from_encoding=None, **kwargs):
+        """The Soup object is initialized as the 'root tag', and the
+        provided markup (which can be a string or a file-like object)
+        is fed into the underlying parser."""
+
+        if 'convertEntities' in kwargs:
+            warnings.warn(
+                "BS4 does not respect the convertEntities argument to the "
+                "BeautifulSoup constructor. Entities are always converted "
+                "to Unicode characters.")
+
+        if 'markupMassage' in kwargs:
+            del kwargs['markupMassage']
+            warnings.warn(
+                "BS4 does not respect the markupMassage argument to the "
+                "BeautifulSoup constructor. The tree builder is responsible "
+                "for any necessary markup massage.")
+
+        if 'smartQuotesTo' in kwargs:
+            del kwargs['smartQuotesTo']
+            warnings.warn(
+                "BS4 does not respect the smartQuotesTo argument to the "
+                "BeautifulSoup constructor. Smart quotes are always converted "
+                "to Unicode characters.")
+
+        if 'selfClosingTags' in kwargs:
+            del kwargs['selfClosingTags']
+            warnings.warn(
+                "BS4 does not respect the selfClosingTags argument to the "
+                "BeautifulSoup constructor. The tree builder is responsible "
+                "for understanding self-closing tags.")
+
+        if 'isHTML' in kwargs:
+            del kwargs['isHTML']
+            warnings.warn(
+                "BS4 does not respect the isHTML argument to the "
+                "BeautifulSoup constructor. You can pass in features='html' "
+                "or features='xml' to get a builder capable of handling "
+                "one or the other.")
+
+        def deprecated_argument(old_name, new_name):
+            if old_name in kwargs:
+                warnings.warn(
+                    'The "%s" argument to the BeautifulSoup constructor '
+                    'has been renamed to "%s."' % (old_name, new_name))
+                value = kwargs[old_name]
+                del kwargs[old_name]
+                return value
+            return None
+
+        parse_only = parse_only or deprecated_argument(
+            "parseOnlyThese", "parse_only")
+
+        from_encoding = from_encoding or deprecated_argument(
+            "fromEncoding", "from_encoding")
+
+        if len(kwargs) > 0:
+            arg = kwargs.keys().pop()
+            raise TypeError(
+                "__init__() got an unexpected keyword argument '%s'" % arg)
+
+        if builder is None:
+            if isinstance(features, basestring):
+                features = [features]
+            if features is None or len(features) == 0:
+                features = self.DEFAULT_BUILDER_FEATURES
+            builder_class = builder_registry.lookup(*features)
+            if builder_class is None:
+                raise FeatureNotFound(
+                    "Couldn't find a tree builder with the features you "
+                    "requested: %s. Do you need to install a parser library?"
+                    % ",".join(features))
+            builder = builder_class()
+        self.builder = builder
+        self.is_xml = builder.is_xml
+        self.builder.soup = self
+
+        self.parse_only = parse_only
+
+        if hasattr(markup, 'read'):        # It's a file-type object.
+            markup = markup.read()
+        elif len(markup) <= 256:
+            # Print out warnings for a couple beginner problems
+            # involving passing non-markup to Beautiful Soup.
+            # Beautiful Soup will still parse the input as markup,
+            # just in case that's what the user really wants.
+            if (isinstance(markup, unicode)
+                and not os.path.supports_unicode_filenames):
+                possible_filename = markup.encode("utf8")
+            else:
+                possible_filename = markup
+            is_file = False
+            try:
+                is_file = os.path.exists(possible_filename)
+            except Exception, e:
+                # This is almost certainly a problem involving
+                # characters not valid in filenames on this
+                # system. Just let it go.
+                pass
+            if is_file:
+                warnings.warn(
+                    '"%s" looks like a filename, not markup. You should probably open this file and pass the filehandle into Beautiful Soup.' % markup)
+            if markup[:5] == "http:" or markup[:6] == "https:":
+                # TODO: This is ugly but I couldn't get it to work in
+                # Python 3 otherwise.
+                if ((isinstance(markup, bytes) and not b' ' in markup)
+                    or (isinstance(markup, unicode) and not u' ' in markup)):
+                    warnings.warn(
+                        '"%s" looks like a URL. Beautiful Soup is not an HTTP client. You should probably use an HTTP client to get the document behind the URL, and feed that document to Beautiful Soup.' % markup)
+
+        for (self.markup, self.original_encoding, self.declared_html_encoding,
+         self.contains_replacement_characters) in (
+            self.builder.prepare_markup(markup, from_encoding)):
+            self.reset()
+            try:
+                self._feed()
+                break
+            except ParserRejectedMarkup:
+                pass
+
+        # Clear out the markup and remove the builder's circular
+        # reference to this object.
+        self.markup = None
+        self.builder.soup = None
+
+    def _feed(self):
+        # Convert the document to Unicode.
+        self.builder.reset()
+
+        self.builder.feed(self.markup)
+        # Close out any unfinished strings and close all the open tags.
+        self.endData()
+        while self.currentTag.name != self.ROOT_TAG_NAME:
+            self.popTag()
+
+    def reset(self):
+        Tag.__init__(self, self, self.builder, self.ROOT_TAG_NAME)
+        self.hidden = 1
+        self.builder.reset()
+        self.current_data = []
+        self.currentTag = None
+        self.tagStack = []
+        self.preserve_whitespace_tag_stack = []
+        self.pushTag(self)
+
+    def new_tag(self, name, namespace=None, nsprefix=None, **attrs):
+        """Create a new tag associated with this soup."""
+        return Tag(None, self.builder, name, namespace, nsprefix, attrs)
+
+    def new_string(self, s, subclass=NavigableString):
+        """Create a new NavigableString associated with this soup."""
+        navigable = subclass(s)
+        navigable.setup()
+        return navigable
+
+    def insert_before(self, successor):
+        raise NotImplementedError("BeautifulSoup objects don't support insert_before().")
+
+    def insert_after(self, successor):
+        raise NotImplementedError("BeautifulSoup objects don't support insert_after().")
+
+    def popTag(self):
+        tag = self.tagStack.pop()
+        if self.preserve_whitespace_tag_stack and tag == self.preserve_whitespace_tag_stack[-1]:
+            self.preserve_whitespace_tag_stack.pop()
+        #print "Pop", tag.name
+        if self.tagStack:
+            self.currentTag = self.tagStack[-1]
+        return self.currentTag
+
+    def pushTag(self, tag):
+        #print "Push", tag.name
+        if self.currentTag:
+            self.currentTag.contents.append(tag)
+        self.tagStack.append(tag)
+        self.currentTag = self.tagStack[-1]
+        if tag.name in self.builder.preserve_whitespace_tags:
+            self.preserve_whitespace_tag_stack.append(tag)
+
+    def endData(self, containerClass=NavigableString):
+        if self.current_data:
+            current_data = u''.join(self.current_data)
+            # If whitespace is not preserved, and this string contains
+            # nothing but ASCII spaces, replace it with a single space
+            # or newline.
+            if not self.preserve_whitespace_tag_stack:
+                strippable = True
+                for i in current_data:
+                    if i not in self.ASCII_SPACES:
+                        strippable = False
+                        break
+                if strippable:
+                    if '\n' in current_data:
+                        current_data = '\n'
+                    else:
+                        current_data = ' '
+
+            # Reset the data collector.
+            self.current_data = []
+
+            # Should we add this string to the tree at all?
+            if self.parse_only and len(self.tagStack) <= 1 and \
+                   (not self.parse_only.text or \
+                    not self.parse_only.search(current_data)):
+                return
+
+            o = containerClass(current_data)
+            self.object_was_parsed(o)
+
+    def object_was_parsed(self, o, parent=None, most_recent_element=None):
+        """Add an object to the parse tree."""
+        parent = parent or self.currentTag
+        most_recent_element = most_recent_element or self._most_recent_element
+        o.setup(parent, most_recent_element)
+
+        if most_recent_element is not None:
+            most_recent_element.next_element = o
+        self._most_recent_element = o
+        parent.contents.append(o)
+
+    def _popToTag(self, name, nsprefix=None, inclusivePop=True):
+        """Pops the tag stack up to and including the most recent
+        instance of the given tag. If inclusivePop is false, pops the tag
+        stack up to but *not* including the most recent instqance of
+        the given tag."""
+        #print "Popping to %s" % name
+        if name == self.ROOT_TAG_NAME:
+            # The BeautifulSoup object itself can never be popped.
+            return
+
+        most_recently_popped = None
+
+        stack_size = len(self.tagStack)
+        for i in range(stack_size - 1, 0, -1):
+            t = self.tagStack[i]
+            if (name == t.name and nsprefix == t.prefix):
+                if inclusivePop:
+                    most_recently_popped = self.popTag()
+                break
+            most_recently_popped = self.popTag()
+
+        return most_recently_popped
+
+    def handle_starttag(self, name, namespace, nsprefix, attrs):
+        """Push a start tag on to the stack.
+
+        If this method returns None, the tag was rejected by the
+        SoupStrainer. You should proceed as if the tag had not occured
+        in the document. For instance, if this was a self-closing tag,
+        don't call handle_endtag.
+        """
+
+        # print "Start tag %s: %s" % (name, attrs)
+        self.endData()
+
+        if (self.parse_only and len(self.tagStack) <= 1
+            and (self.parse_only.text
+                 or not self.parse_only.search_tag(name, attrs))):
+            return None
+
+        tag = Tag(self, self.builder, name, namespace, nsprefix, attrs,
+                  self.currentTag, self._most_recent_element)
+        if tag is None:
+            return tag
+        if self._most_recent_element:
+            self._most_recent_element.next_element = tag
+        self._most_recent_element = tag
+        self.pushTag(tag)
+        return tag
+
+    def handle_endtag(self, name, nsprefix=None):
+        #print "End tag: " + name
+        self.endData()
+        self._popToTag(name, nsprefix)
+
+    def handle_data(self, data):
+        self.current_data.append(data)
+
+    def decode(self, pretty_print=False,
+               eventual_encoding=DEFAULT_OUTPUT_ENCODING,
+               formatter="minimal"):
+        """Returns a string or Unicode representation of this document.
+        To get Unicode, pass None for encoding."""
+
+        if self.is_xml:
+            # Print the XML declaration
+            encoding_part = ''
+            if eventual_encoding != None:
+                encoding_part = ' encoding="%s"' % eventual_encoding
+            prefix = u'<?xml version="1.0"%s?>\n' % encoding_part
+        else:
+            prefix = u''
+        if not pretty_print:
+            indent_level = None
+        else:
+            indent_level = 0
+        return prefix + super(BeautifulSoup, self).decode(
+            indent_level, eventual_encoding, formatter)
+
+# Alias to make it easier to type import: 'from bs4 import _soup'
+_s = BeautifulSoup
+_soup = BeautifulSoup
+
+class BeautifulStoneSoup(BeautifulSoup):
+    """Deprecated interface to an XML parser."""
+
+    def __init__(self, *args, **kwargs):
+        kwargs['features'] = 'xml'
+        warnings.warn(
+            'The BeautifulStoneSoup class is deprecated. Instead of using '
+            'it, pass features="xml" into the BeautifulSoup constructor.')
+        super(BeautifulStoneSoup, self).__init__(*args, **kwargs)
+
+
+class StopParsing(Exception):
+    pass
+
+class FeatureNotFound(ValueError):
+    pass
+
+
+#By default, act as an HTML pretty-printer.
+if __name__ == '__main__':
+    import sys
+    soup = BeautifulSoup(sys.stdin)
+    print soup.prettify()
diff --git a/lib/bs4/builder/__init__.py b/lib/bs4/builder/__init__.py
new file mode 100644
index 0000000..740f5f2
--- /dev/null
+++ b/lib/bs4/builder/__init__.py
@@ -0,0 +1,321 @@
+from collections import defaultdict
+import itertools
+import sys
+from bs4.element import (
+    CharsetMetaAttributeValue,
+    ContentMetaAttributeValue,
+    whitespace_re
+    )
+
+__all__ = [
+    'HTMLTreeBuilder',
+    'SAXTreeBuilder',
+    'TreeBuilder',
+    'TreeBuilderRegistry',
+    ]
+
+# Some useful features for a TreeBuilder to have.
+FAST = 'fast'
+PERMISSIVE = 'permissive'
+STRICT = 'strict'
+XML = 'xml'
+HTML = 'html'
+HTML_5 = 'html5'
+
+
+class TreeBuilderRegistry(object):
+
+    def __init__(self):
+        self.builders_for_feature = defaultdict(list)
+        self.builders = []
+
+    def register(self, treebuilder_class):
+        """Register a treebuilder based on its advertised features."""
+        for feature in treebuilder_class.features:
+            self.builders_for_feature[feature].insert(0, treebuilder_class)
+        self.builders.insert(0, treebuilder_class)
+
+    def lookup(self, *features):
+        if len(self.builders) == 0:
+            # There are no builders at all.
+            return None
+
+        if len(features) == 0:
+            # They didn't ask for any features. Give them the most
+            # recently registered builder.
+            return self.builders[0]
+
+        # Go down the list of features in order, and eliminate any builders
+        # that don't match every feature.
+        features = list(features)
+        features.reverse()
+        candidates = None
+        candidate_set = None
+        while len(features) > 0:
+            feature = features.pop()
+            we_have_the_feature = self.builders_for_feature.get(feature, [])
+            if len(we_have_the_feature) > 0:
+                if candidates is None:
+                    candidates = we_have_the_feature
+                    candidate_set = set(candidates)
+                else:
+                    # Eliminate any candidates that don't have this feature.
+                    candidate_set = candidate_set.intersection(
+                        set(we_have_the_feature))
+
+        # The only valid candidates are the ones in candidate_set.
+        # Go through the original list of candidates and pick the first one
+        # that's in candidate_set.
+        if candidate_set is None:
+            return None
+        for candidate in candidates:
+            if candidate in candidate_set:
+                return candidate
+        return None
+
+# The BeautifulSoup class will take feature lists from developers and use them
+# to look up builders in this registry.
+builder_registry = TreeBuilderRegistry()
+
+class TreeBuilder(object):
+    """Turn a document into a Beautiful Soup object tree."""
+
+    features = []
+
+    is_xml = False
+    preserve_whitespace_tags = set()
+    empty_element_tags = None # A tag will be considered an empty-element
+                              # tag when and only when it has no contents.
+
+    # A value for these tag/attribute combinations is a space- or
+    # comma-separated list of CDATA, rather than a single CDATA.
+    cdata_list_attributes = {}
+
+
+    def __init__(self):
+        self.soup = None
+
+    def reset(self):
+        pass
+
+    def can_be_empty_element(self, tag_name):
+        """Might a tag with this name be an empty-element tag?
+
+        The final markup may or may not actually present this tag as
+        self-closing.
+
+        For instance: an HTMLBuilder does not consider a <p> tag to be
+        an empty-element tag (it's not in
+        HTMLBuilder.empty_element_tags). This means an empty <p> tag
+        will be presented as "<p></p>", not "<p />".
+
+        The default implementation has no opinion about which tags are
+        empty-element tags, so a tag will be presented as an
+        empty-element tag if and only if it has no contents.
+        "<foo></foo>" will become "<foo />", and "<foo>bar</foo>" will
+        be left alone.
+        """
+        if self.empty_element_tags is None:
+            return True
+        return tag_name in self.empty_element_tags
+
+    def feed(self, markup):
+        raise NotImplementedError()
+
+    def prepare_markup(self, markup, user_specified_encoding=None,
+                       document_declared_encoding=None):
+        return markup, None, None, False
+
+    def test_fragment_to_document(self, fragment):
+        """Wrap an HTML fragment to make it look like a document.
+
+        Different parsers do this differently. For instance, lxml
+        introduces an empty <head> tag, and html5lib
+        doesn't. Abstracting this away lets us write simple tests
+        which run HTML fragments through the parser and compare the
+        results against other HTML fragments.
+
+        This method should not be used outside of tests.
+        """
+        return fragment
+
+    def set_up_substitutions(self, tag):
+        return False
+
+    def _replace_cdata_list_attribute_values(self, tag_name, attrs):
+        """Replaces class="foo bar" with class=["foo", "bar"]
+
+        Modifies its input in place.
+        """
+        if not attrs:
+            return attrs
+        if self.cdata_list_attributes:
+            universal = self.cdata_list_attributes.get('*', [])
+            tag_specific = self.cdata_list_attributes.get(
+                tag_name.lower(), None)
+            for attr in attrs.keys():
+                if attr in universal or (tag_specific and attr in tag_specific):
+                    # We have a "class"-type attribute whose string
+                    # value is a whitespace-separated list of
+                    # values. Split it into a list.
+                    value = attrs[attr]
+                    if isinstance(value, basestring):
+                        values = whitespace_re.split(value)
+                    else:
+                        # html5lib sometimes calls setAttributes twice
+                        # for the same tag when rearranging the parse
+                        # tree. On the second call the attribute value
+                        # here is already a list.  If this happens,
+                        # leave the value alone rather than trying to
+                        # split it again.
+                        values = value
+                    attrs[attr] = values
+        return attrs
+
+class SAXTreeBuilder(TreeBuilder):
+    """A Beautiful Soup treebuilder that listens for SAX events."""
+
+    def feed(self, markup):
+        raise NotImplementedError()
+
+    def close(self):
+        pass
+
+    def startElement(self, name, attrs):
+        attrs = dict((key[1], value) for key, value in list(attrs.items()))
+        #print "Start %s, %r" % (name, attrs)
+        self.soup.handle_starttag(name, attrs)
+
+    def endElement(self, name):
+        #print "End %s" % name
+        self.soup.handle_endtag(name)
+
+    def startElementNS(self, nsTuple, nodeName, attrs):
+        # Throw away (ns, nodeName) for now.
+        self.startElement(nodeName, attrs)
+
+    def endElementNS(self, nsTuple, nodeName):
+        # Throw away (ns, nodeName) for now.
+        self.endElement(nodeName)
+        #handler.endElementNS((ns, node.nodeName), node.nodeName)
+
+    def startPrefixMapping(self, prefix, nodeValue):
+        # Ignore the prefix for now.
+        pass
+
+    def endPrefixMapping(self, prefix):
+        # Ignore the prefix for now.
+        # handler.endPrefixMapping(prefix)
+        pass
+
+    def characters(self, content):
+        self.soup.handle_data(content)
+
+    def startDocument(self):
+        pass
+
+    def endDocument(self):
+        pass
+
+
+class HTMLTreeBuilder(TreeBuilder):
+    """This TreeBuilder knows facts about HTML.
+
+    Such as which tags are empty-element tags.
+    """
+
+    preserve_whitespace_tags = set(['pre', 'textarea'])
+    empty_element_tags = set(['br' , 'hr', 'input', 'img', 'meta',
+                              'spacer', 'link', 'frame', 'base'])
+
+    # The HTML standard defines these attributes as containing a
+    # space-separated list of values, not a single value. That is,
+    # class="foo bar" means that the 'class' attribute has two values,
+    # 'foo' and 'bar', not the single value 'foo bar'.  When we
+    # encounter one of these attributes, we will parse its value into
+    # a list of values if possible. Upon output, the list will be
+    # converted back into a string.
+    cdata_list_attributes = {
+        "*" : ['class', 'accesskey', 'dropzone'],
+        "a" : ['rel', 'rev'],
+        "link" :  ['rel', 'rev'],
+        "td" : ["headers"],
+        "th" : ["headers"],
+        "td" : ["headers"],
+        "form" : ["accept-charset"],
+        "object" : ["archive"],
+
+        # These are HTML5 specific, as are *.accesskey and *.dropzone above.
+        "area" : ["rel"],
+        "icon" : ["sizes"],
+        "iframe" : ["sandbox"],
+        "output" : ["for"],
+        }
+
+    def set_up_substitutions(self, tag):
+        # We are only interested in <meta> tags
+        if tag.name != 'meta':
+            return False
+
+        http_equiv = tag.get('http-equiv')
+        content = tag.get('content')
+        charset = tag.get('charset')
+
+        # We are interested in <meta> tags that say what encoding the
+        # document was originally in. This means HTML 5-style <meta>
+        # tags that provide the "charset" attribute. It also means
+        # HTML 4-style <meta> tags that provide the "content"
+        # attribute and have "http-equiv" set to "content-type".
+        #
+        # In both cases we will replace the value of the appropriate
+        # attribute with a standin object that can take on any
+        # encoding.
+        meta_encoding = None
+        if charset is not None:
+            # HTML 5 style:
+            # <meta charset="utf8">
+            meta_encoding = charset
+            tag['charset'] = CharsetMetaAttributeValue(charset)
+
+        elif (content is not None and http_equiv is not None
+              and http_equiv.lower() == 'content-type'):
+            # HTML 4 style:
+            # <meta http-equiv="content-type" content="text/html; charset=utf8">
+            tag['content'] = ContentMetaAttributeValue(content)
+
+        return (meta_encoding is not None)
+
+def register_treebuilders_from(module):
+    """Copy TreeBuilders from the given module into this module."""
+    # I'm fairly sure this is not the best way to do this.
+    this_module = sys.modules['bs4.builder']
+    for name in module.__all__:
+        obj = getattr(module, name)
+
+        if issubclass(obj, TreeBuilder):
+            setattr(this_module, name, obj)
+            this_module.__all__.append(name)
+            # Register the builder while we're at it.
+            this_module.builder_registry.register(obj)
+
+class ParserRejectedMarkup(Exception):
+    pass
+
+# Builders are registered in reverse order of priority, so that custom
+# builder registrations will take precedence. In general, we want lxml
+# to take precedence over html5lib, because it's faster. And we only
+# want to use HTMLParser as a last result.
+from . import _htmlparser
+register_treebuilders_from(_htmlparser)
+try:
+    from . import _html5lib
+    register_treebuilders_from(_html5lib)
+except ImportError:
+    # They don't have html5lib installed.
+    pass
+try:
+    from . import _lxml
+    register_treebuilders_from(_lxml)
+except ImportError:
+    # They don't have lxml installed.
+    pass
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
new file mode 100644
index 0000000..7de36ae
--- /dev/null
+++ b/lib/bs4/builder/_html5lib.py
@@ -0,0 +1,285 @@
+__all__ = [
+    'HTML5TreeBuilder',
+    ]
+
+import warnings
+from bs4.builder import (
+    PERMISSIVE,
+    HTML,
+    HTML_5,
+    HTMLTreeBuilder,
+    )
+from bs4.element import NamespacedAttribute
+import html5lib
+from html5lib.constants import namespaces
+from bs4.element import (
+    Comment,
+    Doctype,
+    NavigableString,
+    Tag,
+    )
+
+class HTML5TreeBuilder(HTMLTreeBuilder):
+    """Use html5lib to build a tree."""
+
+    features = ['html5lib', PERMISSIVE, HTML_5, HTML]
+
+    def prepare_markup(self, markup, user_specified_encoding):
+        # Store the user-specified encoding for use later on.
+        self.user_specified_encoding = user_specified_encoding
+        yield (markup, None, None, False)
+
+    # These methods are defined by Beautiful Soup.
+    def feed(self, markup):
+        if self.soup.parse_only is not None:
+            warnings.warn("You provided a value for parse_only, but the html5lib tree builder doesn't support parse_only. The entire document will be parsed.")
+        parser = html5lib.HTMLParser(tree=self.create_treebuilder)
+        doc = parser.parse(markup, encoding=self.user_specified_encoding)
+
+        # Set the character encoding detected by the tokenizer.
+        if isinstance(markup, unicode):
+            # We need to special-case this because html5lib sets
+            # charEncoding to UTF-8 if it gets Unicode input.
+            doc.original_encoding = None
+        else:
+            doc.original_encoding = parser.tokenizer.stream.charEncoding[0]
+
+    def create_treebuilder(self, namespaceHTMLElements):
+        self.underlying_builder = TreeBuilderForHtml5lib(
+            self.soup, namespaceHTMLElements)
+        return self.underlying_builder
+
+    def test_fragment_to_document(self, fragment):
+        """See `TreeBuilder`."""
+        return u'<html><head></head><body>%s</body></html>' % fragment
+
+
+class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
+
+    def __init__(self, soup, namespaceHTMLElements):
+        self.soup = soup
+        super(TreeBuilderForHtml5lib, self).__init__(namespaceHTMLElements)
+
+    def documentClass(self):
+        self.soup.reset()
+        return Element(self.soup, self.soup, None)
+
+    def insertDoctype(self, token):
+        name = token["name"]
+        publicId = token["publicId"]
+        systemId = token["systemId"]
+
+        doctype = Doctype.for_name_and_ids(name, publicId, systemId)
+        self.soup.object_was_parsed(doctype)
+
+    def elementClass(self, name, namespace):
+        tag = self.soup.new_tag(name, namespace)
+        return Element(tag, self.soup, namespace)
+
+    def commentClass(self, data):
+        return TextNode(Comment(data), self.soup)
+
+    def fragmentClass(self):
+        self.soup = BeautifulSoup("")
+        self.soup.name = "[document_fragment]"
+        return Element(self.soup, self.soup, None)
+
+    def appendChild(self, node):
+        # XXX This code is not covered by the BS4 tests.
+        self.soup.append(node.element)
+
+    def getDocument(self):
+        return self.soup
+
+    def getFragment(self):
+        return html5lib.treebuilders._base.TreeBuilder.getFragment(self).element
+
+class AttrList(object):
+    def __init__(self, element):
+        self.element = element
+        self.attrs = dict(self.element.attrs)
+    def __iter__(self):
+        return list(self.attrs.items()).__iter__()
+    def __setitem__(self, name, value):
+        "set attr", name, value
+        self.element[name] = value
+    def items(self):
+        return list(self.attrs.items())
+    def keys(self):
+        return list(self.attrs.keys())
+    def __len__(self):
+        return len(self.attrs)
+    def __getitem__(self, name):
+        return self.attrs[name]
+    def __contains__(self, name):
+        return name in list(self.attrs.keys())
+
+
+class Element(html5lib.treebuilders._base.Node):
+    def __init__(self, element, soup, namespace):
+        html5lib.treebuilders._base.Node.__init__(self, element.name)
+        self.element = element
+        self.soup = soup
+        self.namespace = namespace
+
+    def appendChild(self, node):
+        string_child = child = None
+        if isinstance(node, basestring):
+            # Some other piece of code decided to pass in a string
+            # instead of creating a TextElement object to contain the
+            # string.
+            string_child = child = node
+        elif isinstance(node, Tag):
+            # Some other piece of code decided to pass in a Tag
+            # instead of creating an Element object to contain the
+            # Tag.
+            child = node
+        elif node.element.__class__ == NavigableString:
+            string_child = child = node.element
+        else:
+            child = node.element
+
+        if not isinstance(child, basestring) and child.parent is not None:
+            node.element.extract()
+
+        if (string_child and self.element.contents
+            and self.element.contents[-1].__class__ == NavigableString):
+            # We are appending a string onto another string.
+            # TODO This has O(n^2) performance, for input like
+            # "a</a>a</a>a</a>..."
+            old_element = self.element.contents[-1]
+            new_element = self.soup.new_string(old_element + string_child)
+            old_element.replace_with(new_element)
+            self.soup._most_recent_element = new_element
+        else:
+            if isinstance(node, basestring):
+                # Create a brand new NavigableString from this string.
+                child = self.soup.new_string(node)
+
+            # Tell Beautiful Soup to act as if it parsed this element
+            # immediately after the parent's last descendant. (Or
+            # immediately after the parent, if it has no children.)
+            if self.element.contents:
+                most_recent_element = self.element._last_descendant(False)
+            else:
+                most_recent_element = self.element
+
+            self.soup.object_was_parsed(
+                child, parent=self.element,
+                most_recent_element=most_recent_element)
+
+    def getAttributes(self):
+        return AttrList(self.element)
+
+    def setAttributes(self, attributes):
+        if attributes is not None and len(attributes) > 0:
+
+            converted_attributes = []
+            for name, value in list(attributes.items()):
+                if isinstance(name, tuple):
+                    new_name = NamespacedAttribute(*name)
+                    del attributes[name]
+                    attributes[new_name] = value
+
+            self.soup.builder._replace_cdata_list_attribute_values(
+                self.name, attributes)
+            for name, value in attributes.items():
+                self.element[name] = value
+
+            # The attributes may contain variables that need substitution.
+            # Call set_up_substitutions manually.
+            #
+            # The Tag constructor called this method when the Tag was created,
+            # but we just set/changed the attributes, so call it again.
+            self.soup.builder.set_up_substitutions(self.element)
+    attributes = property(getAttributes, setAttributes)
+
+    def insertText(self, data, insertBefore=None):
+        if insertBefore:
+            text = TextNode(self.soup.new_string(data), self.soup)
+            self.insertBefore(data, insertBefore)
+        else:
+            self.appendChild(data)
+
+    def insertBefore(self, node, refNode):
+        index = self.element.index(refNode.element)
+        if (node.element.__class__ == NavigableString and self.element.contents
+            and self.element.contents[index-1].__class__ == NavigableString):
+            # (See comments in appendChild)
+            old_node = self.element.contents[index-1]
+            new_str = self.soup.new_string(old_node + node.element)
+            old_node.replace_with(new_str)
+        else:
+            self.element.insert(index, node.element)
+            node.parent = self
+
+    def removeChild(self, node):
+        node.element.extract()
+
+    def reparentChildren(self, new_parent):
+        """Move all of this tag's children into another tag."""
+        element = self.element
+        new_parent_element = new_parent.element
+        # Determine what this tag's next_element will be once all the children
+        # are removed.
+        final_next_element = element.next_sibling
+
+        new_parents_last_descendant = new_parent_element._last_descendant(False, False)
+        if len(new_parent_element.contents) > 0:
+            # The new parent already contains children. We will be
+            # appending this tag's children to the end.
+            new_parents_last_child = new_parent_element.contents[-1]
+            new_parents_last_descendant_next_element = new_parents_last_descendant.next_element
+        else:
+            # The new parent contains no children.
+            new_parents_last_child = None
+            new_parents_last_descendant_next_element = new_parent_element.next_element
+
+        to_append = element.contents
+        append_after = new_parent.element.contents
+        if len(to_append) > 0:
+            # Set the first child's previous_element and previous_sibling
+            # to elements within the new parent
+            first_child = to_append[0]
+            first_child.previous_element = new_parents_last_descendant
+            first_child.previous_sibling = new_parents_last_child
+
+            # Fix the last child's next_element and next_sibling
+            last_child = to_append[-1]
+            last_child.next_element = new_parents_last_descendant_next_element
+            last_child.next_sibling = None
+
+        for child in to_append:
+            child.parent = new_parent_element
+            new_parent_element.contents.append(child)
+
+        # Now that this element has no children, change its .next_element.
+        element.contents = []
+        element.next_element = final_next_element
+
+    def cloneNode(self):
+        tag = self.soup.new_tag(self.element.name, self.namespace)
+        node = Element(tag, self.soup, self.namespace)
+        for key,value in self.attributes:
+            node.attributes[key] = value
+        return node
+
+    def hasContent(self):
+        return self.element.contents
+
+    def getNameTuple(self):
+        if self.namespace == None:
+            return namespaces["html"], self.name
+        else:
+            return self.namespace, self.name
+
+    nameTuple = property(getNameTuple)
+
+class TextNode(Element):
+    def __init__(self, element, soup):
+        html5lib.treebuilders._base.Node.__init__(self, None)
+        self.element = element
+        self.soup = soup
+
+    def cloneNode(self):
+        raise NotImplementedError
diff --git a/lib/bs4/builder/_htmlparser.py b/lib/bs4/builder/_htmlparser.py
new file mode 100644
index 0000000..ca8d8b8
--- /dev/null
+++ b/lib/bs4/builder/_htmlparser.py
@@ -0,0 +1,258 @@
+"""Use the HTMLParser library to parse HTML files that aren't too bad."""
+
+__all__ = [
+    'HTMLParserTreeBuilder',
+    ]
+
+from HTMLParser import (
+    HTMLParser,
+    HTMLParseError,
+    )
+import sys
+import warnings
+
+# Starting in Python 3.2, the HTMLParser constructor takes a 'strict'
+# argument, which we'd like to set to False. Unfortunately,
+# http://bugs.python.org/issue13273 makes strict=True a better bet
+# before Python 3.2.3.
+#
+# At the end of this file, we monkeypatch HTMLParser so that
+# strict=True works well on Python 3.2.2.
+major, minor, release = sys.version_info[:3]
+CONSTRUCTOR_TAKES_STRICT = (
+    major > 3
+    or (major == 3 and minor > 2)
+    or (major == 3 and minor == 2 and release >= 3))
+
+from bs4.element import (
+    CData,
+    Comment,
+    Declaration,
+    Doctype,
+    ProcessingInstruction,
+    )
+from bs4.dammit import EntitySubstitution, UnicodeDammit
+
+from bs4.builder import (
+    HTML,
+    HTMLTreeBuilder,
+    STRICT,
+    )
+
+
+HTMLPARSER = 'html.parser'
+
+class BeautifulSoupHTMLParser(HTMLParser):
+    def handle_starttag(self, name, attrs):
+        # XXX namespace
+        attr_dict = {}
+        for key, value in attrs:
+            # Change None attribute values to the empty string
+            # for consistency with the other tree builders.
+            if value is None:
+                value = ''
+            attr_dict[key] = value
+            attrvalue = '""'
+        self.soup.handle_starttag(name, None, None, attr_dict)
+
+    def handle_endtag(self, name):
+        self.soup.handle_endtag(name)
+
+    def handle_data(self, data):
+        self.soup.handle_data(data)
+
+    def handle_charref(self, name):
+        # XXX workaround for a bug in HTMLParser. Remove this once
+        # it's fixed.
+        if name.startswith('x'):
+            real_name = int(name.lstrip('x'), 16)
+        elif name.startswith('X'):
+            real_name = int(name.lstrip('X'), 16)
+        else:
+            real_name = int(name)
+
+        try:
+            data = unichr(real_name)
+        except (ValueError, OverflowError), e:
+            data = u"\N{REPLACEMENT CHARACTER}"
+
+        self.handle_data(data)
+
+    def handle_entityref(self, name):
+        character = EntitySubstitution.HTML_ENTITY_TO_CHARACTER.get(name)
+        if character is not None:
+            data = character
+        else:
+            data = "&%s;" % name
+        self.handle_data(data)
+
+    def handle_comment(self, data):
+        self.soup.endData()
+        self.soup.handle_data(data)
+        self.soup.endData(Comment)
+
+    def handle_decl(self, data):
+        self.soup.endData()
+        if data.startswith("DOCTYPE "):
+            data = data[len("DOCTYPE "):]
+        elif data == 'DOCTYPE':
+            # i.e. "<!DOCTYPE>"
+            data = ''
+        self.soup.handle_data(data)
+        self.soup.endData(Doctype)
+
+    def unknown_decl(self, data):
+        if data.upper().startswith('CDATA['):
+            cls = CData
+            data = data[len('CDATA['):]
+        else:
+            cls = Declaration
+        self.soup.endData()
+        self.soup.handle_data(data)
+        self.soup.endData(cls)
+
+    def handle_pi(self, data):
+        self.soup.endData()
+        if data.endswith("?") and data.lower().startswith("xml"):
+            # "An XHTML processing instruction using the trailing '?'
+            # will cause the '?' to be included in data." - HTMLParser
+            # docs.
+            #
+            # Strip the question mark so we don't end up with two
+            # question marks.
+            data = data[:-1]
+        self.soup.handle_data(data)
+        self.soup.endData(ProcessingInstruction)
+
+
+class HTMLParserTreeBuilder(HTMLTreeBuilder):
+
+    is_xml = False
+    features = [HTML, STRICT, HTMLPARSER]
+
+    def __init__(self, *args, **kwargs):
+        if CONSTRUCTOR_TAKES_STRICT:
+            kwargs['strict'] = False
+        self.parser_args = (args, kwargs)
+
+    def prepare_markup(self, markup, user_specified_encoding=None,
+                       document_declared_encoding=None):
+        """
+        :return: A 4-tuple (markup, original encoding, encoding
+        declared within markup, whether any characters had to be
+        replaced with REPLACEMENT CHARACTER).
+        """
+        if isinstance(markup, unicode):
+            yield (markup, None, None, False)
+            return
+
+        try_encodings = [user_specified_encoding, document_declared_encoding]
+        dammit = UnicodeDammit(markup, try_encodings, is_html=True)
+        yield (dammit.markup, dammit.original_encoding,
+               dammit.declared_html_encoding,
+               dammit.contains_replacement_characters)
+
+    def feed(self, markup):
+        args, kwargs = self.parser_args
+        parser = BeautifulSoupHTMLParser(*args, **kwargs)
+        parser.soup = self.soup
+        try:
+            parser.feed(markup)
+        except HTMLParseError, e:
+            warnings.warn(RuntimeWarning(
+                "Python's built-in HTMLParser cannot parse the given document. This is not a bug in Beautiful Soup. The best solution is to install an external parser (lxml or html5lib), and use Beautiful Soup with that parser. See http://www.crummy.com/software/BeautifulSoup/bs4/doc/#installing-a-parser for help."))
+            raise e
+
+# Patch 3.2 versions of HTMLParser earlier than 3.2.3 to use some
+# 3.2.3 code. This ensures they don't treat markup like <p></p> as a
+# string.
+#
+# XXX This code can be removed once most Python 3 users are on 3.2.3.
+if major == 3 and minor == 2 and not CONSTRUCTOR_TAKES_STRICT:
+    import re
+    attrfind_tolerant = re.compile(
+        r'\s*((?<=[\'"\s])[^\s/>][^\s/=>]*)(\s*=+\s*'
+        r'(\'[^\']*\'|"[^"]*"|(?![\'"])[^>\s]*))?')
+    HTMLParserTreeBuilder.attrfind_tolerant = attrfind_tolerant
+
+    locatestarttagend = re.compile(r"""
+  <[a-zA-Z][-.a-zA-Z0-9:_]*          # tag name
+  (?:\s+                             # whitespace before attribute name
+    (?:[a-zA-Z_][-.:a-zA-Z0-9_]*     # attribute name
+      (?:\s*=\s*                     # value indicator
+        (?:'[^']*'                   # LITA-enclosed value
+          |\"[^\"]*\"                # LIT-enclosed value
+          |[^'\">\s]+                # bare value
+         )
+       )?
+     )
+   )*
+  \s*                                # trailing whitespace
+""", re.VERBOSE)
+    BeautifulSoupHTMLParser.locatestarttagend = locatestarttagend
+
+    from html.parser import tagfind, attrfind
+
+    def parse_starttag(self, i):
+        self.__starttag_text = None
+        endpos = self.check_for_whole_start_tag(i)
+        if endpos < 0:
+            return endpos
+        rawdata = self.rawdata
+        self.__starttag_text = rawdata[i:endpos]
+
+        # Now parse the data between i+1 and j into a tag and attrs
+        attrs = []
+        match = tagfind.match(rawdata, i+1)
+        assert match, 'unexpected call to parse_starttag()'
+        k = match.end()
+        self.lasttag = tag = rawdata[i+1:k].lower()
+        while k < endpos:
+            if self.strict:
+                m = attrfind.match(rawdata, k)
+            else:
+                m = attrfind_tolerant.match(rawdata, k)
+            if not m:
+                break
+            attrname, rest, attrvalue = m.group(1, 2, 3)
+            if not rest:
+                attrvalue = None
+            elif attrvalue[:1] == '\'' == attrvalue[-1:] or \
+                 attrvalue[:1] == '"' == attrvalue[-1:]:
+                attrvalue = attrvalue[1:-1]
+            if attrvalue:
+                attrvalue = self.unescape(attrvalue)
+            attrs.append((attrname.lower(), attrvalue))
+            k = m.end()
+
+        end = rawdata[k:endpos].strip()
+        if end not in (">", "/>"):
+            lineno, offset = self.getpos()
+            if "\n" in self.__starttag_text:
+                lineno = lineno + self.__starttag_text.count("\n")
+                offset = len(self.__starttag_text) \
+                         - self.__starttag_text.rfind("\n")
+            else:
+                offset = offset + len(self.__starttag_text)
+            if self.strict:
+                self.error("junk characters in start tag: %r"
+                           % (rawdata[k:endpos][:20],))
+            self.handle_data(rawdata[i:endpos])
+            return endpos
+        if end.endswith('/>'):
+            # XHTML-style empty tag: <span attr="value" />
+            self.handle_startendtag(tag, attrs)
+        else:
+            self.handle_starttag(tag, attrs)
+            if tag in self.CDATA_CONTENT_ELEMENTS:
+                self.set_cdata_mode(tag)
+        return endpos
+
+    def set_cdata_mode(self, elem):
+        self.cdata_elem = elem.lower()
+        self.interesting = re.compile(r'</\s*%s\s*>' % self.cdata_elem, re.I)
+
+    BeautifulSoupHTMLParser.parse_starttag = parse_starttag
+    BeautifulSoupHTMLParser.set_cdata_mode = set_cdata_mode
+
+    CONSTRUCTOR_TAKES_STRICT = True
diff --git a/lib/bs4/builder/_lxml.py b/lib/bs4/builder/_lxml.py
new file mode 100644
index 0000000..fa5d498
--- /dev/null
+++ b/lib/bs4/builder/_lxml.py
@@ -0,0 +1,233 @@
+__all__ = [
+    'LXMLTreeBuilderForXML',
+    'LXMLTreeBuilder',
+    ]
+
+from io import BytesIO
+from StringIO import StringIO
+import collections
+from lxml import etree
+from bs4.element import Comment, Doctype, NamespacedAttribute
+from bs4.builder import (
+    FAST,
+    HTML,
+    HTMLTreeBuilder,
+    PERMISSIVE,
+    ParserRejectedMarkup,
+    TreeBuilder,
+    XML)
+from bs4.dammit import EncodingDetector
+
+LXML = 'lxml'
+
+class LXMLTreeBuilderForXML(TreeBuilder):
+    DEFAULT_PARSER_CLASS = etree.XMLParser
+
+    is_xml = True
+
+    # Well, it's permissive by XML parser standards.
+    features = [LXML, XML, FAST, PERMISSIVE]
+
+    CHUNK_SIZE = 512
+
+    # This namespace mapping is specified in the XML Namespace
+    # standard.
+    DEFAULT_NSMAPS = {'http://www.w3.org/XML/1998/namespace' : "xml"}
+
+    def default_parser(self, encoding):
+        # This can either return a parser object or a class, which
+        # will be instantiated with default arguments.
+        if self._default_parser is not None:
+            return self._default_parser
+        return etree.XMLParser(
+            target=self, strip_cdata=False, recover=True, encoding=encoding)
+
+    def parser_for(self, encoding):
+        # Use the default parser.
+        parser = self.default_parser(encoding)
+
+        if isinstance(parser, collections.Callable):
+            # Instantiate the parser with default arguments
+            parser = parser(target=self, strip_cdata=False, encoding=encoding)
+        return parser
+
+    def __init__(self, parser=None, empty_element_tags=None):
+        # TODO: Issue a warning if parser is present but not a
+        # callable, since that means there's no way to create new
+        # parsers for different encodings.
+        self._default_parser = parser
+        if empty_element_tags is not None:
+            self.empty_element_tags = set(empty_element_tags)
+        self.soup = None
+        self.nsmaps = [self.DEFAULT_NSMAPS]
+
+    def _getNsTag(self, tag):
+        # Split the namespace URL out of a fully-qualified lxml tag
+        # name. Copied from lxml's src/lxml/sax.py.
+        if tag[0] == '{':
+            return tuple(tag[1:].split('}', 1))
+        else:
+            return (None, tag)
+
+    def prepare_markup(self, markup, user_specified_encoding=None,
+                       document_declared_encoding=None):
+        """
+        :yield: A series of 4-tuples.
+         (markup, encoding, declared encoding,
+          has undergone character replacement)
+
+        Each 4-tuple represents a strategy for parsing the document.
+        """
+        if isinstance(markup, unicode):
+            # We were given Unicode. Maybe lxml can parse Unicode on
+            # this system?
+            yield markup, None, document_declared_encoding, False
+
+        if isinstance(markup, unicode):
+            # No, apparently not. Convert the Unicode to UTF-8 and
+            # tell lxml to parse it as UTF-8.
+            yield (markup.encode("utf8"), "utf8",
+                   document_declared_encoding, False)
+
+        # Instead of using UnicodeDammit to convert the bytestring to
+        # Unicode using different encodings, use EncodingDetector to
+        # iterate over the encodings, and tell lxml to try to parse
+        # the document as each one in turn.
+        is_html = not self.is_xml
+        try_encodings = [user_specified_encoding, document_declared_encoding]
+        detector = EncodingDetector(markup, try_encodings, is_html)
+        for encoding in detector.encodings:
+            yield (detector.markup, encoding, document_declared_encoding, False)
+
+    def feed(self, markup):
+        if isinstance(markup, bytes):
+            markup = BytesIO(markup)
+        elif isinstance(markup, unicode):
+            markup = StringIO(markup)
+
+        # Call feed() at least once, even if the markup is empty,
+        # or the parser won't be initialized.
+        data = markup.read(self.CHUNK_SIZE)
+        try:
+            self.parser = self.parser_for(self.soup.original_encoding)
+            self.parser.feed(data)
+            while len(data) != 0:
+                # Now call feed() on the rest of the data, chunk by chunk.
+                data = markup.read(self.CHUNK_SIZE)
+                if len(data) != 0:
+                    self.parser.feed(data)
+            self.parser.close()
+        except (UnicodeDecodeError, LookupError, etree.ParserError), e:
+            raise ParserRejectedMarkup(str(e))
+
+    def close(self):
+        self.nsmaps = [self.DEFAULT_NSMAPS]
+
+    def start(self, name, attrs, nsmap={}):
+        # Make sure attrs is a mutable dict--lxml may send an immutable dictproxy.
+        attrs = dict(attrs)
+        nsprefix = None
+        # Invert each namespace map as it comes in.
+        if len(self.nsmaps) > 1:
+            # There are no new namespaces for this tag, but
+            # non-default namespaces are in play, so we need a
+            # separate tag stack to know when they end.
+            self.nsmaps.append(None)
+        elif len(nsmap) > 0:
+            # A new namespace mapping has come into play.
+            inverted_nsmap = dict((value, key) for key, value in nsmap.items())
+            self.nsmaps.append(inverted_nsmap)
+            # Also treat the namespace mapping as a set of attributes on the
+            # tag, so we can recreate it later.
+            attrs = attrs.copy()
+            for prefix, namespace in nsmap.items():
+                attribute = NamespacedAttribute(
+                    "xmlns", prefix, "http://www.w3.org/2000/xmlns/")
+                attrs[attribute] = namespace
+
+        # Namespaces are in play. Find any attributes that came in
+        # from lxml with namespaces attached to their names, and
+        # turn then into NamespacedAttribute objects.
+        new_attrs = {}
+        for attr, value in attrs.items():
+            namespace, attr = self._getNsTag(attr)
+            if namespace is None:
+                new_attrs[attr] = value
+            else:
+                nsprefix = self._prefix_for_namespace(namespace)
+                attr = NamespacedAttribute(nsprefix, attr, namespace)
+                new_attrs[attr] = value
+        attrs = new_attrs
+
+        namespace, name = self._getNsTag(name)
+        nsprefix = self._prefix_for_namespace(namespace)
+        self.soup.handle_starttag(name, namespace, nsprefix, attrs)
+
+    def _prefix_for_namespace(self, namespace):
+        """Find the currently active prefix for the given namespace."""
+        if namespace is None:
+            return None
+        for inverted_nsmap in reversed(self.nsmaps):
+            if inverted_nsmap is not None and namespace in inverted_nsmap:
+                return inverted_nsmap[namespace]
+        return None
+
+    def end(self, name):
+        self.soup.endData()
+        completed_tag = self.soup.tagStack[-1]
+        namespace, name = self._getNsTag(name)
+        nsprefix = None
+        if namespace is not None:
+            for inverted_nsmap in reversed(self.nsmaps):
+                if inverted_nsmap is not None and namespace in inverted_nsmap:
+                    nsprefix = inverted_nsmap[namespace]
+                    break
+        self.soup.handle_endtag(name, nsprefix)
+        if len(self.nsmaps) > 1:
+            # This tag, or one of its parents, introduced a namespace
+            # mapping, so pop it off the stack.
+            self.nsmaps.pop()
+
+    def pi(self, target, data):
+        pass
+
+    def data(self, content):
+        self.soup.handle_data(content)
+
+    def doctype(self, name, pubid, system):
+        self.soup.endData()
+        doctype = Doctype.for_name_and_ids(name, pubid, system)
+        self.soup.object_was_parsed(doctype)
+
+    def comment(self, content):
+        "Handle comments as Comment objects."
+        self.soup.endData()
+        self.soup.handle_data(content)
+        self.soup.endData(Comment)
+
+    def test_fragment_to_document(self, fragment):
+        """See `TreeBuilder`."""
+        return u'<?xml version="1.0" encoding="utf-8"?>\n%s' % fragment
+
+
+class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
+
+    features = [LXML, HTML, FAST, PERMISSIVE]
+    is_xml = False
+
+    def default_parser(self, encoding):
+        return etree.HTMLParser
+
+    def feed(self, markup):
+        encoding = self.soup.original_encoding
+        try:
+            self.parser = self.parser_for(encoding)
+            self.parser.feed(markup)
+            self.parser.close()
+        except (UnicodeDecodeError, LookupError, etree.ParserError), e:
+            raise ParserRejectedMarkup(str(e))
+
+
+    def test_fragment_to_document(self, fragment):
+        """See `TreeBuilder`."""
+        return u'<html><body>%s</body></html>' % fragment
diff --git a/lib/bs4/dammit.py b/lib/bs4/dammit.py
new file mode 100644
index 0000000..59640b7
--- /dev/null
+++ b/lib/bs4/dammit.py
@@ -0,0 +1,829 @@
+# -*- coding: utf-8 -*-
+"""Beautiful Soup bonus library: Unicode, Dammit
+
+This library converts a bytestream to Unicode through any means
+necessary. It is heavily based on code from Mark Pilgrim's Universal
+Feed Parser. It works best on XML and XML, but it does not rewrite the
+XML or HTML to reflect a new encoding; that's the tree builder's job.
+"""
+
+import codecs
+from htmlentitydefs import codepoint2name
+import re
+import logging
+import string
+
+# Import a library to autodetect character encodings.
+chardet_type = None
+try:
+    # First try the fast C implementation.
+    #  PyPI package: cchardet
+    import cchardet
+    def chardet_dammit(s):
+        return cchardet.detect(s)['encoding']
+except ImportError:
+    try:
+        # Fall back to the pure Python implementation
+        #  Debian package: python-chardet
+        #  PyPI package: chardet
+        import chardet
+        def chardet_dammit(s):
+            return chardet.detect(s)['encoding']
+        #import chardet.constants
+        #chardet.constants._debug = 1
+    except ImportError:
+        # No chardet available.
+        def chardet_dammit(s):
+            return None
+
+# Available from http://cjkpython.i18n.org/.
+try:
+    import iconv_codec
+except ImportError:
+    pass
+
+xml_encoding_re = re.compile(
+    '^<\?.*encoding=[\'"](.*?)[\'"].*\?>'.encode(), re.I)
+html_meta_re = re.compile(
+    '<\s*meta[^>]+charset\s*=\s*["\']?([^>]*?)[ /;\'">]'.encode(), re.I)
+
+class EntitySubstitution(object):
+
+    """Substitute XML or HTML entities for the corresponding characters."""
+
+    def _populate_class_variables():
+        lookup = {}
+        reverse_lookup = {}
+        characters_for_re = []
+        for codepoint, name in list(codepoint2name.items()):
+            character = unichr(codepoint)
+            if codepoint != 34:
+                # There's no point in turning the quotation mark into
+                # &quot;, unless it happens within an attribute value, which
+                # is handled elsewhere.
+                characters_for_re.append(character)
+                lookup[character] = name
+            # But we do want to turn &quot; into the quotation mark.
+            reverse_lookup[name] = character
+        re_definition = "[%s]" % "".join(characters_for_re)
+        return lookup, reverse_lookup, re.compile(re_definition)
+    (CHARACTER_TO_HTML_ENTITY, HTML_ENTITY_TO_CHARACTER,
+     CHARACTER_TO_HTML_ENTITY_RE) = _populate_class_variables()
+
+    CHARACTER_TO_XML_ENTITY = {
+        "'": "apos",
+        '"': "quot",
+        "&": "amp",
+        "<": "lt",
+        ">": "gt",
+        }
+
+    BARE_AMPERSAND_OR_BRACKET = re.compile("([<>]|"
+                                           "&(?!#\d+;|#x[0-9a-fA-F]+;|\w+;)"
+                                           ")")
+
+    AMPERSAND_OR_BRACKET = re.compile("([<>&])")
+
+    @classmethod
+    def _substitute_html_entity(cls, matchobj):
+        entity = cls.CHARACTER_TO_HTML_ENTITY.get(matchobj.group(0))
+        return "&%s;" % entity
+
+    @classmethod
+    def _substitute_xml_entity(cls, matchobj):
+        """Used with a regular expression to substitute the
+        appropriate XML entity for an XML special character."""
+        entity = cls.CHARACTER_TO_XML_ENTITY[matchobj.group(0)]
+        return "&%s;" % entity
+
+    @classmethod
+    def quoted_attribute_value(self, value):
+        """Make a value into a quoted XML attribute, possibly escaping it.
+
+         Most strings will be quoted using double quotes.
+
+          Bob's Bar -> "Bob's Bar"
+
+         If a string contains double quotes, it will be quoted using
+         single quotes.
+
+          Welcome to "my bar" -> 'Welcome to "my bar"'
+
+         If a string contains both single and double quotes, the
+         double quotes will be escaped, and the string will be quoted
+         using double quotes.
+
+          Welcome to "Bob's Bar" -> "Welcome to &quot;Bob's bar&quot;
+        """
+        quote_with = '"'
+        if '"' in value:
+            if "'" in value:
+                # The string contains both single and double
+                # quotes.  Turn the double quotes into
+                # entities. We quote the double quotes rather than
+                # the single quotes because the entity name is
+                # "&quot;" whether this is HTML or XML.  If we
+                # quoted the single quotes, we'd have to decide
+                # between &apos; and &squot;.
+                replace_with = "&quot;"
+                value = value.replace('"', replace_with)
+            else:
+                # There are double quotes but no single quotes.
+                # We can use single quotes to quote the attribute.
+                quote_with = "'"
+        return quote_with + value + quote_with
+
+    @classmethod
+    def substitute_xml(cls, value, make_quoted_attribute=False):
+        """Substitute XML entities for special XML characters.
+
+        :param value: A string to be substituted. The less-than sign
+          will become &lt;, the greater-than sign will become &gt;,
+          and any ampersands will become &amp;. If you want ampersands
+          that appear to be part of an entity definition to be left
+          alone, use substitute_xml_containing_entities() instead.
+
+        :param make_quoted_attribute: If True, then the string will be
+         quoted, as befits an attribute value.
+        """
+        # Escape angle brackets and ampersands.
+        value = cls.AMPERSAND_OR_BRACKET.sub(
+            cls._substitute_xml_entity, value)
+
+        if make_quoted_attribute:
+            value = cls.quoted_attribute_value(value)
+        return value
+
+    @classmethod
+    def substitute_xml_containing_entities(
+        cls, value, make_quoted_attribute=False):
+        """Substitute XML entities for special XML characters.
+
+        :param value: A string to be substituted. The less-than sign will
+          become &lt;, the greater-than sign will become &gt;, and any
+          ampersands that are not part of an entity defition will
+          become &amp;.
+
+        :param make_quoted_attribute: If True, then the string will be
+         quoted, as befits an attribute value.
+        """
+        # Escape angle brackets, and ampersands that aren't part of
+        # entities.
+        value = cls.BARE_AMPERSAND_OR_BRACKET.sub(
+            cls._substitute_xml_entity, value)
+
+        if make_quoted_attribute:
+            value = cls.quoted_attribute_value(value)
+        return value
+
+    @classmethod
+    def substitute_html(cls, s):
+        """Replace certain Unicode characters with named HTML entities.
+
+        This differs from data.encode(encoding, 'xmlcharrefreplace')
+        in that the goal is to make the result more readable (to those
+        with ASCII displays) rather than to recover from
+        errors. There's absolutely nothing wrong with a UTF-8 string
+        containg a LATIN SMALL LETTER E WITH ACUTE, but replacing that
+        character with "&eacute;" will make it more readable to some
+        people.
+        """
+        return cls.CHARACTER_TO_HTML_ENTITY_RE.sub(
+            cls._substitute_html_entity, s)
+
+
+class EncodingDetector:
+    """Suggests a number of possible encodings for a bytestring.
+
+    Order of precedence:
+
+    1. Encodings you specifically tell EncodingDetector to try first
+    (the override_encodings argument to the constructor).
+
+    2. An encoding declared within the bytestring itself, either in an
+    XML declaration (if the bytestring is to be interpreted as an XML
+    document), or in a <meta> tag (if the bytestring is to be
+    interpreted as an HTML document.)
+
+    3. An encoding detected through textual analysis by chardet,
+    cchardet, or a similar external library.
+
+    4. UTF-8.
+
+    5. Windows-1252.
+    """
+    def __init__(self, markup, override_encodings=None, is_html=False):
+        self.override_encodings = override_encodings or []
+        self.chardet_encoding = None
+        self.is_html = is_html
+        self.declared_encoding = None
+
+        # First order of business: strip a byte-order mark.
+        self.markup, self.sniffed_encoding = self.strip_byte_order_mark(markup)
+
+    def _usable(self, encoding, tried):
+        if encoding is not None:
+            encoding = encoding.lower()
+            if encoding not in tried:
+                tried.add(encoding)
+                return True
+        return False
+
+    @property
+    def encodings(self):
+        """Yield a number of encodings that might work for this markup."""
+        tried = set()
+        for e in self.override_encodings:
+            if self._usable(e, tried):
+                yield e
+
+        # Did the document originally start with a byte-order mark
+        # that indicated its encoding?
+        if self._usable(self.sniffed_encoding, tried):
+            yield self.sniffed_encoding
+
+        # Look within the document for an XML or HTML encoding
+        # declaration.
+        if self.declared_encoding is None:
+            self.declared_encoding = self.find_declared_encoding(
+                self.markup, self.is_html)
+        if self._usable(self.declared_encoding, tried):
+            yield self.declared_encoding
+
+        # Use third-party character set detection to guess at the
+        # encoding.
+        if self.chardet_encoding is None:
+            self.chardet_encoding = chardet_dammit(self.markup)
+        if self._usable(self.chardet_encoding, tried):
+            yield self.chardet_encoding
+
+        # As a last-ditch effort, try utf-8 and windows-1252.
+        for e in ('utf-8', 'windows-1252'):
+            if self._usable(e, tried):
+                yield e
+
+    @classmethod
+    def strip_byte_order_mark(cls, data):
+        """If a byte-order mark is present, strip it and return the encoding it implies."""
+        encoding = None
+        if (len(data) >= 4) and (data[:2] == b'\xfe\xff') \
+               and (data[2:4] != '\x00\x00'):
+            encoding = 'utf-16be'
+            data = data[2:]
+        elif (len(data) >= 4) and (data[:2] == b'\xff\xfe') \
+                 and (data[2:4] != '\x00\x00'):
+            encoding = 'utf-16le'
+            data = data[2:]
+        elif data[:3] == b'\xef\xbb\xbf':
+            encoding = 'utf-8'
+            data = data[3:]
+        elif data[:4] == b'\x00\x00\xfe\xff':
+            encoding = 'utf-32be'
+            data = data[4:]
+        elif data[:4] == b'\xff\xfe\x00\x00':
+            encoding = 'utf-32le'
+            data = data[4:]
+        return data, encoding
+
+    @classmethod
+    def find_declared_encoding(cls, markup, is_html=False, search_entire_document=False):
+        """Given a document, tries to find its declared encoding.
+
+        An XML encoding is declared at the beginning of the document.
+
+        An HTML encoding is declared in a <meta> tag, hopefully near the
+        beginning of the document.
+        """
+        if search_entire_document:
+            xml_endpos = html_endpos = len(markup)
+        else:
+            xml_endpos = 1024
+            html_endpos = max(2048, int(len(markup) * 0.05))
+            
+        declared_encoding = None
+        declared_encoding_match = xml_encoding_re.search(markup, endpos=xml_endpos)
+        if not declared_encoding_match and is_html:
+            declared_encoding_match = html_meta_re.search(markup, endpos=html_endpos)
+        if declared_encoding_match is not None:
+            declared_encoding = declared_encoding_match.groups()[0].decode(
+                'ascii')
+        if declared_encoding:
+            return declared_encoding.lower()
+        return None
+
+class UnicodeDammit:
+    """A class for detecting the encoding of a *ML document and
+    converting it to a Unicode string. If the source encoding is
+    windows-1252, can replace MS smart quotes with their HTML or XML
+    equivalents."""
+
+    # This dictionary maps commonly seen values for "charset" in HTML
+    # meta tags to the corresponding Python codec names. It only covers
+    # values that aren't in Python's aliases and can't be determined
+    # by the heuristics in find_codec.
+    CHARSET_ALIASES = {"macintosh": "mac-roman",
+                       "x-sjis": "shift-jis"}
+
+    ENCODINGS_WITH_SMART_QUOTES = [
+        "windows-1252",
+        "iso-8859-1",
+        "iso-8859-2",
+        ]
+
+    def __init__(self, markup, override_encodings=[],
+                 smart_quotes_to=None, is_html=False):
+        self.smart_quotes_to = smart_quotes_to
+        self.tried_encodings = []
+        self.contains_replacement_characters = False
+        self.is_html = is_html
+
+        self.detector = EncodingDetector(markup, override_encodings, is_html)
+
+        # Short-circuit if the data is in Unicode to begin with.
+        if isinstance(markup, unicode) or markup == '':
+            self.markup = markup
+            self.unicode_markup = unicode(markup)
+            self.original_encoding = None
+            return
+
+        # The encoding detector may have stripped a byte-order mark.
+        # Use the stripped markup from this point on.
+        self.markup = self.detector.markup
+
+        u = None
+        for encoding in self.detector.encodings:
+            markup = self.detector.markup
+            u = self._convert_from(encoding)
+            if u is not None:
+                break
+
+        if not u:
+            # None of the encodings worked. As an absolute last resort,
+            # try them again with character replacement.
+
+            for encoding in self.detector.encodings:
+                if encoding != "ascii":
+                    u = self._convert_from(encoding, "replace")
+                if u is not None:
+                    logging.warning(
+                            "Some characters could not be decoded, and were "
+                            "replaced with REPLACEMENT CHARACTER.")
+                    self.contains_replacement_characters = True
+                    break
+
+        # If none of that worked, we could at this point force it to
+        # ASCII, but that would destroy so much data that I think
+        # giving up is better.
+        self.unicode_markup = u
+        if not u:
+            self.original_encoding = None
+
+    def _sub_ms_char(self, match):
+        """Changes a MS smart quote character to an XML or HTML
+        entity, or an ASCII character."""
+        orig = match.group(1)
+        if self.smart_quotes_to == 'ascii':
+            sub = self.MS_CHARS_TO_ASCII.get(orig).encode()
+        else:
+            sub = self.MS_CHARS.get(orig)
+            if type(sub) == tuple:
+                if self.smart_quotes_to == 'xml':
+                    sub = '&#x'.encode() + sub[1].encode() + ';'.encode()
+                else:
+                    sub = '&'.encode() + sub[0].encode() + ';'.encode()
+            else:
+                sub = sub.encode()
+        return sub
+
+    def _convert_from(self, proposed, errors="strict"):
+        proposed = self.find_codec(proposed)
+        if not proposed or (proposed, errors) in self.tried_encodings:
+            return None
+        self.tried_encodings.append((proposed, errors))
+        markup = self.markup
+        # Convert smart quotes to HTML if coming from an encoding
+        # that might have them.
+        if (self.smart_quotes_to is not None
+            and proposed in self.ENCODINGS_WITH_SMART_QUOTES):
+            smart_quotes_re = b"([\x80-\x9f])"
+            smart_quotes_compiled = re.compile(smart_quotes_re)
+            markup = smart_quotes_compiled.sub(self._sub_ms_char, markup)
+
+        try:
+            #print "Trying to convert document to %s (errors=%s)" % (
+            #    proposed, errors)
+            u = self._to_unicode(markup, proposed, errors)
+            self.markup = u
+            self.original_encoding = proposed
+        except Exception as e:
+            #print "That didn't work!"
+            #print e
+            return None
+        #print "Correct encoding: %s" % proposed
+        return self.markup
+
+    def _to_unicode(self, data, encoding, errors="strict"):
+        '''Given a string and its encoding, decodes the string into Unicode.
+        %encoding is a string recognized by encodings.aliases'''
+        return unicode(data, encoding, errors)
+
+    @property
+    def declared_html_encoding(self):
+        if not self.is_html:
+            return None
+        return self.detector.declared_encoding
+
+    def find_codec(self, charset):
+        value = (self._codec(self.CHARSET_ALIASES.get(charset, charset))
+               or (charset and self._codec(charset.replace("-", "")))
+               or (charset and self._codec(charset.replace("-", "_")))
+               or (charset and charset.lower())
+               or charset
+                )
+        if value:
+            return value.lower()
+        return None
+
+    def _codec(self, charset):
+        if not charset:
+            return charset
+        codec = None
+        try:
+            codecs.lookup(charset)
+            codec = charset
+        except (LookupError, ValueError):
+            pass
+        return codec
+
+
+    # A partial mapping of ISO-Latin-1 to HTML entities/XML numeric entities.
+    MS_CHARS = {b'\x80': ('euro', '20AC'),
+                b'\x81': ' ',
+                b'\x82': ('sbquo', '201A'),
+                b'\x83': ('fnof', '192'),
+                b'\x84': ('bdquo', '201E'),
+                b'\x85': ('hellip', '2026'),
+                b'\x86': ('dagger', '2020'),
+                b'\x87': ('Dagger', '2021'),
+                b'\x88': ('circ', '2C6'),
+                b'\x89': ('permil', '2030'),
+                b'\x8A': ('Scaron', '160'),
+                b'\x8B': ('lsaquo', '2039'),
+                b'\x8C': ('OElig', '152'),
+                b'\x8D': '?',
+                b'\x8E': ('#x17D', '17D'),
+                b'\x8F': '?',
+                b'\x90': '?',
+                b'\x91': ('lsquo', '2018'),
+                b'\x92': ('rsquo', '2019'),
+                b'\x93': ('ldquo', '201C'),
+                b'\x94': ('rdquo', '201D'),
+                b'\x95': ('bull', '2022'),
+                b'\x96': ('ndash', '2013'),
+                b'\x97': ('mdash', '2014'),
+                b'\x98': ('tilde', '2DC'),
+                b'\x99': ('trade', '2122'),
+                b'\x9a': ('scaron', '161'),
+                b'\x9b': ('rsaquo', '203A'),
+                b'\x9c': ('oelig', '153'),
+                b'\x9d': '?',
+                b'\x9e': ('#x17E', '17E'),
+                b'\x9f': ('Yuml', ''),}
+
+    # A parochial partial mapping of ISO-Latin-1 to ASCII. Contains
+    # horrors like stripping diacritical marks to turn á into a, but also
+    # contains non-horrors like turning “ into ".
+    MS_CHARS_TO_ASCII = {
+        b'\x80' : 'EUR',
+        b'\x81' : ' ',
+        b'\x82' : ',',
+        b'\x83' : 'f',
+        b'\x84' : ',,',
+        b'\x85' : '...',
+        b'\x86' : '+',
+        b'\x87' : '++',
+        b'\x88' : '^',
+        b'\x89' : '%',
+        b'\x8a' : 'S',
+        b'\x8b' : '<',
+        b'\x8c' : 'OE',
+        b'\x8d' : '?',
+        b'\x8e' : 'Z',
+        b'\x8f' : '?',
+        b'\x90' : '?',
+        b'\x91' : "'",
+        b'\x92' : "'",
+        b'\x93' : '"',
+        b'\x94' : '"',
+        b'\x95' : '*',
+        b'\x96' : '-',
+        b'\x97' : '--',
+        b'\x98' : '~',
+        b'\x99' : '(TM)',
+        b'\x9a' : 's',
+        b'\x9b' : '>',
+        b'\x9c' : 'oe',
+        b'\x9d' : '?',
+        b'\x9e' : 'z',
+        b'\x9f' : 'Y',
+        b'\xa0' : ' ',
+        b'\xa1' : '!',
+        b'\xa2' : 'c',
+        b'\xa3' : 'GBP',
+        b'\xa4' : '$', #This approximation is especially parochial--this is the
+                       #generic currency symbol.
+        b'\xa5' : 'YEN',
+        b'\xa6' : '|',
+        b'\xa7' : 'S',
+        b'\xa8' : '..',
+        b'\xa9' : '',
+        b'\xaa' : '(th)',
+        b'\xab' : '<<',
+        b'\xac' : '!',
+        b'\xad' : ' ',
+        b'\xae' : '(R)',
+        b'\xaf' : '-',
+        b'\xb0' : 'o',
+        b'\xb1' : '+-',
+        b'\xb2' : '2',
+        b'\xb3' : '3',
+        b'\xb4' : ("'", 'acute'),
+        b'\xb5' : 'u',
+        b'\xb6' : 'P',
+        b'\xb7' : '*',
+        b'\xb8' : ',',
+        b'\xb9' : '1',
+        b'\xba' : '(th)',
+        b'\xbb' : '>>',
+        b'\xbc' : '1/4',
+        b'\xbd' : '1/2',
+        b'\xbe' : '3/4',
+        b'\xbf' : '?',
+        b'\xc0' : 'A',
+        b'\xc1' : 'A',
+        b'\xc2' : 'A',
+        b'\xc3' : 'A',
+        b'\xc4' : 'A',
+        b'\xc5' : 'A',
+        b'\xc6' : 'AE',
+        b'\xc7' : 'C',
+        b'\xc8' : 'E',
+        b'\xc9' : 'E',
+        b'\xca' : 'E',
+        b'\xcb' : 'E',
+        b'\xcc' : 'I',
+        b'\xcd' : 'I',
+        b'\xce' : 'I',
+        b'\xcf' : 'I',
+        b'\xd0' : 'D',
+        b'\xd1' : 'N',
+        b'\xd2' : 'O',
+        b'\xd3' : 'O',
+        b'\xd4' : 'O',
+        b'\xd5' : 'O',
+        b'\xd6' : 'O',
+        b'\xd7' : '*',
+        b'\xd8' : 'O',
+        b'\xd9' : 'U',
+        b'\xda' : 'U',
+        b'\xdb' : 'U',
+        b'\xdc' : 'U',
+        b'\xdd' : 'Y',
+        b'\xde' : 'b',
+        b'\xdf' : 'B',
+        b'\xe0' : 'a',
+        b'\xe1' : 'a',
+        b'\xe2' : 'a',
+        b'\xe3' : 'a',
+        b'\xe4' : 'a',
+        b'\xe5' : 'a',
+        b'\xe6' : 'ae',
+        b'\xe7' : 'c',
+        b'\xe8' : 'e',
+        b'\xe9' : 'e',
+        b'\xea' : 'e',
+        b'\xeb' : 'e',
+        b'\xec' : 'i',
+        b'\xed' : 'i',
+        b'\xee' : 'i',
+        b'\xef' : 'i',
+        b'\xf0' : 'o',
+        b'\xf1' : 'n',
+        b'\xf2' : 'o',
+        b'\xf3' : 'o',
+        b'\xf4' : 'o',
+        b'\xf5' : 'o',
+        b'\xf6' : 'o',
+        b'\xf7' : '/',
+        b'\xf8' : 'o',
+        b'\xf9' : 'u',
+        b'\xfa' : 'u',
+        b'\xfb' : 'u',
+        b'\xfc' : 'u',
+        b'\xfd' : 'y',
+        b'\xfe' : 'b',
+        b'\xff' : 'y',
+        }
+
+    # A map used when removing rogue Windows-1252/ISO-8859-1
+    # characters in otherwise UTF-8 documents.
+    #
+    # Note that \x81, \x8d, \x8f, \x90, and \x9d are undefined in
+    # Windows-1252.
+    WINDOWS_1252_TO_UTF8 = {
+        0x80 : b'\xe2\x82\xac', # €
+        0x82 : b'\xe2\x80\x9a', # ‚
+        0x83 : b'\xc6\x92',     # ƒ
+        0x84 : b'\xe2\x80\x9e', # „
+        0x85 : b'\xe2\x80\xa6', # …
+        0x86 : b'\xe2\x80\xa0', # †
+        0x87 : b'\xe2\x80\xa1', # ‡
+        0x88 : b'\xcb\x86',     # ˆ
+        0x89 : b'\xe2\x80\xb0', # ‰
+        0x8a : b'\xc5\xa0',     # Š
+        0x8b : b'\xe2\x80\xb9', # ‹
+        0x8c : b'\xc5\x92',     # Œ
+        0x8e : b'\xc5\xbd',     # Ž
+        0x91 : b'\xe2\x80\x98', # ‘
+        0x92 : b'\xe2\x80\x99', # ’
+        0x93 : b'\xe2\x80\x9c', # “
+        0x94 : b'\xe2\x80\x9d', # ”
+        0x95 : b'\xe2\x80\xa2', # •
+        0x96 : b'\xe2\x80\x93', # –
+        0x97 : b'\xe2\x80\x94', # —
+        0x98 : b'\xcb\x9c',     # ˜
+        0x99 : b'\xe2\x84\xa2', # ™
+        0x9a : b'\xc5\xa1',     # š
+        0x9b : b'\xe2\x80\xba', # ›
+        0x9c : b'\xc5\x93',     # œ
+        0x9e : b'\xc5\xbe',     # ž
+        0x9f : b'\xc5\xb8',     # Ÿ
+        0xa0 : b'\xc2\xa0',     #  
+        0xa1 : b'\xc2\xa1',     # ¡
+        0xa2 : b'\xc2\xa2',     # ¢
+        0xa3 : b'\xc2\xa3',     # £
+        0xa4 : b'\xc2\xa4',     # ¤
+        0xa5 : b'\xc2\xa5',     # ¥
+        0xa6 : b'\xc2\xa6',     # ¦
+        0xa7 : b'\xc2\xa7',     # §
+        0xa8 : b'\xc2\xa8',     # ¨
+        0xa9 : b'\xc2\xa9',     # ©
+        0xaa : b'\xc2\xaa',     # ª
+        0xab : b'\xc2\xab',     # «
+        0xac : b'\xc2\xac',     # ¬
+        0xad : b'\xc2\xad',     # ­
+        0xae : b'\xc2\xae',     # ®
+        0xaf : b'\xc2\xaf',     # ¯
+        0xb0 : b'\xc2\xb0',     # °
+        0xb1 : b'\xc2\xb1',     # ±
+        0xb2 : b'\xc2\xb2',     # ²
+        0xb3 : b'\xc2\xb3',     # ³
+        0xb4 : b'\xc2\xb4',     # ´
+        0xb5 : b'\xc2\xb5',     # µ
+        0xb6 : b'\xc2\xb6',     # ¶
+        0xb7 : b'\xc2\xb7',     # ·
+        0xb8 : b'\xc2\xb8',     # ¸
+        0xb9 : b'\xc2\xb9',     # ¹
+        0xba : b'\xc2\xba',     # º
+        0xbb : b'\xc2\xbb',     # »
+        0xbc : b'\xc2\xbc',     # ¼
+        0xbd : b'\xc2\xbd',     # ½
+        0xbe : b'\xc2\xbe',     # ¾
+        0xbf : b'\xc2\xbf',     # ¿
+        0xc0 : b'\xc3\x80',     # À
+        0xc1 : b'\xc3\x81',     # Á
+        0xc2 : b'\xc3\x82',     # Â
+        0xc3 : b'\xc3\x83',     # Ã
+        0xc4 : b'\xc3\x84',     # Ä
+        0xc5 : b'\xc3\x85',     # Å
+        0xc6 : b'\xc3\x86',     # Æ
+        0xc7 : b'\xc3\x87',     # Ç
+        0xc8 : b'\xc3\x88',     # È
+        0xc9 : b'\xc3\x89',     # É
+        0xca : b'\xc3\x8a',     # Ê
+        0xcb : b'\xc3\x8b',     # Ë
+        0xcc : b'\xc3\x8c',     # Ì
+        0xcd : b'\xc3\x8d',     # Í
+        0xce : b'\xc3\x8e',     # Î
+        0xcf : b'\xc3\x8f',     # Ï
+        0xd0 : b'\xc3\x90',     # Ð
+        0xd1 : b'\xc3\x91',     # Ñ
+        0xd2 : b'\xc3\x92',     # Ò
+        0xd3 : b'\xc3\x93',     # Ó
+        0xd4 : b'\xc3\x94',     # Ô
+        0xd5 : b'\xc3\x95',     # Õ
+        0xd6 : b'\xc3\x96',     # Ö
+        0xd7 : b'\xc3\x97',     # ×
+        0xd8 : b'\xc3\x98',     # Ø
+        0xd9 : b'\xc3\x99',     # Ù
+        0xda : b'\xc3\x9a',     # Ú
+        0xdb : b'\xc3\x9b',     # Û
+        0xdc : b'\xc3\x9c',     # Ü
+        0xdd : b'\xc3\x9d',     # Ý
+        0xde : b'\xc3\x9e',     # Þ
+        0xdf : b'\xc3\x9f',     # ß
+        0xe0 : b'\xc3\xa0',     # à
+        0xe1 : b'\xa1',     # á
+        0xe2 : b'\xc3\xa2',     # â
+        0xe3 : b'\xc3\xa3',     # ã
+        0xe4 : b'\xc3\xa4',     # ä
+        0xe5 : b'\xc3\xa5',     # å
+        0xe6 : b'\xc3\xa6',     # æ
+        0xe7 : b'\xc3\xa7',     # ç
+        0xe8 : b'\xc3\xa8',     # è
+        0xe9 : b'\xc3\xa9',     # é
+        0xea : b'\xc3\xaa',     # ê
+        0xeb : b'\xc3\xab',     # ë
+        0xec : b'\xc3\xac',     # ì
+        0xed : b'\xc3\xad',     # í
+        0xee : b'\xc3\xae',     # î
+        0xef : b'\xc3\xaf',     # ï
+        0xf0 : b'\xc3\xb0',     # ð
+        0xf1 : b'\xc3\xb1',     # ñ
+        0xf2 : b'\xc3\xb2',     # ò
+        0xf3 : b'\xc3\xb3',     # ó
+        0xf4 : b'\xc3\xb4',     # ô
+        0xf5 : b'\xc3\xb5',     # õ
+        0xf6 : b'\xc3\xb6',     # ö
+        0xf7 : b'\xc3\xb7',     # ÷
+        0xf8 : b'\xc3\xb8',     # ø
+        0xf9 : b'\xc3\xb9',     # ù
+        0xfa : b'\xc3\xba',     # ú
+        0xfb : b'\xc3\xbb',     # û
+        0xfc : b'\xc3\xbc',     # ü
+        0xfd : b'\xc3\xbd',     # ý
+        0xfe : b'\xc3\xbe',     # þ
+        }
+
+    MULTIBYTE_MARKERS_AND_SIZES = [
+        (0xc2, 0xdf, 2), # 2-byte characters start with a byte C2-DF
+        (0xe0, 0xef, 3), # 3-byte characters start with E0-EF
+        (0xf0, 0xf4, 4), # 4-byte characters start with F0-F4
+        ]
+
+    FIRST_MULTIBYTE_MARKER = MULTIBYTE_MARKERS_AND_SIZES[0][0]
+    LAST_MULTIBYTE_MARKER = MULTIBYTE_MARKERS_AND_SIZES[-1][1]
+
+    @classmethod
+    def detwingle(cls, in_bytes, main_encoding="utf8",
+                  embedded_encoding="windows-1252"):
+        """Fix characters from one encoding embedded in some other encoding.
+
+        Currently the only situation supported is Windows-1252 (or its
+        subset ISO-8859-1), embedded in UTF-8.
+
+        The input must be a bytestring. If you've already converted
+        the document to Unicode, you're too late.
+
+        The output is a bytestring in which `embedded_encoding`
+        characters have been converted to their `main_encoding`
+        equivalents.
+        """
+        if embedded_encoding.replace('_', '-').lower() not in (
+            'windows-1252', 'windows_1252'):
+            raise NotImplementedError(
+                "Windows-1252 and ISO-8859-1 are the only currently supported "
+                "embedded encodings.")
+
+        if main_encoding.lower() not in ('utf8', 'utf-8'):
+            raise NotImplementedError(
+                "UTF-8 is the only currently supported main encoding.")
+
+        byte_chunks = []
+
+        chunk_start = 0
+        pos = 0
+        while pos < len(in_bytes):
+            byte = in_bytes[pos]
+            if not isinstance(byte, int):
+                # Python 2.x
+                byte = ord(byte)
+            if (byte >= cls.FIRST_MULTIBYTE_MARKER
+                and byte <= cls.LAST_MULTIBYTE_MARKER):
+                # This is the start of a UTF-8 multibyte character. Skip
+                # to the end.
+                for start, end, size in cls.MULTIBYTE_MARKERS_AND_SIZES:
+                    if byte >= start and byte <= end:
+                        pos += size
+                        break
+            elif byte >= 0x80 and byte in cls.WINDOWS_1252_TO_UTF8:
+                # We found a Windows-1252 character!
+                # Save the string up to this point as a chunk.
+                byte_chunks.append(in_bytes[chunk_start:pos])
+
+                # Now translate the Windows-1252 character into UTF-8
+                # and add it as another, one-byte chunk.
+                byte_chunks.append(cls.WINDOWS_1252_TO_UTF8[byte])
+                pos += 1
+                chunk_start = pos
+            else:
+                # Go on to the next character.
+                pos += 1
+        if chunk_start == 0:
+            # The string is unchanged.
+            return in_bytes
+        else:
+            # Store the final chunk.
+            byte_chunks.append(in_bytes[chunk_start:])
+        return b''.join(byte_chunks)
+
diff --git a/lib/bs4/diagnose.py b/lib/bs4/diagnose.py
new file mode 100644
index 0000000..4d0b00a
--- /dev/null
+++ b/lib/bs4/diagnose.py
@@ -0,0 +1,204 @@
+"""Diagnostic functions, mainly for use when doing tech support."""
+import cProfile
+from StringIO import StringIO
+from HTMLParser import HTMLParser
+import bs4
+from bs4 import BeautifulSoup, __version__
+from bs4.builder import builder_registry
+
+import os
+import pstats
+import random
+import tempfile
+import time
+import traceback
+import sys
+import cProfile
+
+def diagnose(data):
+    """Diagnostic suite for isolating common problems."""
+    print "Diagnostic running on Beautiful Soup %s" % __version__
+    print "Python version %s" % sys.version
+
+    basic_parsers = ["html.parser", "html5lib", "lxml"]
+    for name in basic_parsers:
+        for builder in builder_registry.builders:
+            if name in builder.features:
+                break
+        else:
+            basic_parsers.remove(name)
+            print (
+                "I noticed that %s is not installed. Installing it may help." %
+                name)
+
+    if 'lxml' in basic_parsers:
+        basic_parsers.append(["lxml", "xml"])
+        from lxml import etree
+        print "Found lxml version %s" % ".".join(map(str,etree.LXML_VERSION))
+
+    if 'html5lib' in basic_parsers:
+        import html5lib
+        print "Found html5lib version %s" % html5lib.__version__
+
+    if hasattr(data, 'read'):
+        data = data.read()
+    elif os.path.exists(data):
+        print '"%s" looks like a filename. Reading data from the file.' % data
+        data = open(data).read()
+    elif data.startswith("http:") or data.startswith("https:"):
+        print '"%s" looks like a URL. Beautiful Soup is not an HTTP client.' % data
+        print "You need to use some other library to get the document behind the URL, and feed that document to Beautiful Soup."
+        return
+    print
+
+    for parser in basic_parsers:
+        print "Trying to parse your markup with %s" % parser
+        success = False
+        try:
+            soup = BeautifulSoup(data, parser)
+            success = True
+        except Exception, e:
+            print "%s could not parse the markup." % parser
+            traceback.print_exc()
+        if success:
+            print "Here's what %s did with the markup:" % parser
+            print soup.prettify()
+
+        print "-" * 80
+
+def lxml_trace(data, html=True, **kwargs):
+    """Print out the lxml events that occur during parsing.
+
+    This lets you see how lxml parses a document when no Beautiful
+    Soup code is running.
+    """
+    from lxml import etree
+    for event, element in etree.iterparse(StringIO(data), html=html, **kwargs):
+        print("%s, %4s, %s" % (event, element.tag, element.text))
+
+class AnnouncingParser(HTMLParser):
+    """Announces HTMLParser parse events, without doing anything else."""
+
+    def _p(self, s):
+        print(s)
+
+    def handle_starttag(self, name, attrs):
+        self._p("%s START" % name)
+
+    def handle_endtag(self, name):
+        self._p("%s END" % name)
+
+    def handle_data(self, data):
+        self._p("%s DATA" % data)
+
+    def handle_charref(self, name):
+        self._p("%s CHARREF" % name)
+
+    def handle_entityref(self, name):
+        self._p("%s ENTITYREF" % name)
+
+    def handle_comment(self, data):
+        self._p("%s COMMENT" % data)
+
+    def handle_decl(self, data):
+        self._p("%s DECL" % data)
+
+    def unknown_decl(self, data):
+        self._p("%s UNKNOWN-DECL" % data)
+
+    def handle_pi(self, data):
+        self._p("%s PI" % data)
+
+def htmlparser_trace(data):
+    """Print out the HTMLParser events that occur during parsing.
+
+    This lets you see how HTMLParser parses a document when no
+    Beautiful Soup code is running.
+    """
+    parser = AnnouncingParser()
+    parser.feed(data)
+
+_vowels = "aeiou"
+_consonants = "bcdfghjklmnpqrstvwxyz"
+
+def rword(length=5):
+    "Generate a random word-like string."
+    s = ''
+    for i in range(length):
+        if i % 2 == 0:
+            t = _consonants
+        else:
+            t = _vowels
+        s += random.choice(t)
+    return s
+
+def rsentence(length=4):
+    "Generate a random sentence-like string."
+    return " ".join(rword(random.randint(4,9)) for i in range(length))
+        
+def rdoc(num_elements=1000):
+    """Randomly generate an invalid HTML document."""
+    tag_names = ['p', 'div', 'span', 'i', 'b', 'script', 'table']
+    elements = []
+    for i in range(num_elements):
+        choice = random.randint(0,3)
+        if choice == 0:
+            # New tag.
+            tag_name = random.choice(tag_names)
+            elements.append("<%s>" % tag_name)
+        elif choice == 1:
+            elements.append(rsentence(random.randint(1,4)))
+        elif choice == 2:
+            # Close a tag.
+            tag_name = random.choice(tag_names)
+            elements.append("</%s>" % tag_name)
+    return "<html>" + "\n".join(elements) + "</html>"
+
+def benchmark_parsers(num_elements=100000):
+    """Very basic head-to-head performance benchmark."""
+    print "Comparative parser benchmark on Beautiful Soup %s" % __version__
+    data = rdoc(num_elements)
+    print "Generated a large invalid HTML document (%d bytes)." % len(data)
+    
+    for parser in ["lxml", ["lxml", "html"], "html5lib", "html.parser"]:
+        success = False
+        try:
+            a = time.time()
+            soup = BeautifulSoup(data, parser)
+            b = time.time()
+            success = True
+        except Exception, e:
+            print "%s could not parse the markup." % parser
+            traceback.print_exc()
+        if success:
+            print "BS4+%s parsed the markup in %.2fs." % (parser, b-a)
+
+    from lxml import etree
+    a = time.time()
+    etree.HTML(data)
+    b = time.time()
+    print "Raw lxml parsed the markup in %.2fs." % (b-a)
+
+    import html5lib
+    parser = html5lib.HTMLParser()
+    a = time.time()
+    parser.parse(data)
+    b = time.time()
+    print "Raw html5lib parsed the markup in %.2fs." % (b-a)
+
+def profile(num_elements=100000, parser="lxml"):
+
+    filehandle = tempfile.NamedTemporaryFile()
+    filename = filehandle.name
+
+    data = rdoc(num_elements)
+    vars = dict(bs4=bs4, data=data, parser=parser)
+    cProfile.runctx('bs4.BeautifulSoup(data, parser)' , vars, vars, filename)
+
+    stats = pstats.Stats(filename)
+    # stats.strip_dirs()
+    stats.sort_stats("cumulative")
+    stats.print_stats('_html5lib|bs4', 50)
+
+if __name__ == '__main__':
+    diagnose(sys.stdin.read())
diff --git a/lib/bs4/element.py b/lib/bs4/element.py
new file mode 100644
index 0000000..da9afdf
--- /dev/null
+++ b/lib/bs4/element.py
@@ -0,0 +1,1611 @@
+import collections
+import re
+import sys
+import warnings
+from bs4.dammit import EntitySubstitution
+
+DEFAULT_OUTPUT_ENCODING = "utf-8"
+PY3K = (sys.version_info[0] > 2)
+
+whitespace_re = re.compile("\s+")
+
+def _alias(attr):
+    """Alias one attribute name to another for backward compatibility"""
+    @property
+    def alias(self):
+        return getattr(self, attr)
+
+    @alias.setter
+    def alias(self):
+        return setattr(self, attr)
+    return alias
+
+
+class NamespacedAttribute(unicode):
+
+    def __new__(cls, prefix, name, namespace=None):
+        if name is None:
+            obj = unicode.__new__(cls, prefix)
+        elif prefix is None:
+            # Not really namespaced.
+            obj = unicode.__new__(cls, name)
+        else:
+            obj = unicode.__new__(cls, prefix + ":" + name)
+        obj.prefix = prefix
+        obj.name = name
+        obj.namespace = namespace
+        return obj
+
+class AttributeValueWithCharsetSubstitution(unicode):
+    """A stand-in object for a character encoding specified in HTML."""
+
+class CharsetMetaAttributeValue(AttributeValueWithCharsetSubstitution):
+    """A generic stand-in for the value of a meta tag's 'charset' attribute.
+
+    When Beautiful Soup parses the markup '<meta charset="utf8">', the
+    value of the 'charset' attribute will be one of these objects.
+    """
+
+    def __new__(cls, original_value):
+        obj = unicode.__new__(cls, original_value)
+        obj.original_value = original_value
+        return obj
+
+    def encode(self, encoding):
+        return encoding
+
+
+class ContentMetaAttributeValue(AttributeValueWithCharsetSubstitution):
+    """A generic stand-in for the value of a meta tag's 'content' attribute.
+
+    When Beautiful Soup parses the markup:
+     <meta http-equiv="content-type" content="text/html; charset=utf8">
+
+    The value of the 'content' attribute will be one of these objects.
+    """
+
+    CHARSET_RE = re.compile("((^|;)\s*charset=)([^;]*)", re.M)
+
+    def __new__(cls, original_value):
+        match = cls.CHARSET_RE.search(original_value)
+        if match is None:
+            # No substitution necessary.
+            return unicode.__new__(unicode, original_value)
+
+        obj = unicode.__new__(cls, original_value)
+        obj.original_value = original_value
+        return obj
+
+    def encode(self, encoding):
+        def rewrite(match):
+            return match.group(1) + encoding
+        return self.CHARSET_RE.sub(rewrite, self.original_value)
+
+class HTMLAwareEntitySubstitution(EntitySubstitution):
+
+    """Entity substitution rules that are aware of some HTML quirks.
+
+    Specifically, the contents of <script> and <style> tags should not
+    undergo entity substitution.
+
+    Incoming NavigableString objects are checked to see if they're the
+    direct children of a <script> or <style> tag.
+    """
+
+    cdata_containing_tags = set(["script", "style"])
+
+    preformatted_tags = set(["pre"])
+
+    @classmethod
+    def _substitute_if_appropriate(cls, ns, f):
+        if (isinstance(ns, NavigableString)
+            and ns.parent is not None
+            and ns.parent.name in cls.cdata_containing_tags):
+            # Do nothing.
+            return ns
+        # Substitute.
+        return f(ns)
+
+    @classmethod
+    def substitute_html(cls, ns):
+        return cls._substitute_if_appropriate(
+            ns, EntitySubstitution.substitute_html)
+
+    @classmethod
+    def substitute_xml(cls, ns):
+        return cls._substitute_if_appropriate(
+            ns, EntitySubstitution.substitute_xml)
+
+class PageElement(object):
+    """Contains the navigational information for some part of the page
+    (either a tag or a piece of text)"""
+
+    # There are five possible values for the "formatter" argument passed in
+    # to methods like encode() and prettify():
+    #
+    # "html" - All Unicode characters with corresponding HTML entities
+    #   are converted to those entities on output.
+    # "minimal" - Bare ampersands and angle brackets are converted to
+    #   XML entities: &amp; &lt; &gt;
+    # None - The null formatter. Unicode characters are never
+    #   converted to entities.  This is not recommended, but it's
+    #   faster than "minimal".
+    # A function - This function will be called on every string that
+    #  needs to undergo entity substitution.
+    #
+
+    # In an HTML document, the default "html" and "minimal" functions
+    # will leave the contents of <script> and <style> tags alone. For
+    # an XML document, all tags will be given the same treatment.
+
+    HTML_FORMATTERS = {
+        "html" : HTMLAwareEntitySubstitution.substitute_html,
+        "minimal" : HTMLAwareEntitySubstitution.substitute_xml,
+        None : None
+        }
+
+    XML_FORMATTERS = {
+        "html" : EntitySubstitution.substitute_html,
+        "minimal" : EntitySubstitution.substitute_xml,
+        None : None
+        }
+
+    def format_string(self, s, formatter='minimal'):
+        """Format the given string using the given formatter."""
+        if not callable(formatter):
+            formatter = self._formatter_for_name(formatter)
+        if formatter is None:
+            output = s
+        else:
+            output = formatter(s)
+        return output
+
+    @property
+    def _is_xml(self):
+        """Is this element part of an XML tree or an HTML tree?
+
+        This is used when mapping a formatter name ("minimal") to an
+        appropriate function (one that performs entity-substitution on
+        the contents of <script> and <style> tags, or not). It's
+        inefficient, but it should be called very rarely.
+        """
+        if self.parent is None:
+            # This is the top-level object. It should have .is_xml set
+            # from tree creation. If not, take a guess--BS is usually
+            # used on HTML markup.
+            return getattr(self, 'is_xml', False)
+        return self.parent._is_xml
+
+    def _formatter_for_name(self, name):
+        "Look up a formatter function based on its name and the tree."
+        if self._is_xml:
+            return self.XML_FORMATTERS.get(
+                name, EntitySubstitution.substitute_xml)
+        else:
+            return self.HTML_FORMATTERS.get(
+                name, HTMLAwareEntitySubstitution.substitute_xml)
+
+    def setup(self, parent=None, previous_element=None):
+        """Sets up the initial relations between this element and
+        other elements."""
+        self.parent = parent
+        self.previous_element = previous_element
+        if previous_element is not None:
+            self.previous_element.next_element = self
+        self.next_element = None
+        self.previous_sibling = None
+        self.next_sibling = None
+        if self.parent is not None and self.parent.contents:
+            self.previous_sibling = self.parent.contents[-1]
+            self.previous_sibling.next_sibling = self
+
+    nextSibling = _alias("next_sibling")  # BS3
+    previousSibling = _alias("previous_sibling")  # BS3
+
+    def replace_with(self, replace_with):
+        if replace_with is self:
+            return
+        if replace_with is self.parent:
+            raise ValueError("Cannot replace a Tag with its parent.")
+        old_parent = self.parent
+        my_index = self.parent.index(self)
+        self.extract()
+        old_parent.insert(my_index, replace_with)
+        return self
+    replaceWith = replace_with  # BS3
+
+    def unwrap(self):
+        my_parent = self.parent
+        my_index = self.parent.index(self)
+        self.extract()
+        for child in reversed(self.contents[:]):
+            my_parent.insert(my_index, child)
+        return self
+    replace_with_children = unwrap
+    replaceWithChildren = unwrap  # BS3
+
+    def wrap(self, wrap_inside):
+        me = self.replace_with(wrap_inside)
+        wrap_inside.append(me)
+        return wrap_inside
+
+    def extract(self):
+        """Destructively rips this element out of the tree."""
+        if self.parent is not None:
+            del self.parent.contents[self.parent.index(self)]
+
+        #Find the two elements that would be next to each other if
+        #this element (and any children) hadn't been parsed. Connect
+        #the two.
+        last_child = self._last_descendant()
+        next_element = last_child.next_element
+
+        if self.previous_element is not None:
+            self.previous_element.next_element = next_element
+        if next_element is not None:
+            next_element.previous_element = self.previous_element
+        self.previous_element = None
+        last_child.next_element = None
+
+        self.parent = None
+        if self.previous_sibling is not None:
+            self.previous_sibling.next_sibling = self.next_sibling
+        if self.next_sibling is not None:
+            self.next_sibling.previous_sibling = self.previous_sibling
+        self.previous_sibling = self.next_sibling = None
+        return self
+
+    def _last_descendant(self, is_initialized=True, accept_self=True):
+        "Finds the last element beneath this object to be parsed."
+        if is_initialized and self.next_sibling:
+            last_child = self.next_sibling.previous_element
+        else:
+            last_child = self
+            while isinstance(last_child, Tag) and last_child.contents:
+                last_child = last_child.contents[-1]
+        if not accept_self and last_child == self:
+            last_child = None
+        return last_child
+    # BS3: Not part of the API!
+    _lastRecursiveChild = _last_descendant
+
+    def insert(self, position, new_child):
+        if new_child is self:
+            raise ValueError("Cannot insert a tag into itself.")
+        if (isinstance(new_child, basestring)
+            and not isinstance(new_child, NavigableString)):
+            new_child = NavigableString(new_child)
+
+        position = min(position, len(self.contents))
+        if hasattr(new_child, 'parent') and new_child.parent is not None:
+            # We're 'inserting' an element that's already one
+            # of this object's children.
+            if new_child.parent is self:
+                current_index = self.index(new_child)
+                if current_index < position:
+                    # We're moving this element further down the list
+                    # of this object's children. That means that when
+                    # we extract this element, our target index will
+                    # jump down one.
+                    position -= 1
+            new_child.extract()
+
+        new_child.parent = self
+        previous_child = None
+        if position == 0:
+            new_child.previous_sibling = None
+            new_child.previous_element = self
+        else:
+            previous_child = self.contents[position - 1]
+            new_child.previous_sibling = previous_child
+            new_child.previous_sibling.next_sibling = new_child
+            new_child.previous_element = previous_child._last_descendant(False)
+        if new_child.previous_element is not None:
+            new_child.previous_element.next_element = new_child
+
+        new_childs_last_element = new_child._last_descendant(False)
+
+        if position >= len(self.contents):
+            new_child.next_sibling = None
+
+            parent = self
+            parents_next_sibling = None
+            while parents_next_sibling is None and parent is not None:
+                parents_next_sibling = parent.next_sibling
+                parent = parent.parent
+                if parents_next_sibling is not None:
+                    # We found the element that comes next in the document.
+                    break
+            if parents_next_sibling is not None:
+                new_childs_last_element.next_element = parents_next_sibling
+            else:
+                # The last element of this tag is the last element in
+                # the document.
+                new_childs_last_element.next_element = None
+        else:
+            next_child = self.contents[position]
+            new_child.next_sibling = next_child
+            if new_child.next_sibling is not None:
+                new_child.next_sibling.previous_sibling = new_child
+            new_childs_last_element.next_element = next_child
+
+        if new_childs_last_element.next_element is not None:
+            new_childs_last_element.next_element.previous_element = new_childs_last_element
+        self.contents.insert(position, new_child)
+
+    def append(self, tag):
+        """Appends the given tag to the contents of this tag."""
+        self.insert(len(self.contents), tag)
+
+    def insert_before(self, predecessor):
+        """Makes the given element the immediate predecessor of this one.
+
+        The two elements will have the same parent, and the given element
+        will be immediately before this one.
+        """
+        if self is predecessor:
+            raise ValueError("Can't insert an element before itself.")
+        parent = self.parent
+        if parent is None:
+            raise ValueError(
+                "Element has no parent, so 'before' has no meaning.")
+        # Extract first so that the index won't be screwed up if they
+        # are siblings.
+        if isinstance(predecessor, PageElement):
+            predecessor.extract()
+        index = parent.index(self)
+        parent.insert(index, predecessor)
+
+    def insert_after(self, successor):
+        """Makes the given element the immediate successor of this one.
+
+        The two elements will have the same parent, and the given element
+        will be immediately after this one.
+        """
+        if self is successor:
+            raise ValueError("Can't insert an element after itself.")
+        parent = self.parent
+        if parent is None:
+            raise ValueError(
+                "Element has no parent, so 'after' has no meaning.")
+        # Extract first so that the index won't be screwed up if they
+        # are siblings.
+        if isinstance(successor, PageElement):
+            successor.extract()
+        index = parent.index(self)
+        parent.insert(index+1, successor)
+
+    def find_next(self, name=None, attrs={}, text=None, **kwargs):
+        """Returns the first item that matches the given criteria and
+        appears after this Tag in the document."""
+        return self._find_one(self.find_all_next, name, attrs, text, **kwargs)
+    findNext = find_next  # BS3
+
+    def find_all_next(self, name=None, attrs={}, text=None, limit=None,
+                    **kwargs):
+        """Returns all items that match the given criteria and appear
+        after this Tag in the document."""
+        return self._find_all(name, attrs, text, limit, self.next_elements,
+                             **kwargs)
+    findAllNext = find_all_next  # BS3
+
+    def find_next_sibling(self, name=None, attrs={}, text=None, **kwargs):
+        """Returns the closest sibling to this Tag that matches the
+        given criteria and appears after this Tag in the document."""
+        return self._find_one(self.find_next_siblings, name, attrs, text,
+                             **kwargs)
+    findNextSibling = find_next_sibling  # BS3
+
+    def find_next_siblings(self, name=None, attrs={}, text=None, limit=None,
+                           **kwargs):
+        """Returns the siblings of this Tag that match the given
+        criteria and appear after this Tag in the document."""
+        return self._find_all(name, attrs, text, limit,
+                              self.next_siblings, **kwargs)
+    findNextSiblings = find_next_siblings   # BS3
+    fetchNextSiblings = find_next_siblings  # BS2
+
+    def find_previous(self, name=None, attrs={}, text=None, **kwargs):
+        """Returns the first item that matches the given criteria and
+        appears before this Tag in the document."""
+        return self._find_one(
+            self.find_all_previous, name, attrs, text, **kwargs)
+    findPrevious = find_previous  # BS3
+
+    def find_all_previous(self, name=None, attrs={}, text=None, limit=None,
+                        **kwargs):
+        """Returns all items that match the given criteria and appear
+        before this Tag in the document."""
+        return self._find_all(name, attrs, text, limit, self.previous_elements,
+                           **kwargs)
+    findAllPrevious = find_all_previous  # BS3
+    fetchPrevious = find_all_previous    # BS2
+
+    def find_previous_sibling(self, name=None, attrs={}, text=None, **kwargs):
+        """Returns the closest sibling to this Tag that matches the
+        given criteria and appears before this Tag in the document."""
+        return self._find_one(self.find_previous_siblings, name, attrs, text,
+                             **kwargs)
+    findPreviousSibling = find_previous_sibling  # BS3
+
+    def find_previous_siblings(self, name=None, attrs={}, text=None,
+                               limit=None, **kwargs):
+        """Returns the siblings of this Tag that match the given
+        criteria and appear before this Tag in the document."""
+        return self._find_all(name, attrs, text, limit,
+                              self.previous_siblings, **kwargs)
+    findPreviousSiblings = find_previous_siblings   # BS3
+    fetchPreviousSiblings = find_previous_siblings  # BS2
+
+    def find_parent(self, name=None, attrs={}, **kwargs):
+        """Returns the closest parent of this Tag that matches the given
+        criteria."""
+        # NOTE: We can't use _find_one because findParents takes a different
+        # set of arguments.
+        r = None
+        l = self.find_parents(name, attrs, 1, **kwargs)
+        if l:
+            r = l[0]
+        return r
+    findParent = find_parent  # BS3
+
+    def find_parents(self, name=None, attrs={}, limit=None, **kwargs):
+        """Returns the parents of this Tag that match the given
+        criteria."""
+
+        return self._find_all(name, attrs, None, limit, self.parents,
+                             **kwargs)
+    findParents = find_parents   # BS3
+    fetchParents = find_parents  # BS2
+
+    @property
+    def next(self):
+        return self.next_element
+
+    @property
+    def previous(self):
+        return self.previous_element
+
+    #These methods do the real heavy lifting.
+
+    def _find_one(self, method, name, attrs, text, **kwargs):
+        r = None
+        l = method(name, attrs, text, 1, **kwargs)
+        if l:
+            r = l[0]
+        return r
+
+    def _find_all(self, name, attrs, text, limit, generator, **kwargs):
+        "Iterates over a generator looking for things that match."
+
+        if isinstance(name, SoupStrainer):
+            strainer = name
+        else:
+            strainer = SoupStrainer(name, attrs, text, **kwargs)
+
+        if text is None and not limit and not attrs and not kwargs:
+            if name is True or name is None:
+                # Optimization to find all tags.
+                result = (element for element in generator
+                          if isinstance(element, Tag))
+                return ResultSet(strainer, result)
+            elif isinstance(name, basestring):
+                # Optimization to find all tags with a given name.
+                result = (element for element in generator
+                          if isinstance(element, Tag)
+                            and element.name == name)
+                return ResultSet(strainer, result)
+        results = ResultSet(strainer)
+        while True:
+            try:
+                i = next(generator)
+            except StopIteration:
+                break
+            if i:
+                found = strainer.search(i)
+                if found:
+                    results.append(found)
+                    if limit and len(results) >= limit:
+                        break
+        return results
+
+    #These generators can be used to navigate starting from both
+    #NavigableStrings and Tags.
+    @property
+    def next_elements(self):
+        i = self.next_element
+        while i is not None:
+            yield i
+            i = i.next_element
+
+    @property
+    def next_siblings(self):
+        i = self.next_sibling
+        while i is not None:
+            yield i
+            i = i.next_sibling
+
+    @property
+    def previous_elements(self):
+        i = self.previous_element
+        while i is not None:
+            yield i
+            i = i.previous_element
+
+    @property
+    def previous_siblings(self):
+        i = self.previous_sibling
+        while i is not None:
+            yield i
+            i = i.previous_sibling
+
+    @property
+    def parents(self):
+        i = self.parent
+        while i is not None:
+            yield i
+            i = i.parent
+
+    # Methods for supporting CSS selectors.
+
+    tag_name_re = re.compile('^[a-z0-9]+$')
+
+    # /^(\w+)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/
+    #   \---/  \---/\-------------/    \-------/
+    #     |      |         |               |
+    #     |      |         |           The value
+    #     |      |    ~,|,^,$,* or =
+    #     |   Attribute
+    #    Tag
+    attribselect_re = re.compile(
+        r'^(?P<tag>\w+)?\[(?P<attribute>\w+)(?P<operator>[=~\|\^\$\*]?)' +
+        r'=?"?(?P<value>[^\]"]*)"?\]$'
+        )
+
+    def _attr_value_as_string(self, value, default=None):
+        """Force an attribute value into a string representation.
+
+        A multi-valued attribute will be converted into a
+        space-separated stirng.
+        """
+        value = self.get(value, default)
+        if isinstance(value, list) or isinstance(value, tuple):
+            value =" ".join(value)
+        return value
+
+    def _tag_name_matches_and(self, function, tag_name):
+        if not tag_name:
+            return function
+        else:
+            def _match(tag):
+                return tag.name == tag_name and function(tag)
+            return _match
+
+    def _attribute_checker(self, operator, attribute, value=''):
+        """Create a function that performs a CSS selector operation.
+
+        Takes an operator, attribute and optional value. Returns a
+        function that will return True for elements that match that
+        combination.
+        """
+        if operator == '=':
+            # string representation of `attribute` is equal to `value`
+            return lambda el: el._attr_value_as_string(attribute) == value
+        elif operator == '~':
+            # space-separated list representation of `attribute`
+            # contains `value`
+            def _includes_value(element):
+                attribute_value = element.get(attribute, [])
+                if not isinstance(attribute_value, list):
+                    attribute_value = attribute_value.split()
+                return value in attribute_value
+            return _includes_value
+        elif operator == '^':
+            # string representation of `attribute` starts with `value`
+            return lambda el: el._attr_value_as_string(
+                attribute, '').startswith(value)
+        elif operator == '$':
+            # string represenation of `attribute` ends with `value`
+            return lambda el: el._attr_value_as_string(
+                attribute, '').endswith(value)
+        elif operator == '*':
+            # string representation of `attribute` contains `value`
+            return lambda el: value in el._attr_value_as_string(attribute, '')
+        elif operator == '|':
+            # string representation of `attribute` is either exactly
+            # `value` or starts with `value` and then a dash.
+            def _is_or_starts_with_dash(element):
+                attribute_value = element._attr_value_as_string(attribute, '')
+                return (attribute_value == value or attribute_value.startswith(
+                        value + '-'))
+            return _is_or_starts_with_dash
+        else:
+            return lambda el: el.has_attr(attribute)
+
+    # Old non-property versions of the generators, for backwards
+    # compatibility with BS3.
+    def nextGenerator(self):
+        return self.next_elements
+
+    def nextSiblingGenerator(self):
+        return self.next_siblings
+
+    def previousGenerator(self):
+        return self.previous_elements
+
+    def previousSiblingGenerator(self):
+        return self.previous_siblings
+
+    def parentGenerator(self):
+        return self.parents
+
+
+class NavigableString(unicode, PageElement):
+
+    PREFIX = ''
+    SUFFIX = ''
+
+    def __new__(cls, value):
+        """Create a new NavigableString.
+
+        When unpickling a NavigableString, this method is called with
+        the string in DEFAULT_OUTPUT_ENCODING. That encoding needs to be
+        passed in to the superclass's __new__ or the superclass won't know
+        how to handle non-ASCII characters.
+        """
+        if isinstance(value, unicode):
+            return unicode.__new__(cls, value)
+        return unicode.__new__(cls, value, DEFAULT_OUTPUT_ENCODING)
+
+    def __copy__(self):
+        return self
+
+    def __getnewargs__(self):
+        return (unicode(self),)
+
+    def __getattr__(self, attr):
+        """text.string gives you text. This is for backwards
+        compatibility for Navigable*String, but for CData* it lets you
+        get the string without the CData wrapper."""
+        if attr == 'string':
+            return self
+        else:
+            raise AttributeError(
+                "'%s' object has no attribute '%s'" % (
+                    self.__class__.__name__, attr))
+
+    def output_ready(self, formatter="minimal"):
+        output = self.format_string(self, formatter)
+        return self.PREFIX + output + self.SUFFIX
+
+    @property
+    def name(self):
+        return None
+
+    @name.setter
+    def name(self, name):
+        raise AttributeError("A NavigableString cannot be given a name.")
+
+class PreformattedString(NavigableString):
+    """A NavigableString not subject to the normal formatting rules.
+
+    The string will be passed into the formatter (to trigger side effects),
+    but the return value will be ignored.
+    """
+
+    def output_ready(self, formatter="minimal"):
+        """CData strings are passed into the formatter.
+        But the return value is ignored."""
+        self.format_string(self, formatter)
+        return self.PREFIX + self + self.SUFFIX
+
+class CData(PreformattedString):
+
+    PREFIX = u'<![CDATA['
+    SUFFIX = u']]>'
+
+class ProcessingInstruction(PreformattedString):
+
+    PREFIX = u'<?'
+    SUFFIX = u'?>'
+
+class Comment(PreformattedString):
+
+    PREFIX = u'<!--'
+    SUFFIX = u'-->'
+
+
+class Declaration(PreformattedString):
+    PREFIX = u'<!'
+    SUFFIX = u'!>'
+
+
+class Doctype(PreformattedString):
+
+    @classmethod
+    def for_name_and_ids(cls, name, pub_id, system_id):
+        value = name or ''
+        if pub_id is not None:
+            value += ' PUBLIC "%s"' % pub_id
+            if system_id is not None:
+                value += ' "%s"' % system_id
+        elif system_id is not None:
+            value += ' SYSTEM "%s"' % system_id
+
+        return Doctype(value)
+
+    PREFIX = u'<!DOCTYPE '
+    SUFFIX = u'>\n'
+
+
+class Tag(PageElement):
+
+    """Represents a found HTML tag with its attributes and contents."""
+
+    def __init__(self, parser=None, builder=None, name=None, namespace=None,
+                 prefix=None, attrs=None, parent=None, previous=None):
+        "Basic constructor."
+
+        if parser is None:
+            self.parser_class = None
+        else:
+            # We don't actually store the parser object: that lets extracted
+            # chunks be garbage-collected.
+            self.parser_class = parser.__class__
+        if name is None:
+            raise ValueError("No value provided for new tag's name.")
+        self.name = name
+        self.namespace = namespace
+        self.prefix = prefix
+        if attrs is None:
+            attrs = {}
+        elif attrs and builder.cdata_list_attributes:
+            attrs = builder._replace_cdata_list_attribute_values(
+                self.name, attrs)
+        else:
+            attrs = dict(attrs)
+        self.attrs = attrs
+        self.contents = []
+        self.setup(parent, previous)
+        self.hidden = False
+
+        # Set up any substitutions, such as the charset in a META tag.
+        if builder is not None:
+            builder.set_up_substitutions(self)
+            self.can_be_empty_element = builder.can_be_empty_element(name)
+        else:
+            self.can_be_empty_element = False
+
+    parserClass = _alias("parser_class")  # BS3
+
+    @property
+    def is_empty_element(self):
+        """Is this tag an empty-element tag? (aka a self-closing tag)
+
+        A tag that has contents is never an empty-element tag.
+
+        A tag that has no contents may or may not be an empty-element
+        tag. It depends on the builder used to create the tag. If the
+        builder has a designated list of empty-element tags, then only
+        a tag whose name shows up in that list is considered an
+        empty-element tag.
+
+        If the builder has no designated list of empty-element tags,
+        then any tag with no contents is an empty-element tag.
+        """
+        return len(self.contents) == 0 and self.can_be_empty_element
+    isSelfClosing = is_empty_element  # BS3
+
+    @property
+    def string(self):
+        """Convenience property to get the single string within this tag.
+
+        :Return: If this tag has a single string child, return value
+         is that string. If this tag has no children, or more than one
+         child, return value is None. If this tag has one child tag,
+         return value is the 'string' attribute of the child tag,
+         recursively.
+        """
+        if len(self.contents) != 1:
+            return None
+        child = self.contents[0]
+        if isinstance(child, NavigableString):
+            return child
+        return child.string
+
+    @string.setter
+    def string(self, string):
+        self.clear()
+        self.append(string.__class__(string))
+
+    def _all_strings(self, strip=False, types=(NavigableString, CData)):
+        """Yield all strings of certain classes, possibly stripping them.
+
+        By default, yields only NavigableString and CData objects. So
+        no comments, processing instructions, etc.
+        """
+        for descendant in self.descendants:
+            if (
+                (types is None and not isinstance(descendant, NavigableString))
+                or
+                (types is not None and type(descendant) not in types)):
+                continue
+            if strip:
+                descendant = descendant.strip()
+                if len(descendant) == 0:
+                    continue
+            yield descendant
+
+    strings = property(_all_strings)
+
+    @property
+    def stripped_strings(self):
+        for string in self._all_strings(True):
+            yield string
+
+    def get_text(self, separator=u"", strip=False,
+                 types=(NavigableString, CData)):
+        """
+        Get all child strings, concatenated using the given separator.
+        """
+        return separator.join([s for s in self._all_strings(
+                    strip, types=types)])
+    getText = get_text
+    text = property(get_text)
+
+    def decompose(self):
+        """Recursively destroys the contents of this tree."""
+        self.extract()
+        i = self
+        while i is not None:
+            next = i.next_element
+            i.__dict__.clear()
+            i.contents = []
+            i = next
+
+    def clear(self, decompose=False):
+        """
+        Extract all children. If decompose is True, decompose instead.
+        """
+        if decompose:
+            for element in self.contents[:]:
+                if isinstance(element, Tag):
+                    element.decompose()
+                else:
+                    element.extract()
+        else:
+            for element in self.contents[:]:
+                element.extract()
+
+    def index(self, element):
+        """
+        Find the index of a child by identity, not value. Avoids issues with
+        tag.contents.index(element) getting the index of equal elements.
+        """
+        for i, child in enumerate(self.contents):
+            if child is element:
+                return i
+        raise ValueError("Tag.index: element not in tag")
+
+    def get(self, key, default=None):
+        """Returns the value of the 'key' attribute for the tag, or
+        the value given for 'default' if it doesn't have that
+        attribute."""
+        return self.attrs.get(key, default)
+
+    def has_attr(self, key):
+        return key in self.attrs
+
+    def __hash__(self):
+        return str(self).__hash__()
+
+    def __getitem__(self, key):
+        """tag[key] returns the value of the 'key' attribute for the tag,
+        and throws an exception if it's not there."""
+        return self.attrs[key]
+
+    def __iter__(self):
+        "Iterating over a tag iterates over its contents."
+        return iter(self.contents)
+
+    def __len__(self):
+        "The length of a tag is the length of its list of contents."
+        return len(self.contents)
+
+    def __contains__(self, x):
+        return x in self.contents
+
+    def __nonzero__(self):
+        "A tag is non-None even if it has no contents."
+        return True
+
+    def __setitem__(self, key, value):
+        """Setting tag[key] sets the value of the 'key' attribute for the
+        tag."""
+        self.attrs[key] = value
+
+    def __delitem__(self, key):
+        "Deleting tag[key] deletes all 'key' attributes for the tag."
+        self.attrs.pop(key, None)
+
+    def __call__(self, *args, **kwargs):
+        """Calling a tag like a function is the same as calling its
+        find_all() method. Eg. tag('a') returns a list of all the A tags
+        found within this tag."""
+        return self.find_all(*args, **kwargs)
+
+    def __getattr__(self, tag):
+        #print "Getattr %s.%s" % (self.__class__, tag)
+        if len(tag) > 3 and tag.endswith('Tag'):
+            # BS3: soup.aTag -> "soup.find("a")
+            tag_name = tag[:-3]
+            warnings.warn(
+                '.%sTag is deprecated, use .find("%s") instead.' % (
+                    tag_name, tag_name))
+            return self.find(tag_name)
+        # We special case contents to avoid recursion.
+        elif not tag.startswith("__") and not tag=="contents":
+            return self.find(tag)
+        raise AttributeError(
+            "'%s' object has no attribute '%s'" % (self.__class__, tag))
+
+    def __eq__(self, other):
+        """Returns true iff this tag has the same name, the same attributes,
+        and the same contents (recursively) as the given tag."""
+        if self is other:
+            return True
+        if (not hasattr(other, 'name') or
+            not hasattr(other, 'attrs') or
+            not hasattr(other, 'contents') or
+            self.name != other.name or
+            self.attrs != other.attrs or
+            len(self) != len(other)):
+            return False
+        for i, my_child in enumerate(self.contents):
+            if my_child != other.contents[i]:
+                return False
+        return True
+
+    def __ne__(self, other):
+        """Returns true iff this tag is not identical to the other tag,
+        as defined in __eq__."""
+        return not self == other
+
+    def __repr__(self, encoding=DEFAULT_OUTPUT_ENCODING):
+        """Renders this tag as a string."""
+        return self.encode(encoding)
+
+    def __unicode__(self):
+        return self.decode()
+
+    def __str__(self):
+        return self.encode()
+
+    if PY3K:
+        __str__ = __repr__ = __unicode__
+
+    def encode(self, encoding=DEFAULT_OUTPUT_ENCODING,
+               indent_level=None, formatter="minimal",
+               errors="xmlcharrefreplace"):
+        # Turn the data structure into Unicode, then encode the
+        # Unicode.
+        u = self.decode(indent_level, encoding, formatter)
+        return u.encode(encoding, errors)
+
+    def _should_pretty_print(self, indent_level):
+        """Should this tag be pretty-printed?"""
+        return (
+            indent_level is not None and
+            (self.name not in HTMLAwareEntitySubstitution.preformatted_tags
+             or self._is_xml))
+
+    def decode(self, indent_level=None,
+               eventual_encoding=DEFAULT_OUTPUT_ENCODING,
+               formatter="minimal"):
+        """Returns a Unicode representation of this tag and its contents.
+
+        :param eventual_encoding: The tag is destined to be
+           encoded into this encoding. This method is _not_
+           responsible for performing that encoding. This information
+           is passed in so that it can be substituted in if the
+           document contains a <META> tag that mentions the document's
+           encoding.
+        """
+
+        # First off, turn a string formatter into a function. This
+        # will stop the lookup from happening over and over again.
+        if not callable(formatter):
+            formatter = self._formatter_for_name(formatter)
+
+        attrs = []
+        if self.attrs:
+            for key, val in sorted(self.attrs.items()):
+                if val is None:
+                    decoded = key
+                else:
+                    if isinstance(val, list) or isinstance(val, tuple):
+                        val = ' '.join(val)
+                    elif not isinstance(val, basestring):
+                        val = unicode(val)
+                    elif (
+                        isinstance(val, AttributeValueWithCharsetSubstitution)
+                        and eventual_encoding is not None):
+                        val = val.encode(eventual_encoding)
+
+                    text = self.format_string(val, formatter)
+                    decoded = (
+                        unicode(key) + '='
+                        + EntitySubstitution.quoted_attribute_value(text))
+                attrs.append(decoded)
+        close = ''
+        closeTag = ''
+
+        prefix = ''
+        if self.prefix:
+            prefix = self.prefix + ":"
+
+        if self.is_empty_element:
+            close = '/'
+        else:
+            closeTag = '</%s%s>' % (prefix, self.name)
+
+        pretty_print = self._should_pretty_print(indent_level)
+        space = ''
+        indent_space = ''
+        if indent_level is not None:
+            indent_space = (' ' * (indent_level - 1))
+        if pretty_print:
+            space = indent_space
+            indent_contents = indent_level + 1
+        else:
+            indent_contents = None
+        contents = self.decode_contents(
+            indent_contents, eventual_encoding, formatter)
+
+        if self.hidden:
+            # This is the 'document root' object.
+            s = contents
+        else:
+            s = []
+            attribute_string = ''
+            if attrs:
+                attribute_string = ' ' + ' '.join(attrs)
+            if indent_level is not None:
+                # Even if this particular tag is not pretty-printed,
+                # we should indent up to the start of the tag.
+                s.append(indent_space)
+            s.append('<%s%s%s%s>' % (
+                    prefix, self.name, attribute_string, close))
+            if pretty_print:
+                s.append("\n")
+            s.append(contents)
+            if pretty_print and contents and contents[-1] != "\n":
+                s.append("\n")
+            if pretty_print and closeTag:
+                s.append(space)
+            s.append(closeTag)
+            if indent_level is not None and closeTag and self.next_sibling:
+                # Even if this particular tag is not pretty-printed,
+                # we're now done with the tag, and we should add a
+                # newline if appropriate.
+                s.append("\n")
+            s = ''.join(s)
+        return s
+
+    def prettify(self, encoding=None, formatter="minimal"):
+        if encoding is None:
+            return self.decode(True, formatter=formatter)
+        else:
+            return self.encode(encoding, True, formatter=formatter)
+
+    def decode_contents(self, indent_level=None,
+                       eventual_encoding=DEFAULT_OUTPUT_ENCODING,
+                       formatter="minimal"):
+        """Renders the contents of this tag as a Unicode string.
+
+        :param eventual_encoding: The tag is destined to be
+           encoded into this encoding. This method is _not_
+           responsible for performing that encoding. This information
+           is passed in so that it can be substituted in if the
+           document contains a <META> tag that mentions the document's
+           encoding.
+        """
+        # First off, turn a string formatter into a function. This
+        # will stop the lookup from happening over and over again.
+        if not callable(formatter):
+            formatter = self._formatter_for_name(formatter)
+
+        pretty_print = (indent_level is not None)
+        s = []
+        for c in self:
+            text = None
+            if isinstance(c, NavigableString):
+                text = c.output_ready(formatter)
+            elif isinstance(c, Tag):
+                s.append(c.decode(indent_level, eventual_encoding,
+                                  formatter))
+            if text and indent_level and not self.name == 'pre':
+                text = text.strip()
+            if text:
+                if pretty_print and not self.name == 'pre':
+                    s.append(" " * (indent_level - 1))
+                s.append(text)
+                if pretty_print and not self.name == 'pre':
+                    s.append("\n")
+        return ''.join(s)
+
+    def encode_contents(
+        self, indent_level=None, encoding=DEFAULT_OUTPUT_ENCODING,
+        formatter="minimal"):
+        """Renders the contents of this tag as a bytestring."""
+        contents = self.decode_contents(indent_level, encoding, formatter)
+        return contents.encode(encoding)
+
+    # Old method for BS3 compatibility
+    def renderContents(self, encoding=DEFAULT_OUTPUT_ENCODING,
+                       prettyPrint=False, indentLevel=0):
+        if not prettyPrint:
+            indentLevel = None
+        return self.encode_contents(
+            indent_level=indentLevel, encoding=encoding)
+
+    #Soup methods
+
+    def find(self, name=None, attrs={}, recursive=True, text=None,
+             **kwargs):
+        """Return only the first child of this Tag matching the given
+        criteria."""
+        r = None
+        l = self.find_all(name, attrs, recursive, text, 1, **kwargs)
+        if l:
+            r = l[0]
+        return r
+    findChild = find
+
+    def find_all(self, name=None, attrs={}, recursive=True, text=None,
+                 limit=None, **kwargs):
+        """Extracts a list of Tag objects that match the given
+        criteria.  You can specify the name of the Tag and any
+        attributes you want the Tag to have.
+
+        The value of a key-value pair in the 'attrs' map can be a
+        string, a list of strings, a regular expression object, or a
+        callable that takes a string and returns whether or not the
+        string matches for some custom definition of 'matches'. The
+        same is true of the tag name."""
+
+        generator = self.descendants
+        if not recursive:
+            generator = self.children
+        return self._find_all(name, attrs, text, limit, generator, **kwargs)
+    findAll = find_all       # BS3
+    findChildren = find_all  # BS2
+
+    #Generator methods
+    @property
+    def children(self):
+        # return iter() to make the purpose of the method clear
+        return iter(self.contents)  # XXX This seems to be untested.
+
+    @property
+    def descendants(self):
+        if not len(self.contents):
+            return
+        stopNode = self._last_descendant().next_element
+        current = self.contents[0]
+        while current is not stopNode:
+            yield current
+            current = current.next_element
+
+    # CSS selector code
+
+    _selector_combinators = ['>', '+', '~']
+    _select_debug = False
+    def select(self, selector, _candidate_generator=None):
+        """Perform a CSS selection operation on the current element."""
+        tokens = selector.split()
+        current_context = [self]
+
+        if tokens[-1] in self._selector_combinators:
+            raise ValueError(
+                'Final combinator "%s" is missing an argument.' % tokens[-1])
+        if self._select_debug:
+            print 'Running CSS selector "%s"' % selector
+        for index, token in enumerate(tokens):
+            if self._select_debug:
+                print ' Considering token "%s"' % token
+            recursive_candidate_generator = None
+            tag_name = None
+            if tokens[index-1] in self._selector_combinators:
+                # This token was consumed by the previous combinator. Skip it.
+                if self._select_debug:
+                    print '  Token was consumed by the previous combinator.'
+                continue
+            # Each operation corresponds to a checker function, a rule
+            # for determining whether a candidate matches the
+            # selector. Candidates are generated by the active
+            # iterator.
+            checker = None
+
+            m = self.attribselect_re.match(token)
+            if m is not None:
+                # Attribute selector
+                tag_name, attribute, operator, value = m.groups()
+                checker = self._attribute_checker(operator, attribute, value)
+
+            elif '#' in token:
+                # ID selector
+                tag_name, tag_id = token.split('#', 1)
+                def id_matches(tag):
+                    return tag.get('id', None) == tag_id
+                checker = id_matches
+
+            elif '.' in token:
+                # Class selector
+                tag_name, klass = token.split('.', 1)
+                classes = set(klass.split('.'))
+                def classes_match(candidate):
+                    return classes.issubset(candidate.get('class', []))
+                checker = classes_match
+
+            elif ':' in token:
+                # Pseudo-class
+                tag_name, pseudo = token.split(':', 1)
+                if tag_name == '':
+                    raise ValueError(
+                        "A pseudo-class must be prefixed with a tag name.")
+                pseudo_attributes = re.match('([a-zA-Z\d-]+)\(([a-zA-Z\d]+)\)', pseudo)
+                found = []
+                if pseudo_attributes is not None:
+                    pseudo_type, pseudo_value = pseudo_attributes.groups()
+                    if pseudo_type == 'nth-of-type':
+                        try:
+                            pseudo_value = int(pseudo_value)
+                        except:
+                            raise NotImplementedError(
+                                'Only numeric values are currently supported for the nth-of-type pseudo-class.')
+                        if pseudo_value < 1:
+                            raise ValueError(
+                                'nth-of-type pseudo-class value must be at least 1.')
+                        class Counter(object):
+                            def __init__(self, destination):
+                                self.count = 0
+                                self.destination = destination
+
+                            def nth_child_of_type(self, tag):
+                                self.count += 1
+                                if self.count == self.destination:
+                                    return True
+                                if self.count > self.destination:
+                                    # Stop the generator that's sending us
+                                    # these things.
+                                    raise StopIteration()
+                                return False
+                        checker = Counter(pseudo_value).nth_child_of_type
+                    else:
+                        raise NotImplementedError(
+                            'Only the following pseudo-classes are implemented: nth-of-type.')
+
+            elif token == '*':
+                # Star selector -- matches everything
+                pass
+            elif token == '>':
+                # Run the next token as a CSS selector against the
+                # direct children of each tag in the current context.
+                recursive_candidate_generator = lambda tag: tag.children
+            elif token == '~':
+                # Run the next token as a CSS selector against the
+                # siblings of each tag in the current context.
+                recursive_candidate_generator = lambda tag: tag.next_siblings
+            elif token == '+':
+                # For each tag in the current context, run the next
+                # token as a CSS selector against the tag's next
+                # sibling that's a tag.
+                def next_tag_sibling(tag):
+                    yield tag.find_next_sibling(True)
+                recursive_candidate_generator = next_tag_sibling
+
+            elif self.tag_name_re.match(token):
+                # Just a tag name.
+                tag_name = token
+            else:
+                raise ValueError(
+                    'Unsupported or invalid CSS selector: "%s"' % token)
+
+            if recursive_candidate_generator:
+                # This happens when the selector looks like  "> foo".
+                #
+                # The generator calls select() recursively on every
+                # member of the current context, passing in a different
+                # candidate generator and a different selector.
+                #
+                # In the case of "> foo", the candidate generator is
+                # one that yields a tag's direct children (">"), and
+                # the selector is "foo".
+                next_token = tokens[index+1]
+                def recursive_select(tag):
+                    if self._select_debug:
+                        print '    Calling select("%s") recursively on %s %s' % (next_token, tag.name, tag.attrs)
+                        print '-' * 40
+                    for i in tag.select(next_token, recursive_candidate_generator):
+                        if self._select_debug:
+                            print '(Recursive select picked up candidate %s %s)' % (i.name, i.attrs)
+                        yield i
+                    if self._select_debug:
+                        print '-' * 40
+                _use_candidate_generator = recursive_select
+            elif _candidate_generator is None:
+                # By default, a tag's candidates are all of its
+                # children. If tag_name is defined, only yield tags
+                # with that name.
+                if self._select_debug:
+                    if tag_name:
+                        check = "[any]"
+                    else:
+                        check = tag_name
+                    print '   Default candidate generator, tag name="%s"' % check
+                if self._select_debug:
+                    # This is redundant with later code, but it stops
+                    # a bunch of bogus tags from cluttering up the
+                    # debug log.
+                    def default_candidate_generator(tag):
+                        for child in tag.descendants:
+                            if not isinstance(child, Tag):
+                                continue
+                            if tag_name and not child.name == tag_name:
+                                continue
+                            yield child
+                    _use_candidate_generator = default_candidate_generator
+                else:
+                    _use_candidate_generator = lambda tag: tag.descendants
+            else:
+                _use_candidate_generator = _candidate_generator
+
+            new_context = []
+            new_context_ids = set([])
+            for tag in current_context:
+                if self._select_debug:
+                    print "    Running candidate generator on %s %s" % (
+                        tag.name, repr(tag.attrs))
+                for candidate in _use_candidate_generator(tag):
+                    if not isinstance(candidate, Tag):
+                        continue
+                    if tag_name and candidate.name != tag_name:
+                        continue
+                    if checker is not None:
+                        try:
+                            result = checker(candidate)
+                        except StopIteration:
+                            # The checker has decided we should no longer
+                            # run the generator.
+                            break
+                    if checker is None or result:
+                        if self._select_debug:
+                            print "     SUCCESS %s %s" % (candidate.name, repr(candidate.attrs))
+                        if id(candidate) not in new_context_ids:
+                            # If a tag matches a selector more than once,
+                            # don't include it in the context more than once.
+                            new_context.append(candidate)
+                            new_context_ids.add(id(candidate))
+                    elif self._select_debug:
+                        print "     FAILURE %s %s" % (candidate.name, repr(candidate.attrs))
+
+            current_context = new_context
+
+        if self._select_debug:
+            print "Final verdict:"
+            for i in current_context:
+                print " %s %s" % (i.name, i.attrs)
+        return current_context
+
+    # Old names for backwards compatibility
+    def childGenerator(self):
+        return self.children
+
+    def recursiveChildGenerator(self):
+        return self.descendants
+
+    def has_key(self, key):
+        """This was kind of misleading because has_key() (attributes)
+        was different from __in__ (contents). has_key() is gone in
+        Python 3, anyway."""
+        warnings.warn('has_key is deprecated. Use has_attr("%s") instead.' % (
+                key))
+        return self.has_attr(key)
+
+# Next, a couple classes to represent queries and their results.
+class SoupStrainer(object):
+    """Encapsulates a number of ways of matching a markup element (tag or
+    text)."""
+
+    def __init__(self, name=None, attrs={}, text=None, **kwargs):
+        self.name = self._normalize_search_value(name)
+        if not isinstance(attrs, dict):
+            # Treat a non-dict value for attrs as a search for the 'class'
+            # attribute.
+            kwargs['class'] = attrs
+            attrs = None
+
+        if 'class_' in kwargs:
+            # Treat class_="foo" as a search for the 'class'
+            # attribute, overriding any non-dict value for attrs.
+            kwargs['class'] = kwargs['class_']
+            del kwargs['class_']
+
+        if kwargs:
+            if attrs:
+                attrs = attrs.copy()
+                attrs.update(kwargs)
+            else:
+                attrs = kwargs
+        normalized_attrs = {}
+        for key, value in attrs.items():
+            normalized_attrs[key] = self._normalize_search_value(value)
+
+        self.attrs = normalized_attrs
+        self.text = self._normalize_search_value(text)
+
+    def _normalize_search_value(self, value):
+        # Leave it alone if it's a Unicode string, a callable, a
+        # regular expression, a boolean, or None.
+        if (isinstance(value, unicode) or callable(value) or hasattr(value, 'match')
+            or isinstance(value, bool) or value is None):
+            return value
+
+        # If it's a bytestring, convert it to Unicode, treating it as UTF-8.
+        if isinstance(value, bytes):
+            return value.decode("utf8")
+
+        # If it's listlike, convert it into a list of strings.
+        if hasattr(value, '__iter__'):
+            new_value = []
+            for v in value:
+                if (hasattr(v, '__iter__') and not isinstance(v, bytes)
+                    and not isinstance(v, unicode)):
+                    # This is almost certainly the user's mistake. In the
+                    # interests of avoiding infinite loops, we'll let
+                    # it through as-is rather than doing a recursive call.
+                    new_value.append(v)
+                else:
+                    new_value.append(self._normalize_search_value(v))
+            return new_value
+
+        # Otherwise, convert it into a Unicode string.
+        # The unicode(str()) thing is so this will do the same thing on Python 2
+        # and Python 3.
+        return unicode(str(value))
+
+    def __str__(self):
+        if self.text:
+            return self.text
+        else:
+            return "%s|%s" % (self.name, self.attrs)
+
+    def search_tag(self, markup_name=None, markup_attrs={}):
+        found = None
+        markup = None
+        if isinstance(markup_name, Tag):
+            markup = markup_name
+            markup_attrs = markup
+        call_function_with_tag_data = (
+            isinstance(self.name, collections.Callable)
+            and not isinstance(markup_name, Tag))
+
+        if ((not self.name)
+            or call_function_with_tag_data
+            or (markup and self._matches(markup, self.name))
+            or (not markup and self._matches(markup_name, self.name))):
+            if call_function_with_tag_data:
+                match = self.name(markup_name, markup_attrs)
+            else:
+                match = True
+                markup_attr_map = None
+                for attr, match_against in list(self.attrs.items()):
+                    if not markup_attr_map:
+                        if hasattr(markup_attrs, 'get'):
+                            markup_attr_map = markup_attrs
+                        else:
+                            markup_attr_map = {}
+                            for k, v in markup_attrs:
+                                markup_attr_map[k] = v
+                    attr_value = markup_attr_map.get(attr)
+                    if not self._matches(attr_value, match_against):
+                        match = False
+                        break
+            if match:
+                if markup:
+                    found = markup
+                else:
+                    found = markup_name
+        if found and self.text and not self._matches(found.string, self.text):
+            found = None
+        return found
+    searchTag = search_tag
+
+    def search(self, markup):
+        # print 'looking for %s in %s' % (self, markup)
+        found = None
+        # If given a list of items, scan it for a text element that
+        # matches.
+        if hasattr(markup, '__iter__') and not isinstance(markup, (Tag, basestring)):
+            for element in markup:
+                if isinstance(element, NavigableString) \
+                       and self.search(element):
+                    found = element
+                    break
+        # If it's a Tag, make sure its name or attributes match.
+        # Don't bother with Tags if we're searching for text.
+        elif isinstance(markup, Tag):
+            if not self.text or self.name or self.attrs:
+                found = self.search_tag(markup)
+        # If it's text, make sure the text matches.
+        elif isinstance(markup, NavigableString) or \
+                 isinstance(markup, basestring):
+            if not self.name and not self.attrs and self._matches(markup, self.text):
+                found = markup
+        else:
+            raise Exception(
+                "I don't know how to match against a %s" % markup.__class__)
+        return found
+
+    def _matches(self, markup, match_against):
+        # print u"Matching %s against %s" % (markup, match_against)
+        result = False
+        if isinstance(markup, list) or isinstance(markup, tuple):
+            # This should only happen when searching a multi-valued attribute
+            # like 'class'.
+            if (isinstance(match_against, unicode)
+                and ' ' in match_against):
+                # A bit of a special case. If they try to match "foo
+                # bar" on a multivalue attribute's value, only accept
+                # the literal value "foo bar"
+                #
+                # XXX This is going to be pretty slow because we keep
+                # splitting match_against. But it shouldn't come up
+                # too often.
+                return (whitespace_re.split(match_against) == markup)
+            else:
+                for item in markup:
+                    if self._matches(item, match_against):
+                        return True
+                return False
+
+        if match_against is True:
+            # True matches any non-None value.
+            return markup is not None
+
+        if isinstance(match_against, collections.Callable):
+            return match_against(markup)
+
+        # Custom callables take the tag as an argument, but all
+        # other ways of matching match the tag name as a string.
+        if isinstance(markup, Tag):
+            markup = markup.name
+
+        # Ensure that `markup` is either a Unicode string, or None.
+        markup = self._normalize_search_value(markup)
+
+        if markup is None:
+            # None matches None, False, an empty string, an empty list, and so on.
+            return not match_against
+
+        if isinstance(match_against, unicode):
+            # Exact string match
+            return markup == match_against
+
+        if hasattr(match_against, 'match'):
+            # Regexp match
+            return match_against.search(markup)
+
+        if hasattr(match_against, '__iter__'):
+            # The markup must be an exact match against something
+            # in the iterable.
+            return markup in match_against
+
+
+class ResultSet(list):
+    """A ResultSet is just a list that keeps track of the SoupStrainer
+    that created it."""
+    def __init__(self, source, result=()):
+        super(ResultSet, self).__init__(result)
+        self.source = source
diff --git a/lib/bs4/testing.py b/lib/bs4/testing.py
new file mode 100644
index 0000000..fd4495a
--- /dev/null
+++ b/lib/bs4/testing.py
@@ -0,0 +1,592 @@
+"""Helper classes for tests."""
+
+import copy
+import functools
+import unittest
+from unittest import TestCase
+from bs4 import BeautifulSoup
+from bs4.element import (
+    CharsetMetaAttributeValue,
+    Comment,
+    ContentMetaAttributeValue,
+    Doctype,
+    SoupStrainer,
+)
+
+from bs4.builder import HTMLParserTreeBuilder
+default_builder = HTMLParserTreeBuilder
+
+
+class SoupTest(unittest.TestCase):
+
+    @property
+    def default_builder(self):
+        return default_builder()
+
+    def soup(self, markup, **kwargs):
+        """Build a Beautiful Soup object from markup."""
+        builder = kwargs.pop('builder', self.default_builder)
+        return BeautifulSoup(markup, builder=builder, **kwargs)
+
+    def document_for(self, markup):
+        """Turn an HTML fragment into a document.
+
+        The details depend on the builder.
+        """
+        return self.default_builder.test_fragment_to_document(markup)
+
+    def assertSoupEquals(self, to_parse, compare_parsed_to=None):
+        builder = self.default_builder
+        obj = BeautifulSoup(to_parse, builder=builder)
+        if compare_parsed_to is None:
+            compare_parsed_to = to_parse
+
+        self.assertEqual(obj.decode(), self.document_for(compare_parsed_to))
+
+
+class HTMLTreeBuilderSmokeTest(object):
+
+    """A basic test of a treebuilder's competence.
+
+    Any HTML treebuilder, present or future, should be able to pass
+    these tests. With invalid markup, there's room for interpretation,
+    and different parsers can handle it differently. But with the
+    markup in these tests, there's not much room for interpretation.
+    """
+
+    def assertDoctypeHandled(self, doctype_fragment):
+        """Assert that a given doctype string is handled correctly."""
+        doctype_str, soup = self._document_with_doctype(doctype_fragment)
+
+        # Make sure a Doctype object was created.
+        doctype = soup.contents[0]
+        self.assertEqual(doctype.__class__, Doctype)
+        self.assertEqual(doctype, doctype_fragment)
+        self.assertEqual(str(soup)[:len(doctype_str)], doctype_str)
+
+        # Make sure that the doctype was correctly associated with the
+        # parse tree and that the rest of the document parsed.
+        self.assertEqual(soup.p.contents[0], 'foo')
+
+    def _document_with_doctype(self, doctype_fragment):
+        """Generate and parse a document with the given doctype."""
+        doctype = '<!DOCTYPE %s>' % doctype_fragment
+        markup = doctype + '\n<p>foo</p>'
+        soup = self.soup(markup)
+        return doctype, soup
+
+    def test_normal_doctypes(self):
+        """Make sure normal, everyday HTML doctypes are handled correctly."""
+        self.assertDoctypeHandled("html")
+        self.assertDoctypeHandled(
+            'html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"')
+
+    def test_empty_doctype(self):
+        soup = self.soup("<!DOCTYPE>")
+        doctype = soup.contents[0]
+        self.assertEqual("", doctype.strip())
+
+    def test_public_doctype_with_url(self):
+        doctype = 'html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"'
+        self.assertDoctypeHandled(doctype)
+
+    def test_system_doctype(self):
+        self.assertDoctypeHandled('foo SYSTEM "http://www.example.com/"')
+
+    def test_namespaced_system_doctype(self):
+        # We can handle a namespaced doctype with a system ID.
+        self.assertDoctypeHandled('xsl:stylesheet SYSTEM "htmlent.dtd"')
+
+    def test_namespaced_public_doctype(self):
+        # Test a namespaced doctype with a public id.
+        self.assertDoctypeHandled('xsl:stylesheet PUBLIC "htmlent.dtd"')
+
+    def test_real_xhtml_document(self):
+        """A real XHTML document should come out more or less the same as it went in."""
+        markup = b"""<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
+<html xmlns="http://www.w3.org/1999/xhtml">
+<head><title>Hello.</title></head>
+<body>Goodbye.</body>
+</html>"""
+        soup = self.soup(markup)
+        self.assertEqual(
+            soup.encode("utf-8").replace(b"\n", b""),
+            markup.replace(b"\n", b""))
+
+    def test_deepcopy(self):
+        """Make sure you can copy the tree builder.
+
+        This is important because the builder is part of a
+        BeautifulSoup object, and we want to be able to copy that.
+        """
+        copy.deepcopy(self.default_builder)
+
+    def test_p_tag_is_never_empty_element(self):
+        """A <p> tag is never designated as an empty-element tag.
+
+        Even if the markup shows it as an empty-element tag, it
+        shouldn't be presented that way.
+        """
+        soup = self.soup("<p/>")
+        self.assertFalse(soup.p.is_empty_element)
+        self.assertEqual(str(soup.p), "<p></p>")
+
+    def test_unclosed_tags_get_closed(self):
+        """A tag that's not closed by the end of the document should be closed.
+
+        This applies to all tags except empty-element tags.
+        """
+        self.assertSoupEquals("<p>", "<p></p>")
+        self.assertSoupEquals("<b>", "<b></b>")
+
+        self.assertSoupEquals("<br>", "<br/>")
+
+    def test_br_is_always_empty_element_tag(self):
+        """A <br> tag is designated as an empty-element tag.
+
+        Some parsers treat <br></br> as one <br/> tag, some parsers as
+        two tags, but it should always be an empty-element tag.
+        """
+        soup = self.soup("<br></br>")
+        self.assertTrue(soup.br.is_empty_element)
+        self.assertEqual(str(soup.br), "<br/>")
+
+    def test_nested_formatting_elements(self):
+        self.assertSoupEquals("<em><em></em></em>")
+
+    def test_comment(self):
+        # Comments are represented as Comment objects.
+        markup = "<p>foo<!--foobar-->baz</p>"
+        self.assertSoupEquals(markup)
+
+        soup = self.soup(markup)
+        comment = soup.find(text="foobar")
+        self.assertEqual(comment.__class__, Comment)
+
+        # The comment is properly integrated into the tree.
+        foo = soup.find(text="foo")
+        self.assertEqual(comment, foo.next_element)
+        baz = soup.find(text="baz")
+        self.assertEqual(comment, baz.previous_element)
+
+    def test_preserved_whitespace_in_pre_and_textarea(self):
+        """Whitespace must be preserved in <pre> and <textarea> tags."""
+        self.assertSoupEquals("<pre>   </pre>")
+        self.assertSoupEquals("<textarea> woo  </textarea>")
+
+    def test_nested_inline_elements(self):
+        """Inline elements can be nested indefinitely."""
+        b_tag = "<b>Inside a B tag</b>"
+        self.assertSoupEquals(b_tag)
+
+        nested_b_tag = "<p>A <i>nested <b>tag</b></i></p>"
+        self.assertSoupEquals(nested_b_tag)
+
+        double_nested_b_tag = "<p>A <a>doubly <i>nested <b>tag</b></i></a></p>"
+        self.assertSoupEquals(nested_b_tag)
+
+    def test_nested_block_level_elements(self):
+        """Block elements can be nested."""
+        soup = self.soup('<blockquote><p><b>Foo</b></p></blockquote>')
+        blockquote = soup.blockquote
+        self.assertEqual(blockquote.p.b.string, 'Foo')
+        self.assertEqual(blockquote.b.string, 'Foo')
+
+    def test_correctly_nested_tables(self):
+        """One table can go inside another one."""
+        markup = ('<table id="1">'
+                  '<tr>'
+                  "<td>Here's another table:"
+                  '<table id="2">'
+                  '<tr><td>foo</td></tr>'
+                  '</table></td>')
+
+        self.assertSoupEquals(
+            markup,
+            '<table id="1"><tr><td>Here\'s another table:'
+            '<table id="2"><tr><td>foo</td></tr></table>'
+            '</td></tr></table>')
+
+        self.assertSoupEquals(
+            "<table><thead><tr><td>Foo</td></tr></thead>"
+            "<tbody><tr><td>Bar</td></tr></tbody>"
+            "<tfoot><tr><td>Baz</td></tr></tfoot></table>")
+
+    def test_deeply_nested_multivalued_attribute(self):
+        # html5lib can set the attributes of the same tag many times
+        # as it rearranges the tree. This has caused problems with
+        # multivalued attributes.
+        markup = '<table><div><div class="css"></div></div></table>'
+        soup = self.soup(markup)
+        self.assertEqual(["css"], soup.div.div['class'])
+
+    def test_angle_brackets_in_attribute_values_are_escaped(self):
+        self.assertSoupEquals('<a b="<a>"></a>', '<a b="&lt;a&gt;"></a>')
+
+    def test_entities_in_attributes_converted_to_unicode(self):
+        expect = u'<p id="pi\N{LATIN SMALL LETTER N WITH TILDE}ata"></p>'
+        self.assertSoupEquals('<p id="pi&#241;ata"></p>', expect)
+        self.assertSoupEquals('<p id="pi&#xf1;ata"></p>', expect)
+        self.assertSoupEquals('<p id="pi&#Xf1;ata"></p>', expect)
+        self.assertSoupEquals('<p id="pi&ntilde;ata"></p>', expect)
+
+    def test_entities_in_text_converted_to_unicode(self):
+        expect = u'<p>pi\N{LATIN SMALL LETTER N WITH TILDE}ata</p>'
+        self.assertSoupEquals("<p>pi&#241;ata</p>", expect)
+        self.assertSoupEquals("<p>pi&#xf1;ata</p>", expect)
+        self.assertSoupEquals("<p>pi&#Xf1;ata</p>", expect)
+        self.assertSoupEquals("<p>pi&ntilde;ata</p>", expect)
+
+    def test_quot_entity_converted_to_quotation_mark(self):
+        self.assertSoupEquals("<p>I said &quot;good day!&quot;</p>",
+                              '<p>I said "good day!"</p>')
+
+    def test_out_of_range_entity(self):
+        expect = u"\N{REPLACEMENT CHARACTER}"
+        self.assertSoupEquals("&#10000000000000;", expect)
+        self.assertSoupEquals("&#x10000000000000;", expect)
+        self.assertSoupEquals("&#1000000000;", expect)
+
+    def test_multipart_strings(self):
+        "Mostly to prevent a recurrence of a bug in the html5lib treebuilder."
+        soup = self.soup("<html><h2>\nfoo</h2><p></p></html>")
+        self.assertEqual("p", soup.h2.string.next_element.name)
+        self.assertEqual("p", soup.p.name)
+
+    def test_basic_namespaces(self):
+        """Parsers don't need to *understand* namespaces, but at the
+        very least they should not choke on namespaces or lose
+        data."""
+
+        markup = b'<html xmlns="http://www.w3.org/1999/xhtml" xmlns:mathml="http://www.w3.org/1998/Math/MathML" xmlns:svg="http://www.w3.org/2000/svg"><head></head><body><mathml:msqrt>4</mathml:msqrt><b svg:fill="red"></b></body></html>'
+        soup = self.soup(markup)
+        self.assertEqual(markup, soup.encode())
+        html = soup.html
+        self.assertEqual('http://www.w3.org/1999/xhtml', soup.html['xmlns'])
+        self.assertEqual(
+            'http://www.w3.org/1998/Math/MathML', soup.html['xmlns:mathml'])
+        self.assertEqual(
+            'http://www.w3.org/2000/svg', soup.html['xmlns:svg'])
+
+    def test_multivalued_attribute_value_becomes_list(self):
+        markup = b'<a class="foo bar">'
+        soup = self.soup(markup)
+        self.assertEqual(['foo', 'bar'], soup.a['class'])
+
+    #
+    # Generally speaking, tests below this point are more tests of
+    # Beautiful Soup than tests of the tree builders. But parsers are
+    # weird, so we run these tests separately for every tree builder
+    # to detect any differences between them.
+    #
+
+    def test_can_parse_unicode_document(self):
+        # A seemingly innocuous document... but it's in Unicode! And
+        # it contains characters that can't be represented in the
+        # encoding found in the  declaration! The horror!
+        markup = u'<html><head><meta encoding="euc-jp"></head><body>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</body>'
+        soup = self.soup(markup)
+        self.assertEqual(u'Sacr\xe9 bleu!', soup.body.string)
+
+    def test_soupstrainer(self):
+        """Parsers should be able to work with SoupStrainers."""
+        strainer = SoupStrainer("b")
+        soup = self.soup("A <b>bold</b> <meta/> <i>statement</i>",
+                         parse_only=strainer)
+        self.assertEqual(soup.decode(), "<b>bold</b>")
+
+    def test_single_quote_attribute_values_become_double_quotes(self):
+        self.assertSoupEquals("<foo attr='bar'></foo>",
+                              '<foo attr="bar"></foo>')
+
+    def test_attribute_values_with_nested_quotes_are_left_alone(self):
+        text = """<foo attr='bar "brawls" happen'>a</foo>"""
+        self.assertSoupEquals(text)
+
+    def test_attribute_values_with_double_nested_quotes_get_quoted(self):
+        text = """<foo attr='bar "brawls" happen'>a</foo>"""
+        soup = self.soup(text)
+        soup.foo['attr'] = 'Brawls happen at "Bob\'s Bar"'
+        self.assertSoupEquals(
+            soup.foo.decode(),
+            """<foo attr="Brawls happen at &quot;Bob\'s Bar&quot;">a</foo>""")
+
+    def test_ampersand_in_attribute_value_gets_escaped(self):
+        self.assertSoupEquals('<this is="really messed up & stuff"></this>',
+                              '<this is="really messed up &amp; stuff"></this>')
+
+        self.assertSoupEquals(
+            '<a href="http://example.org?a=1&b=2;3">foo</a>',
+            '<a href="http://example.org?a=1&amp;b=2;3">foo</a>')
+
+    def test_escaped_ampersand_in_attribute_value_is_left_alone(self):
+        self.assertSoupEquals('<a href="http://example.org?a=1&amp;b=2;3"></a>')
+
+    def test_entities_in_strings_converted_during_parsing(self):
+        # Both XML and HTML entities are converted to Unicode characters
+        # during parsing.
+        text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
+        expected = u"<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>"
+        self.assertSoupEquals(text, expected)
+
+    def test_smart_quotes_converted_on_the_way_in(self):
+        # Microsoft smart quotes are converted to Unicode characters during
+        # parsing.
+        quote = b"<p>\x91Foo\x92</p>"
+        soup = self.soup(quote)
+        self.assertEqual(
+            soup.p.string,
+            u"\N{LEFT SINGLE QUOTATION MARK}Foo\N{RIGHT SINGLE QUOTATION MARK}")
+
+    def test_non_breaking_spaces_converted_on_the_way_in(self):
+        soup = self.soup("<a>&nbsp;&nbsp;</a>")
+        self.assertEqual(soup.a.string, u"\N{NO-BREAK SPACE}" * 2)
+
+    def test_entities_converted_on_the_way_out(self):
+        text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
+        expected = u"<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>".encode("utf-8")
+        soup = self.soup(text)
+        self.assertEqual(soup.p.encode("utf-8"), expected)
+
+    def test_real_iso_latin_document(self):
+        # Smoke test of interrelated functionality, using an
+        # easy-to-understand document.
+
+        # Here it is in Unicode. Note that it claims to be in ISO-Latin-1.
+        unicode_html = u'<html><head><meta content="text/html; charset=ISO-Latin-1" http-equiv="Content-type"/></head><body><p>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</p></body></html>'
+
+        # That's because we're going to encode it into ISO-Latin-1, and use
+        # that to test.
+        iso_latin_html = unicode_html.encode("iso-8859-1")
+
+        # Parse the ISO-Latin-1 HTML.
+        soup = self.soup(iso_latin_html)
+        # Encode it to UTF-8.
+        result = soup.encode("utf-8")
+
+        # What do we expect the result to look like? Well, it would
+        # look like unicode_html, except that the META tag would say
+        # UTF-8 instead of ISO-Latin-1.
+        expected = unicode_html.replace("ISO-Latin-1", "utf-8")
+
+        # And, of course, it would be in UTF-8, not Unicode.
+        expected = expected.encode("utf-8")
+
+        # Ta-da!
+        self.assertEqual(result, expected)
+
+    def test_real_shift_jis_document(self):
+        # Smoke test to make sure the parser can handle a document in
+        # Shift-JIS encoding, without choking.
+        shift_jis_html = (
+            b'<html><head></head><body><pre>'
+            b'\x82\xb1\x82\xea\x82\xcdShift-JIS\x82\xc5\x83R\x81[\x83f'
+            b'\x83B\x83\x93\x83O\x82\xb3\x82\xea\x82\xbd\x93\xfa\x96{\x8c'
+            b'\xea\x82\xcc\x83t\x83@\x83C\x83\x8b\x82\xc5\x82\xb7\x81B'
+            b'</pre></body></html>')
+        unicode_html = shift_jis_html.decode("shift-jis")
+        soup = self.soup(unicode_html)
+
+        # Make sure the parse tree is correctly encoded to various
+        # encodings.
+        self.assertEqual(soup.encode("utf-8"), unicode_html.encode("utf-8"))
+        self.assertEqual(soup.encode("euc_jp"), unicode_html.encode("euc_jp"))
+
+    def test_real_hebrew_document(self):
+        # A real-world test to make sure we can convert ISO-8859-9 (a
+        # Hebrew encoding) to UTF-8.
+        hebrew_document = b'<html><head><title>Hebrew (ISO 8859-8) in Visual Directionality</title></head><body><h1>Hebrew (ISO 8859-8) in Visual Directionality</h1>\xed\xe5\xec\xf9</body></html>'
+        soup = self.soup(
+            hebrew_document, from_encoding="iso8859-8")
+        self.assertEqual(soup.original_encoding, 'iso8859-8')
+        self.assertEqual(
+            soup.encode('utf-8'),
+            hebrew_document.decode("iso8859-8").encode("utf-8"))
+
+    def test_meta_tag_reflects_current_encoding(self):
+        # Here's the <meta> tag saying that a document is
+        # encoded in Shift-JIS.
+        meta_tag = ('<meta content="text/html; charset=x-sjis" '
+                    'http-equiv="Content-type"/>')
+
+        # Here's a document incorporating that meta tag.
+        shift_jis_html = (
+            '<html><head>\n%s\n'
+            '<meta http-equiv="Content-language" content="ja"/>'
+            '</head><body>Shift-JIS markup goes here.') % meta_tag
+        soup = self.soup(shift_jis_html)
+
+        # Parse the document, and the charset is seemingly unaffected.
+        parsed_meta = soup.find('meta', {'http-equiv': 'Content-type'})
+        content = parsed_meta['content']
+        self.assertEqual('text/html; charset=x-sjis', content)
+
+        # But that value is actually a ContentMetaAttributeValue object.
+        self.assertTrue(isinstance(content, ContentMetaAttributeValue))
+
+        # And it will take on a value that reflects its current
+        # encoding.
+        self.assertEqual('text/html; charset=utf8', content.encode("utf8"))
+
+        # For the rest of the story, see TestSubstitutions in
+        # test_tree.py.
+
+    def test_html5_style_meta_tag_reflects_current_encoding(self):
+        # Here's the <meta> tag saying that a document is
+        # encoded in Shift-JIS.
+        meta_tag = ('<meta id="encoding" charset="x-sjis" />')
+
+        # Here's a document incorporating that meta tag.
+        shift_jis_html = (
+            '<html><head>\n%s\n'
+            '<meta http-equiv="Content-language" content="ja"/>'
+            '</head><body>Shift-JIS markup goes here.') % meta_tag
+        soup = self.soup(shift_jis_html)
+
+        # Parse the document, and the charset is seemingly unaffected.
+        parsed_meta = soup.find('meta', id="encoding")
+        charset = parsed_meta['charset']
+        self.assertEqual('x-sjis', charset)
+
+        # But that value is actually a CharsetMetaAttributeValue object.
+        self.assertTrue(isinstance(charset, CharsetMetaAttributeValue))
+
+        # And it will take on a value that reflects its current
+        # encoding.
+        self.assertEqual('utf8', charset.encode("utf8"))
+
+    def test_tag_with_no_attributes_can_have_attributes_added(self):
+        data = self.soup("<a>text</a>")
+        data.a['foo'] = 'bar'
+        self.assertEqual('<a foo="bar">text</a>', data.a.decode())
+
+class XMLTreeBuilderSmokeTest(object):
+
+    def test_docstring_generated(self):
+        soup = self.soup("<root/>")
+        self.assertEqual(
+            soup.encode(), b'<?xml version="1.0" encoding="utf-8"?>\n<root/>')
+
+    def test_real_xhtml_document(self):
+        """A real XHTML document should come out *exactly* the same as it went in."""
+        markup = b"""<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
+<html xmlns="http://www.w3.org/1999/xhtml">
+<head><title>Hello.</title></head>
+<body>Goodbye.</body>
+</html>"""
+        soup = self.soup(markup)
+        self.assertEqual(
+            soup.encode("utf-8"), markup)
+
+    def test_formatter_processes_script_tag_for_xml_documents(self):
+        doc = """
+  <script type="text/javascript">
+  </script>
+"""
+        soup = BeautifulSoup(doc, "xml")
+        # lxml would have stripped this while parsing, but we can add
+        # it later.
+        soup.script.string = 'console.log("< < hey > > ");'
+        encoded = soup.encode()
+        self.assertTrue(b"&lt; &lt; hey &gt; &gt;" in encoded)
+
+    def test_can_parse_unicode_document(self):
+        markup = u'<?xml version="1.0" encoding="euc-jp"><root>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</root>'
+        soup = self.soup(markup)
+        self.assertEqual(u'Sacr\xe9 bleu!', soup.root.string)
+
+    def test_popping_namespaced_tag(self):
+        markup = '<rss xmlns:dc="foo"><dc:creator>b</dc:creator><dc:date>2012-07-02T20:33:42Z</dc:date><dc:rights>c</dc:rights><image>d</image></rss>'
+        soup = self.soup(markup)
+        self.assertEqual(
+            unicode(soup.rss), markup)
+
+    def test_docstring_includes_correct_encoding(self):
+        soup = self.soup("<root/>")
+        self.assertEqual(
+            soup.encode("latin1"),
+            b'<?xml version="1.0" encoding="latin1"?>\n<root/>')
+
+    def test_large_xml_document(self):
+        """A large XML document should come out the same as it went in."""
+        markup = (b'<?xml version="1.0" encoding="utf-8"?>\n<root>'
+                  + b'0' * (2**12)
+                  + b'</root>')
+        soup = self.soup(markup)
+        self.assertEqual(soup.encode("utf-8"), markup)
+
+
+    def test_tags_are_empty_element_if_and_only_if_they_are_empty(self):
+        self.assertSoupEquals("<p>", "<p/>")
+        self.assertSoupEquals("<p>foo</p>")
+
+    def test_namespaces_are_preserved(self):
+        markup = '<root xmlns:a="http://example.com/" xmlns:b="http://example.net/"><a:foo>This tag is in the a namespace</a:foo><b:foo>This tag is in the b namespace</b:foo></root>'
+        soup = self.soup(markup)
+        root = soup.root
+        self.assertEqual("http://example.com/", root['xmlns:a'])
+        self.assertEqual("http://example.net/", root['xmlns:b'])
+
+    def test_closing_namespaced_tag(self):
+        markup = '<p xmlns:dc="http://purl.org/dc/elements/1.1/"><dc:date>20010504</dc:date></p>'
+        soup = self.soup(markup)
+        self.assertEqual(unicode(soup.p), markup)
+
+    def test_namespaced_attributes(self):
+        markup = '<foo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><bar xsi:schemaLocation="http://www.example.com"/></foo>'
+        soup = self.soup(markup)
+        self.assertEqual(unicode(soup.foo), markup)
+
+    def test_namespaced_attributes_xml_namespace(self):
+        markup = '<foo xml:lang="fr">bar</foo>'
+        soup = self.soup(markup)
+        self.assertEqual(unicode(soup.foo), markup)
+
+class HTML5TreeBuilderSmokeTest(HTMLTreeBuilderSmokeTest):
+    """Smoke test for a tree builder that supports HTML5."""
+
+    def test_real_xhtml_document(self):
+        # Since XHTML is not HTML5, HTML5 parsers are not tested to handle
+        # XHTML documents in any particular way.
+        pass
+
+    def test_html_tags_have_namespace(self):
+        markup = "<a>"
+        soup = self.soup(markup)
+        self.assertEqual("http://www.w3.org/1999/xhtml", soup.a.namespace)
+
+    def test_svg_tags_have_namespace(self):
+        markup = '<svg><circle/></svg>'
+        soup = self.soup(markup)
+        namespace = "http://www.w3.org/2000/svg"
+        self.assertEqual(namespace, soup.svg.namespace)
+        self.assertEqual(namespace, soup.circle.namespace)
+
+
+    def test_mathml_tags_have_namespace(self):
+        markup = '<math><msqrt>5</msqrt></math>'
+        soup = self.soup(markup)
+        namespace = 'http://www.w3.org/1998/Math/MathML'
+        self.assertEqual(namespace, soup.math.namespace)
+        self.assertEqual(namespace, soup.msqrt.namespace)
+
+    def test_xml_declaration_becomes_comment(self):
+        markup = '<?xml version="1.0" encoding="utf-8"?><html></html>'
+        soup = self.soup(markup)
+        self.assertTrue(isinstance(soup.contents[0], Comment))
+        self.assertEqual(soup.contents[0], '?xml version="1.0" encoding="utf-8"?')
+        self.assertEqual("html", soup.contents[0].next_element.name)
+
+def skipIf(condition, reason):
+   def nothing(test, *args, **kwargs):
+       return None
+
+   def decorator(test_item):
+       if condition:
+           return nothing
+       else:
+           return test_item
+
+   return decorator
diff --git a/lib/bs4/tests/__init__.py b/lib/bs4/tests/__init__.py
new file mode 100644
index 0000000..142c8cc
--- /dev/null
+++ b/lib/bs4/tests/__init__.py
@@ -0,0 +1 @@
+"The beautifulsoup tests."
diff --git a/lib/bs4/tests/test_builder_registry.py b/lib/bs4/tests/test_builder_registry.py
new file mode 100644
index 0000000..92ad10f
--- /dev/null
+++ b/lib/bs4/tests/test_builder_registry.py
@@ -0,0 +1,141 @@
+"""Tests of the builder registry."""
+
+import unittest
+
+from bs4 import BeautifulSoup
+from bs4.builder import (
+    builder_registry as registry,
+    HTMLParserTreeBuilder,
+    TreeBuilderRegistry,
+)
+
+try:
+    from bs4.builder import HTML5TreeBuilder
+    HTML5LIB_PRESENT = True
+except ImportError:
+    HTML5LIB_PRESENT = False
+
+try:
+    from bs4.builder import (
+        LXMLTreeBuilderForXML,
+        LXMLTreeBuilder,
+        )
+    LXML_PRESENT = True
+except ImportError:
+    LXML_PRESENT = False
+
+
+class BuiltInRegistryTest(unittest.TestCase):
+    """Test the built-in registry with the default builders registered."""
+
+    def test_combination(self):
+        if LXML_PRESENT:
+            self.assertEqual(registry.lookup('fast', 'html'),
+                             LXMLTreeBuilder)
+
+        if LXML_PRESENT:
+            self.assertEqual(registry.lookup('permissive', 'xml'),
+                             LXMLTreeBuilderForXML)
+        self.assertEqual(registry.lookup('strict', 'html'),
+                          HTMLParserTreeBuilder)
+        if HTML5LIB_PRESENT:
+            self.assertEqual(registry.lookup('html5lib', 'html'),
+                              HTML5TreeBuilder)
+
+    def test_lookup_by_markup_type(self):
+        if LXML_PRESENT:
+            self.assertEqual(registry.lookup('html'), LXMLTreeBuilder)
+            self.assertEqual(registry.lookup('xml'), LXMLTreeBuilderForXML)
+        else:
+            self.assertEqual(registry.lookup('xml'), None)
+            if HTML5LIB_PRESENT:
+                self.assertEqual(registry.lookup('html'), HTML5TreeBuilder)
+            else:
+                self.assertEqual(registry.lookup('html'), HTMLParserTreeBuilder)
+
+    def test_named_library(self):
+        if LXML_PRESENT:
+            self.assertEqual(registry.lookup('lxml', 'xml'),
+                             LXMLTreeBuilderForXML)
+            self.assertEqual(registry.lookup('lxml', 'html'),
+                             LXMLTreeBuilder)
+        if HTML5LIB_PRESENT:
+            self.assertEqual(registry.lookup('html5lib'),
+                              HTML5TreeBuilder)
+
+        self.assertEqual(registry.lookup('html.parser'),
+                          HTMLParserTreeBuilder)
+
+    def test_beautifulsoup_constructor_does_lookup(self):
+        # You can pass in a string.
+        BeautifulSoup("", features="html")
+        # Or a list of strings.
+        BeautifulSoup("", features=["html", "fast"])
+
+        # You'll get an exception if BS can't find an appropriate
+        # builder.
+        self.assertRaises(ValueError, BeautifulSoup,
+                          "", features="no-such-feature")
+
+class RegistryTest(unittest.TestCase):
+    """Test the TreeBuilderRegistry class in general."""
+
+    def setUp(self):
+        self.registry = TreeBuilderRegistry()
+
+    def builder_for_features(self, *feature_list):
+        cls = type('Builder_' + '_'.join(feature_list),
+                   (object,), {'features' : feature_list})
+
+        self.registry.register(cls)
+        return cls
+
+    def test_register_with_no_features(self):
+        builder = self.builder_for_features()
+
+        # Since the builder advertises no features, you can't find it
+        # by looking up features.
+        self.assertEqual(self.registry.lookup('foo'), None)
+
+        # But you can find it by doing a lookup with no features, if
+        # this happens to be the only registered builder.
+        self.assertEqual(self.registry.lookup(), builder)
+
+    def test_register_with_features_makes_lookup_succeed(self):
+        builder = self.builder_for_features('foo', 'bar')
+        self.assertEqual(self.registry.lookup('foo'), builder)
+        self.assertEqual(self.registry.lookup('bar'), builder)
+
+    def test_lookup_fails_when_no_builder_implements_feature(self):
+        builder = self.builder_for_features('foo', 'bar')
+        self.assertEqual(self.registry.lookup('baz'), None)
+
+    def test_lookup_gets_most_recent_registration_when_no_feature_specified(self):
+        builder1 = self.builder_for_features('foo')
+        builder2 = self.builder_for_features('bar')
+        self.assertEqual(self.registry.lookup(), builder2)
+
+    def test_lookup_fails_when_no_tree_builders_registered(self):
+        self.assertEqual(self.registry.lookup(), None)
+
+    def test_lookup_gets_most_recent_builder_supporting_all_features(self):
+        has_one = self.builder_for_features('foo')
+        has_the_other = self.builder_for_features('bar')
+        has_both_early = self.builder_for_features('foo', 'bar', 'baz')
+        has_both_late = self.builder_for_features('foo', 'bar', 'quux')
+        lacks_one = self.builder_for_features('bar')
+        has_the_other = self.builder_for_features('foo')
+
+        # There are two builders featuring 'foo' and 'bar', but
+        # the one that also features 'quux' was registered later.
+        self.assertEqual(self.registry.lookup('foo', 'bar'),
+                          has_both_late)
+
+        # There is only one builder featuring 'foo', 'bar', and 'baz'.
+        self.assertEqual(self.registry.lookup('foo', 'bar', 'baz'),
+                          has_both_early)
+
+    def test_lookup_fails_when_cannot_reconcile_requested_features(self):
+        builder1 = self.builder_for_features('foo', 'bar')
+        builder2 = self.builder_for_features('foo', 'baz')
+        self.assertEqual(self.registry.lookup('bar', 'baz'), None)
diff --git a/lib/bs4/tests/test_docs.py b/lib/bs4/tests/test_docs.py
new file mode 100644
index 0000000..5b9f677
--- /dev/null
+++ b/lib/bs4/tests/test_docs.py
@@ -0,0 +1,36 @@
+"Test harness for doctests."
+
+# pylint: disable-msg=E0611,W0142
+
+__metaclass__ = type
+__all__ = [
+    'additional_tests',
+    ]
+
+import atexit
+import doctest
+import os
+#from pkg_resources import (
+#    resource_filename, resource_exists, resource_listdir, cleanup_resources)
+import unittest
+
+DOCTEST_FLAGS = (
+    doctest.ELLIPSIS |
+    doctest.NORMALIZE_WHITESPACE |
+    doctest.REPORT_NDIFF)
+
+
+# def additional_tests():
+#     "Run the doc tests (README.txt and docs/*, if any exist)"
+#     doctest_files = [
+#         os.path.abspath(resource_filename('bs4', 'README.txt'))]
+#     if resource_exists('bs4', 'docs'):
+#         for name in resource_listdir('bs4', 'docs'):
+#             if name.endswith('.txt'):
+#                 doctest_files.append(
+#                     os.path.abspath(
+#                         resource_filename('bs4', 'docs/%s' % name)))
+#     kwargs = dict(module_relative=False, optionflags=DOCTEST_FLAGS)
+#     atexit.register(cleanup_resources)
+#     return unittest.TestSuite((
+#         doctest.DocFileSuite(*doctest_files, **kwargs)))
diff --git a/lib/bs4/tests/test_html5lib.py b/lib/bs4/tests/test_html5lib.py
new file mode 100644
index 0000000..594c3e1
--- /dev/null
+++ b/lib/bs4/tests/test_html5lib.py
@@ -0,0 +1,85 @@
+"""Tests to ensure that the html5lib tree builder generates good trees."""
+
+import warnings
+
+try:
+    from bs4.builder import HTML5TreeBuilder
+    HTML5LIB_PRESENT = True
+except ImportError, e:
+    HTML5LIB_PRESENT = False
+from bs4.element import SoupStrainer
+from bs4.testing import (
+    HTML5TreeBuilderSmokeTest,
+    SoupTest,
+    skipIf,
+)
+
+@skipIf(
+    not HTML5LIB_PRESENT,
+    "html5lib seems not to be present, not testing its tree builder.")
+class HTML5LibBuilderSmokeTest(SoupTest, HTML5TreeBuilderSmokeTest):
+    """See ``HTML5TreeBuilderSmokeTest``."""
+
+    @property
+    def default_builder(self):
+        return HTML5TreeBuilder()
+
+    def test_soupstrainer(self):
+        # The html5lib tree builder does not support SoupStrainers.
+        strainer = SoupStrainer("b")
+        markup = "<p>A <b>bold</b> statement.</p>"
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup(markup, parse_only=strainer)
+        self.assertEqual(
+            soup.decode(), self.document_for(markup))
+
+        self.assertTrue(
+            "the html5lib tree builder doesn't support parse_only" in
+            str(w[0].message))
+
+    def test_correctly_nested_tables(self):
+        """html5lib inserts <tbody> tags where other parsers don't."""
+        markup = ('<table id="1">'
+                  '<tr>'
+                  "<td>Here's another table:"
+                  '<table id="2">'
+                  '<tr><td>foo</td></tr>'
+                  '</table></td>')
+
+        self.assertSoupEquals(
+            markup,
+            '<table id="1"><tbody><tr><td>Here\'s another table:'
+            '<table id="2"><tbody><tr><td>foo</td></tr></tbody></table>'
+            '</td></tr></tbody></table>')
+
+        self.assertSoupEquals(
+            "<table><thead><tr><td>Foo</td></tr></thead>"
+            "<tbody><tr><td>Bar</td></tr></tbody>"
+            "<tfoot><tr><td>Baz</td></tr></tfoot></table>")
+
+    def test_xml_declaration_followed_by_doctype(self):
+        markup = '''<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html>
+<html>
+  <head>
+  </head>
+  <body>
+   <p>foo</p>
+  </body>
+</html>'''
+        soup = self.soup(markup)
+        # Verify that we can reach the <p> tag; this means the tree is connected.
+        self.assertEqual(b"<p>foo</p>", soup.p.encode())
+
+    def test_reparented_markup(self):
+        markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>'
+        soup = self.soup(markup)
+        self.assertEqual(u"<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p></body>", soup.body.decode())
+        self.assertEqual(2, len(soup.find_all('p')))
+
+
+    def test_reparented_markup_ends_with_whitespace(self):
+        markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>\n'
+        soup = self.soup(markup)
+        self.assertEqual(u"<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p>\n</body>", soup.body.decode())
+        self.assertEqual(2, len(soup.find_all('p')))
diff --git a/lib/bs4/tests/test_htmlparser.py b/lib/bs4/tests/test_htmlparser.py
new file mode 100644
index 0000000..bcb5ed2
--- /dev/null
+++ b/lib/bs4/tests/test_htmlparser.py
@@ -0,0 +1,19 @@
+"""Tests to ensure that the html.parser tree builder generates good
+trees."""
+
+from bs4.testing import SoupTest, HTMLTreeBuilderSmokeTest
+from bs4.builder import HTMLParserTreeBuilder
+
+class HTMLParserTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
+
+    @property
+    def default_builder(self):
+        return HTMLParserTreeBuilder()
+
+    def test_namespaced_system_doctype(self):
+        # html.parser can't handle namespaced doctypes, so skip this one.
+        pass
+
+    def test_namespaced_public_doctype(self):
+        # html.parser can't handle namespaced doctypes, so skip this one.
+        pass
diff --git a/lib/bs4/tests/test_lxml.py b/lib/bs4/tests/test_lxml.py
new file mode 100644
index 0000000..2b2e9b7
--- /dev/null
+++ b/lib/bs4/tests/test_lxml.py
@@ -0,0 +1,91 @@
+"""Tests to ensure that the lxml tree builder generates good trees."""
+
+import re
+import warnings
+
+try:
+    import lxml.etree
+    LXML_PRESENT = True
+    LXML_VERSION = lxml.etree.LXML_VERSION
+except ImportError, e:
+    LXML_PRESENT = False
+    LXML_VERSION = (0,)
+
+if LXML_PRESENT:
+    from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
+
+from bs4 import (
+    BeautifulSoup,
+    BeautifulStoneSoup,
+    )
+from bs4.element import Comment, Doctype, SoupStrainer
+from bs4.testing import skipIf
+from bs4.tests import test_htmlparser
+from bs4.testing import (
+    HTMLTreeBuilderSmokeTest,
+    XMLTreeBuilderSmokeTest,
+    SoupTest,
+    skipIf,
+)
+
+@skipIf(
+    not LXML_PRESENT,
+    "lxml seems not to be present, not testing its tree builder.")
+class LXMLTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
+    """See ``HTMLTreeBuilderSmokeTest``."""
+
+    @property
+    def default_builder(self):
+        return LXMLTreeBuilder()
+
+    def test_out_of_range_entity(self):
+        self.assertSoupEquals(
+            "<p>foo&#10000000000000;bar</p>", "<p>foobar</p>")
+        self.assertSoupEquals(
+            "<p>foo&#x10000000000000;bar</p>", "<p>foobar</p>")
+        self.assertSoupEquals(
+            "<p>foo&#1000000000;bar</p>", "<p>foobar</p>")
+
+    # In lxml < 2.3.5, an empty doctype causes a segfault. Skip this
+    # test if an old version of lxml is installed.
+
+    @skipIf(
+        not LXML_PRESENT or LXML_VERSION < (2,3,5,0),
+        "Skipping doctype test for old version of lxml to avoid segfault.")
+    def test_empty_doctype(self):
+        soup = self.soup("<!DOCTYPE>")
+        doctype = soup.contents[0]
+        self.assertEqual("", doctype.strip())
+
+    def test_beautifulstonesoup_is_xml_parser(self):
+        # Make sure that the deprecated BSS class uses an xml builder
+        # if one is installed.
+        with warnings.catch_warnings(record=True) as w:
+            soup = BeautifulStoneSoup("<b />")
+        self.assertEqual(u"<b/>", unicode(soup.b))
+        self.assertTrue("BeautifulStoneSoup class is deprecated" in str(w[0].message))
+
+    def test_real_xhtml_document(self):
+        """lxml strips the XML definition from an XHTML doc, which is fine."""
+        markup = b"""<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
+<html xmlns="http://www.w3.org/1999/xhtml">
+<head><title>Hello.</title></head>
+<body>Goodbye.</body>
+</html>"""
+        soup = self.soup(markup)
+        self.assertEqual(
+            soup.encode("utf-8").replace(b"\n", b''),
+            markup.replace(b'\n', b'').replace(
+                b'<?xml version="1.0" encoding="utf-8"?>', b''))
+
+
+@skipIf(
+    not LXML_PRESENT,
+    "lxml seems not to be present, not testing its XML tree builder.")
+class LXMLXMLTreeBuilderSmokeTest(SoupTest, XMLTreeBuilderSmokeTest):
+    """See ``HTMLTreeBuilderSmokeTest``."""
+
+    @property
+    def default_builder(self):
+        return LXMLTreeBuilderForXML()
diff --git a/lib/bs4/tests/test_soup.py b/lib/bs4/tests/test_soup.py
new file mode 100644
index 0000000..47ac245
--- /dev/null
+++ b/lib/bs4/tests/test_soup.py
@@ -0,0 +1,434 @@
+# -*- coding: utf-8 -*-
+"""Tests of Beautiful Soup as a whole."""
+
+import logging
+import unittest
+import sys
+import tempfile
+
+from bs4 import (
+    BeautifulSoup,
+    BeautifulStoneSoup,
+)
+from bs4.element import (
+    CharsetMetaAttributeValue,
+    ContentMetaAttributeValue,
+    SoupStrainer,
+    NamespacedAttribute,
+    )
+import bs4.dammit
+from bs4.dammit import (
+    EntitySubstitution,
+    UnicodeDammit,
+)
+from bs4.testing import (
+    SoupTest,
+    skipIf,
+)
+import warnings
+
+try:
+    from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
+    LXML_PRESENT = True
+except ImportError, e:
+    LXML_PRESENT = False
+
+PYTHON_2_PRE_2_7 = (sys.version_info < (2,7))
+PYTHON_3_PRE_3_2 = (sys.version_info[0] == 3 and sys.version_info < (3,2))
+
+class TestConstructor(SoupTest):
+
+    def test_short_unicode_input(self):
+        data = u"<h1>éé</h1>"
+        soup = self.soup(data)
+        self.assertEqual(u"éé", soup.h1.string)
+
+    def test_embedded_null(self):
+        data = u"<h1>foo\0bar</h1>"
+        soup = self.soup(data)
+        self.assertEqual(u"foo\0bar", soup.h1.string)
+
+
+class TestDeprecatedConstructorArguments(SoupTest):
+
+    def test_parseOnlyThese_renamed_to_parse_only(self):
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("<a><b></b></a>", parseOnlyThese=SoupStrainer("b"))
+        msg = str(w[0].message)
+        self.assertTrue("parseOnlyThese" in msg)
+        self.assertTrue("parse_only" in msg)
+        self.assertEqual(b"<b></b>", soup.encode())
+
+    def test_fromEncoding_renamed_to_from_encoding(self):
+        with warnings.catch_warnings(record=True) as w:
+            utf8 = b"\xc3\xa9"
+            soup = self.soup(utf8, fromEncoding="utf8")
+        msg = str(w[0].message)
+        self.assertTrue("fromEncoding" in msg)
+        self.assertTrue("from_encoding" in msg)
+        self.assertEqual("utf8", soup.original_encoding)
+
+    def test_unrecognized_keyword_argument(self):
+        self.assertRaises(
+            TypeError, self.soup, "<a>", no_such_argument=True)
+
+class TestWarnings(SoupTest):
+
+    def test_disk_file_warning(self):
+        filehandle = tempfile.NamedTemporaryFile()
+        filename = filehandle.name
+        try:
+            with warnings.catch_warnings(record=True) as w:
+                soup = self.soup(filename)
+            msg = str(w[0].message)
+            self.assertTrue("looks like a filename" in msg)
+        finally:
+            filehandle.close()
+
+        # The file no longer exists, so Beautiful Soup will no longer issue the warning.
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup(filename)
+        self.assertEqual(0, len(w))
+
+    def test_url_warning(self):
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("http://www.crummy.com/")
+        msg = str(w[0].message)
+        self.assertTrue("looks like a URL" in msg)
+
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("http://www.crummy.com/ is great")
+        self.assertEqual(0, len(w))
+
+class TestSelectiveParsing(SoupTest):
+
+    def test_parse_with_soupstrainer(self):
+        markup = "No<b>Yes</b><a>No<b>Yes <c>Yes</c></b>"
+        strainer = SoupStrainer("b")
+        soup = self.soup(markup, parse_only=strainer)
+        self.assertEqual(soup.encode(), b"<b>Yes</b><b>Yes <c>Yes</c></b>")
+
+
+class TestEntitySubstitution(unittest.TestCase):
+    """Standalone tests of the EntitySubstitution class."""
+    def setUp(self):
+        self.sub = EntitySubstitution
+
+    def test_simple_html_substitution(self):
+        # Unicode characters corresponding to named HTML entites
+        # are substituted, and no others.
+        s = u"foo\u2200\N{SNOWMAN}\u00f5bar"
+        self.assertEqual(self.sub.substitute_html(s),
+                          u"foo&forall;\N{SNOWMAN}&otilde;bar")
+
+    def test_smart_quote_substitution(self):
+        # MS smart quotes are a common source of frustration, so we
+        # give them a special test.
+        quotes = b"\x91\x92foo\x93\x94"
+        dammit = UnicodeDammit(quotes)
+        self.assertEqual(self.sub.substitute_html(dammit.markup),
+                          "&lsquo;&rsquo;foo&ldquo;&rdquo;")
+
+    def test_xml_converstion_includes_no_quotes_if_make_quoted_attribute_is_false(self):
+        s = 'Welcome to "my bar"'
+        self.assertEqual(self.sub.substitute_xml(s, False), s)
+
+    def test_xml_attribute_quoting_normally_uses_double_quotes(self):
+        self.assertEqual(self.sub.substitute_xml("Welcome", True),
+                          '"Welcome"')
+        self.assertEqual(self.sub.substitute_xml("Bob's Bar", True),
+                          '"Bob\'s Bar"')
+
+    def test_xml_attribute_quoting_uses_single_quotes_when_value_contains_double_quotes(self):
+        s = 'Welcome to "my bar"'
+        self.assertEqual(self.sub.substitute_xml(s, True),
+                          "'Welcome to \"my bar\"'")
+
+    def test_xml_attribute_quoting_escapes_single_quotes_when_value_contains_both_single_and_double_quotes(self):
+        s = 'Welcome to "Bob\'s Bar"'
+        self.assertEqual(
+            self.sub.substitute_xml(s, True),
+            '"Welcome to &quot;Bob\'s Bar&quot;"')
+
+    def test_xml_quotes_arent_escaped_when_value_is_not_being_quoted(self):
+        quoted = 'Welcome to "Bob\'s Bar"'
+        self.assertEqual(self.sub.substitute_xml(quoted), quoted)
+
+    def test_xml_quoting_handles_angle_brackets(self):
+        self.assertEqual(
+            self.sub.substitute_xml("foo<bar>"),
+            "foo&lt;bar&gt;")
+
+    def test_xml_quoting_handles_ampersands(self):
+        self.assertEqual(self.sub.substitute_xml("AT&T"), "AT&amp;T")
+
+    def test_xml_quoting_including_ampersands_when_they_are_part_of_an_entity(self):
+        self.assertEqual(
+            self.sub.substitute_xml("&Aacute;T&T"),
+            "&amp;Aacute;T&amp;T")
+
+    def test_xml_quoting_ignoring_ampersands_when_they_are_part_of_an_entity(self):
+        self.assertEqual(
+            self.sub.substitute_xml_containing_entities("&Aacute;T&T"),
+            "&Aacute;T&amp;T")
+
+    def test_quotes_not_html_substituted(self):
+        """There's no need to do this except inside attribute values."""
+        text = 'Bob\'s "bar"'
+        self.assertEqual(self.sub.substitute_html(text), text)
+
+
+class TestEncodingConversion(SoupTest):
+    # Test Beautiful Soup's ability to decode and encode from various
+    # encodings.
+
+    def setUp(self):
+        super(TestEncodingConversion, self).setUp()
+        self.unicode_data = u'<html><head><meta charset="utf-8"/></head><body><foo>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</foo></body></html>'
+        self.utf8_data = self.unicode_data.encode("utf-8")
+        # Just so you know what it looks like.
+        self.assertEqual(
+            self.utf8_data,
+            b'<html><head><meta charset="utf-8"/></head><body><foo>Sacr\xc3\xa9 bleu!</foo></body></html>')
+
+    def test_ascii_in_unicode_out(self):
+        # ASCII input is converted to Unicode. The original_encoding
+        # attribute is set to 'utf-8', a superset of ASCII.
+        chardet = bs4.dammit.chardet_dammit
+        logging.disable(logging.WARNING)
+        try:
+            def noop(str):
+                return None
+            # Disable chardet, which will realize that the ASCII is ASCII.
+            bs4.dammit.chardet_dammit = noop
+            ascii = b"<foo>a</foo>"
+            soup_from_ascii = self.soup(ascii)
+            unicode_output = soup_from_ascii.decode()
+            self.assertTrue(isinstance(unicode_output, unicode))
+            self.assertEqual(unicode_output, self.document_for(ascii.decode()))
+            self.assertEqual(soup_from_ascii.original_encoding.lower(), "utf-8")
+        finally:
+            logging.disable(logging.NOTSET)
+            bs4.dammit.chardet_dammit = chardet
+
+    def test_unicode_in_unicode_out(self):
+        # Unicode input is left alone. The original_encoding attribute
+        # is not set.
+        soup_from_unicode = self.soup(self.unicode_data)
+        self.assertEqual(soup_from_unicode.decode(), self.unicode_data)
+        self.assertEqual(soup_from_unicode.foo.string, u'Sacr\xe9 bleu!')
+        self.assertEqual(soup_from_unicode.original_encoding, None)
+
+    def test_utf8_in_unicode_out(self):
+        # UTF-8 input is converted to Unicode. The original_encoding
+        # attribute is set.
+        soup_from_utf8 = self.soup(self.utf8_data)
+        self.assertEqual(soup_from_utf8.decode(), self.unicode_data)
+        self.assertEqual(soup_from_utf8.foo.string, u'Sacr\xe9 bleu!')
+
+    def test_utf8_out(self):
+        # The internal data structures can be encoded as UTF-8.
+        soup_from_unicode = self.soup(self.unicode_data)
+        self.assertEqual(soup_from_unicode.encode('utf-8'), self.utf8_data)
+
+    @skipIf(
+        PYTHON_2_PRE_2_7 or PYTHON_3_PRE_3_2,
+        "Bad HTMLParser detected; skipping test of non-ASCII characters in attribute name.")
+    def test_attribute_name_containing_unicode_characters(self):
+        markup = u'<div><a \N{SNOWMAN}="snowman"></a></div>'
+        self.assertEqual(self.soup(markup).div.encode("utf8"), markup.encode("utf8"))
+
+class TestUnicodeDammit(unittest.TestCase):
+    """Standalone tests of UnicodeDammit."""
+
+    def test_unicode_input(self):
+        markup = u"I'm already Unicode! \N{SNOWMAN}"
+        dammit = UnicodeDammit(markup)
+        self.assertEqual(dammit.unicode_markup, markup)
+
+    def test_smart_quotes_to_unicode(self):
+        markup = b"<foo>\x91\x92\x93\x94</foo>"
+        dammit = UnicodeDammit(markup)
+        self.assertEqual(
+            dammit.unicode_markup, u"<foo>\u2018\u2019\u201c\u201d</foo>")
+
+    def test_smart_quotes_to_xml_entities(self):
+        markup = b"<foo>\x91\x92\x93\x94</foo>"
+        dammit = UnicodeDammit(markup, smart_quotes_to="xml")
+        self.assertEqual(
+            dammit.unicode_markup, "<foo>&#x2018;&#x2019;&#x201C;&#x201D;</foo>")
+
+    def test_smart_quotes_to_html_entities(self):
+        markup = b"<foo>\x91\x92\x93\x94</foo>"
+        dammit = UnicodeDammit(markup, smart_quotes_to="html")
+        self.assertEqual(
+            dammit.unicode_markup, "<foo>&lsquo;&rsquo;&ldquo;&rdquo;</foo>")
+
+    def test_smart_quotes_to_ascii(self):
+        markup = b"<foo>\x91\x92\x93\x94</foo>"
+        dammit = UnicodeDammit(markup, smart_quotes_to="ascii")
+        self.assertEqual(
+            dammit.unicode_markup, """<foo>''""</foo>""")
+
+    def test_detect_utf8(self):
+        utf8 = b"\xc3\xa9"
+        dammit = UnicodeDammit(utf8)
+        self.assertEqual(dammit.unicode_markup, u'\xe9')
+        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
+
+    def test_convert_hebrew(self):
+        hebrew = b"\xed\xe5\xec\xf9"
+        dammit = UnicodeDammit(hebrew, ["iso-8859-8"])
+        self.assertEqual(dammit.original_encoding.lower(), 'iso-8859-8')
+        self.assertEqual(dammit.unicode_markup, u'\u05dd\u05d5\u05dc\u05e9')
+
+    def test_dont_see_smart_quotes_where_there_are_none(self):
+        utf_8 = b"\343\202\261\343\203\274\343\202\277\343\202\244 Watch"
+        dammit = UnicodeDammit(utf_8)
+        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
+        self.assertEqual(dammit.unicode_markup.encode("utf-8"), utf_8)
+
+    def test_ignore_inappropriate_codecs(self):
+        utf8_data = u"Räksmörgås".encode("utf-8")
+        dammit = UnicodeDammit(utf8_data, ["iso-8859-8"])
+        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
+
+    def test_ignore_invalid_codecs(self):
+        utf8_data = u"Räksmörgås".encode("utf-8")
+        for bad_encoding in ['.utf8', '...', 'utF---16.!']:
+            dammit = UnicodeDammit(utf8_data, [bad_encoding])
+            self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
+
+    def test_detect_html5_style_meta_tag(self):
+
+        for data in (
+            b'<html><meta charset="euc-jp" /></html>',
+            b"<html><meta charset='euc-jp' /></html>",
+            b"<html><meta charset=euc-jp /></html>",
+            b"<html><meta charset=euc-jp/></html>"):
+            dammit = UnicodeDammit(data, is_html=True)
+            self.assertEqual(
+                "euc-jp", dammit.original_encoding)
+
+    def test_last_ditch_entity_replacement(self):
+        # This is a UTF-8 document that contains bytestrings
+        # completely incompatible with UTF-8 (ie. encoded with some other
+        # encoding).
+        #
+        # Since there is no consistent encoding for the document,
+        # Unicode, Dammit will eventually encode the document as UTF-8
+        # and encode the incompatible characters as REPLACEMENT
+        # CHARACTER.
+        #
+        # If chardet is installed, it will detect that the document
+        # can be converted into ISO-8859-1 without errors. This happens
+        # to be the wrong encoding, but it is a consistent encoding, so the
+        # code we're testing here won't run.
+        #
+        # So we temporarily disable chardet if it's present.
+        doc = b"""\357\273\277<?xml version="1.0" encoding="UTF-8"?>
+<html><b>\330\250\330\252\330\261</b>
+<i>\310\322\321\220\312\321\355\344</i></html>"""
+        chardet = bs4.dammit.chardet_dammit
+        logging.disable(logging.WARNING)
+        try:
+            def noop(str):
+                return None
+            bs4.dammit.chardet_dammit = noop
+            dammit = UnicodeDammit(doc)
+            self.assertEqual(True, dammit.contains_replacement_characters)
+            self.assertTrue(u"\ufffd" in dammit.unicode_markup)
+
+            soup = BeautifulSoup(doc, "html.parser")
+            self.assertTrue(soup.contains_replacement_characters)
+        finally:
+            logging.disable(logging.NOTSET)
+            bs4.dammit.chardet_dammit = chardet
+
+    def test_byte_order_mark_removed(self):
+        # A document written in UTF-16LE will have its byte order marker stripped.
+        data = b'\xff\xfe<\x00a\x00>\x00\xe1\x00\xe9\x00<\x00/\x00a\x00>\x00'
+        dammit = UnicodeDammit(data)
+        self.assertEqual(u"<a>áé</a>", dammit.unicode_markup)
+        self.assertEqual("utf-16le", dammit.original_encoding)
+
+    def test_detwingle(self):
+        # Here's a UTF8 document.
+        utf8 = (u"\N{SNOWMAN}" * 3).encode("utf8")
+
+        # Here's a Windows-1252 document.
+        windows_1252 = (
+            u"\N{LEFT DOUBLE QUOTATION MARK}Hi, I like Windows!"
+            u"\N{RIGHT DOUBLE QUOTATION MARK}").encode("windows_1252")
+
+        # Through some unholy alchemy, they've been stuck together.
+        doc = utf8 + windows_1252 + utf8
+
+        # The document can't be turned into UTF-8:
+        self.assertRaises(UnicodeDecodeError, doc.decode, "utf8")
+
+        # Unicode, Dammit thinks the whole document is Windows-1252,
+        # and decodes it into "â˜ƒâ˜ƒâ˜ƒ“Hi, I like Windows!”â˜ƒâ˜ƒâ˜ƒ"
+
+        # But if we run it through fix_embedded_windows_1252, it's fixed:
+
+        fixed = UnicodeDammit.detwingle(doc)
+        self.assertEqual(
+            u"☃☃☃“Hi, I like Windows!”☃☃☃", fixed.decode("utf8"))
+
+    def test_detwingle_ignores_multibyte_characters(self):
+        # Each of these characters has a UTF-8 representation ending
+        # in \x93. \x93 is a smart quote if interpreted as
+        # Windows-1252. But our code knows to skip over multibyte
+        # UTF-8 characters, so they'll survive the process unscathed.
+        for tricky_unicode_char in (
+            u"\N{LATIN SMALL LIGATURE OE}", # 2-byte char '\xc5\x93'
+            u"\N{LATIN SUBSCRIPT SMALL LETTER X}", # 3-byte char '\xe2\x82\x93'
+            u"\xf0\x90\x90\x93", # This is a CJK character, not sure which one.
+            ):
+            input = tricky_unicode_char.encode("utf8")
+            self.assertTrue(input.endswith(b'\x93'))
+            output = UnicodeDammit.detwingle(input)
+            self.assertEqual(output, input)
+
+class TestNamedspacedAttribute(SoupTest):
+
+    def test_name_may_be_none(self):
+        a = NamespacedAttribute("xmlns", None)
+        self.assertEqual(a, "xmlns")
+
+    def test_attribute_is_equivalent_to_colon_separated_string(self):
+        a = NamespacedAttribute("a", "b")
+        self.assertEqual("a:b", a)
+
+    def test_attributes_are_equivalent_if_prefix_and_name_identical(self):
+        a = NamespacedAttribute("a", "b", "c")
+        b = NamespacedAttribute("a", "b", "c")
+        self.assertEqual(a, b)
+
+        # The actual namespace is not considered.
+        c = NamespacedAttribute("a", "b", None)
+        self.assertEqual(a, c)
+
+        # But name and prefix are important.
+        d = NamespacedAttribute("a", "z", "c")
+        self.assertNotEqual(a, d)
+
+        e = NamespacedAttribute("z", "b", "c")
+        self.assertNotEqual(a, e)
+
+
+class TestAttributeValueWithCharsetSubstitution(unittest.TestCase):
+
+    def test_content_meta_attribute_value(self):
+        value = CharsetMetaAttributeValue("euc-jp")
+        self.assertEqual("euc-jp", value)
+        self.assertEqual("euc-jp", value.original_value)
+        self.assertEqual("utf8", value.encode("utf8"))
+
+
+    def test_content_meta_attribute_value(self):
+        value = ContentMetaAttributeValue("text/html; charset=euc-jp")
+        self.assertEqual("text/html; charset=euc-jp", value)
+        self.assertEqual("text/html; charset=euc-jp", value.original_value)
+        self.assertEqual("text/html; charset=utf8", value.encode("utf8"))
diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
new file mode 100644
index 0000000..f8515c0
--- /dev/null
+++ b/lib/bs4/tests/test_tree.py
@@ -0,0 +1,1829 @@
+# -*- coding: utf-8 -*-
+"""Tests for Beautiful Soup's tree traversal methods.
+
+The tree traversal methods are the main advantage of using Beautiful
+Soup over just using a parser.
+
+Different parsers will build different Beautiful Soup trees given the
+same markup, but all Beautiful Soup trees can be traversed with the
+methods tested here.
+"""
+
+import copy
+import pickle
+import re
+import warnings
+from bs4 import BeautifulSoup
+from bs4.builder import (
+    builder_registry,
+    HTMLParserTreeBuilder,
+)
+from bs4.element import (
+    CData,
+    Comment,
+    Doctype,
+    NavigableString,
+    SoupStrainer,
+    Tag,
+)
+from bs4.testing import (
+    SoupTest,
+    skipIf,
+)
+
+XML_BUILDER_PRESENT = (builder_registry.lookup("xml") is not None)
+LXML_PRESENT = (builder_registry.lookup("lxml") is not None)
+
+class TreeTest(SoupTest):
+
+    def assertSelects(self, tags, should_match):
+        """Make sure that the given tags have the correct text.
+
+        This is used in tests that define a bunch of tags, each
+        containing a single string, and then select certain strings by
+        some mechanism.
+        """
+        self.assertEqual([tag.string for tag in tags], should_match)
+
+    def assertSelectsIDs(self, tags, should_match):
+        """Make sure that the given tags have the correct IDs.
+
+        This is used in tests that define a bunch of tags, each
+        containing a single string, and then select certain strings by
+        some mechanism.
+        """
+        self.assertEqual([tag['id'] for tag in tags], should_match)
+
+
+class TestFind(TreeTest):
+    """Basic tests of the find() method.
+
+    find() just calls find_all() with limit=1, so it's not tested all
+    that thouroughly here.
+    """
+
+    def test_find_tag(self):
+        soup = self.soup("<a>1</a><b>2</b><a>3</a><b>4</b>")
+        self.assertEqual(soup.find("b").string, "2")
+
+    def test_unicode_text_find(self):
+        soup = self.soup(u'<h1>Räksmörgås</h1>')
+        self.assertEqual(soup.find(text=u'Räksmörgås'), u'Räksmörgås')
+
+    def test_find_everything(self):
+        """Test an optimization that finds all tags."""
+        soup = self.soup("<a>foo</a><b>bar</b>")
+        self.assertEqual(2, len(soup.find_all()))
+
+    def test_find_everything_with_name(self):
+        """Test an optimization that finds all tags with a given name."""
+        soup = self.soup("<a>foo</a><b>bar</b><a>baz</a>")
+        self.assertEqual(2, len(soup.find_all('a')))
+
+class TestFindAll(TreeTest):
+    """Basic tests of the find_all() method."""
+
+    def test_find_all_text_nodes(self):
+        """You can search the tree for text nodes."""
+        soup = self.soup("<html>Foo<b>bar</b>\xbb</html>")
+        # Exact match.
+        self.assertEqual(soup.find_all(text="bar"), [u"bar"])
+        # Match any of a number of strings.
+        self.assertEqual(
+            soup.find_all(text=["Foo", "bar"]), [u"Foo", u"bar"])
+        # Match a regular expression.
+        self.assertEqual(soup.find_all(text=re.compile('.*')),
+                         [u"Foo", u"bar", u'\xbb'])
+        # Match anything.
+        self.assertEqual(soup.find_all(text=True),
+                         [u"Foo", u"bar", u'\xbb'])
+
+    def test_find_all_limit(self):
+        """You can limit the number of items returned by find_all."""
+        soup = self.soup("<a>1</a><a>2</a><a>3</a><a>4</a><a>5</a>")
+        self.assertSelects(soup.find_all('a', limit=3), ["1", "2", "3"])
+        self.assertSelects(soup.find_all('a', limit=1), ["1"])
+        self.assertSelects(
+            soup.find_all('a', limit=10), ["1", "2", "3", "4", "5"])
+
+        # A limit of 0 means no limit.
+        self.assertSelects(
+            soup.find_all('a', limit=0), ["1", "2", "3", "4", "5"])
+
+    def test_calling_a_tag_is_calling_findall(self):
+        soup = self.soup("<a>1</a><b>2<a id='foo'>3</a></b>")
+        self.assertSelects(soup('a', limit=1), ["1"])
+        self.assertSelects(soup.b(id="foo"), ["3"])
+
+    def test_find_all_with_self_referential_data_structure_does_not_cause_infinite_recursion(self):
+        soup = self.soup("<a></a>")
+        # Create a self-referential list.
+        l = []
+        l.append(l)
+
+        # Without special code in _normalize_search_value, this would cause infinite
+        # recursion.
+        self.assertEqual([], soup.find_all(l))
+
+    def test_find_all_resultset(self):
+        """All find_all calls return a ResultSet"""
+        soup = self.soup("<a></a>")
+        result = soup.find_all("a")
+        self.assertTrue(hasattr(result, "source"))
+
+        result = soup.find_all(True)
+        self.assertTrue(hasattr(result, "source"))
+
+        result = soup.find_all(text="foo")
+        self.assertTrue(hasattr(result, "source"))
+
+
+class TestFindAllBasicNamespaces(TreeTest):
+
+    def test_find_by_namespaced_name(self):
+        soup = self.soup('<mathml:msqrt>4</mathml:msqrt><a svg:fill="red">')
+        self.assertEqual("4", soup.find("mathml:msqrt").string)
+        self.assertEqual("a", soup.find(attrs= { "svg:fill" : "red" }).name)
+
+
+class TestFindAllByName(TreeTest):
+    """Test ways of finding tags by tag name."""
+
+    def setUp(self):
+        super(TreeTest, self).setUp()
+        self.tree =  self.soup("""<a>First tag.</a>
+                                  <b>Second tag.</b>
+                                  <c>Third <a>Nested tag.</a> tag.</c>""")
+
+    def test_find_all_by_tag_name(self):
+        # Find all the <a> tags.
+        self.assertSelects(
+            self.tree.find_all('a'), ['First tag.', 'Nested tag.'])
+
+    def test_find_all_by_name_and_text(self):
+        self.assertSelects(
+            self.tree.find_all('a', text='First tag.'), ['First tag.'])
+
+        self.assertSelects(
+            self.tree.find_all('a', text=True), ['First tag.', 'Nested tag.'])
+
+        self.assertSelects(
+            self.tree.find_all('a', text=re.compile("tag")),
+            ['First tag.', 'Nested tag.'])
+
+
+    def test_find_all_on_non_root_element(self):
+        # You can call find_all on any node, not just the root.
+        self.assertSelects(self.tree.c.find_all('a'), ['Nested tag.'])
+
+    def test_calling_element_invokes_find_all(self):
+        self.assertSelects(self.tree('a'), ['First tag.', 'Nested tag.'])
+
+    def test_find_all_by_tag_strainer(self):
+        self.assertSelects(
+            self.tree.find_all(SoupStrainer('a')),
+            ['First tag.', 'Nested tag.'])
+
+    def test_find_all_by_tag_names(self):
+        self.assertSelects(
+            self.tree.find_all(['a', 'b']),
+            ['First tag.', 'Second tag.', 'Nested tag.'])
+
+    def test_find_all_by_tag_dict(self):
+        self.assertSelects(
+            self.tree.find_all({'a' : True, 'b' : True}),
+            ['First tag.', 'Second tag.', 'Nested tag.'])
+
+    def test_find_all_by_tag_re(self):
+        self.assertSelects(
+            self.tree.find_all(re.compile('^[ab]$')),
+            ['First tag.', 'Second tag.', 'Nested tag.'])
+
+    def test_find_all_with_tags_matching_method(self):
+        # You can define an oracle method that determines whether
+        # a tag matches the search.
+        def id_matches_name(tag):
+            return tag.name == tag.get('id')
+
+        tree = self.soup("""<a id="a">Match 1.</a>
+                            <a id="1">Does not match.</a>
+                            <b id="b">Match 2.</a>""")
+
+        self.assertSelects(
+            tree.find_all(id_matches_name), ["Match 1.", "Match 2."])
+
+
+class TestFindAllByAttribute(TreeTest):
+
+    def test_find_all_by_attribute_name(self):
+        # You can pass in keyword arguments to find_all to search by
+        # attribute.
+        tree = self.soup("""
+                         <a id="first">Matching a.</a>
+                         <a id="second">
+                          Non-matching <b id="first">Matching b.</b>a.
+                         </a>""")
+        self.assertSelects(tree.find_all(id='first'),
+                           ["Matching a.", "Matching b."])
+
+    def test_find_all_by_utf8_attribute_value(self):
+        peace = u"םולש".encode("utf8")
+        data = u'<a title="םולש"></a>'.encode("utf8")
+        soup = self.soup(data)
+        self.assertEqual([soup.a], soup.find_all(title=peace))
+        self.assertEqual([soup.a], soup.find_all(title=peace.decode("utf8")))
+        self.assertEqual([soup.a], soup.find_all(title=[peace, "something else"]))
+
+    def test_find_all_by_attribute_dict(self):
+        # You can pass in a dictionary as the argument 'attrs'. This
+        # lets you search for attributes like 'name' (a fixed argument
+        # to find_all) and 'class' (a reserved word in Python.)
+        tree = self.soup("""
+                         <a name="name1" class="class1">Name match.</a>
+                         <a name="name2" class="class2">Class match.</a>
+                         <a name="name3" class="class3">Non-match.</a>
+                         <name1>A tag called 'name1'.</name1>
+                         """)
+
+        # This doesn't do what you want.
+        self.assertSelects(tree.find_all(name='name1'),
+                           ["A tag called 'name1'."])
+        # This does what you want.
+        self.assertSelects(tree.find_all(attrs={'name' : 'name1'}),
+                           ["Name match."])
+
+        self.assertSelects(tree.find_all(attrs={'class' : 'class2'}),
+                           ["Class match."])
+
+    def test_find_all_by_class(self):
+        tree = self.soup("""
+                         <a class="1">Class 1.</a>
+                         <a class="2">Class 2.</a>
+                         <b class="1">Class 1.</b>
+                         <c class="3 4">Class 3 and 4.</c>
+                         """)
+
+        # Passing in the class_ keyword argument will search against
+        # the 'class' attribute.
+        self.assertSelects(tree.find_all('a', class_='1'), ['Class 1.'])
+        self.assertSelects(tree.find_all('c', class_='3'), ['Class 3 and 4.'])
+        self.assertSelects(tree.find_all('c', class_='4'), ['Class 3 and 4.'])
+
+        # Passing in a string to 'attrs' will also search the CSS class.
+        self.assertSelects(tree.find_all('a', '1'), ['Class 1.'])
+        self.assertSelects(tree.find_all(attrs='1'), ['Class 1.', 'Class 1.'])
+        self.assertSelects(tree.find_all('c', '3'), ['Class 3 and 4.'])
+        self.assertSelects(tree.find_all('c', '4'), ['Class 3 and 4.'])
+
+    def test_find_by_class_when_multiple_classes_present(self):
+        tree = self.soup("<gar class='foo bar'>Found it</gar>")
+
+        f = tree.find_all("gar", class_=re.compile("o"))
+        self.assertSelects(f, ["Found it"])
+
+        f = tree.find_all("gar", class_=re.compile("a"))
+        self.assertSelects(f, ["Found it"])
+
+        # Since the class is not the string "foo bar", but the two
+        # strings "foo" and "bar", this will not find anything.
+        f = tree.find_all("gar", class_=re.compile("o b"))
+        self.assertSelects(f, [])
+
+    def test_find_all_with_non_dictionary_for_attrs_finds_by_class(self):
+        soup = self.soup("<a class='bar'>Found it</a>")
+
+        self.assertSelects(soup.find_all("a", re.compile("ba")), ["Found it"])
+
+        def big_attribute_value(value):
+            return len(value) > 3
+
+        self.assertSelects(soup.find_all("a", big_attribute_value), [])
+
+        def small_attribute_value(value):
+            return len(value) <= 3
+
+        self.assertSelects(
+            soup.find_all("a", small_attribute_value), ["Found it"])
+
+    def test_find_all_with_string_for_attrs_finds_multiple_classes(self):
+        soup = self.soup('<a class="foo bar"></a><a class="foo"></a>')
+        a, a2 = soup.find_all("a")
+        self.assertEqual([a, a2], soup.find_all("a", "foo"))
+        self.assertEqual([a], soup.find_all("a", "bar"))
+
+        # If you specify the class as a string that contains a
+        # space, only that specific value will be found.
+        self.assertEqual([a], soup.find_all("a", class_="foo bar"))
+        self.assertEqual([a], soup.find_all("a", "foo bar"))
+        self.assertEqual([], soup.find_all("a", "bar foo"))
+
+    def test_find_all_by_attribute_soupstrainer(self):
+        tree = self.soup("""
+                         <a id="first">Match.</a>
+                         <a id="second">Non-match.</a>""")
+
+        strainer = SoupStrainer(attrs={'id' : 'first'})
+        self.assertSelects(tree.find_all(strainer), ['Match.'])
+
+    def test_find_all_with_missing_atribute(self):
+        # You can pass in None as the value of an attribute to find_all.
+        # This will match tags that do not have that attribute set.
+        tree = self.soup("""<a id="1">ID present.</a>
+                            <a>No ID present.</a>
+                            <a id="">ID is empty.</a>""")
+        self.assertSelects(tree.find_all('a', id=None), ["No ID present."])
+
+    def test_find_all_with_defined_attribute(self):
+        # You can pass in None as the value of an attribute to find_all.
+        # This will match tags that have that attribute set to any value.
+        tree = self.soup("""<a id="1">ID present.</a>
+                            <a>No ID present.</a>
+                            <a id="">ID is empty.</a>""")
+        self.assertSelects(
+            tree.find_all(id=True), ["ID present.", "ID is empty."])
+
+    def test_find_all_with_numeric_attribute(self):
+        # If you search for a number, it's treated as a string.
+        tree = self.soup("""<a id=1>Unquoted attribute.</a>
+                            <a id="1">Quoted attribute.</a>""")
+
+        expected = ["Unquoted attribute.", "Quoted attribute."]
+        self.assertSelects(tree.find_all(id=1), expected)
+        self.assertSelects(tree.find_all(id="1"), expected)
+
+    def test_find_all_with_list_attribute_values(self):
+        # You can pass a list of attribute values instead of just one,
+        # and you'll get tags that match any of the values.
+        tree = self.soup("""<a id="1">1</a>
+                            <a id="2">2</a>
+                            <a id="3">3</a>
+                            <a>No ID.</a>""")
+        self.assertSelects(tree.find_all(id=["1", "3", "4"]),
+                           ["1", "3"])
+
+    def test_find_all_with_regular_expression_attribute_value(self):
+        # You can pass a regular expression as an attribute value, and
+        # you'll get tags whose values for that attribute match the
+        # regular expression.
+        tree = self.soup("""<a id="a">One a.</a>
+                            <a id="aa">Two as.</a>
+                            <a id="ab">Mixed as and bs.</a>
+                            <a id="b">One b.</a>
+                            <a>No ID.</a>""")
+
+        self.assertSelects(tree.find_all(id=re.compile("^a+$")),
+                           ["One a.", "Two as."])
+
+    def test_find_by_name_and_containing_string(self):
+        soup = self.soup("<b>foo</b><b>bar</b><a>foo</a>")
+        a = soup.a
+
+        self.assertEqual([a], soup.find_all("a", text="foo"))
+        self.assertEqual([], soup.find_all("a", text="bar"))
+        self.assertEqual([], soup.find_all("a", text="bar"))
+
+    def test_find_by_name_and_containing_string_when_string_is_buried(self):
+        soup = self.soup("<a>foo</a><a><b><c>foo</c></b></a>")
+        self.assertEqual(soup.find_all("a"), soup.find_all("a", text="foo"))
+
+    def test_find_by_attribute_and_containing_string(self):
+        soup = self.soup('<b id="1">foo</b><a id="2">foo</a>')
+        a = soup.a
+
+        self.assertEqual([a], soup.find_all(id=2, text="foo"))
+        self.assertEqual([], soup.find_all(id=1, text="bar"))
+
+
+
+
+class TestIndex(TreeTest):
+    """Test Tag.index"""
+    def test_index(self):
+        tree = self.soup("""<div>
+                            <a>Identical</a>
+                            <b>Not identical</b>
+                            <a>Identical</a>
+
+                            <c><d>Identical with child</d></c>
+                            <b>Also not identical</b>
+                            <c><d>Identical with child</d></c>
+                            </div>""")
+        div = tree.div
+        for i, element in enumerate(div.contents):
+            self.assertEqual(i, div.index(element))
+        self.assertRaises(ValueError, tree.index, 1)
+
+
+class TestParentOperations(TreeTest):
+    """Test navigation and searching through an element's parents."""
+
+    def setUp(self):
+        super(TestParentOperations, self).setUp()
+        self.tree = self.soup('''<ul id="empty"></ul>
+                                 <ul id="top">
+                                  <ul id="middle">
+                                   <ul id="bottom">
+                                    <b>Start here</b>
+                                   </ul>
+                                  </ul>''')
+        self.start = self.tree.b
+
+
+    def test_parent(self):
+        self.assertEqual(self.start.parent['id'], 'bottom')
+        self.assertEqual(self.start.parent.parent['id'], 'middle')
+        self.assertEqual(self.start.parent.parent.parent['id'], 'top')
+
+    def test_parent_of_top_tag_is_soup_object(self):
+        top_tag = self.tree.contents[0]
+        self.assertEqual(top_tag.parent, self.tree)
+
+    def test_soup_object_has_no_parent(self):
+        self.assertEqual(None, self.tree.parent)
+
+    def test_find_parents(self):
+        self.assertSelectsIDs(
+            self.start.find_parents('ul'), ['bottom', 'middle', 'top'])
+        self.assertSelectsIDs(
+            self.start.find_parents('ul', id="middle"), ['middle'])
+
+    def test_find_parent(self):
+        self.assertEqual(self.start.find_parent('ul')['id'], 'bottom')
+        self.assertEqual(self.start.find_parent('ul', id='top')['id'], 'top')
+
+    def test_parent_of_text_element(self):
+        text = self.tree.find(text="Start here")
+        self.assertEqual(text.parent.name, 'b')
+
+    def test_text_element_find_parent(self):
+        text = self.tree.find(text="Start here")
+        self.assertEqual(text.find_parent('ul')['id'], 'bottom')
+
+    def test_parent_generator(self):
+        parents = [parent['id'] for parent in self.start.parents
+                   if parent is not None and 'id' in parent.attrs]
+        self.assertEqual(parents, ['bottom', 'middle', 'top'])
+
+
+class ProximityTest(TreeTest):
+
+    def setUp(self):
+        super(TreeTest, self).setUp()
+        self.tree = self.soup(
+            '<html id="start"><head></head><body><b id="1">One</b><b id="2">Two</b><b id="3">Three</b></body></html>')
+
+
+class TestNextOperations(ProximityTest):
+
+    def setUp(self):
+        super(TestNextOperations, self).setUp()
+        self.start = self.tree.b
+
+    def test_next(self):
+        self.assertEqual(self.start.next_element, "One")
+        self.assertEqual(self.start.next_element.next_element['id'], "2")
+
+    def test_next_of_last_item_is_none(self):
+        last = self.tree.find(text="Three")
+        self.assertEqual(last.next_element, None)
+
+    def test_next_of_root_is_none(self):
+        # The document root is outside the next/previous chain.
+        self.assertEqual(self.tree.next_element, None)
+
+    def test_find_all_next(self):
+        self.assertSelects(self.start.find_all_next('b'), ["Two", "Three"])
+        self.start.find_all_next(id=3)
+        self.assertSelects(self.start.find_all_next(id=3), ["Three"])
+
+    def test_find_next(self):
+        self.assertEqual(self.start.find_next('b')['id'], '2')
+        self.assertEqual(self.start.find_next(text="Three"), "Three")
+
+    def test_find_next_for_text_element(self):
+        text = self.tree.find(text="One")
+        self.assertEqual(text.find_next("b").string, "Two")
+        self.assertSelects(text.find_all_next("b"), ["Two", "Three"])
+
+    def test_next_generator(self):
+        start = self.tree.find(text="Two")
+        successors = [node for node in start.next_elements]
+        # There are two successors: the final <b> tag and its text contents.
+        tag, contents = successors
+        self.assertEqual(tag['id'], '3')
+        self.assertEqual(contents, "Three")
+
+class TestPreviousOperations(ProximityTest):
+
+    def setUp(self):
+        super(TestPreviousOperations, self).setUp()
+        self.end = self.tree.find(text="Three")
+
+    def test_previous(self):
+        self.assertEqual(self.end.previous_element['id'], "3")
+        self.assertEqual(self.end.previous_element.previous_element, "Two")
+
+    def test_previous_of_first_item_is_none(self):
+        first = self.tree.find('html')
+        self.assertEqual(first.previous_element, None)
+
+    def test_previous_of_root_is_none(self):
+        # The document root is outside the next/previous chain.
+        # XXX This is broken!
+        #self.assertEqual(self.tree.previous_element, None)
+        pass
+
+    def test_find_all_previous(self):
+        # The <b> tag containing the "Three" node is the predecessor
+        # of the "Three" node itself, which is why "Three" shows up
+        # here.
+        self.assertSelects(
+            self.end.find_all_previous('b'), ["Three", "Two", "One"])
+        self.assertSelects(self.end.find_all_previous(id=1), ["One"])
+
+    def test_find_previous(self):
+        self.assertEqual(self.end.find_previous('b')['id'], '3')
+        self.assertEqual(self.end.find_previous(text="One"), "One")
+
+    def test_find_previous_for_text_element(self):
+        text = self.tree.find(text="Three")
+        self.assertEqual(text.find_previous("b").string, "Three")
+        self.assertSelects(
+            text.find_all_previous("b"), ["Three", "Two", "One"])
+
+    def test_previous_generator(self):
+        start = self.tree.find(text="One")
+        predecessors = [node for node in start.previous_elements]
+
+        # There are four predecessors: the <b> tag containing "One"
+        # the <body> tag, the <head> tag, and the <html> tag.
+        b, body, head, html = predecessors
+        self.assertEqual(b['id'], '1')
+        self.assertEqual(body.name, "body")
+        self.assertEqual(head.name, "head")
+        self.assertEqual(html.name, "html")
+
+
+class SiblingTest(TreeTest):
+
+    def setUp(self):
+        super(SiblingTest, self).setUp()
+        markup = '''<html>
+                    <span id="1">
+                     <span id="1.1"></span>
+                    </span>
+                    <span id="2">
+                     <span id="2.1"></span>
+                    </span>
+                    <span id="3">
+                     <span id="3.1"></span>
+                    </span>
+                    <span id="4"></span>
+                    </html>'''
+        # All that whitespace looks good but makes the tests more
+        # difficult. Get rid of it.
+        markup = re.compile("\n\s*").sub("", markup)
+        self.tree = self.soup(markup)
+
+
+class TestNextSibling(SiblingTest):
+
+    def setUp(self):
+        super(TestNextSibling, self).setUp()
+        self.start = self.tree.find(id="1")
+
+    def test_next_sibling_of_root_is_none(self):
+        self.assertEqual(self.tree.next_sibling, None)
+
+    def test_next_sibling(self):
+        self.assertEqual(self.start.next_sibling['id'], '2')
+        self.assertEqual(self.start.next_sibling.next_sibling['id'], '3')
+
+        # Note the difference between next_sibling and next_element.
+        self.assertEqual(self.start.next_element['id'], '1.1')
+
+    def test_next_sibling_may_not_exist(self):
+        self.assertEqual(self.tree.html.next_sibling, None)
+
+        nested_span = self.tree.find(id="1.1")
+        self.assertEqual(nested_span.next_sibling, None)
+
+        last_span = self.tree.find(id="4")
+        self.assertEqual(last_span.next_sibling, None)
+
+    def test_find_next_sibling(self):
+        self.assertEqual(self.start.find_next_sibling('span')['id'], '2')
+
+    def test_next_siblings(self):
+        self.assertSelectsIDs(self.start.find_next_siblings("span"),
+                              ['2', '3', '4'])
+
+        self.assertSelectsIDs(self.start.find_next_siblings(id='3'), ['3'])
+
+    def test_next_sibling_for_text_element(self):
+        soup = self.soup("Foo<b>bar</b>baz")
+        start = soup.find(text="Foo")
+        self.assertEqual(start.next_sibling.name, 'b')
+        self.assertEqual(start.next_sibling.next_sibling, 'baz')
+
+        self.assertSelects(start.find_next_siblings('b'), ['bar'])
+        self.assertEqual(start.find_next_sibling(text="baz"), "baz")
+        self.assertEqual(start.find_next_sibling(text="nonesuch"), None)
+
+
+class TestPreviousSibling(SiblingTest):
+
+    def setUp(self):
+        super(TestPreviousSibling, self).setUp()
+        self.end = self.tree.find(id="4")
+
+    def test_previous_sibling_of_root_is_none(self):
+        self.assertEqual(self.tree.previous_sibling, None)
+
+    def test_previous_sibling(self):
+        self.assertEqual(self.end.previous_sibling['id'], '3')
+        self.assertEqual(self.end.previous_sibling.previous_sibling['id'], '2')
+
+        # Note the difference between previous_sibling and previous_element.
+        self.assertEqual(self.end.previous_element['id'], '3.1')
+
+    def test_previous_sibling_may_not_exist(self):
+        self.assertEqual(self.tree.html.previous_sibling, None)
+
+        nested_span = self.tree.find(id="1.1")
+        self.assertEqual(nested_span.previous_sibling, None)
+
+        first_span = self.tree.find(id="1")
+        self.assertEqual(first_span.previous_sibling, None)
+
+    def test_find_previous_sibling(self):
+        self.assertEqual(self.end.find_previous_sibling('span')['id'], '3')
+
+    def test_previous_siblings(self):
+        self.assertSelectsIDs(self.end.find_previous_siblings("span"),
+                              ['3', '2', '1'])
+
+        self.assertSelectsIDs(self.end.find_previous_siblings(id='1'), ['1'])
+
+    def test_previous_sibling_for_text_element(self):
+        soup = self.soup("Foo<b>bar</b>baz")
+        start = soup.find(text="baz")
+        self.assertEqual(start.previous_sibling.name, 'b')
+        self.assertEqual(start.previous_sibling.previous_sibling, 'Foo')
+
+        self.assertSelects(start.find_previous_siblings('b'), ['bar'])
+        self.assertEqual(start.find_previous_sibling(text="Foo"), "Foo")
+        self.assertEqual(start.find_previous_sibling(text="nonesuch"), None)
+
+
+class TestTagCreation(SoupTest):
+    """Test the ability to create new tags."""
+    def test_new_tag(self):
+        soup = self.soup("")
+        new_tag = soup.new_tag("foo", bar="baz")
+        self.assertTrue(isinstance(new_tag, Tag))
+        self.assertEqual("foo", new_tag.name)
+        self.assertEqual(dict(bar="baz"), new_tag.attrs)
+        self.assertEqual(None, new_tag.parent)
+
+    def test_tag_inherits_self_closing_rules_from_builder(self):
+        if XML_BUILDER_PRESENT:
+            xml_soup = BeautifulSoup("", "xml")
+            xml_br = xml_soup.new_tag("br")
+            xml_p = xml_soup.new_tag("p")
+
+            # Both the <br> and <p> tag are empty-element, just because
+            # they have no contents.
+            self.assertEqual(b"<br/>", xml_br.encode())
+            self.assertEqual(b"<p/>", xml_p.encode())
+
+        html_soup = BeautifulSoup("", "html")
+        html_br = html_soup.new_tag("br")
+        html_p = html_soup.new_tag("p")
+
+        # The HTML builder users HTML's rules about which tags are
+        # empty-element tags, and the new tags reflect these rules.
+        self.assertEqual(b"<br/>", html_br.encode())
+        self.assertEqual(b"<p></p>", html_p.encode())
+
+    def test_new_string_creates_navigablestring(self):
+        soup = self.soup("")
+        s = soup.new_string("foo")
+        self.assertEqual("foo", s)
+        self.assertTrue(isinstance(s, NavigableString))
+
+    def test_new_string_can_create_navigablestring_subclass(self):
+        soup = self.soup("")
+        s = soup.new_string("foo", Comment)
+        self.assertEqual("foo", s)
+        self.assertTrue(isinstance(s, Comment))
+
+class TestTreeModification(SoupTest):
+
+    def test_attribute_modification(self):
+        soup = self.soup('<a id="1"></a>')
+        soup.a['id'] = 2
+        self.assertEqual(soup.decode(), self.document_for('<a id="2"></a>'))
+        del(soup.a['id'])
+        self.assertEqual(soup.decode(), self.document_for('<a></a>'))
+        soup.a['id2'] = 'foo'
+        self.assertEqual(soup.decode(), self.document_for('<a id2="foo"></a>'))
+
+    def test_new_tag_creation(self):
+        builder = builder_registry.lookup('html')()
+        soup = self.soup("<body></body>", builder=builder)
+        a = Tag(soup, builder, 'a')
+        ol = Tag(soup, builder, 'ol')
+        a['href'] = 'http://foo.com/'
+        soup.body.insert(0, a)
+        soup.body.insert(1, ol)
+        self.assertEqual(
+            soup.body.encode(),
+            b'<body><a href="http://foo.com/"></a><ol></ol></body>')
+
+    def test_append_to_contents_moves_tag(self):
+        doc = """<p id="1">Don't leave me <b>here</b>.</p>
+                <p id="2">Don\'t leave!</p>"""
+        soup = self.soup(doc)
+        second_para = soup.find(id='2')
+        bold = soup.b
+
+        # Move the <b> tag to the end of the second paragraph.
+        soup.find(id='2').append(soup.b)
+
+        # The <b> tag is now a child of the second paragraph.
+        self.assertEqual(bold.parent, second_para)
+
+        self.assertEqual(
+            soup.decode(), self.document_for(
+                '<p id="1">Don\'t leave me .</p>\n'
+                '<p id="2">Don\'t leave!<b>here</b></p>'))
+
+    def test_replace_with_returns_thing_that_was_replaced(self):
+        text = "<a></a><b><c></c></b>"
+        soup = self.soup(text)
+        a = soup.a
+        new_a = a.replace_with(soup.c)
+        self.assertEqual(a, new_a)
+
+    def test_unwrap_returns_thing_that_was_replaced(self):
+        text = "<a><b></b><c></c></a>"
+        soup = self.soup(text)
+        a = soup.a
+        new_a = a.unwrap()
+        self.assertEqual(a, new_a)
+
+    def test_replace_tag_with_itself(self):
+        text = "<a><b></b><c>Foo<d></d></c></a><a><e></e></a>"
+        soup = self.soup(text)
+        c = soup.c
+        soup.c.replace_with(c)
+        self.assertEqual(soup.decode(), self.document_for(text))
+
+    def test_replace_tag_with_its_parent_raises_exception(self):
+        text = "<a><b></b></a>"
+        soup = self.soup(text)
+        self.assertRaises(ValueError, soup.b.replace_with, soup.a)
+
+    def test_insert_tag_into_itself_raises_exception(self):
+        text = "<a><b></b></a>"
+        soup = self.soup(text)
+        self.assertRaises(ValueError, soup.a.insert, 0, soup.a)
+
+    def test_replace_with_maintains_next_element_throughout(self):
+        soup = self.soup('<p><a>one</a><b>three</b></p>')
+        a = soup.a
+        b = a.contents[0]
+        # Make it so the <a> tag has two text children.
+        a.insert(1, "two")
+
+        # Now replace each one with the empty string.
+        left, right = a.contents
+        left.replaceWith('')
+        right.replaceWith('')
+
+        # The <b> tag is still connected to the tree.
+        self.assertEqual("three", soup.b.string)
+
+    def test_replace_final_node(self):
+        soup = self.soup("<b>Argh!</b>")
+        soup.find(text="Argh!").replace_with("Hooray!")
+        new_text = soup.find(text="Hooray!")
+        b = soup.b
+        self.assertEqual(new_text.previous_element, b)
+        self.assertEqual(new_text.parent, b)
+        self.assertEqual(new_text.previous_element.next_element, new_text)
+        self.assertEqual(new_text.next_element, None)
+
+    def test_consecutive_text_nodes(self):
+        # A builder should never create two consecutive text nodes,
+        # but if you insert one next to another, Beautiful Soup will
+        # handle it correctly.
+        soup = self.soup("<a><b>Argh!</b><c></c></a>")
+        soup.b.insert(1, "Hooray!")
+
+        self.assertEqual(
+            soup.decode(), self.document_for(
+                "<a><b>Argh!Hooray!</b><c></c></a>"))
+
+        new_text = soup.find(text="Hooray!")
+        self.assertEqual(new_text.previous_element, "Argh!")
+        self.assertEqual(new_text.previous_element.next_element, new_text)
+
+        self.assertEqual(new_text.previous_sibling, "Argh!")
+        self.assertEqual(new_text.previous_sibling.next_sibling, new_text)
+
+        self.assertEqual(new_text.next_sibling, None)
+        self.assertEqual(new_text.next_element, soup.c)
+
+    def test_insert_string(self):
+        soup = self.soup("<a></a>")
+        soup.a.insert(0, "bar")
+        soup.a.insert(0, "foo")
+        # The string were added to the tag.
+        self.assertEqual(["foo", "bar"], soup.a.contents)
+        # And they were converted to NavigableStrings.
+        self.assertEqual(soup.a.contents[0].next_element, "bar")
+
+    def test_insert_tag(self):
+        builder = self.default_builder
+        soup = self.soup(
+            "<a><b>Find</b><c>lady!</c><d></d></a>", builder=builder)
+        magic_tag = Tag(soup, builder, 'magictag')
+        magic_tag.insert(0, "the")
+        soup.a.insert(1, magic_tag)
+
+        self.assertEqual(
+            soup.decode(), self.document_for(
+                "<a><b>Find</b><magictag>the</magictag><c>lady!</c><d></d></a>"))
+
+        # Make sure all the relationships are hooked up correctly.
+        b_tag = soup.b
+        self.assertEqual(b_tag.next_sibling, magic_tag)
+        self.assertEqual(magic_tag.previous_sibling, b_tag)
+
+        find = b_tag.find(text="Find")
+        self.assertEqual(find.next_element, magic_tag)
+        self.assertEqual(magic_tag.previous_element, find)
+
+        c_tag = soup.c
+        self.assertEqual(magic_tag.next_sibling, c_tag)
+        self.assertEqual(c_tag.previous_sibling, magic_tag)
+
+        the = magic_tag.find(text="the")
+        self.assertEqual(the.parent, magic_tag)
+        self.assertEqual(the.next_element, c_tag)
+        self.assertEqual(c_tag.previous_element, the)
+
+    def test_append_child_thats_already_at_the_end(self):
+        data = "<a><b></b></a>"
+        soup = self.soup(data)
+        soup.a.append(soup.b)
+        self.assertEqual(data, soup.decode())
+
+    def test_move_tag_to_beginning_of_parent(self):
+        data = "<a><b></b><c></c><d></d></a>"
+        soup = self.soup(data)
+        soup.a.insert(0, soup.d)
+        self.assertEqual("<a><d></d><b></b><c></c></a>", soup.decode())
+
+    def test_insert_works_on_empty_element_tag(self):
+        # This is a little strange, since most HTML parsers don't allow
+        # markup like this to come through. But in general, we don't
+        # know what the parser would or wouldn't have allowed, so
+        # I'm letting this succeed for now.
+        soup = self.soup("<br/>")
+        soup.br.insert(1, "Contents")
+        self.assertEqual(str(soup.br), "<br>Contents</br>")
+
+    def test_insert_before(self):
+        soup = self.soup("<a>foo</a><b>bar</b>")
+        soup.b.insert_before("BAZ")
+        soup.a.insert_before("QUUX")
+        self.assertEqual(
+            soup.decode(), self.document_for("QUUX<a>foo</a>BAZ<b>bar</b>"))
+
+        soup.a.insert_before(soup.b)
+        self.assertEqual(
+            soup.decode(), self.document_for("QUUX<b>bar</b><a>foo</a>BAZ"))
+
+    def test_insert_after(self):
+        soup = self.soup("<a>foo</a><b>bar</b>")
+        soup.b.insert_after("BAZ")
+        soup.a.insert_after("QUUX")
+        self.assertEqual(
+            soup.decode(), self.document_for("<a>foo</a>QUUX<b>bar</b>BAZ"))
+        soup.b.insert_after(soup.a)
+        self.assertEqual(
+            soup.decode(), self.document_for("QUUX<b>bar</b><a>foo</a>BAZ"))
+
+    def test_insert_after_raises_exception_if_after_has_no_meaning(self):
+        soup = self.soup("")
+        tag = soup.new_tag("a")
+        string = soup.new_string("")
+        self.assertRaises(ValueError, string.insert_after, tag)
+        self.assertRaises(NotImplementedError, soup.insert_after, tag)
+        self.assertRaises(ValueError, tag.insert_after, tag)
+
+    def test_insert_before_raises_notimplementederror_if_before_has_no_meaning(self):
+        soup = self.soup("")
+        tag = soup.new_tag("a")
+        string = soup.new_string("")
+        self.assertRaises(ValueError, string.insert_before, tag)
+        self.assertRaises(NotImplementedError, soup.insert_before, tag)
+        self.assertRaises(ValueError, tag.insert_before, tag)
+
+    def test_replace_with(self):
+        soup = self.soup(
+                "<p>There's <b>no</b> business like <b>show</b> business</p>")
+        no, show = soup.find_all('b')
+        show.replace_with(no)
+        self.assertEqual(
+            soup.decode(),
+            self.document_for(
+                "<p>There's  business like <b>no</b> business</p>"))
+
+        self.assertEqual(show.parent, None)
+        self.assertEqual(no.parent, soup.p)
+        self.assertEqual(no.next_element, "no")
+        self.assertEqual(no.next_sibling, " business")
+
+    def test_replace_first_child(self):
+        data = "<a><b></b><c></c></a>"
+        soup = self.soup(data)
+        soup.b.replace_with(soup.c)
+        self.assertEqual("<a><c></c></a>", soup.decode())
+
+    def test_replace_last_child(self):
+        data = "<a><b></b><c></c></a>"
+        soup = self.soup(data)
+        soup.c.replace_with(soup.b)
+        self.assertEqual("<a><b></b></a>", soup.decode())
+
+    def test_nested_tag_replace_with(self):
+        soup = self.soup(
+            """<a>We<b>reserve<c>the</c><d>right</d></b></a><e>to<f>refuse</f><g>service</g></e>""")
+
+        # Replace the entire <b> tag and its contents ("reserve the
+        # right") with the <f> tag ("refuse").
+        remove_tag = soup.b
+        move_tag = soup.f
+        remove_tag.replace_with(move_tag)
+
+        self.assertEqual(
+            soup.decode(), self.document_for(
+                "<a>We<f>refuse</f></a><e>to<g>service</g></e>"))
+
+        # The <b> tag is now an orphan.
+        self.assertEqual(remove_tag.parent, None)
+        self.assertEqual(remove_tag.find(text="right").next_element, None)
+        self.assertEqual(remove_tag.previous_element, None)
+        self.assertEqual(remove_tag.next_sibling, None)
+        self.assertEqual(remove_tag.previous_sibling, None)
+
+        # The <f> tag is now connected to the <a> tag.
+        self.assertEqual(move_tag.parent, soup.a)
+        self.assertEqual(move_tag.previous_element, "We")
+        self.assertEqual(move_tag.next_element.next_element, soup.e)
+        self.assertEqual(move_tag.next_sibling, None)
+
+        # The gap where the <f> tag used to be has been mended, and
+        # the word "to" is now connected to the <g> tag.
+        to_text = soup.find(text="to")
+        g_tag = soup.g
+        self.assertEqual(to_text.next_element, g_tag)
+        self.assertEqual(to_text.next_sibling, g_tag)
+        self.assertEqual(g_tag.previous_element, to_text)
+        self.assertEqual(g_tag.previous_sibling, to_text)
+
+    def test_unwrap(self):
+        tree = self.soup("""
+            <p>Unneeded <em>formatting</em> is unneeded</p>
+            """)
+        tree.em.unwrap()
+        self.assertEqual(tree.em, None)
+        self.assertEqual(tree.p.text, "Unneeded formatting is unneeded")
+
+    def test_wrap(self):
+        soup = self.soup("I wish I was bold.")
+        value = soup.string.wrap(soup.new_tag("b"))
+        self.assertEqual(value.decode(), "<b>I wish I was bold.</b>")
+        self.assertEqual(
+            soup.decode(), self.document_for("<b>I wish I was bold.</b>"))
+
+    def test_wrap_extracts_tag_from_elsewhere(self):
+        soup = self.soup("<b></b>I wish I was bold.")
+        soup.b.next_sibling.wrap(soup.b)
+        self.assertEqual(
+            soup.decode(), self.document_for("<b>I wish I was bold.</b>"))
+
+    def test_wrap_puts_new_contents_at_the_end(self):
+        soup = self.soup("<b>I like being bold.</b>I wish I was bold.")
+        soup.b.next_sibling.wrap(soup.b)
+        self.assertEqual(2, len(soup.b.contents))
+        self.assertEqual(
+            soup.decode(), self.document_for(
+                "<b>I like being bold.I wish I was bold.</b>"))
+
+    def test_extract(self):
+        soup = self.soup(
+            '<html><body>Some content. <div id="nav">Nav crap</div> More content.</body></html>')
+
+        self.assertEqual(len(soup.body.contents), 3)
+        extracted = soup.find(id="nav").extract()
+
+        self.assertEqual(
+            soup.decode(), "<html><body>Some content.  More content.</body></html>")
+        self.assertEqual(extracted.decode(), '<div id="nav">Nav crap</div>')
+
+        # The extracted tag is now an orphan.
+        self.assertEqual(len(soup.body.contents), 2)
+        self.assertEqual(extracted.parent, None)
+        self.assertEqual(extracted.previous_element, None)
+        self.assertEqual(extracted.next_element.next_element, None)
+
+        # The gap where the extracted tag used to be has been mended.
+        content_1 = soup.find(text="Some content. ")
+        content_2 = soup.find(text=" More content.")
+        self.assertEqual(content_1.next_element, content_2)
+        self.assertEqual(content_1.next_sibling, content_2)
+        self.assertEqual(content_2.previous_element, content_1)
+        self.assertEqual(content_2.previous_sibling, content_1)
+
+    def test_extract_distinguishes_between_identical_strings(self):
+        soup = self.soup("<a>foo</a><b>bar</b>")
+        foo_1 = soup.a.string
+        bar_1 = soup.b.string
+        foo_2 = soup.new_string("foo")
+        bar_2 = soup.new_string("bar")
+        soup.a.append(foo_2)
+        soup.b.append(bar_2)
+
+        # Now there are two identical strings in the <a> tag, and two
+        # in the <b> tag. Let's remove the first "foo" and the second
+        # "bar".
+        foo_1.extract()
+        bar_2.extract()
+        self.assertEqual(foo_2, soup.a.string)
+        self.assertEqual(bar_2, soup.b.string)
+
+    def test_clear(self):
+        """Tag.clear()"""
+        soup = self.soup("<p><a>String <em>Italicized</em></a> and another</p>")
+        # clear using extract()
+        a = soup.a
+        soup.p.clear()
+        self.assertEqual(len(soup.p.contents), 0)
+        self.assertTrue(hasattr(a, "contents"))
+
+        # clear using decompose()
+        em = a.em
+        a.clear(decompose=True)
+        self.assertEqual(0, len(em.contents))
+
+    def test_string_set(self):
+        """Tag.string = 'string'"""
+        soup = self.soup("<a></a> <b><c></c></b>")
+        soup.a.string = "foo"
+        self.assertEqual(soup.a.contents, ["foo"])
+        soup.b.string = "bar"
+        self.assertEqual(soup.b.contents, ["bar"])
+
+    def test_string_set_does_not_affect_original_string(self):
+        soup = self.soup("<a><b>foo</b><c>bar</c>")
+        soup.b.string = soup.c.string
+        self.assertEqual(soup.a.encode(), b"<a><b>bar</b><c>bar</c></a>")
+
+    def test_set_string_preserves_class_of_string(self):
+        soup = self.soup("<a></a>")
+        cdata = CData("foo")
+        soup.a.string = cdata
+        self.assertTrue(isinstance(soup.a.string, CData))
+
+class TestElementObjects(SoupTest):
+    """Test various features of element objects."""
+
+    def test_len(self):
+        """The length of an element is its number of children."""
+        soup = self.soup("<top>1<b>2</b>3</top>")
+
+        # The BeautifulSoup object itself contains one element: the
+        # <top> tag.
+        self.assertEqual(len(soup.contents), 1)
+        self.assertEqual(len(soup), 1)
+
+        # The <top> tag contains three elements: the text node "1", the
+        # <b> tag, and the text node "3".
+        self.assertEqual(len(soup.top), 3)
+        self.assertEqual(len(soup.top.contents), 3)
+
+    def test_member_access_invokes_find(self):
+        """Accessing a Python member .foo invokes find('foo')"""
+        soup = self.soup('<b><i></i></b>')
+        self.assertEqual(soup.b, soup.find('b'))
+        self.assertEqual(soup.b.i, soup.find('b').find('i'))
+        self.assertEqual(soup.a, None)
+
+    def test_deprecated_member_access(self):
+        soup = self.soup('<b><i></i></b>')
+        with warnings.catch_warnings(record=True) as w:
+            tag = soup.bTag
+        self.assertEqual(soup.b, tag)
+        self.assertEqual(
+            '.bTag is deprecated, use .find("b") instead.',
+            str(w[0].message))
+
+    def test_has_attr(self):
+        """has_attr() checks for the presence of an attribute.
+
+        Please note note: has_attr() is different from
+        __in__. has_attr() checks the tag's attributes and __in__
+        checks the tag's chidlren.
+        """
+        soup = self.soup("<foo attr='bar'>")
+        self.assertTrue(soup.foo.has_attr('attr'))
+        self.assertFalse(soup.foo.has_attr('attr2'))
+
+
+    def test_attributes_come_out_in_alphabetical_order(self):
+        markup = '<b a="1" z="5" m="3" f="2" y="4"></b>'
+        self.assertSoupEquals(markup, '<b a="1" f="2" m="3" y="4" z="5"></b>')
+
+    def test_string(self):
+        # A tag that contains only a text node makes that node
+        # available as .string.
+        soup = self.soup("<b>foo</b>")
+        self.assertEqual(soup.b.string, 'foo')
+
+    def test_empty_tag_has_no_string(self):
+        # A tag with no children has no .stirng.
+        soup = self.soup("<b></b>")
+        self.assertEqual(soup.b.string, None)
+
+    def test_tag_with_multiple_children_has_no_string(self):
+        # A tag with no children has no .string.
+        soup = self.soup("<a>foo<b></b><b></b></b>")
+        self.assertEqual(soup.b.string, None)
+
+        soup = self.soup("<a>foo<b></b>bar</b>")
+        self.assertEqual(soup.b.string, None)
+
+        # Even if all the children are strings, due to trickery,
+        # it won't work--but this would be a good optimization.
+        soup = self.soup("<a>foo</b>")
+        soup.a.insert(1, "bar")
+        self.assertEqual(soup.a.string, None)
+
+    def test_tag_with_recursive_string_has_string(self):
+        # A tag with a single child which has a .string inherits that
+        # .string.
+        soup = self.soup("<a><b>foo</b></a>")
+        self.assertEqual(soup.a.string, "foo")
+        self.assertEqual(soup.string, "foo")
+
+    def test_lack_of_string(self):
+        """Only a tag containing a single text node has a .string."""
+        soup = self.soup("<b>f<i>e</i>o</b>")
+        self.assertFalse(soup.b.string)
+
+        soup = self.soup("<b></b>")
+        self.assertFalse(soup.b.string)
+
+    def test_all_text(self):
+        """Tag.text and Tag.get_text(sep=u"") -> all child text, concatenated"""
+        soup = self.soup("<a>a<b>r</b>   <r> t </r></a>")
+        self.assertEqual(soup.a.text, "ar  t ")
+        self.assertEqual(soup.a.get_text(strip=True), "art")
+        self.assertEqual(soup.a.get_text(","), "a,r, , t ")
+        self.assertEqual(soup.a.get_text(",", strip=True), "a,r,t")
+
+    def test_get_text_ignores_comments(self):
+        soup = self.soup("foo<!--IGNORE-->bar")
+        self.assertEqual(soup.get_text(), "foobar")
+
+        self.assertEqual(
+            soup.get_text(types=(NavigableString, Comment)), "fooIGNOREbar")
+        self.assertEqual(
+            soup.get_text(types=None), "fooIGNOREbar")
+
+    def test_all_strings_ignores_comments(self):
+        soup = self.soup("foo<!--IGNORE-->bar")
+        self.assertEqual(['foo', 'bar'], list(soup.strings))
+
+class TestCDAtaListAttributes(SoupTest):
+
+    """Testing cdata-list attributes like 'class'.
+    """
+    def test_single_value_becomes_list(self):
+        soup = self.soup("<a class='foo'>")
+        self.assertEqual(["foo"],soup.a['class'])
+
+    def test_multiple_values_becomes_list(self):
+        soup = self.soup("<a class='foo bar'>")
+        self.assertEqual(["foo", "bar"], soup.a['class'])
+
+    def test_multiple_values_separated_by_weird_whitespace(self):
+        soup = self.soup("<a class='foo\tbar\nbaz'>")
+        self.assertEqual(["foo", "bar", "baz"],soup.a['class'])
+
+    def test_attributes_joined_into_string_on_output(self):
+        soup = self.soup("<a class='foo\tbar'>")
+        self.assertEqual(b'<a class="foo bar"></a>', soup.a.encode())
+
+    def test_accept_charset(self):
+        soup = self.soup('<form accept-charset="ISO-8859-1 UTF-8">')
+        self.assertEqual(['ISO-8859-1', 'UTF-8'], soup.form['accept-charset'])
+
+    def test_cdata_attribute_applying_only_to_one_tag(self):
+        data = '<a accept-charset="ISO-8859-1 UTF-8"></a>'
+        soup = self.soup(data)
+        # We saw in another test that accept-charset is a cdata-list
+        # attribute for the <form> tag. But it's not a cdata-list
+        # attribute for any other tag.
+        self.assertEqual('ISO-8859-1 UTF-8', soup.a['accept-charset'])
+
+    def test_string_has_immutable_name_property(self):
+        string = self.soup("s").string
+        self.assertEqual(None, string.name)
+        def t():
+            string.name = 'foo'
+        self.assertRaises(AttributeError, t)
+
+class TestPersistence(SoupTest):
+    "Testing features like pickle and deepcopy."
+
+    def setUp(self):
+        super(TestPersistence, self).setUp()
+        self.page = """<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
+"http://www.w3.org/TR/REC-html40/transitional.dtd">
+<html>
+<head>
+<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
+<title>Beautiful Soup: We called him Tortoise because he taught us.</title>
+<link rev="made" href="mailto:leonardr@segfault.org">
+<meta name="Description" content="Beautiful Soup: an HTML parser optimized for screen-scraping.">
+<meta name="generator" content="Markov Approximation 1.4 (module: leonardr)">
+<meta name="author" content="Leonard Richardson">
+</head>
+<body>
+<a href="foo">foo</a>
+<a href="foo"><b>bar</b></a>
+</body>
+</html>"""
+        self.tree = self.soup(self.page)
+
+    def test_pickle_and_unpickle_identity(self):
+        # Pickling a tree, then unpickling it, yields a tree identical
+        # to the original.
+        dumped = pickle.dumps(self.tree, 2)
+        loaded = pickle.loads(dumped)
+        self.assertEqual(loaded.__class__, BeautifulSoup)
+        self.assertEqual(loaded.decode(), self.tree.decode())
+
+    def test_deepcopy_identity(self):
+        # Making a deepcopy of a tree yields an identical tree.
+        copied = copy.deepcopy(self.tree)
+        self.assertEqual(copied.decode(), self.tree.decode())
+
+    def test_unicode_pickle(self):
+        # A tree containing Unicode characters can be pickled.
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        dumped = pickle.dumps(soup, pickle.HIGHEST_PROTOCOL)
+        loaded = pickle.loads(dumped)
+        self.assertEqual(loaded.decode(), soup.decode())
+
+
+class TestSubstitutions(SoupTest):
+
+    def test_default_formatter_is_minimal(self):
+        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        soup = self.soup(markup)
+        decoded = soup.decode(formatter="minimal")
+        # The < is converted back into &lt; but the e-with-acute is left alone.
+        self.assertEqual(
+            decoded,
+            self.document_for(
+                u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
+
+    def test_formatter_html(self):
+        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        soup = self.soup(markup)
+        decoded = soup.decode(formatter="html")
+        self.assertEqual(
+            decoded,
+            self.document_for("<b>&lt;&lt;Sacr&eacute; bleu!&gt;&gt;</b>"))
+
+    def test_formatter_minimal(self):
+        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        soup = self.soup(markup)
+        decoded = soup.decode(formatter="minimal")
+        # The < is converted back into &lt; but the e-with-acute is left alone.
+        self.assertEqual(
+            decoded,
+            self.document_for(
+                u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
+
+    def test_formatter_null(self):
+        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        soup = self.soup(markup)
+        decoded = soup.decode(formatter=None)
+        # Neither the angle brackets nor the e-with-acute are converted.
+        # This is not valid HTML, but it's what the user wanted.
+        self.assertEqual(decoded,
+                          self.document_for(u"<b><<Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!>></b>"))
+
+    def test_formatter_custom(self):
+        markup = u"<b>&lt;foo&gt;</b><b>bar</b>"
+        soup = self.soup(markup)
+        decoded = soup.decode(formatter = lambda x: x.upper())
+        # Instead of normal entity conversion code, the custom
+        # callable is called on every string.
+        self.assertEqual(
+            decoded,
+            self.document_for(u"<b><FOO></b><b>BAR</b>"))
+
+    def test_formatter_is_run_on_attribute_values(self):
+        markup = u'<a href="http://a.com?a=b&c=é">e</a>'
+        soup = self.soup(markup)
+        a = soup.a
+
+        expect_minimal = u'<a href="http://a.com?a=b&amp;c=é">e</a>'
+
+        self.assertEqual(expect_minimal, a.decode())
+        self.assertEqual(expect_minimal, a.decode(formatter="minimal"))
+
+        expect_html = u'<a href="http://a.com?a=b&amp;c=&eacute;">e</a>'
+        self.assertEqual(expect_html, a.decode(formatter="html"))
+
+        self.assertEqual(markup, a.decode(formatter=None))
+        expect_upper = u'<a href="HTTP://A.COM?A=B&C=É">E</a>'
+        self.assertEqual(expect_upper, a.decode(formatter=lambda x: x.upper()))
+
+    def test_formatter_skips_script_tag_for_html_documents(self):
+        doc = """
+  <script type="text/javascript">
+   console.log("< < hey > > ");
+  </script>
+"""
+        encoded = BeautifulSoup(doc).encode()
+        self.assertTrue(b"< < hey > >" in encoded)
+
+    def test_formatter_skips_style_tag_for_html_documents(self):
+        doc = """
+  <style type="text/css">
+   console.log("< < hey > > ");
+  </style>
+"""
+        encoded = BeautifulSoup(doc).encode()
+        self.assertTrue(b"< < hey > >" in encoded)
+
+    def test_prettify_leaves_preformatted_text_alone(self):
+        soup = self.soup("<div>  foo  <pre>  \tbar\n  \n  </pre>  baz  ")
+        # Everything outside the <pre> tag is reformatted, but everything
+        # inside is left alone.
+        self.assertEqual(
+            u'<div>\n foo\n <pre>  \tbar\n  \n  </pre>\n baz\n</div>',
+            soup.div.prettify())
+
+    def test_prettify_accepts_formatter(self):
+        soup = BeautifulSoup("<html><body>foo</body></html>")
+        pretty = soup.prettify(formatter = lambda x: x.upper())
+        self.assertTrue("FOO" in pretty)
+
+    def test_prettify_outputs_unicode_by_default(self):
+        soup = self.soup("<a></a>")
+        self.assertEqual(unicode, type(soup.prettify()))
+
+    def test_prettify_can_encode_data(self):
+        soup = self.soup("<a></a>")
+        self.assertEqual(bytes, type(soup.prettify("utf-8")))
+
+    def test_html_entity_substitution_off_by_default(self):
+        markup = u"<b>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</b>"
+        soup = self.soup(markup)
+        encoded = soup.b.encode("utf-8")
+        self.assertEqual(encoded, markup.encode('utf-8'))
+
+    def test_encoding_substitution(self):
+        # Here's the <meta> tag saying that a document is
+        # encoded in Shift-JIS.
+        meta_tag = ('<meta content="text/html; charset=x-sjis" '
+                    'http-equiv="Content-type"/>')
+        soup = self.soup(meta_tag)
+
+        # Parse the document, and the charset apprears unchanged.
+        self.assertEqual(soup.meta['content'], 'text/html; charset=x-sjis')
+
+        # Encode the document into some encoding, and the encoding is
+        # substituted into the meta tag.
+        utf_8 = soup.encode("utf-8")
+        self.assertTrue(b"charset=utf-8" in utf_8)
+
+        euc_jp = soup.encode("euc_jp")
+        self.assertTrue(b"charset=euc_jp" in euc_jp)
+
+        shift_jis = soup.encode("shift-jis")
+        self.assertTrue(b"charset=shift-jis" in shift_jis)
+
+        utf_16_u = soup.encode("utf-16").decode("utf-16")
+        self.assertTrue("charset=utf-16" in utf_16_u)
+
+    def test_encoding_substitution_doesnt_happen_if_tag_is_strained(self):
+        markup = ('<head><meta content="text/html; charset=x-sjis" '
+                    'http-equiv="Content-type"/></head><pre>foo</pre>')
+
+        # Beautiful Soup used to try to rewrite the meta tag even if the
+        # meta tag got filtered out by the strainer. This test makes
+        # sure that doesn't happen.
+        strainer = SoupStrainer('pre')
+        soup = self.soup(markup, parse_only=strainer)
+        self.assertEqual(soup.contents[0].name, 'pre')
+
+class TestEncoding(SoupTest):
+    """Test the ability to encode objects into strings."""
+
+    def test_unicode_string_can_be_encoded(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(soup.b.string.encode("utf-8"),
+                          u"\N{SNOWMAN}".encode("utf-8"))
+
+    def test_tag_containing_unicode_string_can_be_encoded(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(
+            soup.b.encode("utf-8"), html.encode("utf-8"))
+
+    def test_encoding_substitutes_unrecognized_characters_by_default(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(soup.b.encode("ascii"), b"<b>&#9731;</b>")
+
+    def test_encoding_can_be_made_strict(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertRaises(
+            UnicodeEncodeError, soup.encode, "ascii", errors="strict")
+
+    def test_decode_contents(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(u"\N{SNOWMAN}", soup.b.decode_contents())
+
+    def test_encode_contents(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(
+            u"\N{SNOWMAN}".encode("utf8"), soup.b.encode_contents(
+                encoding="utf8"))
+
+    def test_deprecated_renderContents(self):
+        html = u"<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        self.assertEqual(
+            u"\N{SNOWMAN}".encode("utf8"), soup.b.renderContents())
+
+class TestNavigableStringSubclasses(SoupTest):
+
+    def test_cdata(self):
+        # None of the current builders turn CDATA sections into CData
+        # objects, but you can create them manually.
+        soup = self.soup("")
+        cdata = CData("foo")
+        soup.insert(1, cdata)
+        self.assertEqual(str(soup), "<![CDATA[foo]]>")
+        self.assertEqual(soup.find(text="foo"), "foo")
+        self.assertEqual(soup.contents[0], "foo")
+
+    def test_cdata_is_never_formatted(self):
+        """Text inside a CData object is passed into the formatter.
+
+        But the return value is ignored.
+        """
+
+        self.count = 0
+        def increment(*args):
+            self.count += 1
+            return "BITTER FAILURE"
+
+        soup = self.soup("")
+        cdata = CData("<><><>")
+        soup.insert(1, cdata)
+        self.assertEqual(
+            b"<![CDATA[<><><>]]>", soup.encode(formatter=increment))
+        self.assertEqual(1, self.count)
+
+    def test_doctype_ends_in_newline(self):
+        # Unlike other NavigableString subclasses, a DOCTYPE always ends
+        # in a newline.
+        doctype = Doctype("foo")
+        soup = self.soup("")
+        soup.insert(1, doctype)
+        self.assertEqual(soup.encode(), b"<!DOCTYPE foo>\n")
+
+
+class TestSoupSelector(TreeTest):
+
+    HTML = """
+<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
+"http://www.w3.org/TR/html4/strict.dtd">
+<html>
+<head>
+<title>The title</title>
+<link rel="stylesheet" href="blah.css" type="text/css" id="l1">
+</head>
+<body>
+
+<div id="main" class="fancy">
+<div id="inner">
+<h1 id="header1">An H1</h1>
+<p>Some text</p>
+<p class="onep" id="p1">Some more text</p>
+<h2 id="header2">An H2</h2>
+<p class="class1 class2 class3" id="pmulti">Another</p>
+<a href="http://bob.example.org/" rel="friend met" id="bob">Bob</a>
+<h2 id="header3">Another H2</h2>
+<a id="me" href="http://simonwillison.net/" rel="me">me</a>
+<span class="s1">
+<a href="#" id="s1a1">span1a1</a>
+<a href="#" id="s1a2">span1a2 <span id="s1a2s1">test</span></a>
+<span class="span2">
+<a href="#" id="s2a1">span2a1</a>
+</span>
+<span class="span3"></span>
+</span>
+</div>
+<p lang="en" id="lang-en">English</p>
+<p lang="en-gb" id="lang-en-gb">English UK</p>
+<p lang="en-us" id="lang-en-us">English US</p>
+<p lang="fr" id="lang-fr">French</p>
+</div>
+
+<div id="footer">
+</div>
+"""
+
+    def setUp(self):
+        self.soup = BeautifulSoup(self.HTML)
+
+    def assertSelects(self, selector, expected_ids):
+        el_ids = [el['id'] for el in self.soup.select(selector)]
+        el_ids.sort()
+        expected_ids.sort()
+        self.assertEqual(expected_ids, el_ids,
+            "Selector %s, expected [%s], got [%s]" % (
+                selector, ', '.join(expected_ids), ', '.join(el_ids)
+            )
+        )
+
+    assertSelect = assertSelects
+
+    def assertSelectMultiple(self, *tests):
+        for selector, expected_ids in tests:
+            self.assertSelect(selector, expected_ids)
+
+    def test_one_tag_one(self):
+        els = self.soup.select('title')
+        self.assertEqual(len(els), 1)
+        self.assertEqual(els[0].name, 'title')
+        self.assertEqual(els[0].contents, [u'The title'])
+
+    def test_one_tag_many(self):
+        els = self.soup.select('div')
+        self.assertEqual(len(els), 3)
+        for div in els:
+            self.assertEqual(div.name, 'div')
+
+    def test_tag_in_tag_one(self):
+        els = self.soup.select('div div')
+        self.assertSelects('div div', ['inner'])
+
+    def test_tag_in_tag_many(self):
+        for selector in ('html div', 'html body div', 'body div'):
+            self.assertSelects(selector, ['main', 'inner', 'footer'])
+
+    def test_tag_no_match(self):
+        self.assertEqual(len(self.soup.select('del')), 0)
+
+    def test_invalid_tag(self):
+        self.assertRaises(ValueError, self.soup.select, 'tag%t')
+
+    def test_header_tags(self):
+        self.assertSelectMultiple(
+            ('h1', ['header1']),
+            ('h2', ['header2', 'header3']),
+        )
+
+    def test_class_one(self):
+        for selector in ('.onep', 'p.onep', 'html p.onep'):
+            els = self.soup.select(selector)
+            self.assertEqual(len(els), 1)
+            self.assertEqual(els[0].name, 'p')
+            self.assertEqual(els[0]['class'], ['onep'])
+
+    def test_class_mismatched_tag(self):
+        els = self.soup.select('div.onep')
+        self.assertEqual(len(els), 0)
+
+    def test_one_id(self):
+        for selector in ('div#inner', '#inner', 'div div#inner'):
+            self.assertSelects(selector, ['inner'])
+
+    def test_bad_id(self):
+        els = self.soup.select('#doesnotexist')
+        self.assertEqual(len(els), 0)
+
+    def test_items_in_id(self):
+        els = self.soup.select('div#inner p')
+        self.assertEqual(len(els), 3)
+        for el in els:
+            self.assertEqual(el.name, 'p')
+        self.assertEqual(els[1]['class'], ['onep'])
+        self.assertFalse(els[0].has_attr('class'))
+
+    def test_a_bunch_of_emptys(self):
+        for selector in ('div#main del', 'div#main div.oops', 'div div#main'):
+            self.assertEqual(len(self.soup.select(selector)), 0)
+
+    def test_multi_class_support(self):
+        for selector in ('.class1', 'p.class1', '.class2', 'p.class2',
+            '.class3', 'p.class3', 'html p.class2', 'div#inner .class2'):
+            self.assertSelects(selector, ['pmulti'])
+
+    def test_multi_class_selection(self):
+        for selector in ('.class1.class3', '.class3.class2',
+                         '.class1.class2.class3'):
+            self.assertSelects(selector, ['pmulti'])
+
+    def test_child_selector(self):
+        self.assertSelects('.s1 > a', ['s1a1', 's1a2'])
+        self.assertSelects('.s1 > a span', ['s1a2s1'])
+
+    def test_child_selector_id(self):
+        self.assertSelects('.s1 > a#s1a2 span', ['s1a2s1'])
+
+    def test_attribute_equals(self):
+        self.assertSelectMultiple(
+            ('p[class="onep"]', ['p1']),
+            ('p[id="p1"]', ['p1']),
+            ('[class="onep"]', ['p1']),
+            ('[id="p1"]', ['p1']),
+            ('link[rel="stylesheet"]', ['l1']),
+            ('link[type="text/css"]', ['l1']),
+            ('link[href="blah.css"]', ['l1']),
+            ('link[href="no-blah.css"]', []),
+            ('[rel="stylesheet"]', ['l1']),
+            ('[type="text/css"]', ['l1']),
+            ('[href="blah.css"]', ['l1']),
+            ('[href="no-blah.css"]', []),
+            ('p[href="no-blah.css"]', []),
+            ('[href="no-blah.css"]', []),
+        )
+
+    def test_attribute_tilde(self):
+        self.assertSelectMultiple(
+            ('p[class~="class1"]', ['pmulti']),
+            ('p[class~="class2"]', ['pmulti']),
+            ('p[class~="class3"]', ['pmulti']),
+            ('[class~="class1"]', ['pmulti']),
+            ('[class~="class2"]', ['pmulti']),
+            ('[class~="class3"]', ['pmulti']),
+            ('a[rel~="friend"]', ['bob']),
+            ('a[rel~="met"]', ['bob']),
+            ('[rel~="friend"]', ['bob']),
+            ('[rel~="met"]', ['bob']),
+        )
+
+    def test_attribute_startswith(self):
+        self.assertSelectMultiple(
+            ('[rel^="style"]', ['l1']),
+            ('link[rel^="style"]', ['l1']),
+            ('notlink[rel^="notstyle"]', []),
+            ('[rel^="notstyle"]', []),
+            ('link[rel^="notstyle"]', []),
+            ('link[href^="bla"]', ['l1']),
+            ('a[href^="http://"]', ['bob', 'me']),
+            ('[href^="http://"]', ['bob', 'me']),
+            ('[id^="p"]', ['pmulti', 'p1']),
+            ('[id^="m"]', ['me', 'main']),
+            ('div[id^="m"]', ['main']),
+            ('a[id^="m"]', ['me']),
+        )
+
+    def test_attribute_endswith(self):
+        self.assertSelectMultiple(
+            ('[href$=".css"]', ['l1']),
+            ('link[href$=".css"]', ['l1']),
+            ('link[id$="1"]', ['l1']),
+            ('[id$="1"]', ['l1', 'p1', 'header1', 's1a1', 's2a1', 's1a2s1']),
+            ('div[id$="1"]', []),
+            ('[id$="noending"]', []),
+        )
+
+    def test_attribute_contains(self):
+        self.assertSelectMultiple(
+            # From test_attribute_startswith
+            ('[rel*="style"]', ['l1']),
+            ('link[rel*="style"]', ['l1']),
+            ('notlink[rel*="notstyle"]', []),
+            ('[rel*="notstyle"]', []),
+            ('link[rel*="notstyle"]', []),
+            ('link[href*="bla"]', ['l1']),
+            ('a[href*="http://"]', ['bob', 'me']),
+            ('[href*="http://"]', ['bob', 'me']),
+            ('[id*="p"]', ['pmulti', 'p1']),
+            ('div[id*="m"]', ['main']),
+            ('a[id*="m"]', ['me']),
+            # From test_attribute_endswith
+            ('[href*=".css"]', ['l1']),
+            ('link[href*=".css"]', ['l1']),
+            ('link[id*="1"]', ['l1']),
+            ('[id*="1"]', ['l1', 'p1', 'header1', 's1a1', 's1a2', 's2a1', 's1a2s1']),
+            ('div[id*="1"]', []),
+            ('[id*="noending"]', []),
+            # New for this test
+            ('[href*="."]', ['bob', 'me', 'l1']),
+            ('a[href*="."]', ['bob', 'me']),
+            ('link[href*="."]', ['l1']),
+            ('div[id*="n"]', ['main', 'inner']),
+            ('div[id*="nn"]', ['inner']),
+        )
+
+    def test_attribute_exact_or_hypen(self):
+        self.assertSelectMultiple(
+            ('p[lang|="en"]', ['lang-en', 'lang-en-gb', 'lang-en-us']),
+            ('[lang|="en"]', ['lang-en', 'lang-en-gb', 'lang-en-us']),
+            ('p[lang|="fr"]', ['lang-fr']),
+            ('p[lang|="gb"]', []),
+        )
+
+    def test_attribute_exists(self):
+        self.assertSelectMultiple(
+            ('[rel]', ['l1', 'bob', 'me']),
+            ('link[rel]', ['l1']),
+            ('a[rel]', ['bob', 'me']),
+            ('[lang]', ['lang-en', 'lang-en-gb', 'lang-en-us', 'lang-fr']),
+            ('p[class]', ['p1', 'pmulti']),
+            ('[blah]', []),
+            ('p[blah]', []),
+        )
+
+    def test_nth_of_type(self):
+        # Try to select first paragraph
+        els = self.soup.select('div#inner p:nth-of-type(1)')
+        self.assertEqual(len(els), 1)
+        self.assertEqual(els[0].string, u'Some text')
+
+        # Try to select third paragraph
+        els = self.soup.select('div#inner p:nth-of-type(3)')
+        self.assertEqual(len(els), 1)
+        self.assertEqual(els[0].string, u'Another')
+
+        # Try to select (non-existent!) fourth paragraph
+        els = self.soup.select('div#inner p:nth-of-type(4)')
+        self.assertEqual(len(els), 0)
+
+        # Pass in an invalid value.
+        self.assertRaises(
+            ValueError, self.soup.select, 'div p:nth-of-type(0)')
+
+    def test_nth_of_type_direct_descendant(self):
+        els = self.soup.select('div#inner > p:nth-of-type(1)')
+        self.assertEqual(len(els), 1)
+        self.assertEqual(els[0].string, u'Some text')
+
+    def test_id_child_selector_nth_of_type(self):
+        self.assertSelects('#inner > p:nth-of-type(2)', ['p1'])
+
+    def test_select_on_element(self):
+        # Other tests operate on the tree; this operates on an element
+        # within the tree.
+        inner = self.soup.find("div", id="main")
+        selected = inner.select("div")
+        # The <div id="inner"> tag was selected. The <div id="footer">
+        # tag was not.
+        self.assertSelectsIDs(selected, ['inner'])
+
+    def test_overspecified_child_id(self):
+        self.assertSelects(".fancy #inner", ['inner'])
+        self.assertSelects(".normal #inner", [])
+
+    def test_adjacent_sibling_selector(self):
+        self.assertSelects('#p1 + h2', ['header2'])
+        self.assertSelects('#p1 + h2 + p', ['pmulti'])
+        self.assertSelects('#p1 + #header2 + .class1', ['pmulti'])
+        self.assertEqual([], self.soup.select('#p1 + p'))
+
+    def test_general_sibling_selector(self):
+        self.assertSelects('#p1 ~ h2', ['header2', 'header3'])
+        self.assertSelects('#p1 ~ #header2', ['header2'])
+        self.assertSelects('#p1 ~ h2 + a', ['me'])
+        self.assertSelects('#p1 ~ h2 + [rel="me"]', ['me'])
+        self.assertEqual([], self.soup.select('#inner ~ h2'))
+
+    def test_dangling_combinator(self):
+        self.assertRaises(ValueError, self.soup.select, 'h1 >')
+
+    def test_sibling_combinator_wont_select_same_tag_twice(self):
+        self.assertSelects('p[lang] ~ p', ['lang-en-gb', 'lang-en-us', 'lang-fr'])
-- 
1.9.1


