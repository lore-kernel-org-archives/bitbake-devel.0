Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C31FC25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 11:42:06 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.9472.1717155716242907643
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 May 2024 04:41:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dx24fLL4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35dceef4227so965414f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717155714; x=1717760514; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbfFU81E16SDViXapJZE4W5OEzwTFROVokl3nQlAyj8=;
        b=dx24fLL4LBS7Akk7RIUzO/9bdPyo2lLYlPu9eV4zHgI42IYcfqsZnmEbWj/mTydg/p
         6jiOjMGpfIvPvqrQLyX4eDlLmm5EQjcJqwMtsaxFqCRRpnEzZR7DDkt6J+k2YhgfGUe3
         JjP9d36zf+ozN6/MRf+vKv75J6rzRlbU2aEic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155714; x=1717760514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbfFU81E16SDViXapJZE4W5OEzwTFROVokl3nQlAyj8=;
        b=od9lTgkUqt9OZIWXELqfuFBRBDjoZGMNZvd1/sXsa/AuH+1kz/dqpN4Qqy/bnQpM5H
         eA1TEE1C0UPISKAygBIh+jq5/DG1koYnq7Dj1ZSpS3kktOf6wtzRevknPnebjhlm4kJz
         4SAky4AqK93G9fwyIfKuH9ldYC6fdLhCxTH4UqnR3MKlUH3rt+w8+NG+jCekNckO+0b0
         +Upcc+GcNBlqGQkjRGsLoo+tZTe5tAu/cGsev6rmWv4d3KI6e5+CvcBkMJpWPDEY3gMc
         2MtxsSHfFD0PHB2IDRnbqhw7FawEdWVqM9t6DoeAUhsXFj5zEfHOs3kFC55HInc1r9bp
         UREw==
X-Gm-Message-State: AOJu0YwOxiZhCUjXybNCRWjk6SS6lFNWGG64N6VpXJvSGqX0Nwoscdhw
	kKPk0zIBlozC29rVxc32Y+o6JCvda73+paDnf+AzMQihsM/ItJYrYE7OgTAez5uYkrDG3svyjwD
	I
X-Google-Smtp-Source: AGHT+IE2NNUNwMyJZbEfnvZO2pGsNU5/rlepYfM8XcIlrHzSGonOHffpCL77ZFCV0BGY7fY7oia4fQ==
X-Received: by 2002:adf:ea11:0:b0:354:f2b0:ebd6 with SMTP id ffacd0b85a97d-35e0f25e2b9mr1134881f8f.9.1717155712584;
        Fri, 31 May 2024 04:41:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9173:4fa2:d1b3:c8be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d9c68sm1661078f8f.56.2024.05.31.04.41.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:41:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bs4: Update to 4.12.3 from 4.4.1
Date: Fri, 31 May 2024 12:41:50 +0100
Message-Id: <20240531114150.3255109-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 May 2024 11:42:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16297

It makes sense to switch to a more recent version and keep up to date
with upstream changes and things like new python version support.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bs4/AUTHORS                        |   49 +
 lib/bs4/AUTHORS.txt                    |   43 -
 lib/bs4/{NEWS.txt => CHANGELOG}        |  779 ++++++++-
 lib/bs4/{COPYING.txt => LICENSE}       |   11 +-
 lib/bs4/__init__.py                    |  680 ++++++--
 lib/bs4/builder/__init__.py            |  382 +++-
 lib/bs4/builder/_html5lib.py           |  251 ++-
 lib/bs4/builder/_htmlparser.py         |  433 +++--
 lib/bs4/builder/_lxml.py               |  212 ++-
 lib/bs4/css.py                         |  280 +++
 lib/bs4/dammit.py                      |  411 ++++-
 lib/bs4/diagnose.py                    |   83 +-
 lib/bs4/element.py                     | 2219 ++++++++++++++++--------
 lib/bs4/formatter.py                   |  185 ++
 lib/bs4/testing.py                     |  686 --------
 lib/bs4/tests/__init__.py              |    1 -
 lib/bs4/tests/test_builder_registry.py |  147 --
 lib/bs4/tests/test_docs.py             |   32 -
 lib/bs4/tests/test_html5lib.py         |   98 --
 lib/bs4/tests/test_htmlparser.py       |   31 -
 lib/bs4/tests/test_lxml.py             |   70 -
 lib/bs4/tests/test_soup.py             |  479 -----
 lib/bs4/tests/test_tree.py             | 2004 ---------------------
 23 files changed, 4675 insertions(+), 4891 deletions(-)
 create mode 100644 lib/bs4/AUTHORS
 delete mode 100644 lib/bs4/AUTHORS.txt
 rename lib/bs4/{NEWS.txt => CHANGELOG} (56%)
 rename lib/bs4/{COPYING.txt => LICENSE} (80%)
 create mode 100644 lib/bs4/css.py
 create mode 100644 lib/bs4/formatter.py
 delete mode 100644 lib/bs4/testing.py
 delete mode 100644 lib/bs4/tests/__init__.py
 delete mode 100644 lib/bs4/tests/test_builder_registry.py
 delete mode 100644 lib/bs4/tests/test_docs.py
 delete mode 100644 lib/bs4/tests/test_html5lib.py
 delete mode 100644 lib/bs4/tests/test_htmlparser.py
 delete mode 100644 lib/bs4/tests/test_lxml.py
 delete mode 100644 lib/bs4/tests/test_soup.py
 delete mode 100644 lib/bs4/tests/test_tree.py

diff --git a/lib/bs4/AUTHORS b/lib/bs4/AUTHORS
new file mode 100644
index 0000000000..1f14fe07de
--- /dev/null
+++ b/lib/bs4/AUTHORS
@@ -0,0 +1,49 @@
+Behold, mortal, the origins of Beautiful Soup...
+================================================
+
+Leonard Richardson is the primary maintainer.
+
+Aaron DeVore and Isaac Muse have made significant contributions to the
+code base.
+
+Mark Pilgrim provided the encoding detection code that forms the base
+of UnicodeDammit.
+
+Thomas Kluyver and Ezio Melotti finished the work of getting Beautiful
+Soup 4 working under Python 3.
+
+Simon Willison wrote soupselect, which was used to make Beautiful Soup
+support CSS selectors. Isaac Muse wrote SoupSieve, which made it
+possible to _remove_ the CSS selector code from Beautiful Soup.
+
+Sam Ruby helped with a lot of edge cases.
+
+Jonathan Ellis was awarded the prestigious Beau Potage D'Or for his
+work in solving the nestable tags conundrum.
+
+An incomplete list of people have contributed patches to Beautiful
+Soup:
+
+ Istvan Albert, Andrew Lin, Anthony Baxter, Oliver Beattie, Andrew
+Boyko, Tony Chang, Francisco Canas, "Delong", Zephyr Fang, Fuzzy,
+Roman Gaufman, Yoni Gilad, Richie Hindle, Toshihiro Kamiya, Peteris
+Krumins, Kent Johnson, Marek Kapolka, Andreas Kostyrka, Roel Kramer,
+Ben Last, Robert Leftwich, Stefaan Lippens, "liquider", Staffan
+Malmgren, Ksenia Marasanova, JP Moins, Adam Monsen, John Nagle, "Jon",
+Ed Oskiewicz, Martijn Peters, Greg Phillips, Giles Radford, Stefano
+Revera, Arthur Rudolph, Marko Samastur, James Salter, Jouni Sepp�nen,
+Alexander Schmolck, Tim Shirley, Geoffrey Sneddon, Ville Skytt�,
+"Vikas", Jens Svalgaard, Andy Theyers, Eric Weiser, Glyn Webster, John
+Wiseman, Paul Wright, Danny Yoo
+
+An incomplete list of people who made suggestions or found bugs or
+found ways to break Beautiful Soup:
+
+ Hanno B�ck, Matteo Bertini, Chris Curvey, Simon Cusack, Bruce Eckel,
+ Matt Ernst, Michael Foord, Tom Harris, Bill de hOra, Donald Howes,
+ Matt Patterson, Scott Roberts, Steve Strassmann, Mike Williams,
+ warchild at redho dot com, Sami Kuisma, Carlos Rocha, Bob Hutchison,
+ Joren Mc, Michal Migurski, John Kleven, Tim Heaney, Tripp Lilley, Ed
+ Summers, Dennis Sutch, Chris Smith, Aaron Swartz, Stuart
+ Turner, Greg Edwards, Kevin J Kalupson, Nikos Kouremenos, Artur de
+ Sousa Rocha, Yichun Wei, Per Vognsen
diff --git a/lib/bs4/AUTHORS.txt b/lib/bs4/AUTHORS.txt
deleted file mode 100644
index 2ac8fcc8cc..0000000000
--- a/lib/bs4/AUTHORS.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Behold, mortal, the origins of Beautiful Soup...
-================================================
-
-Leonard Richardson is the primary programmer.
-
-Aaron DeVore is awesome.
-
-Mark Pilgrim provided the encoding detection code that forms the base
-of UnicodeDammit.
-
-Thomas Kluyver and Ezio Melotti finished the work of getting Beautiful
-Soup 4 working under Python 3.
-
-Simon Willison wrote soupselect, which was used to make Beautiful Soup
-support CSS selectors.
-
-Sam Ruby helped with a lot of edge cases.
-
-Jonathan Ellis was awarded the prestigous Beau Potage D'Or for his
-work in solving the nestable tags conundrum.
-
-An incomplete list of people have contributed patches to Beautiful
-Soup:
-
- Istvan Albert, Andrew Lin, Anthony Baxter, Andrew Boyko, Tony Chang,
- Zephyr Fang, Fuzzy, Roman Gaufman, Yoni Gilad, Richie Hindle, Peteris
- Krumins, Kent Johnson, Ben Last, Robert Leftwich, Staffan Malmgren,
- Ksenia Marasanova, JP Moins, Adam Monsen, John Nagle, "Jon", Ed
- Oskiewicz, Greg Phillips, Giles Radford, Arthur Rudolph, Marko
- Samastur, Jouni Sepp�nen, Alexander Schmolck, Andy Theyers, Glyn
- Webster, Paul Wright, Danny Yoo
-
-An incomplete list of people who made suggestions or found bugs or
-found ways to break Beautiful Soup:
-
- Hanno B�ck, Matteo Bertini, Chris Curvey, Simon Cusack, Bruce Eckel,
- Matt Ernst, Michael Foord, Tom Harris, Bill de hOra, Donald Howes,
- Matt Patterson, Scott Roberts, Steve Strassmann, Mike Williams,
- warchild at redho dot com, Sami Kuisma, Carlos Rocha, Bob Hutchison,
- Joren Mc, Michal Migurski, John Kleven, Tim Heaney, Tripp Lilley, Ed
- Summers, Dennis Sutch, Chris Smith, Aaron Sweep^W Swartz, Stuart
- Turner, Greg Edwards, Kevin J Kalupson, Nikos Kouremenos, Artur de
- Sousa Rocha, Yichun Wei, Per Vognsen
diff --git a/lib/bs4/NEWS.txt b/lib/bs4/CHANGELOG
similarity index 56%
rename from lib/bs4/NEWS.txt
rename to lib/bs4/CHANGELOG
index 88a60a2458..2701446a6d 100644
--- a/lib/bs4/NEWS.txt
+++ b/lib/bs4/CHANGELOG
@@ -1,3 +1,776 @@
+= 4.12.3 (20240117)
+
+* The Beautiful Soup documentation now has a Spanish translation, thanks
+  to Carlos Romero. Delong Wang's Chinese translation has been updated
+  to cover Beautiful Soup 4.12.0.
+
+* Fixed a regression such that if you set .hidden on a tag, the tag
+  becomes invisible but its contents are still visible. User manipulation
+  of .hidden is not a documented or supported feature, so don't do this,
+  but it wasn't too difficult to keep the old behavior working.
+
+* Fixed a case found by Mengyuhan where html.parser giving up on
+  markup would result in an AssertionError instead of a
+  ParserRejectedMarkup exception.
+
+* Added the correct stacklevel to instances of the XMLParsedAsHTMLWarning.
+  [bug=2034451]
+
+* Corrected the syntax of the license definition in pyproject.toml. Patch
+  by Louis Maddox. [bug=2032848]
+
+* Corrected a typo in a test that was causing test failures when run against
+  libxml2 2.12.1. [bug=2045481]
+
+= 4.12.2 (20230407)
+
+* Fixed an unhandled exception in BeautifulSoup.decode_contents
+  and methods that call it. [bug=2015545]
+
+= 4.12.1 (20230405)
+
+NOTE: the following things are likely to be dropped in the next
+feature release of Beautiful Soup:
+
+ Official support for Python 3.6.
+ Inclusion of unit tests and test data in the wheel file.
+ Two scripts: demonstrate_parser_differences.py and test-all-versions.
+
+Changes:
+
+* This version of Beautiful Soup replaces setup.py and setup.cfg
+  with pyproject.toml. Beautiful Soup now uses tox as its test backend
+  and hatch to do builds.
+
+* The main functional improvement in this version is a nonrecursive technique
+  for regenerating a tree. This technique is used to avoid situations where,
+  in previous versions, doing something to a very deeply nested tree
+  would overflow the Python interpreter stack:
+
+  1. Outputting a tree as a string, e.g. with
+     BeautifulSoup.encode() [bug=1471755]
+
+  2. Making copies of trees (copy.copy() and
+     copy.deepcopy() from the Python standard library). [bug=1709837]
+
+  3. Pickling a BeautifulSoup object. (Note that pickling a Tag
+     object can still cause an overflow.)
+
+* Making a copy of a BeautifulSoup object no longer parses the
+  document again, which should improve performance significantly.
+
+* When a BeautifulSoup object is unpickled, Beautiful Soup now
+  tries to associate an appropriate TreeBuilder object with it.
+
+* Tag.prettify() will now consistently end prettified markup with
+  a newline.
+
+* Added unit tests for fuzz test cases created by third
+  parties. Some of these tests are skipped since they point
+  to problems outside of Beautiful Soup, but this change
+  puts them all in one convenient place.
+
+* PageElement now implements the known_xml attribute. (This was technically
+  a bug, but it shouldn't be an issue in normal use.) [bug=2007895]
+
+* The demonstrate_parser_differences.py script was still written in
+  Python 2. I've converted it to Python 3, but since no one has
+  mentioned this over the years, it's a sign that no one uses this
+  script and it's not serving its purpose.
+
+= 4.12.0 (20230320)
+
+* Introduced the .css property, which centralizes all access to
+  the Soup Sieve API. This allows Beautiful Soup to give direct
+  access to as much of Soup Sieve that makes sense, without cluttering
+  the BeautifulSoup and Tag classes with a lot of new methods.
+
+  This does mean one addition to the BeautifulSoup and Tag classes
+  (the .css property itself), so this might be a breaking change if you
+  happen to use Beautiful Soup to parse XML that includes a tag called
+  <css>. In particular, code like this will stop working in 4.12.0:
+
+    soup.css['id']
+
+  Code like this will work just as before:
+
+    soup.find_one('css')['id']
+
+  The Soup Sieve methods supported through the .css property are
+  select(), select_one(), iselect(), closest(), match(), filter(),
+  escape(), and compile(). The BeautifulSoup and Tag classes still
+  support the select() and select_one() methods; they have not been
+  deprecated, but they have been demoted to convenience methods.
+
+  [bug=2003677]
+
+* When the html.parser parser decides it can't parse a document, Beautiful
+  Soup now consistently propagates this fact by raising a
+  ParserRejectedMarkup error. [bug=2007343]
+
+* Removed some error checking code from diagnose(), which is redundant with
+  similar (but more Pythonic) code in the BeautifulSoup constructor.
+  [bug=2007344]
+
+* Added intersphinx references to the documentation so that other
+  projects have a target to point to when they reference Beautiful
+  Soup classes. [bug=1453370]
+
+= 4.11.2 (20230131)
+
+* Fixed test failures caused by nondeterministic behavior of
+  UnicodeDammit's character detection, depending on the platform setup.
+  [bug=1973072]
+
+* Fixed another crash when overriding multi_valued_attributes and using the
+  html5lib parser. [bug=1948488]
+
+* The HTMLFormatter and XMLFormatter constructors no longer return a
+  value. [bug=1992693]
+
+* Tag.interesting_string_types is now propagated when a tag is
+  copied. [bug=1990400]
+
+* Warnings now do their best to provide an appropriate stacklevel,
+  improving the usefulness of the message. [bug=1978744]
+
+* Passing a Tag's .contents into PageElement.extend() now works the
+  same way as passing the Tag itself.
+
+* Soup Sieve tests will be skipped if the library is not installed.
+
+= 4.11.1 (20220408)
+
+This release was done to ensure that the unit tests are packaged along
+with the released source. There are no functionality changes in this
+release, but there are a few other packaging changes:
+
+* The Japanese and Korean translations of the documentation are included.
+* The changelog is now packaged as CHANGELOG, and the license file is
+  packaged as LICENSE. NEWS.txt and COPYING.txt are still present,
+  but may be removed in the future.
+* TODO.txt is no longer packaged, since a TODO is not relevant for released
+  code.
+
+= 4.11.0 (20220407)
+
+* Ported unit tests to use pytest.
+
+* Added special string classes, RubyParenthesisString and RubyTextString,
+  to make it possible to treat ruby text specially in get_text() calls.
+  [bug=1941980]
+
+* It's now possible to customize the way output is indented by
+  providing a value for the 'indent' argument to the Formatter
+  constructor. The 'indent' argument works very similarly to the
+  argument of the same name in the Python standard library's
+  json.dump() function. [bug=1955497]
+
+* If the charset-normalizer Python module
+  (https://pypi.org/project/charset-normalizer/) is installed, Beautiful
+  Soup will use it to detect the character sets of incoming documents.
+  This is also the module used by newer versions of the Requests library.
+  For the sake of backwards compatibility, chardet and cchardet both take
+  precedence if installed. [bug=1955346]
+
+* Added a workaround for an lxml bug
+  (https://bugs.launchpad.net/lxml/+bug/1948551) that causes
+  problems when parsing a Unicode string beginning with BYTE ORDER MARK.
+  [bug=1947768]
+
+* Issue a warning when an HTML parser is used to parse a document that
+  looks like XML but not XHTML. [bug=1939121]
+
+* Do a better job of keeping track of namespaces as an XML document is
+  parsed, so that CSS selectors that use namespaces will do the right
+  thing more often. [bug=1946243]
+
+* Some time ago, the misleadingly named "text" argument to find-type
+  methods was renamed to the more accurate "string." But this supposed
+  "renaming" didn't make it into important places like the method
+  signatures or the docstrings. That's corrected in this
+  version. "text" still works, but will give a DeprecationWarning.
+  [bug=1947038]
+
+* Fixed a crash when pickling a BeautifulSoup object that has no
+  tree builder. [bug=1934003]
+
+* Fixed a crash when overriding multi_valued_attributes and using the
+  html5lib parser. [bug=1948488]
+
+* Standardized the wording of the MarkupResemblesLocatorWarning
+  warnings to omit untrusted input and make the warnings less
+  judgmental about what you ought to be doing. [bug=1955450]
+
+* Removed support for the iconv_codec library, which doesn't seem
+  to exist anymore and was never put up on PyPI. (The closest
+  replacement on PyPI, iconv_codecs, is GPL-licensed, so we can't use
+  it--it's also quite old.)
+
+= 4.10.0 (20210907)
+
+* This is the first release of Beautiful Soup to only support Python
+  3. I dropped Python 2 support to maintain support for newer versions
+  (58 and up) of setuptools. See:
+  https://github.com/pypa/setuptools/issues/2769 [bug=1942919]
+
+* The behavior of methods like .get_text() and .strings now differs
+  depending on the type of tag. The change is visible with HTML tags
+  like <script>, <style>, and <template>. Starting in 4.9.0, methods
+  like get_text() returned no results on such tags, because the
+  contents of those tags are not considered 'text' within the document
+  as a whole.
+
+  But a user who calls script.get_text() is working from a different
+  definition of 'text' than a user who calls div.get_text()--otherwise
+  there would be no need to call script.get_text() at all. In 4.10.0,
+  the contents of (e.g.) a <script> tag are considered 'text' during a
+  get_text() call on the tag itself, but not considered 'text' during
+  a get_text() call on the tag's parent.
+
+  Because of this change, calling get_text() on each child of a tag
+  may now return a different result than calling get_text() on the tag
+  itself. That's because different tags now have different
+  understandings of what counts as 'text'. [bug=1906226] [bug=1868861]
+
+* NavigableString and its subclasses now implement the get_text()
+  method, as well as the properties .strings and
+  .stripped_strings. These methods will either return the string
+  itself, or nothing, so the only reason to use this is when iterating
+  over a list of mixed Tag and NavigableString objects. [bug=1904309]
+
+* The 'html5' formatter now treats attributes whose values are the
+  empty string as HTML boolean attributes. Previously (and in other
+  formatters), an attribute value must be set as None to be treated as
+  a boolean attribute. In a future release, I plan to also give this
+  behavior to the 'html' formatter. Patch by Isaac Muse. [bug=1915424]
+
+* The 'replace_with()' method now takes a variable number of arguments,
+  and can be used to replace a single element with a sequence of elements.
+  Patch by Bill Chandos. [rev=605]
+
+* Corrected output when the namespace prefix associated with a
+  namespaced attribute is the empty string, as opposed to
+  None. [bug=1915583]
+
+* Performance improvement when processing tags that speeds up overall
+  tree construction by 2%. Patch by Morotti. [bug=1899358]
+
+* Corrected the use of special string container classes in cases when a
+  single tag may contain strings with different containers; such as
+  the <template> tag, which may contain both TemplateString objects
+  and Comment objects. [bug=1913406]
+
+* The html.parser tree builder can now handle named entities
+  found in the HTML5 spec in much the same way that the html5lib
+  tree builder does. Note that the lxml HTML tree builder doesn't handle
+  named entities this way. [bug=1924908]
+
+* Added a second way to pass specify encodings to UnicodeDammit and
+  EncodingDetector, based on the order of precedence defined in the
+  HTML5 spec, starting at:
+  https://html.spec.whatwg.org/multipage/parsing.html#parsing-with-a-known-character-encoding
+
+  Encodings in 'known_definite_encodings' are tried first, then
+  byte-order-mark sniffing is run, then encodings in 'user_encodings'
+  are tried. The old argument, 'override_encodings', is now a
+  deprecated alias for 'known_definite_encodings'.
+
+  This changes the default behavior of the html.parser and lxml tree
+  builders, in a way that may slightly improve encoding
+  detection but will probably have no effect. [bug=1889014]
+
+* Improve the warning issued when a directory name (as opposed to
+  the name of a regular file) is passed as markup into the BeautifulSoup
+  constructor. [bug=1913628]
+
+= 4.9.3 (20201003)
+
+This is the final release of Beautiful Soup to support Python
+2. Beautiful Soup's official support for Python 2 ended on 01 January,
+2021. In the Launchpad Git repository, the final revision to support
+Python 2 was revision 70f546b1e689a70e2f103795efce6d261a3dadf7; it is
+tagged as "python2".
+
+* Implemented a significant performance optimization to the process of
+  searching the parse tree. Patch by Morotti. [bug=1898212]
+
+= 4.9.2 (20200926)
+
+* Fixed a bug that caused too many tags to be popped from the tag
+  stack during tree building, when encountering a closing tag that had
+  no matching opening tag. [bug=1880420]
+
+* Fixed a bug that inconsistently moved elements over when passing
+  a Tag, rather than a list, into Tag.extend(). [bug=1885710]
+
+* Specify the soupsieve dependency in a way that complies with
+  PEP 508. Patch by Mike Nerone. [bug=1893696]
+
+* Change the signatures for BeautifulSoup.insert_before and insert_after
+  (which are not implemented) to match PageElement.insert_before and
+  insert_after, quieting warnings in some IDEs. [bug=1897120]
+
+= 4.9.1 (20200517)
+
+* Added a keyword argument 'on_duplicate_attribute' to the
+  BeautifulSoupHTMLParser constructor (used by the html.parser tree
+  builder) which lets you customize the handling of markup that
+  contains the same attribute more than once, as in:
+  <a href="url1" href="url2"> [bug=1878209]
+
+* Added a distinct subclass, GuessedAtParserWarning, for the warning
+  issued when BeautifulSoup is instantiated without a parser being
+  specified. [bug=1873787]
+
+* Added a distinct subclass, MarkupResemblesLocatorWarning, for the
+  warning issued when BeautifulSoup is instantiated with 'markup' that
+  actually seems to be a URL or the path to a file on
+  disk. [bug=1873787]
+
+* The new NavigableString subclasses (Stylesheet, Script, and
+  TemplateString) can now be imported directly from the bs4 package.
+
+* If you encode a document with a Python-specific encoding like
+  'unicode_escape', that encoding is no longer mentioned in the final
+  XML or HTML document. Instead, encoding information is omitted or
+  left blank. [bug=1874955]
+
+* Fixed test failures when run against soupselect 2.0. Patch by Tomáš
+  Chvátal. [bug=1872279]
+
+= 4.9.0 (20200405)
+
+* Added PageElement.decomposed, a new property which lets you
+  check whether you've already called decompose() on a Tag or
+  NavigableString.
+
+* Embedded CSS and Javascript is now stored in distinct Stylesheet and
+  Script tags, which are ignored by methods like get_text() since most
+  people don't consider this sort of content to be 'text'. This
+  feature is not supported by the html5lib treebuilder. [bug=1868861]
+
+* Added a Russian translation by 'authoress' to the repository.
+
+* Fixed an unhandled exception when formatting a Tag that had been
+  decomposed.[bug=1857767]
+
+* Fixed a bug that happened when passing a Unicode filename containing
+  non-ASCII characters as markup into Beautiful Soup, on a system that
+  allows Unicode filenames. [bug=1866717]
+
+* Added a performance optimization to PageElement.extract(). Patch by
+  Arthur Darcet.
+
+= 4.8.2 (20191224)
+
+* Added Python docstrings to all public methods of the most commonly
+  used classes.
+
+* Added a Chinese translation by Deron Wang and a Brazilian Portuguese
+  translation by Cezar Peixeiro to the repository.
+
+* Fixed two deprecation warnings. Patches by Colin
+  Watson and Nicholas Neumann. [bug=1847592] [bug=1855301]
+
+* The html.parser tree builder now correctly handles DOCTYPEs that are
+  not uppercase. [bug=1848401]
+
+* PageElement.select() now returns a ResultSet rather than a regular
+  list, making it consistent with methods like find_all().
+
+= 4.8.1 (20191006)
+
+* When the html.parser or html5lib parsers are in use, Beautiful Soup
+  will, by default, record the position in the original document where
+  each tag was encountered. This includes line number (Tag.sourceline)
+  and position within a line (Tag.sourcepos).  Based on code by Chris
+  Mayo. [bug=1742921]
+
+* When instantiating a BeautifulSoup object, it's now possible to
+   provide a dictionary ('element_classes') of the classes you'd like to be
+   instantiated instead of Tag, NavigableString, etc.
+
+* Fixed the definition of the default XML namespace when using
+   lxml 4.4. Patch by Isaac Muse. [bug=1840141]
+
+* Fixed a crash when pretty-printing tags that were not created
+   during initial parsing. [bug=1838903]
+
+* Copying a Tag preserves information that was originally obtained from
+   the TreeBuilder used to build the original Tag. [bug=1838903]
+
+* Raise an explanatory exception when the underlying parser
+   completely rejects the incoming markup. [bug=1838877]
+
+* Avoid a crash when trying to detect the declared encoding of a
+   Unicode document. [bug=1838877]
+
+* Avoid a crash when unpickling certain parse trees generated
+   using html5lib on Python 3. [bug=1843545]
+
+= 4.8.0 (20190720, "One Small Soup")
+
+This release focuses on making it easier to customize Beautiful Soup's
+input mechanism (the TreeBuilder) and output mechanism (the Formatter).
+
+* You can customize the TreeBuilder object by passing keyword
+  arguments into the BeautifulSoup constructor. Those keyword
+  arguments will be passed along into the TreeBuilder constructor.
+
+  The main reason to do this right now is to change how which
+  attributes are treated as multi-valued attributes (the way 'class'
+  is treated by default). You can do this with the
+  'multi_valued_attributes' argument. [bug=1832978]
+
+* The role of Formatter objects has been greatly expanded. The Formatter
+  class now controls the following:
+
+  - The function to call to perform entity substitution. (This was
+    previously Formatter's only job.)
+  - Which tags should be treated as containing CDATA and have their
+    contents exempt from entity substitution.
+  - The order in which a tag's attributes are output. [bug=1812422]
+  - Whether or not to put a '/' inside a void element, e.g. '<br/>' vs '<br>'
+
+  All preexisting code should work as before.
+
+* Added a new method to the API, Tag.smooth(), which consolidates
+  multiple adjacent NavigableString elements. [bug=1697296]
+
+* &apos; (which is valid in XML, XHTML, and HTML 5, but not HTML 4) is always
+  recognized as a named entity and converted to a single quote. [bug=1818721]
+
+= 4.7.1 (20190106)
+
+* Fixed a significant performance problem introduced in 4.7.0. [bug=1810617]
+
+* Fixed an incorrectly raised exception when inserting a tag before or
+  after an identical tag. [bug=1810692]
+
+* Beautiful Soup will no longer try to keep track of namespaces that
+  are not defined with a prefix; this can confuse soupselect. [bug=1810680]
+
+* Tried even harder to avoid the deprecation warning originally fixed in
+   4.6.1. [bug=1778909]
+
+= 4.7.0 (20181231)
+
+* Beautiful Soup's CSS Selector implementation has been replaced by a
+  dependency on Isaac Muse's SoupSieve project (the soupsieve package
+  on PyPI). The good news is that SoupSieve has a much more robust and
+  complete implementation of CSS selectors, resolving a large number
+  of longstanding issues. The bad news is that from this point onward,
+  SoupSieve must be installed if you want to use the select() method.
+
+  You don't have to change anything lf you installed Beautiful Soup
+  through pip (SoupSieve will be automatically installed when you
+  upgrade Beautiful Soup) or if you don't use CSS selectors from
+  within Beautiful Soup.
+
+  SoupSieve documentation: https://facelessuser.github.io/soupsieve/
+
+* Added the PageElement.extend() method, which works like list.append().
+   [bug=1514970]
+
+* PageElement.insert_before() and insert_after() now take a variable
+   number of arguments. [bug=1514970]
+
+* Fix a number of problems with the tree builder that caused
+  trees that were superficially okay, but which fell apart when bits
+  were extracted. Patch by Isaac Muse. [bug=1782928,1809910]
+
+* Fixed a problem with the tree builder in which elements that
+  contained no content (such as empty comments and all-whitespace
+  elements) were not being treated as part of the tree. Patch by Isaac
+  Muse. [bug=1798699]
+
+* Fixed a problem with multi-valued attributes where the value
+  contained whitespace. Thanks to Jens Svalgaard for the
+  fix. [bug=1787453]
+
+* Clarified ambiguous license statements in the source code. Beautiful
+  Soup is released under the MIT license, and has been since 4.4.0.
+
+* This file has been renamed from NEWS.txt to CHANGELOG.
+
+= 4.6.3 (20180812)
+
+* Exactly the same as 4.6.2. Re-released to make the README file
+  render properly on PyPI.
+
+= 4.6.2 (20180812)
+
+* Fix an exception when a custom formatter was asked to format a void
+  element. [bug=1784408]
+
+= 4.6.1 (20180728)
+
+* Stop data loss when encountering an empty numeric entity, and
+  possibly in other cases.  Thanks to tos.kamiya for the fix. [bug=1698503]
+
+* Preserve XML namespaces introduced inside an XML document, not just
+   the ones introduced at the top level. [bug=1718787]
+
+* Added a new formatter, "html5", which represents void elements
+   as "<element>" rather than "<element/>".  [bug=1716272]
+
+* Fixed a problem where the html.parser tree builder interpreted
+  a string like "&foo " as the character entity "&foo;"  [bug=1728706]
+
+* Correctly handle invalid HTML numeric character entities like &#147;
+  which reference code points that are not Unicode code points. Note
+  that this is only fixed when Beautiful Soup is used with the
+  html.parser parser -- html5lib already worked and I couldn't fix it
+  with lxml.  [bug=1782933]
+
+* Improved the warning given when no parser is specified. [bug=1780571]
+
+* When markup contains duplicate elements, a select() call that
+  includes multiple match clauses will match all relevant
+  elements. [bug=1770596]
+
+* Fixed code that was causing deprecation warnings in recent Python 3
+  versions. Includes a patch from Ville Skyttä. [bug=1778909] [bug=1689496]
+
+* Fixed a Windows crash in diagnose() when checking whether a long
+  markup string is a filename. [bug=1737121]
+
+* Stopped HTMLParser from raising an exception in very rare cases of
+  bad markup. [bug=1708831]
+
+* Fixed a bug where find_all() was not working when asked to find a
+  tag with a namespaced name in an XML document that was parsed as
+  HTML. [bug=1723783]
+
+* You can get finer control over formatting by subclassing
+  bs4.element.Formatter and passing a Formatter instance into (e.g.)
+  encode(). [bug=1716272]
+
+* You can pass a dictionary of `attrs` into
+  BeautifulSoup.new_tag. This makes it possible to create a tag with
+  an attribute like 'name' that would otherwise be masked by another
+  argument of new_tag. [bug=1779276]
+
+* Clarified the deprecation warning when accessing tag.fooTag, to cover
+  the possibility that you might really have been looking for a tag
+  called 'fooTag'.
+
+= 4.6.0 (20170507) =
+
+* Added the `Tag.get_attribute_list` method, which acts like `Tag.get` for
+  getting the value of an attribute, but which always returns a list,
+  whether or not the attribute is a multi-value attribute. [bug=1678589]
+
+* It's now possible to use a tag's namespace prefix when searching,
+  e.g. soup.find('namespace:tag') [bug=1655332]
+
+* Improved the handling of empty-element tags like <br> when using the
+  html.parser parser. [bug=1676935]
+
+* HTML parsers treat all HTML4 and HTML5 empty element tags (aka void
+  element tags) correctly. [bug=1656909]
+
+* Namespace prefix is preserved when an XML tag is copied. Thanks
+  to Vikas for a patch and test. [bug=1685172]
+
+= 4.5.3 (20170102) =
+
+* Fixed foster parenting when html5lib is the tree builder. Thanks to
+  Geoffrey Sneddon for a patch and test.
+  
+* Fixed yet another problem that caused the html5lib tree builder to
+  create a disconnected parse tree. [bug=1629825]
+
+= 4.5.2 (20170102) =
+
+* Apart from the version number, this release is identical to
+  4.5.3. Due to user error, it could not be completely uploaded to
+  PyPI. Use 4.5.3 instead.
+
+= 4.5.1 (20160802) =
+
+* Fixed a crash when passing Unicode markup that contained a
+  processing instruction into the lxml HTML parser on Python
+  3. [bug=1608048]
+
+= 4.5.0 (20160719) =
+
+* Beautiful Soup is no longer compatible with Python 2.6. This
+  actually happened a few releases ago, but it's now official.
+
+* Beautiful Soup will now work with versions of html5lib greater than
+  0.99999999. [bug=1603299]
+
+* If a search against each individual value of a multi-valued
+  attribute fails, the search will be run one final time against the
+  complete attribute value considered as a single string. That is, if
+  a tag has class="foo bar" and neither "foo" nor "bar" matches, but
+  "foo bar" does, the tag is now considered a match.
+
+  This happened in previous versions, but only when the value being
+  searched for was a string. Now it also works when that value is
+  a regular expression, a list of strings, etc. [bug=1476868]
+
+* Fixed a bug that deranged the tree when a whitespace element was
+  reparented into a tag that contained an identical whitespace
+  element. [bug=1505351]
+
+* Added support for CSS selector values that contain quoted spaces,
+  such as tag[style="display: foo"]. [bug=1540588]
+
+* Corrected handling of XML processing instructions. [bug=1504393]
+
+* Corrected an encoding error that happened when a BeautifulSoup
+  object was copied. [bug=1554439]
+
+* The contents of <textarea> tags will no longer be modified when the
+  tree is prettified. [bug=1555829]
+
+* When a BeautifulSoup object is pickled but its tree builder cannot
+  be pickled, its .builder attribute is set to None instead of being
+  destroyed. This avoids a performance problem once the object is
+  unpickled. [bug=1523629]
+
+* Specify the file and line number when warning about a
+  BeautifulSoup object being instantiated without a parser being
+  specified. [bug=1574647]
+
+* The `limit` argument to `select()` now works correctly, though it's
+  not implemented very efficiently. [bug=1520530]
+
+* Fixed a Python 3 ByteWarning when a URL was passed in as though it
+  were markup. Thanks to James Salter for a patch and
+  test. [bug=1533762]
+
+* We don't run the check for a filename passed in as markup if the
+  'filename' contains a less-than character; the less-than character
+  indicates it's most likely a very small document. [bug=1577864]
+
+= 4.4.1 (20150928) =
+
+* Fixed a bug that deranged the tree when part of it was
+  removed. Thanks to Eric Weiser for the patch and John Wiseman for a
+  test. [bug=1481520]
+
+* Fixed a parse bug with the html5lib tree-builder. Thanks to Roel
+  Kramer for the patch. [bug=1483781]
+
+* Improved the implementation of CSS selector grouping. Thanks to
+  Orangain for the patch. [bug=1484543]
+
+* Fixed the test_detect_utf8 test so that it works when chardet is
+  installed. [bug=1471359]
+
+* Corrected the output of Declaration objects. [bug=1477847]
+
+
+= 4.4.0 (20150703) =
+
+Especially important changes:
+
+* Added a warning when you instantiate a BeautifulSoup object without
+  explicitly naming a parser. [bug=1398866]
+
+* __repr__ now returns an ASCII bytestring in Python 2, and a Unicode
+  string in Python 3, instead of a UTF8-encoded bytestring in both
+  versions. In Python 3, __str__ now returns a Unicode string instead
+  of a bytestring. [bug=1420131]
+
+* The `text` argument to the find_* methods is now called `string`,
+  which is more accurate. `text` still works, but `string` is the
+  argument described in the documentation. `text` may eventually
+  change its meaning, but not for a very long time. [bug=1366856]
+
+* Changed the way soup objects work under copy.copy(). Copying a
+  NavigableString or a Tag will give you a new NavigableString that's
+  equal to the old one but not connected to the parse tree. Patch by
+  Martijn Peters. [bug=1307490]
+
+* Started using a standard MIT license. [bug=1294662]
+
+* Added a Chinese translation of the documentation by Delong .w.
+
+New features:
+
+* Introduced the select_one() method, which uses a CSS selector but
+  only returns the first match, instead of a list of
+  matches. [bug=1349367]
+
+* You can now create a Tag object without specifying a
+  TreeBuilder. Patch by Martijn Pieters. [bug=1307471]
+
+* You can now create a NavigableString or a subclass just by invoking
+  the constructor. [bug=1294315]
+
+* Added an `exclude_encodings` argument to UnicodeDammit and to the
+  Beautiful Soup constructor, which lets you prohibit the detection of
+  an encoding that you know is wrong. [bug=1469408]
+
+* The select() method now supports selector grouping. Patch by
+  Francisco Canas [bug=1191917]
+
+Bug fixes:
+
+* Fixed yet another problem that caused the html5lib tree builder to
+  create a disconnected parse tree. [bug=1237763]
+
+* Force object_was_parsed() to keep the tree intact even when an element
+  from later in the document is moved into place. [bug=1430633]
+
+* Fixed yet another bug that caused a disconnected tree when html5lib
+  copied an element from one part of the tree to another. [bug=1270611]
+
+* Fixed a bug where Element.extract() could create an infinite loop in
+  the remaining tree.
+
+* The select() method can now find tags whose names contain
+  dashes. Patch by Francisco Canas. [bug=1276211]
+
+* The select() method can now find tags with attributes whose names
+  contain dashes. Patch by Marek Kapolka. [bug=1304007]
+
+* Improved the lxml tree builder's handling of processing
+  instructions. [bug=1294645]
+
+* Restored the helpful syntax error that happens when you try to
+  import the Python 2 edition of Beautiful Soup under Python
+  3. [bug=1213387]
+
+* In Python 3.4 and above, set the new convert_charrefs argument to
+  the html.parser constructor to avoid a warning and future
+  failures. Patch by Stefano Revera. [bug=1375721]
+
+* The warning when you pass in a filename or URL as markup will now be
+  displayed correctly even if the filename or URL is a Unicode
+  string. [bug=1268888]
+
+* If the initial <html> tag contains a CDATA list attribute such as
+  'class', the html5lib tree builder will now turn its value into a
+  list, as it would with any other tag. [bug=1296481]
+
+* Fixed an import error in Python 3.5 caused by the removal of the
+  HTMLParseError class. [bug=1420063]
+
+* Improved docstring for encode_contents() and
+  decode_contents(). [bug=1441543]
+
+* Fixed a crash in Unicode, Dammit's encoding detector when the name
+  of the encoding itself contained invalid bytes. [bug=1360913]
+
+* Improved the exception raised when you call .unwrap() or
+  .replace_with() on an element that's not attached to a tree.
+
+* Raise a NotImplementedError whenever an unsupported CSS pseudoclass
+  is used in select(). Previously some cases did not result in a
+  NotImplementedError.
+
+* It's now possible to pickle a BeautifulSoup object no matter which
+  tree builder was used to create it. However, the only tree builder
+  that survives the pickling process is the HTMLParserTreeBuilder
+  ('html.parser'). If you unpickle a BeautifulSoup object created with
+  some other tree builder, soup.builder will be None. [bug=1231545]
+
 = 4.3.2 (20131002) =
 
 * Fixed a bug in which short Unicode input was improperly encoded to
@@ -331,7 +1104,7 @@
 * Renamed Tag.nsprefix to Tag.prefix, for consistency with
   NamespacedAttribute.
 
-* Fixed a test failure that occured on Python 3.x when chardet was
+* Fixed a test failure that occurred on Python 3.x when chardet was
   installed.
 
 * Made prettify() return Unicode by default, so it will look nice on
@@ -365,7 +1138,7 @@
 
 * Restored compatibility with Python 2.6.
 
-* The install process no longer installs docs or auxillary text files.
+* The install process no longer installs docs or auxiliary text files.
 
 * It's now possible to deepcopy a BeautifulSoup object created with
   Python's built-in HTML parser.
@@ -604,7 +1377,7 @@ Added an import that makes BS work in Python 2.3.
 Fixed a UnicodeDecodeError when unpickling documents that contain
 non-ASCII characters.
 
-Fixed a TypeError that occured in some circumstances when a tag
+Fixed a TypeError that occurred in some circumstances when a tag
 contained no text.
 
 Jump through hoops to avoid the use of chardet, which can be extremely
diff --git a/lib/bs4/COPYING.txt b/lib/bs4/LICENSE
similarity index 80%
rename from lib/bs4/COPYING.txt
rename to lib/bs4/LICENSE
index d668d13f04..08e3a9cf8c 100644
--- a/lib/bs4/COPYING.txt
+++ b/lib/bs4/LICENSE
@@ -1,6 +1,6 @@
 Beautiful Soup is made available under the MIT license:
 
- Copyright (c) 2004-2012 Leonard Richardson
+ Copyright (c) Leonard Richardson
 
  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
@@ -20,7 +20,12 @@ Beautiful Soup is made available under the MIT license:
  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- SOFTWARE, DAMMIT.
+ SOFTWARE.
 
 Beautiful Soup incorporates code from the html5lib library, which is
-also made available under the MIT license.
+also made available under the MIT license. Copyright (c) James Graham
+and other contributors
+
+Beautiful Soup has an optional dependency on the soupsieve library,
+which is also made available under the MIT license. Copyright (c)
+Isaac Muse
diff --git a/lib/bs4/__init__.py b/lib/bs4/__init__.py
index e35725b86e..d8ad5e1dc1 100644
--- a/lib/bs4/__init__.py
+++ b/lib/bs4/__init__.py
@@ -1,65 +1,99 @@
-"""Beautiful Soup
-Elixir and Tonic
-"The Screen-Scraper's Friend"
+"""Beautiful Soup Elixir and Tonic - "The Screen-Scraper's Friend".
+
 http://www.crummy.com/software/BeautifulSoup/
 
 Beautiful Soup uses a pluggable XML or HTML parser to parse a
 (possibly invalid) document into a tree representation. Beautiful Soup
-provides provides methods and Pythonic idioms that make it easy to
-navigate, search, and modify the parse tree.
+provides methods and Pythonic idioms that make it easy to navigate,
+search, and modify the parse tree.
 
-Beautiful Soup works with Python 2.6 and up. It works better if lxml
+Beautiful Soup works with Python 3.6 and up. It works better if lxml
 and/or html5lib is installed.
 
 For more than you ever wanted to know about Beautiful Soup, see the
-documentation:
-http://www.crummy.com/software/BeautifulSoup/bs4/doc/
+documentation: http://www.crummy.com/software/BeautifulSoup/bs4/doc/
 """
 
 __author__ = "Leonard Richardson (leonardr@segfault.org)"
-__version__ = "4.4.1"
-__copyright__ = "Copyright (c) 2004-2015 Leonard Richardson"
+__version__ = "4.12.3"
+__copyright__ = "Copyright (c) 2004-2024 Leonard Richardson"
+# Use of this source code is governed by the MIT license.
 __license__ = "MIT"
 
 __all__ = ['BeautifulSoup']
 
+from collections import Counter
 import os
 import re
+import sys
+import traceback
 import warnings
 
-from .builder import builder_registry, ParserRejectedMarkup
+# The very first thing we do is give a useful error if someone is
+# running this code under Python 2.
+if sys.version_info.major < 3:
+    raise ImportError('You are trying to use a Python 3-specific version of Beautiful Soup under Python 2. This will not work. The final version of Beautiful Soup to support Python 2 was 4.9.3.')
+
+from .builder import (
+    builder_registry,
+    ParserRejectedMarkup,
+    XMLParsedAsHTMLWarning,
+    HTMLParserTreeBuilder
+)
 from .dammit import UnicodeDammit
 from .element import (
     CData,
     Comment,
+    CSS,
     DEFAULT_OUTPUT_ENCODING,
     Declaration,
     Doctype,
     NavigableString,
     PageElement,
     ProcessingInstruction,
+    PYTHON_SPECIFIC_ENCODINGS,
     ResultSet,
+    Script,
+    Stylesheet,
     SoupStrainer,
     Tag,
+    TemplateString,
     )
 
-# The very first thing we do is give a useful error if someone is
-# running this code under Python 3 without converting it.
-'You are trying to run the Python 2 version of Beautiful Soup under Python 3. This will not work.'!='You need to convert the code, either by installing it (`python setup.py install`) or by running 2to3 (`2to3 -w bs4`).'
+# Define some custom warnings.
+class GuessedAtParserWarning(UserWarning):
+    """The warning issued when BeautifulSoup has to guess what parser to
+    use -- probably because no parser was specified in the constructor.
+    """
 
-class BeautifulSoup(Tag):
+class MarkupResemblesLocatorWarning(UserWarning):
+    """The warning issued when BeautifulSoup is given 'markup' that
+    actually looks like a resource locator -- a URL or a path to a file
+    on disk.
     """
-    This class defines the basic interface called by the tree builders.
 
-    These methods will be called by the parser:
-      reset()
-      feed(markup)
+   
+class BeautifulSoup(Tag):
+    """A data structure representing a parsed HTML or XML document.
+
+    Most of the methods you'll call on a BeautifulSoup object are inherited from
+    PageElement or Tag.
+
+    Internally, this class defines the basic interface called by the
+    tree builders when converting an HTML/XML document into a data
+    structure. The interface abstracts away the differences between
+    parsers. To write a new tree builder, you'll need to understand
+    these methods as a whole.
+
+    These methods will be called by the BeautifulSoup constructor:
+      * reset()
+      * feed(markup)
 
     The tree builder may call these methods from its feed() implementation:
-      handle_starttag(name, attrs) # See note about return value
-      handle_endtag(name)
-      handle_data(data) # Appends to the current data node
-      endData(containerClass=NavigableString) # Ends the current data node
+      * handle_starttag(name, attrs) # See note about return value
+      * handle_endtag(name)
+      * handle_data(data) # Appends to the current data node
+      * endData(containerClass) # Ends the current data node
 
     No matter how complicated the underlying parser is, you should be
     able to build a tree using 'start tag' events, 'end tag' events,
@@ -69,24 +103,77 @@ class BeautifulSoup(Tag):
     like HTML's <br> tag), call handle_starttag and then
     handle_endtag.
     """
+
+    # Since BeautifulSoup subclasses Tag, it's possible to treat it as
+    # a Tag with a .name. This name makes it clear the BeautifulSoup
+    # object isn't a real markup tag.
     ROOT_TAG_NAME = '[document]'
 
     # If the end-user gives no indication which tree builder they
     # want, look for one with these features.
     DEFAULT_BUILDER_FEATURES = ['html', 'fast']
 
+    # A string containing all ASCII whitespace characters, used in
+    # endData() to detect data chunks that seem 'empty'.
     ASCII_SPACES = '\x20\x0a\x09\x0c\x0d'
 
-    NO_PARSER_SPECIFIED_WARNING = "No parser was explicitly specified, so I'm using the best available %(markup_type)s parser for this system (\"%(parser)s\"). This usually isn't a problem, but if you run this code on another system, or in a different virtual environment, it may use a different parser and behave differently.\n\nTo get rid of this warning, change this:\n\n BeautifulSoup([your markup])\n\nto this:\n\n BeautifulSoup([your markup], \"%(parser)s\")\n"
-
+    NO_PARSER_SPECIFIED_WARNING = "No parser was explicitly specified, so I'm using the best available %(markup_type)s parser for this system (\"%(parser)s\"). This usually isn't a problem, but if you run this code on another system, or in a different virtual environment, it may use a different parser and behave differently.\n\nThe code that caused this warning is on line %(line_number)s of the file %(filename)s. To get rid of this warning, pass the additional argument 'features=\"%(parser)s\"' to the BeautifulSoup constructor.\n"
+   
     def __init__(self, markup="", features=None, builder=None,
                  parse_only=None, from_encoding=None, exclude_encodings=None,
-                 **kwargs):
-        """The Soup object is initialized as the 'root tag', and the
-        provided markup (which can be a string or a file-like object)
-        is fed into the underlying parser."""
-
+                 element_classes=None, **kwargs):
+        """Constructor.
+
+        :param markup: A string or a file-like object representing
+         markup to be parsed.
+
+        :param features: Desirable features of the parser to be
+         used. This may be the name of a specific parser ("lxml",
+         "lxml-xml", "html.parser", or "html5lib") or it may be the
+         type of markup to be used ("html", "html5", "xml"). It's
+         recommended that you name a specific parser, so that
+         Beautiful Soup gives you the same results across platforms
+         and virtual environments.
+
+        :param builder: A TreeBuilder subclass to instantiate (or
+         instance to use) instead of looking one up based on
+         `features`. You only need to use this if you've implemented a
+         custom TreeBuilder.
+
+        :param parse_only: A SoupStrainer. Only parts of the document
+         matching the SoupStrainer will be considered. This is useful
+         when parsing part of a document that would otherwise be too
+         large to fit into memory.
+
+        :param from_encoding: A string indicating the encoding of the
+         document to be parsed. Pass this in if Beautiful Soup is
+         guessing wrongly about the document's encoding.
+
+        :param exclude_encodings: A list of strings indicating
+         encodings known to be wrong. Pass this in if you don't know
+         the document's encoding but you know Beautiful Soup's guess is
+         wrong.
+
+        :param element_classes: A dictionary mapping BeautifulSoup
+         classes like Tag and NavigableString, to other classes you'd
+         like to be instantiated instead as the parse tree is
+         built. This is useful for subclassing Tag or NavigableString
+         to modify default behavior.
+
+        :param kwargs: For backwards compatibility purposes, the
+         constructor accepts certain keyword arguments used in
+         Beautiful Soup 3. None of these arguments do anything in
+         Beautiful Soup 4; they will result in a warning and then be
+         ignored.
+         
+         Apart from this, any keyword arguments passed into the
+         BeautifulSoup constructor are propagated to the TreeBuilder
+         constructor. This makes it possible to configure a
+         TreeBuilder by passing in arguments, not just by saying which
+         one to use.
+        """
         if 'convertEntities' in kwargs:
+            del kwargs['convertEntities']
             warnings.warn(
                 "BS4 does not respect the convertEntities argument to the "
                 "BeautifulSoup constructor. Entities are always converted "
@@ -125,10 +212,10 @@ class BeautifulSoup(Tag):
             if old_name in kwargs:
                 warnings.warn(
                     'The "%s" argument to the BeautifulSoup constructor '
-                    'has been renamed to "%s."' % (old_name, new_name))
-                value = kwargs[old_name]
-                del kwargs[old_name]
-                return value
+                    'has been renamed to "%s."' % (old_name, new_name),
+                    DeprecationWarning, stacklevel=3
+                )
+                return kwargs.pop(old_name)
             return None
 
         parse_only = parse_only or deprecated_argument(
@@ -137,13 +224,23 @@ class BeautifulSoup(Tag):
         from_encoding = from_encoding or deprecated_argument(
             "fromEncoding", "from_encoding")
 
-        if len(kwargs) > 0:
-            arg = list(kwargs.keys()).pop()
-            raise TypeError(
-                "__init__() got an unexpected keyword argument '%s'" % arg)
-
-        if builder is None:
-            original_features = features
+        if from_encoding and isinstance(markup, str):
+            warnings.warn("You provided Unicode markup but also provided a value for from_encoding. Your from_encoding will be ignored.")
+            from_encoding = None
+
+        self.element_classes = element_classes or dict()
+
+        # We need this information to track whether or not the builder
+        # was specified well enough that we can omit the 'you need to
+        # specify a parser' warning.
+        original_builder = builder
+        original_features = features
+            
+        if isinstance(builder, type):
+            # A builder class was passed in; it needs to be instantiated.
+            builder_class = builder
+            builder = None
+        elif builder is None:
             if isinstance(features, str):
                 features = [features]
             if features is None or len(features) == 0:
@@ -154,85 +251,227 @@ class BeautifulSoup(Tag):
                     "Couldn't find a tree builder with the features you "
                     "requested: %s. Do you need to install a parser library?"
                     % ",".join(features))
-            builder = builder_class()
-            if not (original_features == builder.NAME or
-                    original_features in builder.ALTERNATE_NAMES):
+
+        # At this point either we have a TreeBuilder instance in
+        # builder, or we have a builder_class that we can instantiate
+        # with the remaining **kwargs.
+        if builder is None:
+            builder = builder_class(**kwargs)
+            if not original_builder and not (
+                    original_features == builder.NAME or
+                    original_features in builder.ALTERNATE_NAMES
+            ) and markup:
+                # The user did not tell us which TreeBuilder to use,
+                # and we had to guess. Issue a warning.
                 if builder.is_xml:
                     markup_type = "XML"
                 else:
                     markup_type = "HTML"
-                warnings.warn(self.NO_PARSER_SPECIFIED_WARNING % dict(
-                    parser=builder.NAME,
-                    markup_type=markup_type))
 
+                # This code adapted from warnings.py so that we get the same line
+                # of code as our warnings.warn() call gets, even if the answer is wrong
+                # (as it may be in a multithreading situation).
+                caller = None
+                try:
+                    caller = sys._getframe(1)
+                except ValueError:
+                    pass
+                if caller:
+                    globals = caller.f_globals
+                    line_number = caller.f_lineno
+                else:
+                    globals = sys.__dict__
+                    line_number= 1                    
+                filename = globals.get('__file__')
+                if filename:
+                    fnl = filename.lower()
+                    if fnl.endswith((".pyc", ".pyo")):
+                        filename = filename[:-1]
+                if filename:
+                    # If there is no filename at all, the user is most likely in a REPL,
+                    # and the warning is not necessary.
+                    values = dict(
+                        filename=filename,
+                        line_number=line_number,
+                        parser=builder.NAME,
+                        markup_type=markup_type
+                    )
+                    warnings.warn(
+                        self.NO_PARSER_SPECIFIED_WARNING % values,
+                        GuessedAtParserWarning, stacklevel=2
+                    )
+        else:
+            if kwargs:
+                warnings.warn("Keyword arguments to the BeautifulSoup constructor will be ignored. These would normally be passed into the TreeBuilder constructor, but a TreeBuilder instance was passed in as `builder`.")
+                    
         self.builder = builder
         self.is_xml = builder.is_xml
-        self.builder.soup = self
-
+        self.known_xml = self.is_xml
+        self._namespaces = dict()
         self.parse_only = parse_only
 
         if hasattr(markup, 'read'):        # It's a file-type object.
             markup = markup.read()
-        elif len(markup) <= 256:
-            # Print out warnings for a couple beginner problems
+        elif len(markup) <= 256 and (
+                (isinstance(markup, bytes) and not b'<' in markup)
+                or (isinstance(markup, str) and not '<' in markup)
+        ):
+            # Issue warnings for a couple beginner problems
             # involving passing non-markup to Beautiful Soup.
             # Beautiful Soup will still parse the input as markup,
-            # just in case that's what the user really wants.
-            if (isinstance(markup, str)
-                and not os.path.supports_unicode_filenames):
-                possible_filename = markup.encode("utf8")
-            else:
-                possible_filename = markup
-            is_file = False
-            try:
-                is_file = os.path.exists(possible_filename)
-            except Exception as e:
-                # This is almost certainly a problem involving
-                # characters not valid in filenames on this
-                # system. Just let it go.
-                pass
-            if is_file:
-                if isinstance(markup, str):
-                    markup = markup.encode("utf8")
-                warnings.warn(
-                    '"%s" looks like a filename, not markup. You should probably open this file and pass the filehandle into Beautiful Soup.' % markup)
-            if markup[:5] == "http:" or markup[:6] == "https:":
-                # TODO: This is ugly but I couldn't get it to work in
-                # Python 3 otherwise.
-                if ((isinstance(markup, bytes) and not b' ' in markup)
-                    or (isinstance(markup, str) and not ' ' in markup)):
-                    if isinstance(markup, str):
-                        markup = markup.encode("utf8")
-                    warnings.warn(
-                        '"%s" looks like a URL. Beautiful Soup is not an HTTP client. You should probably use an HTTP client to get the document behind the URL, and feed that document to Beautiful Soup.' % markup)
+            # since that is sometimes the intended behavior.
+            if not self._markup_is_url(markup):
+                self._markup_resembles_filename(markup)                
 
+        rejections = []
+        success = False
         for (self.markup, self.original_encoding, self.declared_html_encoding,
          self.contains_replacement_characters) in (
              self.builder.prepare_markup(
                  markup, from_encoding, exclude_encodings=exclude_encodings)):
             self.reset()
+            self.builder.initialize_soup(self)
             try:
                 self._feed()
+                success = True
                 break
-            except ParserRejectedMarkup:
+            except ParserRejectedMarkup as e:
+                rejections.append(e)
                 pass
 
+        if not success:
+            other_exceptions = [str(e) for e in rejections]
+            raise ParserRejectedMarkup(
+                "The markup you provided was rejected by the parser. Trying a different parser or a different encoding may help.\n\nOriginal exception(s) from parser:\n " + "\n ".join(other_exceptions)
+            )
+
         # Clear out the markup and remove the builder's circular
         # reference to this object.
         self.markup = None
         self.builder.soup = None
 
-    def __copy__(self):
-        return type(self)(self.encode(), builder=self.builder)
+    def _clone(self):
+        """Create a new BeautifulSoup object with the same TreeBuilder,
+        but not associated with any markup.
+
+        This is the first step of the deepcopy process.
+        """
+        clone = type(self)("", None, self.builder)
 
+        # Keep track of the encoding of the original document,
+        # since we won't be parsing it again.
+        clone.original_encoding = self.original_encoding
+        return clone
+        
     def __getstate__(self):
         # Frequently a tree builder can't be pickled.
         d = dict(self.__dict__)
-        if 'builder' in d and not self.builder.picklable:
-            del d['builder']
+        if 'builder' in d and d['builder'] is not None and not self.builder.picklable:
+            d['builder'] = type(self.builder)
+        # Store the contents as a Unicode string.
+        d['contents'] = []
+        d['markup'] = self.decode()
+
+        # If _most_recent_element is present, it's a Tag object left
+        # over from initial parse. It might not be picklable and we
+        # don't need it.
+        if '_most_recent_element' in d:
+            del d['_most_recent_element']
         return d
 
+    def __setstate__(self, state):
+        # If necessary, restore the TreeBuilder by looking it up.
+        self.__dict__ = state
+        if isinstance(self.builder, type):
+            self.builder = self.builder()
+        elif not self.builder:
+            # We don't know which builder was used to build this
+            # parse tree, so use a default we know is always available.
+            self.builder = HTMLParserTreeBuilder()
+        self.builder.soup = self
+        self.reset()
+        self._feed()
+        return state
+
+    
+    @classmethod
+    def _decode_markup(cls, markup):
+        """Ensure `markup` is bytes so it's safe to send into warnings.warn.
+
+        TODO: warnings.warn had this problem back in 2010 but it might not
+        anymore.
+        """
+        if isinstance(markup, bytes):
+            decoded = markup.decode('utf-8', 'replace')
+        else:
+            decoded = markup
+        return decoded
+
+    @classmethod
+    def _markup_is_url(cls, markup):
+        """Error-handling method to raise a warning if incoming markup looks
+        like a URL.
+
+        :param markup: A string.
+        :return: Whether or not the markup resembles a URL
+            closely enough to justify a warning.
+        """
+        if isinstance(markup, bytes):
+            space = b' '
+            cant_start_with = (b"http:", b"https:")
+        elif isinstance(markup, str):
+            space = ' '
+            cant_start_with = ("http:", "https:")
+        else:
+            return False
+
+        if any(markup.startswith(prefix) for prefix in cant_start_with):
+            if not space in markup:
+                warnings.warn(
+                    'The input looks more like a URL than markup. You may want to use'
+                    ' an HTTP client like requests to get the document behind'
+                    ' the URL, and feed that document to Beautiful Soup.',
+                    MarkupResemblesLocatorWarning,
+                    stacklevel=3
+                )
+                return True
+        return False
+
+    @classmethod
+    def _markup_resembles_filename(cls, markup):
+        """Error-handling method to raise a warning if incoming markup
+        resembles a filename.
+
+        :param markup: A bytestring or string.
+        :return: Whether or not the markup resembles a filename
+            closely enough to justify a warning.
+        """
+        path_characters = '/\\'
+        extensions = ['.html', '.htm', '.xml', '.xhtml', '.txt']
+        if isinstance(markup, bytes):
+            path_characters = path_characters.encode("utf8")
+            extensions = [x.encode('utf8') for x in extensions]
+        filelike = False
+        if any(x in markup for x in path_characters):
+            filelike = True
+        else:
+            lower = markup.lower()
+            if any(lower.endswith(ext) for ext in extensions):
+                filelike = True
+        if filelike:
+            warnings.warn(
+                'The input looks more like a filename than markup. You may'
+                ' want to open this file and pass the filehandle into'
+                ' Beautiful Soup.',
+                MarkupResemblesLocatorWarning, stacklevel=3
+            )
+            return True
+        return False
+    
     def _feed(self):
+        """Internal method that parses previously set markup, creating a large
+        number of Tag and NavigableString objects.
+        """
         # Convert the document to Unicode.
         self.builder.reset()
 
@@ -243,48 +482,111 @@ class BeautifulSoup(Tag):
             self.popTag()
 
     def reset(self):
+        """Reset this object to a state as though it had never parsed any
+        markup.
+        """
         Tag.__init__(self, self, self.builder, self.ROOT_TAG_NAME)
         self.hidden = 1
         self.builder.reset()
         self.current_data = []
         self.currentTag = None
         self.tagStack = []
+        self.open_tag_counter = Counter()
         self.preserve_whitespace_tag_stack = []
+        self.string_container_stack = []
+        self._most_recent_element = None
         self.pushTag(self)
 
-    def new_tag(self, name, namespace=None, nsprefix=None, **attrs):
-        """Create a new tag associated with this soup."""
-        return Tag(None, self.builder, name, namespace, nsprefix, attrs)
+    def new_tag(self, name, namespace=None, nsprefix=None, attrs={},
+                sourceline=None, sourcepos=None, **kwattrs):
+        """Create a new Tag associated with this BeautifulSoup object.
+
+        :param name: The name of the new Tag.
+        :param namespace: The URI of the new Tag's XML namespace, if any.
+        :param prefix: The prefix for the new Tag's XML namespace, if any.
+        :param attrs: A dictionary of this Tag's attribute values; can
+            be used instead of `kwattrs` for attributes like 'class'
+            that are reserved words in Python.
+        :param sourceline: The line number where this tag was
+            (purportedly) found in its source document.
+        :param sourcepos: The character position within `sourceline` where this
+            tag was (purportedly) found.
+        :param kwattrs: Keyword arguments for the new Tag's attribute values.
 
-    def new_string(self, s, subclass=NavigableString):
-        """Create a new NavigableString associated with this soup."""
-        return subclass(s)
+        """
+        kwattrs.update(attrs)
+        return self.element_classes.get(Tag, Tag)(
+            None, self.builder, name, namespace, nsprefix, kwattrs,
+            sourceline=sourceline, sourcepos=sourcepos
+        )
+
+    def string_container(self, base_class=None):
+        container = base_class or NavigableString
+        
+        # There may be a general override of NavigableString.
+        container = self.element_classes.get(
+            container, container
+        )
+
+        # On top of that, we may be inside a tag that needs a special
+        # container class.
+        if self.string_container_stack and container is NavigableString:
+            container = self.builder.string_containers.get(
+                self.string_container_stack[-1].name, container
+            )
+        return container
+        
+    def new_string(self, s, subclass=None):
+        """Create a new NavigableString associated with this BeautifulSoup
+        object.
+        """
+        container = self.string_container(subclass)
+        return container(s)
 
-    def insert_before(self, successor):
+    def insert_before(self, *args):
+        """This method is part of the PageElement API, but `BeautifulSoup` doesn't implement
+        it because there is nothing before or after it in the parse tree.
+        """
         raise NotImplementedError("BeautifulSoup objects don't support insert_before().")
 
-    def insert_after(self, successor):
+    def insert_after(self, *args):
+        """This method is part of the PageElement API, but `BeautifulSoup` doesn't implement
+        it because there is nothing before or after it in the parse tree.
+        """
         raise NotImplementedError("BeautifulSoup objects don't support insert_after().")
 
     def popTag(self):
+        """Internal method called by _popToTag when a tag is closed."""
         tag = self.tagStack.pop()
+        if tag.name in self.open_tag_counter:
+            self.open_tag_counter[tag.name] -= 1
         if self.preserve_whitespace_tag_stack and tag == self.preserve_whitespace_tag_stack[-1]:
             self.preserve_whitespace_tag_stack.pop()
-        #print "Pop", tag.name
+        if self.string_container_stack and tag == self.string_container_stack[-1]:
+            self.string_container_stack.pop()
+        #print("Pop", tag.name)
         if self.tagStack:
             self.currentTag = self.tagStack[-1]
         return self.currentTag
 
     def pushTag(self, tag):
-        #print "Push", tag.name
-        if self.currentTag:
+        """Internal method called by handle_starttag when a tag is opened."""
+        #print("Push", tag.name)
+        if self.currentTag is not None:
             self.currentTag.contents.append(tag)
         self.tagStack.append(tag)
         self.currentTag = self.tagStack[-1]
+        if tag.name != self.ROOT_TAG_NAME:
+            self.open_tag_counter[tag.name] += 1
         if tag.name in self.builder.preserve_whitespace_tags:
             self.preserve_whitespace_tag_stack.append(tag)
+        if tag.name in self.builder.string_containers:
+            self.string_container_stack.append(tag)
 
-    def endData(self, containerClass=NavigableString):
+    def endData(self, containerClass=None):
+        """Method called by the TreeBuilder when the end of a data segment
+        occurs.
+        """       
         if self.current_data:
             current_data = ''.join(self.current_data)
             # If whitespace is not preserved, and this string contains
@@ -311,61 +613,93 @@ class BeautifulSoup(Tag):
                     not self.parse_only.search(current_data)):
                 return
 
+            containerClass = self.string_container(containerClass)
             o = containerClass(current_data)
             self.object_was_parsed(o)
 
     def object_was_parsed(self, o, parent=None, most_recent_element=None):
-        """Add an object to the parse tree."""
-        parent = parent or self.currentTag
-        previous_element = most_recent_element or self._most_recent_element
+        """Method called by the TreeBuilder to integrate an object into the parse tree."""
+        if parent is None:
+            parent = self.currentTag
+        if most_recent_element is not None:
+            previous_element = most_recent_element
+        else:
+            previous_element = self._most_recent_element
 
         next_element = previous_sibling = next_sibling = None
         if isinstance(o, Tag):
             next_element = o.next_element
             next_sibling = o.next_sibling
             previous_sibling = o.previous_sibling
-            if not previous_element:
+            if previous_element is None:
                 previous_element = o.previous_element
 
+        fix = parent.next_element is not None
+
         o.setup(parent, previous_element, next_element, previous_sibling, next_sibling)
 
         self._most_recent_element = o
         parent.contents.append(o)
 
-        if parent.next_sibling:
-            # This node is being inserted into an element that has
-            # already been parsed. Deal with any dangling references.
-            index = parent.contents.index(o)
-            if index == 0:
-                previous_element = parent
-                previous_sibling = None
-            else:
-                previous_element = previous_sibling = parent.contents[index-1]
-            if index == len(parent.contents)-1:
-                next_element = parent.next_sibling
-                next_sibling = None
-            else:
-                next_element = next_sibling = parent.contents[index+1]
-
-            o.previous_element = previous_element
-            if previous_element:
-                previous_element.next_element = o
-            o.next_element = next_element
-            if next_element:
-                next_element.previous_element = o
-            o.next_sibling = next_sibling
-            if next_sibling:
-                next_sibling.previous_sibling = o
-            o.previous_sibling = previous_sibling
-            if previous_sibling:
-                previous_sibling.next_sibling = o
+        # Check if we are inserting into an already parsed node.
+        if fix:
+            self._linkage_fixer(parent)
+
+    def _linkage_fixer(self, el):
+        """Make sure linkage of this fragment is sound."""
+
+        first = el.contents[0]
+        child = el.contents[-1]
+        descendant = child
+
+        if child is first and el.parent is not None:
+            # Parent should be linked to first child
+            el.next_element = child
+            # We are no longer linked to whatever this element is
+            prev_el = child.previous_element
+            if prev_el is not None and prev_el is not el:
+                prev_el.next_element = None
+            # First child should be linked to the parent, and no previous siblings.
+            child.previous_element = el
+            child.previous_sibling = None
+
+        # We have no sibling as we've been appended as the last.
+        child.next_sibling = None
+
+        # This index is a tag, dig deeper for a "last descendant"
+        if isinstance(child, Tag) and child.contents:
+            descendant = child._last_descendant(False)
+
+        # As the final step, link last descendant. It should be linked
+        # to the parent's next sibling (if found), else walk up the chain
+        # and find a parent with a sibling. It should have no next sibling.
+        descendant.next_element = None
+        descendant.next_sibling = None
+        target = el
+        while True:
+            if target is None:
+                break
+            elif target.next_sibling is not None:
+                descendant.next_element = target.next_sibling
+                target.next_sibling.previous_element = child
+                break
+            target = target.parent
 
     def _popToTag(self, name, nsprefix=None, inclusivePop=True):
         """Pops the tag stack up to and including the most recent
-        instance of the given tag. If inclusivePop is false, pops the tag
-        stack up to but *not* including the most recent instqance of
-        the given tag."""
-        #print "Popping to %s" % name
+        instance of the given tag.
+
+        If there are no open tags with the given name, nothing will be
+        popped.
+
+        :param name: Pop up to the most recent tag with this name.
+        :param nsprefix: The namespace prefix that goes with `name`.
+        :param inclusivePop: It this is false, pops the tag stack up
+          to but *not* including the most recent instqance of the
+          given tag.
+
+        """
+        #print("Popping to %s" % name)
         if name == self.ROOT_TAG_NAME:
             # The BeautifulSoup object itself can never be popped.
             return
@@ -374,6 +708,8 @@ class BeautifulSoup(Tag):
 
         stack_size = len(self.tagStack)
         for i in range(stack_size - 1, 0, -1):
+            if not self.open_tag_counter.get(name):
+                break
             t = self.tagStack[i]
             if (name == t.name and nsprefix == t.prefix):
                 if inclusivePop:
@@ -383,16 +719,26 @@ class BeautifulSoup(Tag):
 
         return most_recently_popped
 
-    def handle_starttag(self, name, namespace, nsprefix, attrs):
-        """Push a start tag on to the stack.
-
-        If this method returns None, the tag was rejected by the
-        SoupStrainer. You should proceed as if the tag had not occured
+    def handle_starttag(self, name, namespace, nsprefix, attrs, sourceline=None,
+                        sourcepos=None, namespaces=None):
+        """Called by the tree builder when a new tag is encountered.
+
+        :param name: Name of the tag.
+        :param nsprefix: Namespace prefix for the tag.
+        :param attrs: A dictionary of attribute values.
+        :param sourceline: The line number where this tag was found in its
+            source document.
+        :param sourcepos: The character position within `sourceline` where this
+            tag was found.
+        :param namespaces: A dictionary of all namespace prefix mappings 
+            currently in scope in the document.
+
+        If this method returns None, the tag was rejected by an active
+        SoupStrainer. You should proceed as if the tag had not occurred
         in the document. For instance, if this was a self-closing tag,
         don't call handle_endtag.
         """
-
-        # print "Start tag %s: %s" % (name, attrs)
+        # print("Start tag %s: %s" % (name, attrs))
         self.endData()
 
         if (self.parse_only and len(self.tagStack) <= 1
@@ -400,34 +746,54 @@ class BeautifulSoup(Tag):
                  or not self.parse_only.search_tag(name, attrs))):
             return None
 
-        tag = Tag(self, self.builder, name, namespace, nsprefix, attrs,
-                  self.currentTag, self._most_recent_element)
+        tag = self.element_classes.get(Tag, Tag)(
+            self, self.builder, name, namespace, nsprefix, attrs,
+            self.currentTag, self._most_recent_element,
+            sourceline=sourceline, sourcepos=sourcepos,
+            namespaces=namespaces
+        )
         if tag is None:
             return tag
-        if self._most_recent_element:
+        if self._most_recent_element is not None:
             self._most_recent_element.next_element = tag
         self._most_recent_element = tag
         self.pushTag(tag)
         return tag
 
     def handle_endtag(self, name, nsprefix=None):
-        #print "End tag: " + name
+        """Called by the tree builder when an ending tag is encountered.
+
+        :param name: Name of the tag.
+        :param nsprefix: Namespace prefix for the tag.
+        """
+        #print("End tag: " + name)
         self.endData()
         self._popToTag(name, nsprefix)
-
+        
     def handle_data(self, data):
+        """Called by the tree builder when a chunk of textual data is encountered."""
         self.current_data.append(data)
-
+       
     def decode(self, pretty_print=False,
                eventual_encoding=DEFAULT_OUTPUT_ENCODING,
-               formatter="minimal"):
-        """Returns a string or Unicode representation of this document.
-        To get Unicode, pass None for encoding."""
-
+               formatter="minimal", iterator=None):
+        """Returns a string or Unicode representation of the parse tree
+            as an HTML or XML document.
+
+        :param pretty_print: If this is True, indentation will be used to
+            make the document more readable.
+        :param eventual_encoding: The encoding of the final document.
+            If this is None, the document will be a Unicode string.
+        """
         if self.is_xml:
             # Print the XML declaration
             encoding_part = ''
-            if eventual_encoding is not None:
+            if eventual_encoding in PYTHON_SPECIFIC_ENCODINGS:
+                # This is a special Python encoding; it can't actually
+                # go into an XML document because it means nothing
+                # outside of Python.
+                eventual_encoding = None
+            if eventual_encoding != None:
                 encoding_part = ' encoding="%s"' % eventual_encoding
             prefix = '<?xml version="1.0"%s?>\n' % encoding_part
         else:
@@ -437,9 +803,9 @@ class BeautifulSoup(Tag):
         else:
             indent_level = 0
         return prefix + super(BeautifulSoup, self).decode(
-            indent_level, eventual_encoding, formatter)
+            indent_level, eventual_encoding, formatter, iterator)
 
-# Alias to make it easier to type import: 'from bs4 import _soup'
+# Aliases to make it easier to get started quickly, e.g. 'from bs4 import _soup'
 _s = BeautifulSoup
 _soup = BeautifulSoup
 
@@ -450,19 +816,25 @@ class BeautifulStoneSoup(BeautifulSoup):
         kwargs['features'] = 'xml'
         warnings.warn(
             'The BeautifulStoneSoup class is deprecated. Instead of using '
-            'it, pass features="xml" into the BeautifulSoup constructor.')
+            'it, pass features="xml" into the BeautifulSoup constructor.',
+            DeprecationWarning, stacklevel=2
+        )
         super(BeautifulStoneSoup, self).__init__(*args, **kwargs)
 
 
 class StopParsing(Exception):
+    """Exception raised by a TreeBuilder if it's unable to continue parsing."""
     pass
 
 class FeatureNotFound(ValueError):
+    """Exception raised by the BeautifulSoup constructor if no parser with the
+    requested features is found.
+    """
     pass
 
 
-#By default, act as an HTML pretty-printer.
+#If this file is run as a script, act as an HTML pretty-printer.
 if __name__ == '__main__':
     import sys
     soup = BeautifulSoup(sys.stdin)
-    print(soup.prettify())
+    print((soup.prettify()))
diff --git a/lib/bs4/builder/__init__.py b/lib/bs4/builder/__init__.py
index 6ccd4d23d6..ffb31fc25e 100644
--- a/lib/bs4/builder/__init__.py
+++ b/lib/bs4/builder/__init__.py
@@ -1,11 +1,21 @@
+# Use of this source code is governed by the MIT license.
+__license__ = "MIT"
+
 from collections import defaultdict
 import itertools
+import re
+import warnings
 import sys
 from bs4.element import (
     CharsetMetaAttributeValue,
     ContentMetaAttributeValue,
-    whitespace_re
-    )
+    RubyParenthesisString,
+    RubyTextString,
+    Stylesheet,
+    Script,
+    TemplateString,
+    nonwhitespace_re
+)
 
 __all__ = [
     'HTMLTreeBuilder',
@@ -22,20 +32,41 @@ XML = 'xml'
 HTML = 'html'
 HTML_5 = 'html5'
 
+class XMLParsedAsHTMLWarning(UserWarning):
+    """The warning issued when an HTML parser is used to parse
+    XML that is not XHTML.
+    """
+    MESSAGE = """It looks like you're parsing an XML document using an HTML parser. If this really is an HTML document (maybe it's XHTML?), you can ignore or filter this warning. If it's XML, you should know that using an XML parser will be more reliable. To parse this document as XML, make sure you have the lxml package installed, and pass the keyword argument `features="xml"` into the BeautifulSoup constructor."""
+
 
 class TreeBuilderRegistry(object):
-
+    """A way of looking up TreeBuilder subclasses by their name or by desired
+    features.
+    """
+    
     def __init__(self):
         self.builders_for_feature = defaultdict(list)
         self.builders = []
 
     def register(self, treebuilder_class):
-        """Register a treebuilder based on its advertised features."""
+        """Register a treebuilder based on its advertised features.
+
+        :param treebuilder_class: A subclass of Treebuilder. its .features
+           attribute should list its features.
+        """
         for feature in treebuilder_class.features:
             self.builders_for_feature[feature].insert(0, treebuilder_class)
         self.builders.insert(0, treebuilder_class)
 
     def lookup(self, *features):
+        """Look up a TreeBuilder subclass with the desired features.
+
+        :param features: A list of features to look for. If none are
+            provided, the most recently registered TreeBuilder subclass
+            will be used.
+        :return: A TreeBuilder subclass, or None if there's no
+            registered subclass with all the requested features.
+        """
         if len(self.builders) == 0:
             # There are no builders at all.
             return None
@@ -78,7 +109,7 @@ class TreeBuilderRegistry(object):
 builder_registry = TreeBuilderRegistry()
 
 class TreeBuilder(object):
-    """Turn a document into a Beautiful Soup object tree."""
+    """Turn a textual document into a Beautiful Soup object tree."""
 
     NAME = "[Unknown tree builder]"
     ALTERNATE_NAMES = []
@@ -86,19 +117,89 @@ class TreeBuilder(object):
 
     is_xml = False
     picklable = False
-    preserve_whitespace_tags = set()
     empty_element_tags = None # A tag will be considered an empty-element
                               # tag when and only when it has no contents.
-
+    
     # A value for these tag/attribute combinations is a space- or
     # comma-separated list of CDATA, rather than a single CDATA.
-    cdata_list_attributes = {}
-
-
-    def __init__(self):
+    DEFAULT_CDATA_LIST_ATTRIBUTES = defaultdict(list)
+
+    # Whitespace should be preserved inside these tags.
+    DEFAULT_PRESERVE_WHITESPACE_TAGS = set()
+
+    # The textual contents of tags with these names should be
+    # instantiated with some class other than NavigableString.
+    DEFAULT_STRING_CONTAINERS = {}
+    
+    USE_DEFAULT = object()
+
+    # Most parsers don't keep track of line numbers.
+    TRACKS_LINE_NUMBERS = False
+    
+    def __init__(self, multi_valued_attributes=USE_DEFAULT,
+                 preserve_whitespace_tags=USE_DEFAULT,
+                 store_line_numbers=USE_DEFAULT,
+                 string_containers=USE_DEFAULT,
+    ):
+        """Constructor.
+
+        :param multi_valued_attributes: If this is set to None, the
+         TreeBuilder will not turn any values for attributes like
+         'class' into lists. Setting this to a dictionary will
+         customize this behavior; look at DEFAULT_CDATA_LIST_ATTRIBUTES
+         for an example.
+
+         Internally, these are called "CDATA list attributes", but that
+         probably doesn't make sense to an end-user, so the argument name
+         is `multi_valued_attributes`.
+
+        :param preserve_whitespace_tags: A list of tags to treat
+         the way <pre> tags are treated in HTML. Tags in this list
+         are immune from pretty-printing; their contents will always be
+         output as-is.
+
+        :param string_containers: A dictionary mapping tag names to
+        the classes that should be instantiated to contain the textual
+        contents of those tags. The default is to use NavigableString
+        for every tag, no matter what the name. You can override the
+        default by changing DEFAULT_STRING_CONTAINERS.
+
+        :param store_line_numbers: If the parser keeps track of the
+         line numbers and positions of the original markup, that
+         information will, by default, be stored in each corresponding
+         `Tag` object. You can turn this off by passing
+         store_line_numbers=False. If the parser you're using doesn't 
+         keep track of this information, then setting store_line_numbers=True
+         will do nothing.
+        """
         self.soup = None
-
+        if multi_valued_attributes is self.USE_DEFAULT:
+            multi_valued_attributes = self.DEFAULT_CDATA_LIST_ATTRIBUTES
+        self.cdata_list_attributes = multi_valued_attributes
+        if preserve_whitespace_tags is self.USE_DEFAULT:
+            preserve_whitespace_tags = self.DEFAULT_PRESERVE_WHITESPACE_TAGS
+        self.preserve_whitespace_tags = preserve_whitespace_tags
+        if store_line_numbers == self.USE_DEFAULT:
+            store_line_numbers = self.TRACKS_LINE_NUMBERS
+        self.store_line_numbers = store_line_numbers 
+        if string_containers == self.USE_DEFAULT:
+            string_containers = self.DEFAULT_STRING_CONTAINERS
+        self.string_containers = string_containers
+        
+    def initialize_soup(self, soup):
+        """The BeautifulSoup object has been initialized and is now
+        being associated with the TreeBuilder.
+
+        :param soup: A BeautifulSoup object.
+        """
+        self.soup = soup
+        
     def reset(self):
+        """Do any work necessary to reset the underlying parser
+        for a new document.
+
+        By default, this does nothing.
+        """
         pass
 
     def can_be_empty_element(self, tag_name):
@@ -110,24 +211,58 @@ class TreeBuilder(object):
         For instance: an HTMLBuilder does not consider a <p> tag to be
         an empty-element tag (it's not in
         HTMLBuilder.empty_element_tags). This means an empty <p> tag
-        will be presented as "<p></p>", not "<p />".
+        will be presented as "<p></p>", not "<p/>" or "<p>".
 
         The default implementation has no opinion about which tags are
         empty-element tags, so a tag will be presented as an
-        empty-element tag if and only if it has no contents.
-        "<foo></foo>" will become "<foo />", and "<foo>bar</foo>" will
+        empty-element tag if and only if it has no children.
+        "<foo></foo>" will become "<foo/>", and "<foo>bar</foo>" will
         be left alone.
+
+        :param tag_name: The name of a markup tag.
         """
         if self.empty_element_tags is None:
             return True
         return tag_name in self.empty_element_tags
-
+    
     def feed(self, markup):
+        """Run some incoming markup through some parsing process,
+        populating the `BeautifulSoup` object in self.soup.
+
+        This method is not implemented in TreeBuilder; it must be
+        implemented in subclasses.
+
+        :return: None.
+        """
         raise NotImplementedError()
 
     def prepare_markup(self, markup, user_specified_encoding=None,
-                       document_declared_encoding=None):
-        return markup, None, None, False
+                       document_declared_encoding=None, exclude_encodings=None):
+        """Run any preliminary steps necessary to make incoming markup
+        acceptable to the parser.
+
+        :param markup: Some markup -- probably a bytestring.
+        :param user_specified_encoding: The user asked to try this encoding.
+        :param document_declared_encoding: The markup itself claims to be
+            in this encoding. NOTE: This argument is not used by the
+            calling code and can probably be removed.
+        :param exclude_encodings: The user asked _not_ to try any of
+            these encodings.
+
+        :yield: A series of 4-tuples:
+         (markup, encoding, declared encoding,
+          has undergone character replacement)
+
+         Each 4-tuple represents a strategy for converting the
+         document to Unicode and parsing it. Each strategy will be tried 
+         in turn.
+
+         By default, the only strategy is to parse the markup
+         as-is. See `LXMLTreeBuilderForXML` and
+         `HTMLParserTreeBuilder` for implementations that take into
+         account the quirks of particular parsers.
+        """
+        yield markup, None, None, False
 
     def test_fragment_to_document(self, fragment):
         """Wrap an HTML fragment to make it look like a document.
@@ -139,16 +274,36 @@ class TreeBuilder(object):
         results against other HTML fragments.
 
         This method should not be used outside of tests.
+
+        :param fragment: A string -- fragment of HTML.
+        :return: A string -- a full HTML document.
         """
         return fragment
 
     def set_up_substitutions(self, tag):
+        """Set up any substitutions that will need to be performed on 
+        a `Tag` when it's output as a string.
+
+        By default, this does nothing. See `HTMLTreeBuilder` for a
+        case where this is used.
+
+        :param tag: A `Tag`
+        :return: Whether or not a substitution was performed.
+        """
         return False
 
     def _replace_cdata_list_attribute_values(self, tag_name, attrs):
-        """Replaces class="foo bar" with class=["foo", "bar"]
+        """When an attribute value is associated with a tag that can
+        have multiple values for that attribute, convert the string
+        value to a list of strings.
 
-        Modifies its input in place.
+        Basically, replaces class="foo bar" with class=["foo", "bar"]
+
+        NOTE: This method modifies its input in place.
+
+        :param tag_name: The name of a tag.
+        :param attrs: A dictionary containing the tag's attributes.
+           Any appropriate attribute values will be modified in place.
         """
         if not attrs:
             return attrs
@@ -163,7 +318,7 @@ class TreeBuilder(object):
                     # values. Split it into a list.
                     value = attrs[attr]
                     if isinstance(value, str):
-                        values = whitespace_re.split(value)
+                        values = nonwhitespace_re.findall(value)
                     else:
                         # html5lib sometimes calls setAttributes twice
                         # for the same tag when rearranging the parse
@@ -174,9 +329,13 @@ class TreeBuilder(object):
                         values = value
                     attrs[attr] = values
         return attrs
-
+    
 class SAXTreeBuilder(TreeBuilder):
-    """A Beautiful Soup treebuilder that listens for SAX events."""
+    """A Beautiful Soup treebuilder that listens for SAX events.
+
+    This is not currently used for anything, but it demonstrates
+    how a simple TreeBuilder would work.
+    """
 
     def feed(self, markup):
         raise NotImplementedError()
@@ -186,11 +345,11 @@ class SAXTreeBuilder(TreeBuilder):
 
     def startElement(self, name, attrs):
         attrs = dict((key[1], value) for key, value in list(attrs.items()))
-        #print "Start %s, %r" % (name, attrs)
+        #print("Start %s, %r" % (name, attrs))
         self.soup.handle_starttag(name, attrs)
 
     def endElement(self, name):
-        #print "End %s" % name
+        #print("End %s" % name)
         self.soup.handle_endtag(name)
 
     def startElementNS(self, nsTuple, nodeName, attrs):
@@ -227,10 +386,44 @@ class HTMLTreeBuilder(TreeBuilder):
     Such as which tags are empty-element tags.
     """
 
-    preserve_whitespace_tags = set(['pre', 'textarea'])
-    empty_element_tags = set(['br' , 'hr', 'input', 'img', 'meta',
-                              'spacer', 'link', 'frame', 'base'])
-
+    empty_element_tags = set([
+        # These are from HTML5.
+        'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'keygen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr',
+        
+        # These are from earlier versions of HTML and are removed in HTML5.
+        'basefont', 'bgsound', 'command', 'frame', 'image', 'isindex', 'nextid', 'spacer'
+    ])
+
+    # The HTML standard defines these as block-level elements. Beautiful
+    # Soup does not treat these elements differently from other elements,
+    # but it may do so eventually, and this information is available if
+    # you need to use it.
+    block_elements = set(["address", "article", "aside", "blockquote", "canvas", "dd", "div", "dl", "dt", "fieldset", "figcaption", "figure", "footer", "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hr", "li", "main", "nav", "noscript", "ol", "output", "p", "pre", "section", "table", "tfoot", "ul", "video"])
+
+    # These HTML tags need special treatment so they can be
+    # represented by a string class other than NavigableString.
+    #
+    # For some of these tags, it's because the HTML standard defines
+    # an unusual content model for them. I made this list by going
+    # through the HTML spec
+    # (https://html.spec.whatwg.org/#metadata-content) and looking for
+    # "metadata content" elements that can contain strings.
+    #
+    # The Ruby tags (<rt> and <rp>) are here despite being normal
+    # "phrasing content" tags, because the content they contain is
+    # qualitatively different from other text in the document, and it
+    # can be useful to be able to distinguish it.
+    #
+    # TODO: Arguably <noscript> could go here but it seems
+    # qualitatively different from the other tags.
+    DEFAULT_STRING_CONTAINERS = {
+        'rt' : RubyTextString,
+        'rp' : RubyParenthesisString,
+        'style': Stylesheet,
+        'script': Script,
+        'template': TemplateString,
+    }    
+    
     # The HTML standard defines these attributes as containing a
     # space-separated list of values, not a single value. That is,
     # class="foo bar" means that the 'class' attribute has two values,
@@ -238,7 +431,7 @@ class HTMLTreeBuilder(TreeBuilder):
     # encounter one of these attributes, we will parse its value into
     # a list of values if possible. Upon output, the list will be
     # converted back into a string.
-    cdata_list_attributes = {
+    DEFAULT_CDATA_LIST_ATTRIBUTES = {
         "*" : ['class', 'accesskey', 'dropzone'],
         "a" : ['rel', 'rev'],
         "link" :  ['rel', 'rev'],
@@ -255,7 +448,19 @@ class HTMLTreeBuilder(TreeBuilder):
         "output" : ["for"],
         }
 
+    DEFAULT_PRESERVE_WHITESPACE_TAGS = set(['pre', 'textarea'])
+
     def set_up_substitutions(self, tag):
+        """Replace the declared encoding in a <meta> tag with a placeholder,
+        to be substituted when the tag is output to a string.
+
+        An HTML document may come in to Beautiful Soup as one
+        encoding, but exit in a different encoding, and the <meta> tag
+        needs to be changed to reflect this.
+
+        :param tag: A `Tag`
+        :return: Whether or not a substitution was performed.
+        """
         # We are only interested in <meta> tags
         if tag.name != 'meta':
             return False
@@ -288,10 +493,107 @@ class HTMLTreeBuilder(TreeBuilder):
 
         return (meta_encoding is not None)
 
+class DetectsXMLParsedAsHTML(object):
+    """A mixin class for any class (a TreeBuilder, or some class used by a
+    TreeBuilder) that's in a position to detect whether an XML
+    document is being incorrectly parsed as HTML, and issue an
+    appropriate warning.
+
+    This requires being able to observe an incoming processing
+    instruction that might be an XML declaration, and also able to
+    observe tags as they're opened. If you can't do that for a given
+    TreeBuilder, there's a less reliable implementation based on
+    examining the raw markup.
+    """
+
+    # Regular expression for seeing if markup has an <html> tag.
+    LOOKS_LIKE_HTML = re.compile("<[^ +]html", re.I)
+    LOOKS_LIKE_HTML_B = re.compile(b"<[^ +]html", re.I)
+
+    XML_PREFIX = '<?xml'
+    XML_PREFIX_B = b'<?xml'
+    
+    @classmethod
+    def warn_if_markup_looks_like_xml(cls, markup, stacklevel=3):
+        """Perform a check on some markup to see if it looks like XML
+        that's not XHTML. If so, issue a warning.
+
+        This is much less reliable than doing the check while parsing,
+        but some of the tree builders can't do that.
+
+        :param stacklevel: The stacklevel of the code calling this
+        function.
+
+        :return: True if the markup looks like non-XHTML XML, False
+        otherwise.
+
+        """
+        if isinstance(markup, bytes):
+            prefix = cls.XML_PREFIX_B
+            looks_like_html = cls.LOOKS_LIKE_HTML_B
+        else:
+            prefix = cls.XML_PREFIX
+            looks_like_html = cls.LOOKS_LIKE_HTML
+        
+        if (markup is not None
+            and markup.startswith(prefix)
+            and not looks_like_html.search(markup[:500])
+        ):
+            cls._warn(stacklevel=stacklevel+2)
+            return True
+        return False
+
+    @classmethod
+    def _warn(cls, stacklevel=5):
+        """Issue a warning about XML being parsed as HTML."""
+        warnings.warn(
+            XMLParsedAsHTMLWarning.MESSAGE, XMLParsedAsHTMLWarning,
+            stacklevel=stacklevel
+        )
+        
+    def _initialize_xml_detector(self):
+        """Call this method before parsing a document."""
+        self._first_processing_instruction = None
+        self._root_tag = None
+       
+    def _document_might_be_xml(self, processing_instruction):
+        """Call this method when encountering an XML declaration, or a
+        "processing instruction" that might be an XML declaration.
+        """
+        if (self._first_processing_instruction is not None
+            or self._root_tag is not None):
+            # The document has already started. Don't bother checking
+            # anymore.
+            return
+
+        self._first_processing_instruction = processing_instruction
+
+        # We won't know until we encounter the first tag whether or
+        # not this is actually a problem.
+        
+    def _root_tag_encountered(self, name):
+        """Call this when you encounter the document's root tag.
+
+        This is where we actually check whether an XML document is
+        being incorrectly parsed as HTML, and issue the warning.
+        """
+        if self._root_tag is not None:
+            # This method was incorrectly called multiple times. Do
+            # nothing.
+            return
+
+        self._root_tag = name
+        if (name != 'html' and self._first_processing_instruction is not None
+            and self._first_processing_instruction.lower().startswith('xml ')):
+            # We encountered an XML declaration and then a tag other
+            # than 'html'. This is a reliable indicator that a
+            # non-XHTML document is being parsed as XML.
+            self._warn()
+
+    
 def register_treebuilders_from(module):
     """Copy TreeBuilders from the given module into this module."""
-    # I'm fairly sure this is not the best way to do this.
-    this_module = sys.modules['bs4.builder']
+    this_module = sys.modules[__name__]
     for name in module.__all__:
         obj = getattr(module, name)
 
@@ -302,12 +604,22 @@ def register_treebuilders_from(module):
             this_module.builder_registry.register(obj)
 
 class ParserRejectedMarkup(Exception):
-    pass
-
+    """An Exception to be raised when the underlying parser simply
+    refuses to parse the given markup.
+    """
+    def __init__(self, message_or_exception):
+        """Explain why the parser rejected the given markup, either
+        with a textual explanation or another exception.
+        """
+        if isinstance(message_or_exception, Exception):
+            e = message_or_exception
+            message_or_exception = "%s: %s" % (e.__class__.__name__, str(e))
+        super(ParserRejectedMarkup, self).__init__(message_or_exception)
+            
 # Builders are registered in reverse order of priority, so that custom
 # builder registrations will take precedence. In general, we want lxml
 # to take precedence over html5lib, because it's faster. And we only
-# want to use HTMLParser as a last result.
+# want to use HTMLParser as a last resort.
 from . import _htmlparser
 register_treebuilders_from(_htmlparser)
 try:
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index 9e9216ef9c..7c46a85118 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -1,9 +1,14 @@
+# Use of this source code is governed by the MIT license.
+__license__ = "MIT"
+
 __all__ = [
     'HTML5TreeBuilder',
     ]
 
 import warnings
+import re
 from bs4.builder import (
+    DetectsXMLParsedAsHTML,
     PERMISSIVE,
     HTML,
     HTML_5,
@@ -11,17 +16,13 @@ from bs4.builder import (
     )
 from bs4.element import (
     NamespacedAttribute,
-    whitespace_re,
+    nonwhitespace_re,
 )
 import html5lib
-try:
-    # html5lib >= 0.99999999/1.0b9
-    from html5lib.treebuilders import base as treebuildersbase
-except ImportError:
-    # html5lib <= 0.9999999/1.0b8
-    from html5lib.treebuilders import _base as treebuildersbase
-from html5lib.constants import namespaces
-
+from html5lib.constants import (
+    namespaces,
+    prefixes,
+    )
 from bs4.element import (
     Comment,
     Doctype,
@@ -29,13 +30,37 @@ from bs4.element import (
     Tag,
     )
 
+try:
+    # Pre-0.99999999
+    from html5lib.treebuilders import _base as treebuilder_base
+    new_html5lib = False
+except ImportError as e:
+    # 0.99999999 and up
+    from html5lib.treebuilders import base as treebuilder_base
+    new_html5lib = True
+
 class HTML5TreeBuilder(HTMLTreeBuilder):
-    """Use html5lib to build a tree."""
+    """Use html5lib to build a tree.
+
+    Note that this TreeBuilder does not support some features common
+    to HTML TreeBuilders. Some of these features could theoretically
+    be implemented, but at the very least it's quite difficult,
+    because html5lib moves the parse tree around as it's being built.
+
+    * This TreeBuilder doesn't use different subclasses of NavigableString
+      based on the name of the tag in which the string was found.
+
+    * You can't use a SoupStrainer to parse only part of a document.
+    """
 
     NAME = "html5lib"
 
     features = [NAME, PERMISSIVE, HTML_5, HTML]
 
+    # html5lib can tell us which line number and position in the
+    # original file is the source of an element.
+    TRACKS_LINE_NUMBERS = True
+    
     def prepare_markup(self, markup, user_specified_encoding,
                        document_declared_encoding=None, exclude_encodings=None):
         # Store the user-specified encoding for use later on.
@@ -45,27 +70,56 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
         # ATM because the html5lib TreeBuilder doesn't use
         # UnicodeDammit.
         if exclude_encodings:
-            warnings.warn("You provided a value for exclude_encoding, but the html5lib tree builder doesn't support exclude_encoding.")
+            warnings.warn(
+                "You provided a value for exclude_encoding, but the html5lib tree builder doesn't support exclude_encoding.",
+                stacklevel=3
+            )
+
+        # html5lib only parses HTML, so if it's given XML that's worth
+        # noting.
+        DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(
+            markup, stacklevel=3
+        )
+
         yield (markup, None, None, False)
 
     # These methods are defined by Beautiful Soup.
     def feed(self, markup):
         if self.soup.parse_only is not None:
-            warnings.warn("You provided a value for parse_only, but the html5lib tree builder doesn't support parse_only. The entire document will be parsed.")
+            warnings.warn(
+                "You provided a value for parse_only, but the html5lib tree builder doesn't support parse_only. The entire document will be parsed.",
+                stacklevel=4
+            )
         parser = html5lib.HTMLParser(tree=self.create_treebuilder)
-        doc = parser.parse(markup, encoding=self.user_specified_encoding)
-
+        self.underlying_builder.parser = parser
+        extra_kwargs = dict()
+        if not isinstance(markup, str):
+            if new_html5lib:
+                extra_kwargs['override_encoding'] = self.user_specified_encoding
+            else:
+                extra_kwargs['encoding'] = self.user_specified_encoding
+        doc = parser.parse(markup, **extra_kwargs)
+        
         # Set the character encoding detected by the tokenizer.
         if isinstance(markup, str):
             # We need to special-case this because html5lib sets
             # charEncoding to UTF-8 if it gets Unicode input.
             doc.original_encoding = None
         else:
-            doc.original_encoding = parser.tokenizer.stream.charEncoding[0]
-
+            original_encoding = parser.tokenizer.stream.charEncoding[0]
+            if not isinstance(original_encoding, str):
+                # In 0.99999999 and up, the encoding is an html5lib
+                # Encoding object. We want to use a string for compatibility
+                # with other tree builders.
+                original_encoding = original_encoding.name
+            doc.original_encoding = original_encoding
+        self.underlying_builder.parser = None
+            
     def create_treebuilder(self, namespaceHTMLElements):
         self.underlying_builder = TreeBuilderForHtml5lib(
-            self.soup, namespaceHTMLElements)
+            namespaceHTMLElements, self.soup,
+            store_line_numbers=self.store_line_numbers
+        )
         return self.underlying_builder
 
     def test_fragment_to_document(self, fragment):
@@ -73,12 +127,30 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
         return '<html><head></head><body>%s</body></html>' % fragment
 
 
-class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
-
-    def __init__(self, soup, namespaceHTMLElements):
-        self.soup = soup
+class TreeBuilderForHtml5lib(treebuilder_base.TreeBuilder):
+    
+    def __init__(self, namespaceHTMLElements, soup=None,
+                 store_line_numbers=True, **kwargs):
+        if soup:
+            self.soup = soup
+        else:
+            from bs4 import BeautifulSoup
+            # TODO: Why is the parser 'html.parser' here? To avoid an
+            # infinite loop?
+            self.soup = BeautifulSoup(
+                "", "html.parser", store_line_numbers=store_line_numbers,
+                **kwargs
+            )
+        # TODO: What are **kwargs exactly? Should they be passed in
+        # here in addition to/instead of being passed to the BeautifulSoup
+        # constructor?
         super(TreeBuilderForHtml5lib, self).__init__(namespaceHTMLElements)
 
+        # This will be set later to an html5lib.html5parser.HTMLParser
+        # object, which we can use to track the current line number.
+        self.parser = None
+        self.store_line_numbers = store_line_numbers
+        
     def documentClass(self):
         self.soup.reset()
         return Element(self.soup, self.soup, None)
@@ -92,14 +164,26 @@ class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
         self.soup.object_was_parsed(doctype)
 
     def elementClass(self, name, namespace):
-        tag = self.soup.new_tag(name, namespace)
+        kwargs = {}
+        if self.parser and self.store_line_numbers:
+            # This represents the point immediately after the end of the
+            # tag. We don't know when the tag started, but we do know
+            # where it ended -- the character just before this one.
+            sourceline, sourcepos = self.parser.tokenizer.stream.position()
+            kwargs['sourceline'] = sourceline
+            kwargs['sourcepos'] = sourcepos-1
+        tag = self.soup.new_tag(name, namespace, **kwargs)
+
         return Element(tag, self.soup, namespace)
 
     def commentClass(self, data):
         return TextNode(Comment(data), self.soup)
 
     def fragmentClass(self):
-        self.soup = BeautifulSoup("")
+        from bs4 import BeautifulSoup
+        # TODO: Why is the parser 'html.parser' here? To avoid an
+        # infinite loop?
+        self.soup = BeautifulSoup("", "html.parser")
         self.soup.name = "[document_fragment]"
         return Element(self.soup, self.soup, None)
 
@@ -111,7 +195,57 @@ class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
         return self.soup
 
     def getFragment(self):
-        return treebuildersbase.TreeBuilder.getFragment(self).element
+        return treebuilder_base.TreeBuilder.getFragment(self).element
+
+    def testSerializer(self, element):
+        from bs4 import BeautifulSoup
+        rv = []
+        doctype_re = re.compile(r'^(.*?)(?: PUBLIC "(.*?)"(?: "(.*?)")?| SYSTEM "(.*?)")?$')
+
+        def serializeElement(element, indent=0):
+            if isinstance(element, BeautifulSoup):
+                pass
+            if isinstance(element, Doctype):
+                m = doctype_re.match(element)
+                if m:
+                    name = m.group(1)
+                    if m.lastindex > 1:
+                        publicId = m.group(2) or ""
+                        systemId = m.group(3) or m.group(4) or ""
+                        rv.append("""|%s<!DOCTYPE %s "%s" "%s">""" %
+                                  (' ' * indent, name, publicId, systemId))
+                    else:
+                        rv.append("|%s<!DOCTYPE %s>" % (' ' * indent, name))
+                else:
+                    rv.append("|%s<!DOCTYPE >" % (' ' * indent,))
+            elif isinstance(element, Comment):
+                rv.append("|%s<!-- %s -->" % (' ' * indent, element))
+            elif isinstance(element, NavigableString):
+                rv.append("|%s\"%s\"" % (' ' * indent, element))
+            else:
+                if element.namespace:
+                    name = "%s %s" % (prefixes[element.namespace],
+                                      element.name)
+                else:
+                    name = element.name
+                rv.append("|%s<%s>" % (' ' * indent, name))
+                if element.attrs:
+                    attributes = []
+                    for name, value in list(element.attrs.items()):
+                        if isinstance(name, NamespacedAttribute):
+                            name = "%s %s" % (prefixes[name.namespace], name.name)
+                        if isinstance(value, list):
+                            value = " ".join(value)
+                        attributes.append((name, value))
+
+                    for name, value in sorted(attributes):
+                        rv.append('|%s%s="%s"' % (' ' * (indent + 2), name, value))
+                indent += 2
+                for child in element.children:
+                    serializeElement(child, indent)
+        serializeElement(element, 0)
+
+        return "\n".join(rv)
 
 class AttrList(object):
     def __init__(self, element):
@@ -122,14 +256,14 @@ class AttrList(object):
     def __setitem__(self, name, value):
         # If this attribute is a multi-valued attribute for this element,
         # turn its value into a list.
-        list_attr = HTML5TreeBuilder.cdata_list_attributes
-        if (name in list_attr['*']
+        list_attr = self.element.cdata_list_attributes or {}
+        if (name in list_attr.get('*', [])
             or (self.element.name in list_attr
-                and name in list_attr[self.element.name])):
+                and name in list_attr.get(self.element.name, []))):
             # A node that is being cloned may have already undergone
             # this procedure.
             if not isinstance(value, list):
-                value = whitespace_re.split(value)
+                value = nonwhitespace_re.findall(value)
         self.element[name] = value
     def items(self):
         return list(self.attrs.items())
@@ -143,9 +277,9 @@ class AttrList(object):
         return name in list(self.attrs.keys())
 
 
-class Element(treebuildersbase.Node):
+class Element(treebuilder_base.Node):
     def __init__(self, element, soup, namespace):
-        treebuildersbase.Node.__init__(self, element.name)
+        treebuilder_base.Node.__init__(self, element.name)
         self.element = element
         self.soup = soup
         self.namespace = namespace
@@ -164,13 +298,15 @@ class Element(treebuildersbase.Node):
             child = node
         elif node.element.__class__ == NavigableString:
             string_child = child = node.element
+            node.parent = self
         else:
             child = node.element
+            node.parent = self
 
         if not isinstance(child, str) and child.parent is not None:
             node.element.extract()
 
-        if (string_child and self.element.contents
+        if (string_child is not None and self.element.contents
             and self.element.contents[-1].__class__ == NavigableString):
             # We are appending a string onto another string.
             # TODO This has O(n^2) performance, for input like
@@ -203,12 +339,12 @@ class Element(treebuildersbase.Node):
                 most_recent_element=most_recent_element)
 
     def getAttributes(self):
+        if isinstance(self.element, Comment):
+            return {}
         return AttrList(self.element)
 
     def setAttributes(self, attributes):
-
         if attributes is not None and len(attributes) > 0:
-
             converted_attributes = []
             for name, value in list(attributes.items()):
                 if isinstance(name, tuple):
@@ -230,11 +366,11 @@ class Element(treebuildersbase.Node):
     attributes = property(getAttributes, setAttributes)
 
     def insertText(self, data, insertBefore=None):
+        text = TextNode(self.soup.new_string(data), self.soup)
         if insertBefore:
-            text = TextNode(self.soup.new_string(data), self.soup)
-            self.insertBefore(data, insertBefore)
+            self.insertBefore(text, insertBefore)
         else:
-            self.appendChild(data)
+            self.appendChild(text)
 
     def insertBefore(self, node, refNode):
         index = self.element.index(refNode.element)
@@ -253,9 +389,10 @@ class Element(treebuildersbase.Node):
 
     def reparentChildren(self, new_parent):
         """Move all of this tag's children into another tag."""
-        # print "MOVE", self.element.contents
-        # print "FROM", self.element
-        # print "TO", new_parent.element
+        # print("MOVE", self.element.contents)
+        # print("FROM", self.element)
+        # print("TO", new_parent.element)
+
         element = self.element
         new_parent_element = new_parent.element
         # Determine what this tag's next_element will be once all the children
@@ -274,29 +411,35 @@ class Element(treebuildersbase.Node):
             new_parents_last_descendant_next_element = new_parent_element.next_element
 
         to_append = element.contents
-        append_after = new_parent_element.contents
         if len(to_append) > 0:
             # Set the first child's previous_element and previous_sibling
             # to elements within the new parent
             first_child = to_append[0]
-            if new_parents_last_descendant:
+            if new_parents_last_descendant is not None:
                 first_child.previous_element = new_parents_last_descendant
             else:
                 first_child.previous_element = new_parent_element
             first_child.previous_sibling = new_parents_last_child
-            if new_parents_last_descendant:
+            if new_parents_last_descendant is not None:
                 new_parents_last_descendant.next_element = first_child
             else:
                 new_parent_element.next_element = first_child
-            if new_parents_last_child:
+            if new_parents_last_child is not None:
                 new_parents_last_child.next_sibling = first_child
 
-            # Fix the last child's next_element and next_sibling
-            last_child = to_append[-1]
-            last_child.next_element = new_parents_last_descendant_next_element
-            if new_parents_last_descendant_next_element:
-                new_parents_last_descendant_next_element.previous_element = last_child
-            last_child.next_sibling = None
+            # Find the very last element being moved. It is now the
+            # parent's last descendant. It has no .next_sibling and
+            # its .next_element is whatever the previous last
+            # descendant had.
+            last_childs_last_descendant = to_append[-1]._last_descendant(False, True)
+
+            last_childs_last_descendant.next_element = new_parents_last_descendant_next_element
+            if new_parents_last_descendant_next_element is not None:
+                # TODO: This code has no test coverage and I'm not sure
+                # how to get html5lib to go through this path, but it's
+                # just the other side of the previous line.
+                new_parents_last_descendant_next_element.previous_element = last_childs_last_descendant
+            last_childs_last_descendant.next_sibling = None
 
         for child in to_append:
             child.parent = new_parent_element
@@ -306,9 +449,9 @@ class Element(treebuildersbase.Node):
         element.contents = []
         element.next_element = final_next_element
 
-        # print "DONE WITH MOVE"
-        # print "FROM", self.element
-        # print "TO", new_parent_element
+        # print("DONE WITH MOVE")
+        # print("FROM", self.element)
+        # print("TO", new_parent_element)
 
     def cloneNode(self):
         tag = self.soup.new_tag(self.element.name, self.namespace)
@@ -321,7 +464,7 @@ class Element(treebuildersbase.Node):
         return self.element.contents
 
     def getNameTuple(self):
-        if self.namespace is None:
+        if self.namespace == None:
             return namespaces["html"], self.name
         else:
             return self.namespace, self.name
@@ -330,7 +473,7 @@ class Element(treebuildersbase.Node):
 
 class TextNode(Element):
     def __init__(self, element, soup):
-        treebuildersbase.Node.__init__(self, None)
+        treebuilder_base.Node.__init__(self, None)
         self.element = element
         self.soup = soup
 
diff --git a/lib/bs4/builder/_htmlparser.py b/lib/bs4/builder/_htmlparser.py
index bb0a63f2f3..3cc187f892 100644
--- a/lib/bs4/builder/_htmlparser.py
+++ b/lib/bs4/builder/_htmlparser.py
@@ -1,35 +1,18 @@
+# encoding: utf-8
 """Use the HTMLParser library to parse HTML files that aren't too bad."""
 
+# Use of this source code is governed by the MIT license.
+__license__ = "MIT"
+
 __all__ = [
     'HTMLParserTreeBuilder',
     ]
 
 from html.parser import HTMLParser
 
-try:
-    from html.parser import HTMLParseError
-except ImportError as e:
-    # HTMLParseError is removed in Python 3.5. Since it can never be
-    # thrown in 3.5, we can just define our own class as a placeholder.
-    class HTMLParseError(Exception):
-        pass
-
 import sys
 import warnings
 
-# Starting in Python 3.2, the HTMLParser constructor takes a 'strict'
-# argument, which we'd like to set to False. Unfortunately,
-# http://bugs.python.org/issue13273 makes strict=True a better bet
-# before Python 3.2.3.
-#
-# At the end of this file, we monkeypatch HTMLParser so that
-# strict=True works well on Python 3.2.2.
-major, minor, release = sys.version_info[:3]
-CONSTRUCTOR_TAKES_STRICT = major == 3 and minor == 2 and release >= 3
-CONSTRUCTOR_STRICT_IS_DEPRECATED = major == 3 and minor == 3
-CONSTRUCTOR_TAKES_CONVERT_CHARREFS = major == 3 and minor >= 4
-
-
 from bs4.element import (
     CData,
     Comment,
@@ -40,6 +23,8 @@ from bs4.element import (
 from bs4.dammit import EntitySubstitution, UnicodeDammit
 
 from bs4.builder import (
+    DetectsXMLParsedAsHTML,
+    ParserRejectedMarkup,
     HTML,
     HTMLTreeBuilder,
     STRICT,
@@ -48,8 +33,84 @@ from bs4.builder import (
 
 HTMLPARSER = 'html.parser'
 
-class BeautifulSoupHTMLParser(HTMLParser):
-    def handle_starttag(self, name, attrs):
+class BeautifulSoupHTMLParser(HTMLParser, DetectsXMLParsedAsHTML):
+    """A subclass of the Python standard library's HTMLParser class, which
+    listens for HTMLParser events and translates them into calls
+    to Beautiful Soup's tree construction API.
+    """
+
+    # Strategies for handling duplicate attributes
+    IGNORE = 'ignore'
+    REPLACE = 'replace'
+    
+    def __init__(self, *args, **kwargs):
+        """Constructor.
+
+        :param on_duplicate_attribute: A strategy for what to do if a
+            tag includes the same attribute more than once. Accepted
+            values are: REPLACE (replace earlier values with later
+            ones, the default), IGNORE (keep the earliest value
+            encountered), or a callable. A callable must take three
+            arguments: the dictionary of attributes already processed,
+            the name of the duplicate attribute, and the most recent value
+            encountered.           
+        """
+        self.on_duplicate_attribute = kwargs.pop(
+            'on_duplicate_attribute', self.REPLACE
+        )
+        HTMLParser.__init__(self, *args, **kwargs)
+
+        # Keep a list of empty-element tags that were encountered
+        # without an explicit closing tag. If we encounter a closing tag
+        # of this type, we'll associate it with one of those entries.
+        #
+        # This isn't a stack because we don't care about the
+        # order. It's a list of closing tags we've already handled and
+        # will ignore, assuming they ever show up.
+        self.already_closed_empty_element = []
+
+        self._initialize_xml_detector()
+
+    def error(self, message):
+        # NOTE: This method is required so long as Python 3.9 is
+        # supported. The corresponding code is removed from HTMLParser
+        # in 3.5, but not removed from ParserBase until 3.10.
+        # https://github.com/python/cpython/issues/76025
+        #
+        # The original implementation turned the error into a warning,
+        # but in every case I discovered, this made HTMLParser
+        # immediately crash with an error message that was less
+        # helpful than the warning. The new implementation makes it
+        # more clear that html.parser just can't parse this
+        # markup. The 3.10 implementation does the same, though it
+        # raises AssertionError rather than calling a method. (We
+        # catch this error and wrap it in a ParserRejectedMarkup.)
+        raise ParserRejectedMarkup(message)
+
+    def handle_startendtag(self, name, attrs):
+        """Handle an incoming empty-element tag.
+
+        This is only called when the markup looks like <tag/>.
+
+        :param name: Name of the tag.
+        :param attrs: Dictionary of the tag's attributes.
+        """
+        # is_startend() tells handle_starttag not to close the tag
+        # just because its name matches a known empty-element tag. We
+        # know that this is an empty-element tag and we want to call
+        # handle_endtag ourselves.
+        tag = self.handle_starttag(name, attrs, handle_empty_element=False)
+        self.handle_endtag(name)
+        
+    def handle_starttag(self, name, attrs, handle_empty_element=True):
+        """Handle an opening tag, e.g. '<tag>'
+
+        :param name: Name of the tag.
+        :param attrs: Dictionary of the tag's attributes.
+        :param handle_empty_element: True if this tag is known to be
+            an empty-element tag (i.e. there is not expected to be any
+            closing tag).
+        """
         # XXX namespace
         attr_dict = {}
         for key, value in attrs:
@@ -57,20 +118,78 @@ class BeautifulSoupHTMLParser(HTMLParser):
             # for consistency with the other tree builders.
             if value is None:
                 value = ''
-            attr_dict[key] = value
+            if key in attr_dict:
+                # A single attribute shows up multiple times in this
+                # tag. How to handle it depends on the
+                # on_duplicate_attribute setting.
+                on_dupe = self.on_duplicate_attribute
+                if on_dupe == self.IGNORE:
+                    pass
+                elif on_dupe in (None, self.REPLACE):
+                    attr_dict[key] = value
+                else:
+                    on_dupe(attr_dict, key, value)
+            else:
+                attr_dict[key] = value
             attrvalue = '""'
-        self.soup.handle_starttag(name, None, None, attr_dict)
-
-    def handle_endtag(self, name):
-        self.soup.handle_endtag(name)
-
+        #print("START", name)
+        sourceline, sourcepos = self.getpos()
+        tag = self.soup.handle_starttag(
+            name, None, None, attr_dict, sourceline=sourceline,
+            sourcepos=sourcepos
+        )
+        if tag and tag.is_empty_element and handle_empty_element:
+            # Unlike other parsers, html.parser doesn't send separate end tag
+            # events for empty-element tags. (It's handled in
+            # handle_startendtag, but only if the original markup looked like
+            # <tag/>.)
+            #
+            # So we need to call handle_endtag() ourselves. Since we
+            # know the start event is identical to the end event, we
+            # don't want handle_endtag() to cross off any previous end
+            # events for tags of this name.
+            self.handle_endtag(name, check_already_closed=False)
+
+            # But we might encounter an explicit closing tag for this tag
+            # later on. If so, we want to ignore it.
+            self.already_closed_empty_element.append(name)
+
+        if self._root_tag is None:
+            self._root_tag_encountered(name)
+            
+    def handle_endtag(self, name, check_already_closed=True):
+        """Handle a closing tag, e.g. '</tag>'
+        
+        :param name: A tag name.
+        :param check_already_closed: True if this tag is expected to
+           be the closing portion of an empty-element tag,
+           e.g. '<tag></tag>'.
+        """
+        #print("END", name)
+        if check_already_closed and name in self.already_closed_empty_element:
+            # This is a redundant end tag for an empty-element tag.
+            # We've already called handle_endtag() for it, so just
+            # check it off the list.
+            #print("ALREADY CLOSED", name)
+            self.already_closed_empty_element.remove(name)
+        else:
+            self.soup.handle_endtag(name)
+            
     def handle_data(self, data):
+        """Handle some textual data that shows up between tags."""
         self.soup.handle_data(data)
 
     def handle_charref(self, name):
-        # XXX workaround for a bug in HTMLParser. Remove this once
-        # it's fixed in all supported versions.
-        # http://bugs.python.org/issue13633
+        """Handle a numeric character reference by converting it to the
+        corresponding Unicode character and treating it as textual
+        data.
+
+        :param name: Character number, possibly in hexadecimal.
+        """
+        # TODO: This was originally a workaround for a bug in
+        # HTMLParser. (http://bugs.python.org/issue13633) The bug has
+        # been fixed, but removing this code still makes some
+        # Beautiful Soup tests fail. This needs investigation.
         if name.startswith('x'):
             real_name = int(name.lstrip('x'), 16)
         elif name.startswith('X'):
@@ -78,37 +197,71 @@ class BeautifulSoupHTMLParser(HTMLParser):
         else:
             real_name = int(name)
 
-        try:
-            data = chr(real_name)
-        except (ValueError, OverflowError) as e:
-            data = "\N{REPLACEMENT CHARACTER}"
-
+        data = None
+        if real_name < 256:
+            # HTML numeric entities are supposed to reference Unicode
+            # code points, but sometimes they reference code points in
+            # some other encoding (ahem, Windows-1252). E.g. &#147;
+            # instead of &#201; for LEFT DOUBLE QUOTATION MARK. This
+            # code tries to detect this situation and compensate.
+            for encoding in (self.soup.original_encoding, 'windows-1252'):
+                if not encoding:
+                    continue
+                try:
+                    data = bytearray([real_name]).decode(encoding)
+                except UnicodeDecodeError as e:
+                    pass
+        if not data:
+            try:
+                data = chr(real_name)
+            except (ValueError, OverflowError) as e:
+                pass
+        data = data or "\N{REPLACEMENT CHARACTER}"
         self.handle_data(data)
 
     def handle_entityref(self, name):
+        """Handle a named entity reference by converting it to the
+        corresponding Unicode character(s) and treating it as textual
+        data.
+
+        :param name: Name of the entity reference.
+        """
         character = EntitySubstitution.HTML_ENTITY_TO_CHARACTER.get(name)
         if character is not None:
             data = character
         else:
-            data = "&%s;" % name
+            # If this were XML, it would be ambiguous whether "&foo"
+            # was an character entity reference with a missing
+            # semicolon or the literal string "&foo". Since this is
+            # HTML, we have a complete list of all character entity references,
+            # and this one wasn't found, so assume it's the literal string "&foo".
+            data = "&%s" % name
         self.handle_data(data)
 
     def handle_comment(self, data):
+        """Handle an HTML comment.
+
+        :param data: The text of the comment.
+        """
         self.soup.endData()
         self.soup.handle_data(data)
         self.soup.endData(Comment)
 
     def handle_decl(self, data):
+        """Handle a DOCTYPE declaration.
+
+        :param data: The text of the declaration.
+        """
         self.soup.endData()
-        if data.startswith("DOCTYPE "):
-            data = data[len("DOCTYPE "):]
-        elif data == 'DOCTYPE':
-            # i.e. "<!DOCTYPE>"
-            data = ''
+        data = data[len("DOCTYPE "):]
         self.soup.handle_data(data)
         self.soup.endData(Doctype)
 
     def unknown_decl(self, data):
+        """Handle a declaration of unknown type -- probably a CDATA block.
+
+        :param data: The text of the declaration.
+        """
         if data.upper().startswith('CDATA['):
             cls = CData
             data = data[len('CDATA['):]
@@ -119,144 +272,116 @@ class BeautifulSoupHTMLParser(HTMLParser):
         self.soup.endData(cls)
 
     def handle_pi(self, data):
+        """Handle a processing instruction.
+
+        :param data: The text of the instruction.
+        """
         self.soup.endData()
         self.soup.handle_data(data)
+        self._document_might_be_xml(data)
         self.soup.endData(ProcessingInstruction)
 
 
 class HTMLParserTreeBuilder(HTMLTreeBuilder):
-
+    """A Beautiful soup `TreeBuilder` that uses the `HTMLParser` parser,
+    found in the Python standard library.
+    """
     is_xml = False
     picklable = True
     NAME = HTMLPARSER
     features = [NAME, HTML, STRICT]
 
-    def __init__(self, *args, **kwargs):
-        if CONSTRUCTOR_TAKES_STRICT and not CONSTRUCTOR_STRICT_IS_DEPRECATED:
-            kwargs['strict'] = False
-        if CONSTRUCTOR_TAKES_CONVERT_CHARREFS:
-            kwargs['convert_charrefs'] = False
-        self.parser_args = (args, kwargs)
+    # The html.parser knows which line number and position in the
+    # original file is the source of an element.
+    TRACKS_LINE_NUMBERS = True
 
+    def __init__(self, parser_args=None, parser_kwargs=None, **kwargs):
+        """Constructor.
+
+        :param parser_args: Positional arguments to pass into 
+            the BeautifulSoupHTMLParser constructor, once it's
+            invoked.
+        :param parser_kwargs: Keyword arguments to pass into 
+            the BeautifulSoupHTMLParser constructor, once it's
+            invoked.
+        :param kwargs: Keyword arguments for the superclass constructor.
+        """
+        # Some keyword arguments will be pulled out of kwargs and placed
+        # into parser_kwargs.
+        extra_parser_kwargs = dict()
+        for arg in ('on_duplicate_attribute',):
+            if arg in kwargs:
+                value = kwargs.pop(arg)
+                extra_parser_kwargs[arg] = value
+        super(HTMLParserTreeBuilder, self).__init__(**kwargs)
+        parser_args = parser_args or []
+        parser_kwargs = parser_kwargs or {}
+        parser_kwargs.update(extra_parser_kwargs)
+        parser_kwargs['convert_charrefs'] = False
+        self.parser_args = (parser_args, parser_kwargs)
+        
     def prepare_markup(self, markup, user_specified_encoding=None,
                        document_declared_encoding=None, exclude_encodings=None):
-        """
-        :return: A 4-tuple (markup, original encoding, encoding
-        declared within markup, whether any characters had to be
-        replaced with REPLACEMENT CHARACTER).
+
+        """Run any preliminary steps necessary to make incoming markup
+        acceptable to the parser.
+
+        :param markup: Some markup -- probably a bytestring.
+        :param user_specified_encoding: The user asked to try this encoding.
+        :param document_declared_encoding: The markup itself claims to be
+            in this encoding.
+        :param exclude_encodings: The user asked _not_ to try any of
+            these encodings.
+
+        :yield: A series of 4-tuples:
+         (markup, encoding, declared encoding,
+          has undergone character replacement)
+
+         Each 4-tuple represents a strategy for converting the
+         document to Unicode and parsing it. Each strategy will be tried 
+         in turn.
         """
         if isinstance(markup, str):
+            # Parse Unicode as-is.
             yield (markup, None, None, False)
             return
 
+        # Ask UnicodeDammit to sniff the most likely encoding.
+
+        # This was provided by the end-user; treat it as a known
+        # definite encoding per the algorithm laid out in the HTML5
+        # spec.  (See the EncodingDetector class for details.)
+        known_definite_encodings = [user_specified_encoding]
+
+        # This was found in the document; treat it as a slightly lower-priority
+        # user encoding.
+        user_encodings = [document_declared_encoding]
+
         try_encodings = [user_specified_encoding, document_declared_encoding]
-        dammit = UnicodeDammit(markup, try_encodings, is_html=True,
-                               exclude_encodings=exclude_encodings)
+        dammit = UnicodeDammit(
+            markup,
+            known_definite_encodings=known_definite_encodings,
+            user_encodings=user_encodings,
+            is_html=True,
+            exclude_encodings=exclude_encodings
+        )
         yield (dammit.markup, dammit.original_encoding,
                dammit.declared_html_encoding,
                dammit.contains_replacement_characters)
 
     def feed(self, markup):
+        """Run some incoming markup through some parsing process,
+        populating the `BeautifulSoup` object in self.soup.
+        """
         args, kwargs = self.parser_args
         parser = BeautifulSoupHTMLParser(*args, **kwargs)
         parser.soup = self.soup
         try:
             parser.feed(markup)
-        except HTMLParseError as e:
-            warnings.warn(RuntimeWarning(
-                "Python's built-in HTMLParser cannot parse the given document. This is not a bug in Beautiful Soup. The best solution is to install an external parser (lxml or html5lib), and use Beautiful Soup with that parser. See http://www.crummy.com/software/BeautifulSoup/bs4/doc/#installing-a-parser for help."))
-            raise e
-
-# Patch 3.2 versions of HTMLParser earlier than 3.2.3 to use some
-# 3.2.3 code. This ensures they don't treat markup like <p></p> as a
-# string.
-#
-# XXX This code can be removed once most Python 3 users are on 3.2.3.
-if major == 3 and minor == 2 and not CONSTRUCTOR_TAKES_STRICT:
-    import re
-    attrfind_tolerant = re.compile(
-        r'\s*((?<=[\'"\s])[^\s/>][^\s/=>]*)(\s*=+\s*'
-        r'(\'[^\']*\'|"[^"]*"|(?![\'"])[^>\s]*))?')
-    HTMLParserTreeBuilder.attrfind_tolerant = attrfind_tolerant
-
-    locatestarttagend = re.compile(r"""
-  <[a-zA-Z][-.a-zA-Z0-9:_]*          # tag name
-  (?:\s+                             # whitespace before attribute name
-    (?:[a-zA-Z_][-.:a-zA-Z0-9_]*     # attribute name
-      (?:\s*=\s*                     # value indicator
-        (?:'[^']*'                   # LITA-enclosed value
-          |\"[^\"]*\"                # LIT-enclosed value
-          |[^'\">\s]+                # bare value
-         )
-       )?
-     )
-   )*
-  \s*                                # trailing whitespace
-""", re.VERBOSE)
-    BeautifulSoupHTMLParser.locatestarttagend = locatestarttagend
-
-    from html.parser import tagfind, attrfind
-
-    def parse_starttag(self, i):
-        self.__starttag_text = None
-        endpos = self.check_for_whole_start_tag(i)
-        if endpos < 0:
-            return endpos
-        rawdata = self.rawdata
-        self.__starttag_text = rawdata[i:endpos]
-
-        # Now parse the data between i+1 and j into a tag and attrs
-        attrs = []
-        match = tagfind.match(rawdata, i+1)
-        assert match, 'unexpected call to parse_starttag()'
-        k = match.end()
-        self.lasttag = tag = rawdata[i+1:k].lower()
-        while k < endpos:
-            if self.strict:
-                m = attrfind.match(rawdata, k)
-            else:
-                m = attrfind_tolerant.match(rawdata, k)
-            if not m:
-                break
-            attrname, rest, attrvalue = m.group(1, 2, 3)
-            if not rest:
-                attrvalue = None
-            elif attrvalue[:1] == '\'' == attrvalue[-1:] or \
-                 attrvalue[:1] == '"' == attrvalue[-1:]:
-                attrvalue = attrvalue[1:-1]
-            if attrvalue:
-                attrvalue = self.unescape(attrvalue)
-            attrs.append((attrname.lower(), attrvalue))
-            k = m.end()
-
-        end = rawdata[k:endpos].strip()
-        if end not in (">", "/>"):
-            lineno, offset = self.getpos()
-            if "\n" in self.__starttag_text:
-                lineno = lineno + self.__starttag_text.count("\n")
-                offset = len(self.__starttag_text) \
-                         - self.__starttag_text.rfind("\n")
-            else:
-                offset = offset + len(self.__starttag_text)
-            if self.strict:
-                self.error("junk characters in start tag: %r"
-                           % (rawdata[k:endpos][:20],))
-            self.handle_data(rawdata[i:endpos])
-            return endpos
-        if end.endswith('/>'):
-            # XHTML-style empty tag: <span attr="value" />
-            self.handle_startendtag(tag, attrs)
-        else:
-            self.handle_starttag(tag, attrs)
-            if tag in self.CDATA_CONTENT_ELEMENTS:
-                self.set_cdata_mode(tag)
-        return endpos
-
-    def set_cdata_mode(self, elem):
-        self.cdata_elem = elem.lower()
-        self.interesting = re.compile(r'</\s*%s\s*>' % self.cdata_elem, re.I)
-
-    BeautifulSoupHTMLParser.parse_starttag = parse_starttag
-    BeautifulSoupHTMLParser.set_cdata_mode = set_cdata_mode
-
-    CONSTRUCTOR_TAKES_STRICT = True
+            parser.close()
+        except AssertionError as e:
+            # html.parser raises AssertionError in rare cases to
+            # indicate a fatal problem with the markup, especially
+            # when there's an error in the doctype declaration.
+            raise ParserRejectedMarkup(e)
+        parser.already_closed_empty_element = []
diff --git a/lib/bs4/builder/_lxml.py b/lib/bs4/builder/_lxml.py
index 9c6c14ee65..4f7cf74681 100644
--- a/lib/bs4/builder/_lxml.py
+++ b/lib/bs4/builder/_lxml.py
@@ -1,19 +1,28 @@
+# Use of this source code is governed by the MIT license.
+__license__ = "MIT"
+
 __all__ = [
     'LXMLTreeBuilderForXML',
     'LXMLTreeBuilder',
     ]
 
+try:
+    from collections.abc import Callable # Python 3.6
+except ImportError as e:
+    from collections import Callable
+
 from io import BytesIO
 from io import StringIO
-import collections
 from lxml import etree
 from bs4.element import (
     Comment,
     Doctype,
     NamespacedAttribute,
     ProcessingInstruction,
+    XMLProcessingInstruction,
 )
 from bs4.builder import (
+    DetectsXMLParsedAsHTML,
     FAST,
     HTML,
     HTMLTreeBuilder,
@@ -25,10 +34,15 @@ from bs4.dammit import EncodingDetector
 
 LXML = 'lxml'
 
+def _invert(d):
+    "Invert a dictionary."
+    return dict((v,k) for k, v in list(d.items()))
+
 class LXMLTreeBuilderForXML(TreeBuilder):
     DEFAULT_PARSER_CLASS = etree.XMLParser
 
     is_xml = True
+    processing_instruction_class = XMLProcessingInstruction
 
     NAME = "lxml-xml"
     ALTERNATE_NAMES = ["xml"]
@@ -40,26 +54,79 @@ class LXMLTreeBuilderForXML(TreeBuilder):
 
     # This namespace mapping is specified in the XML Namespace
     # standard.
-    DEFAULT_NSMAPS = {'http://www.w3.org/XML/1998/namespace' : "xml"}
+    DEFAULT_NSMAPS = dict(xml='http://www.w3.org/XML/1998/namespace')
+
+    DEFAULT_NSMAPS_INVERTED = _invert(DEFAULT_NSMAPS)
+
+    # NOTE: If we parsed Element objects and looked at .sourceline,
+    # we'd be able to see the line numbers from the original document.
+    # But instead we build an XMLParser or HTMLParser object to serve
+    # as the target of parse messages, and those messages don't include
+    # line numbers.
+    # See: https://bugs.launchpad.net/lxml/+bug/1846906
+    
+    def initialize_soup(self, soup):
+        """Let the BeautifulSoup object know about the standard namespace
+        mapping.
+
+        :param soup: A `BeautifulSoup`.
+        """
+        super(LXMLTreeBuilderForXML, self).initialize_soup(soup)
+        self._register_namespaces(self.DEFAULT_NSMAPS)
+
+    def _register_namespaces(self, mapping):
+        """Let the BeautifulSoup object know about namespaces encountered
+        while parsing the document.
+
+        This might be useful later on when creating CSS selectors.
+
+        This will track (almost) all namespaces, even ones that were
+        only in scope for part of the document. If two namespaces have
+        the same prefix, only the first one encountered will be
+        tracked. Un-prefixed namespaces are not tracked.
 
+        :param mapping: A dictionary mapping namespace prefixes to URIs.
+        """
+        for key, value in list(mapping.items()):
+            # This is 'if key' and not 'if key is not None' because we
+            # don't track un-prefixed namespaces. Soupselect will
+            # treat an un-prefixed namespace as the default, which
+            # causes confusion in some cases.
+            if key and key not in self.soup._namespaces:
+                # Let the BeautifulSoup object know about a new namespace.
+                # If there are multiple namespaces defined with the same
+                # prefix, the first one in the document takes precedence.
+                self.soup._namespaces[key] = value
+                
     def default_parser(self, encoding):
-        # This can either return a parser object or a class, which
-        # will be instantiated with default arguments.
+        """Find the default parser for the given encoding.
+
+        :param encoding: A string.
+        :return: Either a parser object or a class, which
+          will be instantiated with default arguments.
+        """
         if self._default_parser is not None:
             return self._default_parser
         return etree.XMLParser(
             target=self, strip_cdata=False, recover=True, encoding=encoding)
 
     def parser_for(self, encoding):
+        """Instantiate an appropriate parser for the given encoding.
+
+        :param encoding: A string.
+        :return: A parser object such as an `etree.XMLParser`.
+        """
         # Use the default parser.
         parser = self.default_parser(encoding)
 
-        if isinstance(parser, collections.Callable):
+        if isinstance(parser, Callable):
             # Instantiate the parser with default arguments
-            parser = parser(target=self, strip_cdata=False, encoding=encoding)
+            parser = parser(
+                target=self, strip_cdata=False, recover=True, encoding=encoding
+            )
         return parser
 
-    def __init__(self, parser=None, empty_element_tags=None):
+    def __init__(self, parser=None, empty_element_tags=None, **kwargs):
         # TODO: Issue a warning if parser is present but not a
         # callable, since that means there's no way to create new
         # parsers for different encodings.
@@ -67,8 +134,10 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         if empty_element_tags is not None:
             self.empty_element_tags = set(empty_element_tags)
         self.soup = None
-        self.nsmaps = [self.DEFAULT_NSMAPS]
-
+        self.nsmaps = [self.DEFAULT_NSMAPS_INVERTED]
+        self.active_namespace_prefixes = [dict(self.DEFAULT_NSMAPS)]
+        super(LXMLTreeBuilderForXML, self).__init__(**kwargs)
+        
     def _getNsTag(self, tag):
         # Split the namespace URL out of a fully-qualified lxml tag
         # name. Copied from lxml's src/lxml/sax.py.
@@ -80,16 +149,51 @@ class LXMLTreeBuilderForXML(TreeBuilder):
     def prepare_markup(self, markup, user_specified_encoding=None,
                        exclude_encodings=None,
                        document_declared_encoding=None):
-        """
-        :yield: A series of 4-tuples.
+        """Run any preliminary steps necessary to make incoming markup
+        acceptable to the parser.
+
+        lxml really wants to get a bytestring and convert it to
+        Unicode itself. So instead of using UnicodeDammit to convert
+        the bytestring to Unicode using different encodings, this
+        implementation uses EncodingDetector to iterate over the
+        encodings, and tell lxml to try to parse the document as each
+        one in turn.
+
+        :param markup: Some markup -- hopefully a bytestring.
+        :param user_specified_encoding: The user asked to try this encoding.
+        :param document_declared_encoding: The markup itself claims to be
+            in this encoding.
+        :param exclude_encodings: The user asked _not_ to try any of
+            these encodings.
+
+        :yield: A series of 4-tuples:
          (markup, encoding, declared encoding,
           has undergone character replacement)
 
-        Each 4-tuple represents a strategy for parsing the document.
+         Each 4-tuple represents a strategy for converting the
+         document to Unicode and parsing it. Each strategy will be tried 
+         in turn.
         """
+        is_html = not self.is_xml
+        if is_html:
+            self.processing_instruction_class = ProcessingInstruction
+            # We're in HTML mode, so if we're given XML, that's worth
+            # noting.
+            DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(
+                markup, stacklevel=3
+            )
+        else:
+            self.processing_instruction_class = XMLProcessingInstruction
+
         if isinstance(markup, str):
             # We were given Unicode. Maybe lxml can parse Unicode on
             # this system?
+
+            # TODO: This is a workaround for
+            # https://bugs.launchpad.net/lxml/+bug/1948551.
+            # We can remove it once the upstream issue is fixed.
+            if len(markup) > 0 and markup[0] == u'\N{BYTE ORDER MARK}':
+                markup = markup[1:]
             yield markup, None, document_declared_encoding, False
 
         if isinstance(markup, str):
@@ -98,14 +202,19 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             yield (markup.encode("utf8"), "utf8",
                    document_declared_encoding, False)
 
-        # Instead of using UnicodeDammit to convert the bytestring to
-        # Unicode using different encodings, use EncodingDetector to
-        # iterate over the encodings, and tell lxml to try to parse
-        # the document as each one in turn.
-        is_html = not self.is_xml
-        try_encodings = [user_specified_encoding, document_declared_encoding]
+        # This was provided by the end-user; treat it as a known
+        # definite encoding per the algorithm laid out in the HTML5
+        # spec.  (See the EncodingDetector class for details.)
+        known_definite_encodings = [user_specified_encoding]
+
+        # This was found in the document; treat it as a slightly lower-priority
+        # user encoding.
+        user_encodings = [document_declared_encoding]
         detector = EncodingDetector(
-            markup, try_encodings, is_html, exclude_encodings)
+            markup, known_definite_encodings=known_definite_encodings,
+            user_encodings=user_encodings, is_html=is_html,
+            exclude_encodings=exclude_encodings
+        )
         for encoding in detector.encodings:
             yield (detector.markup, encoding, document_declared_encoding, False)
 
@@ -128,25 +237,45 @@ class LXMLTreeBuilderForXML(TreeBuilder):
                     self.parser.feed(data)
             self.parser.close()
         except (UnicodeDecodeError, LookupError, etree.ParserError) as e:
-            raise ParserRejectedMarkup(str(e))
+            raise ParserRejectedMarkup(e)
 
     def close(self):
-        self.nsmaps = [self.DEFAULT_NSMAPS]
+        self.nsmaps = [self.DEFAULT_NSMAPS_INVERTED]
 
     def start(self, name, attrs, nsmap={}):
         # Make sure attrs is a mutable dict--lxml may send an immutable dictproxy.
         attrs = dict(attrs)
         nsprefix = None
         # Invert each namespace map as it comes in.
-        if len(self.nsmaps) > 1:
-            # There are no new namespaces for this tag, but
-            # non-default namespaces are in play, so we need a
-            # separate tag stack to know when they end.
-            self.nsmaps.append(None)
+        if len(nsmap) == 0 and len(self.nsmaps) > 1:
+                # There are no new namespaces for this tag, but
+                # non-default namespaces are in play, so we need a
+                # separate tag stack to know when they end.
+                self.nsmaps.append(None)
         elif len(nsmap) > 0:
             # A new namespace mapping has come into play.
-            inverted_nsmap = dict((value, key) for key, value in list(nsmap.items()))
-            self.nsmaps.append(inverted_nsmap)
+
+            # First, Let the BeautifulSoup object know about it.
+            self._register_namespaces(nsmap)
+
+            # Then, add it to our running list of inverted namespace
+            # mappings.
+            self.nsmaps.append(_invert(nsmap))
+
+            # The currently active namespace prefixes have
+            # changed. Calculate the new mapping so it can be stored
+            # with all Tag objects created while these prefixes are in
+            # scope.
+            current_mapping = dict(self.active_namespace_prefixes[-1])
+            current_mapping.update(nsmap)
+
+            # We should not track un-prefixed namespaces as we can only hold one
+            # and it will be recognized as the default namespace by soupsieve,
+            # which may be confusing in some situations.
+            if '' in current_mapping:
+                del current_mapping['']
+            self.active_namespace_prefixes.append(current_mapping)
+            
             # Also treat the namespace mapping as a set of attributes on the
             # tag, so we can recreate it later.
             attrs = attrs.copy()
@@ -171,8 +300,11 @@ class LXMLTreeBuilderForXML(TreeBuilder):
 
         namespace, name = self._getNsTag(name)
         nsprefix = self._prefix_for_namespace(namespace)
-        self.soup.handle_starttag(name, namespace, nsprefix, attrs)
-
+        self.soup.handle_starttag(
+            name, namespace, nsprefix, attrs,
+            namespaces=self.active_namespace_prefixes[-1]
+        )
+        
     def _prefix_for_namespace(self, namespace):
         """Find the currently active prefix for the given namespace."""
         if namespace is None:
@@ -196,13 +328,20 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         if len(self.nsmaps) > 1:
             # This tag, or one of its parents, introduced a namespace
             # mapping, so pop it off the stack.
-            self.nsmaps.pop()
-
+            out_of_scope_nsmap = self.nsmaps.pop()
+
+            if out_of_scope_nsmap is not None:
+                # This tag introduced a namespace mapping which is no
+                # longer in scope. Recalculate the currently active
+                # namespace prefixes.
+                self.active_namespace_prefixes.pop()
+            
     def pi(self, target, data):
         self.soup.endData()
-        self.soup.handle_data(target + ' ' + data)
-        self.soup.endData(ProcessingInstruction)
-
+        data = target + ' ' + data
+        self.soup.handle_data(data)
+        self.soup.endData(self.processing_instruction_class)
+        
     def data(self, content):
         self.soup.handle_data(content)
 
@@ -229,6 +368,7 @@ class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
 
     features = ALTERNATE_NAMES + [NAME, HTML, FAST, PERMISSIVE]
     is_xml = False
+    processing_instruction_class = ProcessingInstruction
 
     def default_parser(self, encoding):
         return etree.HTMLParser
@@ -240,7 +380,7 @@ class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
             self.parser.feed(markup)
             self.parser.close()
         except (UnicodeDecodeError, LookupError, etree.ParserError) as e:
-            raise ParserRejectedMarkup(str(e))
+            raise ParserRejectedMarkup(e)
 
 
     def test_fragment_to_document(self, fragment):
diff --git a/lib/bs4/css.py b/lib/bs4/css.py
new file mode 100644
index 0000000000..245ac6010a
--- /dev/null
+++ b/lib/bs4/css.py
@@ -0,0 +1,280 @@
+"""Integration code for CSS selectors using Soup Sieve (pypi: soupsieve)."""
+
+import warnings
+try:
+    import soupsieve
+except ImportError as e:
+    soupsieve = None
+    warnings.warn(
+        'The soupsieve package is not installed. CSS selectors cannot be used.'
+    )
+
+
+class CSS(object):
+    """A proxy object against the soupsieve library, to simplify its
+    CSS selector API.
+
+    Acquire this object through the .css attribute on the
+    BeautifulSoup object, or on the Tag you want to use as the
+    starting point for a CSS selector.
+
+    The main advantage of doing this is that the tag to be selected
+    against doesn't need to be explicitly specified in the function
+    calls, since it's already scoped to a tag.
+    """
+
+    def __init__(self, tag, api=soupsieve):
+        """Constructor.
+
+        You don't need to instantiate this class yourself; instead,
+        access the .css attribute on the BeautifulSoup object, or on
+        the Tag you want to use as the starting point for your CSS
+        selector.
+
+        :param tag: All CSS selectors will use this as their starting
+        point.
+
+        :param api: A plug-in replacement for the soupsieve module,
+        designed mainly for use in tests.
+        """
+        if api is None:
+            raise NotImplementedError(
+                "Cannot execute CSS selectors because the soupsieve package is not installed."
+            )
+        self.api = api
+        self.tag = tag
+
+    def escape(self, ident):
+        """Escape a CSS identifier.
+
+        This is a simple wrapper around soupselect.escape(). See the
+        documentation for that function for more information.
+        """
+        if soupsieve is None:
+            raise NotImplementedError(
+                "Cannot escape CSS identifiers because the soupsieve package is not installed."
+            )
+        return self.api.escape(ident)
+
+    def _ns(self, ns, select):
+        """Normalize a dictionary of namespaces."""
+        if not isinstance(select, self.api.SoupSieve) and ns is None:
+            # If the selector is a precompiled pattern, it already has
+            # a namespace context compiled in, which cannot be
+            # replaced.
+            ns = self.tag._namespaces
+        return ns
+
+    def _rs(self, results):
+        """Normalize a list of results to a Resultset.
+
+        A ResultSet is more consistent with the rest of Beautiful
+        Soup's API, and ResultSet.__getattr__ has a helpful error
+        message if you try to treat a list of results as a single
+        result (a common mistake).
+        """
+        # Import here to avoid circular import
+        from bs4.element import ResultSet
+        return ResultSet(None, results)
+
+    def compile(self, select, namespaces=None, flags=0, **kwargs):
+        """Pre-compile a selector and return the compiled object.
+
+        :param selector: A CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+           used in the CSS selector to namespace URIs. By default,
+           Beautiful Soup will use the prefixes it encountered while
+           parsing the document.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.compile() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+           soupsieve.compile() method.
+
+        :return: A precompiled selector object.
+        :rtype: soupsieve.SoupSieve
+        """
+        return self.api.compile(
+            select, self._ns(namespaces, select), flags, **kwargs
+        )
+
+    def select_one(self, select, namespaces=None, flags=0, **kwargs):
+        """Perform a CSS selection operation on the current Tag and return the
+        first result.
+
+        This uses the Soup Sieve library. For more information, see
+        that library's documentation for the soupsieve.select_one()
+        method.
+
+        :param selector: A CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+           used in the CSS selector to namespace URIs. By default,
+           Beautiful Soup will use the prefixes it encountered while
+           parsing the document.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.select_one() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+           soupsieve.select_one() method.
+
+        :return: A Tag, or None if the selector has no match.
+        :rtype: bs4.element.Tag
+
+        """
+        return self.api.select_one(
+            select, self.tag, self._ns(namespaces, select), flags, **kwargs
+        )
+
+    def select(self, select, namespaces=None, limit=0, flags=0, **kwargs):
+        """Perform a CSS selection operation on the current Tag.
+
+        This uses the Soup Sieve library. For more information, see
+        that library's documentation for the soupsieve.select()
+        method.
+
+        :param selector: A string containing a CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+            used in the CSS selector to namespace URIs. By default,
+            Beautiful Soup will pass in the prefixes it encountered while
+            parsing the document.
+
+        :param limit: After finding this number of results, stop looking.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.select() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+            soupsieve.select() method.
+
+        :return: A ResultSet of Tag objects.
+        :rtype: bs4.element.ResultSet
+
+        """
+        if limit is None:
+            limit = 0
+
+        return self._rs(
+            self.api.select(
+                select, self.tag, self._ns(namespaces, select), limit, flags,
+                **kwargs
+            )
+        )
+
+    def iselect(self, select, namespaces=None, limit=0, flags=0, **kwargs):
+        """Perform a CSS selection operation on the current Tag.
+
+        This uses the Soup Sieve library. For more information, see
+        that library's documentation for the soupsieve.iselect()
+        method. It is the same as select(), but it returns a generator
+        instead of a list.
+
+        :param selector: A string containing a CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+            used in the CSS selector to namespace URIs. By default,
+            Beautiful Soup will pass in the prefixes it encountered while
+            parsing the document.
+
+        :param limit: After finding this number of results, stop looking.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.iselect() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+            soupsieve.iselect() method.
+
+        :return: A generator
+        :rtype: types.GeneratorType
+        """
+        return self.api.iselect(
+            select, self.tag, self._ns(namespaces, select), limit, flags, **kwargs
+        )
+
+    def closest(self, select, namespaces=None, flags=0, **kwargs):
+        """Find the Tag closest to this one that matches the given selector.
+
+        This uses the Soup Sieve library. For more information, see
+        that library's documentation for the soupsieve.closest()
+        method.
+
+        :param selector: A string containing a CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+            used in the CSS selector to namespace URIs. By default,
+            Beautiful Soup will pass in the prefixes it encountered while
+            parsing the document.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.closest() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+            soupsieve.closest() method.
+
+        :return: A Tag, or None if there is no match.
+        :rtype: bs4.Tag
+
+        """
+        return self.api.closest(
+            select, self.tag, self._ns(namespaces, select), flags, **kwargs
+        )
+
+    def match(self, select, namespaces=None, flags=0, **kwargs):
+        """Check whether this Tag matches the given CSS selector.
+
+        This uses the Soup Sieve library. For more information, see
+        that library's documentation for the soupsieve.match()
+        method.
+
+        :param: a CSS selector.
+
+        :param namespaces: A dictionary mapping namespace prefixes
+            used in the CSS selector to namespace URIs. By default,
+            Beautiful Soup will pass in the prefixes it encountered while
+            parsing the document.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.match() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+            soupsieve.match() method.
+
+        :return: True if this Tag matches the selector; False otherwise.
+        :rtype: bool
+        """
+        return self.api.match(
+            select, self.tag, self._ns(namespaces, select), flags, **kwargs
+        )
+
+    def filter(self, select, namespaces=None, flags=0, **kwargs):
+        """Filter this Tag's direct children based on the given CSS selector.
+
+        This uses the Soup Sieve library. It works the same way as
+        passing this Tag into that library's soupsieve.filter()
+        method. More information, for more information see the
+        documentation for soupsieve.filter().
+
+        :param namespaces: A dictionary mapping namespace prefixes
+            used in the CSS selector to namespace URIs. By default,
+            Beautiful Soup will pass in the prefixes it encountered while
+            parsing the document.
+
+        :param flags: Flags to be passed into Soup Sieve's
+            soupsieve.filter() method.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+            soupsieve.filter() method.
+
+        :return: A ResultSet of Tag objects.
+        :rtype: bs4.element.ResultSet
+
+        """
+        return self._rs(
+            self.api.filter(
+                select, self.tag, self._ns(namespaces, select), flags, **kwargs
+            )
+        )
diff --git a/lib/bs4/dammit.py b/lib/bs4/dammit.py
index 7ad9e0dd1e..692433c57a 100644
--- a/lib/bs4/dammit.py
+++ b/lib/bs4/dammit.py
@@ -6,61 +6,185 @@ necessary. It is heavily based on code from Mark Pilgrim's Universal
 Feed Parser. It works best on XML and HTML, but it does not rewrite the
 XML or HTML to reflect a new encoding; that's the tree builder's job.
 """
+# Use of this source code is governed by the MIT license.
 __license__ = "MIT"
 
-import codecs
 from html.entities import codepoint2name
+from collections import defaultdict
+import codecs
 import re
 import logging
-
-# Import a library to autodetect character encodings.
-chardet_type = None
+import string
+
+# Import a library to autodetect character encodings. We'll support
+# any of a number of libraries that all support the same API:
+#
+# * cchardet
+# * chardet
+# * charset-normalizer
+chardet_module = None
 try:
-    # First try the fast C implementation.
     #  PyPI package: cchardet
-    import cchardet
-    def chardet_dammit(s):
-        return cchardet.detect(s)['encoding']
+    import cchardet as chardet_module
 except ImportError:
     try:
-        # Fall back to the pure Python implementation
         #  Debian package: python-chardet
         #  PyPI package: chardet
-        import chardet
-        def chardet_dammit(s):
-            return chardet.detect(s)['encoding']
-        #import chardet.constants
-        #chardet.constants._debug = 1
+        import chardet as chardet_module
     except ImportError:
-        # No chardet available.
-        def chardet_dammit(s):
+        try:
+            # PyPI package: charset-normalizer
+            import charset_normalizer as chardet_module
+        except ImportError:
+            # No chardet available.
+            chardet_module = None
+
+if chardet_module:
+    def chardet_dammit(s):
+        if isinstance(s, str):
             return None
+        return chardet_module.detect(s)['encoding']
+else:
+    def chardet_dammit(s):
+        return None
 
-xml_encoding_re = re.compile(
-    r'^<\?.*encoding=[\'"](.*?)[\'"].*\?>'.encode(), re.I)
-html_meta_re = re.compile(
-    r'<\s*meta[^>]+charset\s*=\s*["\']?([^>]*?)[ /;\'">]'.encode(), re.I)
+# Build bytestring and Unicode versions of regular expressions for finding
+# a declared encoding inside an XML or HTML document.
+xml_encoding = '^\\s*<\\?.*encoding=[\'"](.*?)[\'"].*\\?>'
+html_meta = '<\\s*meta[^>]+charset\\s*=\\s*["\']?([^>]*?)[ /;\'">]'
+encoding_res = dict()
+encoding_res[bytes] = {
+    'html' : re.compile(html_meta.encode("ascii"), re.I),
+    'xml' : re.compile(xml_encoding.encode("ascii"), re.I),
+}
+encoding_res[str] = {
+    'html' : re.compile(html_meta, re.I),
+    'xml' : re.compile(xml_encoding, re.I)
+}
+
+from html.entities import html5
 
 class EntitySubstitution(object):
-
-    """Substitute XML or HTML entities for the corresponding characters."""
+    """The ability to substitute XML or HTML entities for certain characters."""
 
     def _populate_class_variables():
-        lookup = {}
-        reverse_lookup = {}
-        characters_for_re = []
+        """Initialize variables used by this class to manage the plethora of
+        HTML5 named entities.
+
+        This function returns a 3-tuple containing two dictionaries
+        and a regular expression:
+
+        unicode_to_name - A mapping of Unicode strings like "⦨" to
+        entity names like "angmsdaa". When a single Unicode string has
+        multiple entity names, we try to choose the most commonly-used
+        name.
+
+        name_to_unicode: A mapping of entity names like "angmsdaa" to 
+        Unicode strings like "⦨".
+
+        named_entity_re: A regular expression matching (almost) any
+        Unicode string that corresponds to an HTML5 named entity.
+        """
+        unicode_to_name = {}
+        name_to_unicode = {}
+
+        short_entities = set()
+        long_entities_by_first_character = defaultdict(set)
+        
+        for name_with_semicolon, character in sorted(html5.items()):
+            # "It is intentional, for legacy compatibility, that many
+            # code points have multiple character reference names. For
+            # example, some appear both with and without the trailing
+            # semicolon, or with different capitalizations."
+            # - https://html.spec.whatwg.org/multipage/named-characters.html#named-character-references
+            #
+            # The parsers are in charge of handling (or not) character
+            # references with no trailing semicolon, so we remove the
+            # semicolon whenever it appears.
+            if name_with_semicolon.endswith(';'):
+                name = name_with_semicolon[:-1]
+            else:
+                name = name_with_semicolon
+
+            # When parsing HTML, we want to recognize any known named
+            # entity and convert it to a sequence of Unicode
+            # characters.
+            if name not in name_to_unicode:
+                name_to_unicode[name] = character
+
+            # When _generating_ HTML, we want to recognize special
+            # character sequences that _could_ be converted to named
+            # entities.
+            unicode_to_name[character] = name
+
+            # We also need to build a regular expression that lets us
+            # _find_ those characters in output strings so we can
+            # replace them.
+            #
+            # This is tricky, for two reasons.
+
+            if (len(character) == 1 and ord(character) < 128
+                and character not in '<>&'):
+                # First, it would be annoying to turn single ASCII
+                # characters like | into named entities like
+                # &verbar;. The exceptions are <>&, which we _must_
+                # turn into named entities to produce valid HTML.
+                continue
+
+            if len(character) > 1 and all(ord(x) < 128 for x in character):
+                # We also do not want to turn _combinations_ of ASCII
+                # characters like 'fj' into named entities like '&fjlig;',
+                # though that's more debateable.
+                continue
+
+            # Second, some named entities have a Unicode value that's
+            # a subset of the Unicode value for some _other_ named
+            # entity.  As an example, \u2267' is &GreaterFullEqual;,
+            # but '\u2267\u0338' is &NotGreaterFullEqual;. Our regular
+            # expression needs to match the first two characters of
+            # "\u2267\u0338foo", but only the first character of
+            # "\u2267foo".
+            #
+            # In this step, we build two sets of characters that
+            # _eventually_ need to go into the regular expression. But
+            # we won't know exactly what the regular expression needs
+            # to look like until we've gone through the entire list of
+            # named entities.
+            if len(character) == 1:
+                short_entities.add(character)
+            else:
+                long_entities_by_first_character[character[0]].add(character)
+
+        # Now that we've been through the entire list of entities, we
+        # can create a regular expression that matches any of them.
+        particles = set()
+        for short in short_entities:
+            long_versions = long_entities_by_first_character[short]
+            if not long_versions:
+                particles.add(short)
+            else:
+                ignore = "".join([x[1] for x in long_versions])
+                # This finds, e.g. \u2267 but only if it is _not_
+                # followed by \u0338.
+                particles.add("%s(?![%s])" % (short, ignore))
+        
+        for long_entities in list(long_entities_by_first_character.values()):
+            for long_entity in long_entities:
+                particles.add(long_entity)
+
+        re_definition = "(%s)" % "|".join(particles)
+                
+        # If an entity shows up in both html5 and codepoint2name, it's
+        # likely that HTML5 gives it several different names, such as
+        # 'rsquo' and 'rsquor'. When converting Unicode characters to
+        # named entities, the codepoint2name name should take
+        # precedence where possible, since that's the more easily
+        # recognizable one.
         for codepoint, name in list(codepoint2name.items()):
             character = chr(codepoint)
-            if codepoint != 34:
-                # There's no point in turning the quotation mark into
-                # &quot;, unless it happens within an attribute value, which
-                # is handled elsewhere.
-                characters_for_re.append(character)
-                lookup[character] = name
-            # But we do want to turn &quot; into the quotation mark.
-            reverse_lookup[name] = character
-        re_definition = "[%s]" % "".join(characters_for_re)
-        return lookup, reverse_lookup, re.compile(re_definition)
+            unicode_to_name[character] = name
+
+        return unicode_to_name, name_to_unicode, re.compile(re_definition)
     (CHARACTER_TO_HTML_ENTITY, HTML_ENTITY_TO_CHARACTER,
      CHARACTER_TO_HTML_ENTITY_RE) = _populate_class_variables()
 
@@ -72,21 +196,23 @@ class EntitySubstitution(object):
         ">": "gt",
         }
 
-    BARE_AMPERSAND_OR_BRACKET = re.compile(r"([<>]|"
-                                           r"&(?!#\d+;|#x[0-9a-fA-F]+;|\w+;)"
-                                           r")")
+    BARE_AMPERSAND_OR_BRACKET = re.compile("([<>]|"
+                                           "&(?!#\\d+;|#x[0-9a-fA-F]+;|\\w+;)"
+                                           ")")
 
-    AMPERSAND_OR_BRACKET = re.compile(r"([<>&])")
+    AMPERSAND_OR_BRACKET = re.compile("([<>&])")
 
     @classmethod
     def _substitute_html_entity(cls, matchobj):
+        """Used with a regular expression to substitute the
+        appropriate HTML entity for a special character string."""
         entity = cls.CHARACTER_TO_HTML_ENTITY.get(matchobj.group(0))
         return "&%s;" % entity
 
     @classmethod
     def _substitute_xml_entity(cls, matchobj):
         """Used with a regular expression to substitute the
-        appropriate XML entity for an XML special character."""
+        appropriate XML entity for a special character string."""
         entity = cls.CHARACTER_TO_XML_ENTITY[matchobj.group(0)]
         return "&%s;" % entity
 
@@ -181,6 +307,8 @@ class EntitySubstitution(object):
         containg a LATIN SMALL LETTER E WITH ACUTE, but replacing that
         character with "&eacute;" will make it more readable to some
         people.
+
+        :param s: A Unicode string.
         """
         return cls.CHARACTER_TO_HTML_ENTITY_RE.sub(
             cls._substitute_html_entity, s)
@@ -192,23 +320,65 @@ class EncodingDetector:
     Order of precedence:
 
     1. Encodings you specifically tell EncodingDetector to try first
-    (the override_encodings argument to the constructor).
+    (the known_definite_encodings argument to the constructor).
+
+    2. An encoding determined by sniffing the document's byte-order mark.
+
+    3. Encodings you specifically tell EncodingDetector to try if
+    byte-order mark sniffing fails (the user_encodings argument to the
+    constructor).
 
-    2. An encoding declared within the bytestring itself, either in an
+    4. An encoding declared within the bytestring itself, either in an
     XML declaration (if the bytestring is to be interpreted as an XML
     document), or in a <meta> tag (if the bytestring is to be
     interpreted as an HTML document.)
 
-    3. An encoding detected through textual analysis by chardet,
+    5. An encoding detected through textual analysis by chardet,
     cchardet, or a similar external library.
 
     4. UTF-8.
 
     5. Windows-1252.
+
     """
-    def __init__(self, markup, override_encodings=None, is_html=False,
-                 exclude_encodings=None):
-        self.override_encodings = override_encodings or []
+    def __init__(self, markup, known_definite_encodings=None,
+                 is_html=False, exclude_encodings=None,
+                 user_encodings=None, override_encodings=None):
+        """Constructor.
+
+        :param markup: Some markup in an unknown encoding.
+
+        :param known_definite_encodings: When determining the encoding
+            of `markup`, these encodings will be tried first, in
+            order. In HTML terms, this corresponds to the "known
+            definite encoding" step defined here:
+            https://html.spec.whatwg.org/multipage/parsing.html#parsing-with-a-known-character-encoding
+
+        :param user_encodings: These encodings will be tried after the
+            `known_definite_encodings` have been tried and failed, and
+            after an attempt to sniff the encoding by looking at a
+            byte order mark has failed. In HTML terms, this
+            corresponds to the step "user has explicitly instructed
+            the user agent to override the document's character
+            encoding", defined here:
+            https://html.spec.whatwg.org/multipage/parsing.html#determining-the-character-encoding
+
+        :param override_encodings: A deprecated alias for
+            known_definite_encodings. Any encodings here will be tried
+            immediately after the encodings in
+            known_definite_encodings.
+
+        :param is_html: If True, this markup is considered to be
+            HTML. Otherwise it's assumed to be XML.
+
+        :param exclude_encodings: These encodings will not be tried,
+            even if they otherwise would be.
+
+        """
+        self.known_definite_encodings = list(known_definite_encodings or [])
+        if override_encodings:
+            self.known_definite_encodings += override_encodings
+        self.user_encodings = user_encodings or []
         exclude_encodings = exclude_encodings or []
         self.exclude_encodings = set([x.lower() for x in exclude_encodings])
         self.chardet_encoding = None
@@ -219,6 +389,12 @@ class EncodingDetector:
         self.markup, self.sniffed_encoding = self.strip_byte_order_mark(markup)
 
     def _usable(self, encoding, tried):
+        """Should we even bother to try this encoding?
+
+        :param encoding: Name of an encoding.
+        :param tried: Encodings that have already been tried. This will be modified
+            as a side effect.
+        """
         if encoding is not None:
             encoding = encoding.lower()
             if encoding in self.exclude_encodings:
@@ -230,9 +406,14 @@ class EncodingDetector:
 
     @property
     def encodings(self):
-        """Yield a number of encodings that might work for this markup."""
+        """Yield a number of encodings that might work for this markup.
+
+        :yield: A sequence of strings.
+        """
         tried = set()
-        for e in self.override_encodings:
+
+        # First, try the known definite encodings
+        for e in self.known_definite_encodings:
             if self._usable(e, tried):
                 yield e
 
@@ -241,6 +422,12 @@ class EncodingDetector:
         if self._usable(self.sniffed_encoding, tried):
             yield self.sniffed_encoding
 
+        # Sniffing the byte-order mark did nothing; try the user
+        # encodings.
+        for e in self.user_encodings:
+            if self._usable(e, tried):
+                yield e
+            
         # Look within the document for an XML or HTML encoding
         # declaration.
         if self.declared_encoding is None:
@@ -263,7 +450,11 @@ class EncodingDetector:
 
     @classmethod
     def strip_byte_order_mark(cls, data):
-        """If a byte-order mark is present, strip it and return the encoding it implies."""
+        """If a byte-order mark is present, strip it and return the encoding it implies.
+
+        :param data: Some markup.
+        :return: A 2-tuple (modified data, implied encoding)
+        """
         encoding = None
         if isinstance(data, str):
             # Unicode data cannot have a byte-order mark.
@@ -295,21 +486,36 @@ class EncodingDetector:
 
         An HTML encoding is declared in a <meta> tag, hopefully near the
         beginning of the document.
+
+        :param markup: Some markup.
+        :param is_html: If True, this markup is considered to be HTML. Otherwise
+            it's assumed to be XML.
+        :param search_entire_document: Since an encoding is supposed to declared near the beginning
+            of the document, most of the time it's only necessary to search a few kilobytes of data.
+            Set this to True to force this method to search the entire document.
         """
         if search_entire_document:
             xml_endpos = html_endpos = len(markup)
         else:
             xml_endpos = 1024
             html_endpos = max(2048, int(len(markup) * 0.05))
-            
+
+        if isinstance(markup, bytes):
+            res = encoding_res[bytes]
+        else:
+            res = encoding_res[str]
+
+        xml_re = res['xml']
+        html_re = res['html']
         declared_encoding = None
-        declared_encoding_match = xml_encoding_re.search(markup, endpos=xml_endpos)
+        declared_encoding_match = xml_re.search(markup, endpos=xml_endpos)
         if not declared_encoding_match and is_html:
-            declared_encoding_match = html_meta_re.search(markup, endpos=html_endpos)
+            declared_encoding_match = html_re.search(markup, endpos=html_endpos)
         if declared_encoding_match is not None:
-            declared_encoding = declared_encoding_match.groups()[0].decode(
-                'ascii', 'replace')
+            declared_encoding = declared_encoding_match.groups()[0]
         if declared_encoding:
+            if isinstance(declared_encoding, bytes):
+                declared_encoding = declared_encoding.decode('ascii', 'replace')
             return declared_encoding.lower()
         return None
 
@@ -332,15 +538,53 @@ class UnicodeDammit:
         "iso-8859-2",
         ]
 
-    def __init__(self, markup, override_encodings=[],
-                 smart_quotes_to=None, is_html=False, exclude_encodings=[]):
+    def __init__(self, markup, known_definite_encodings=[],
+                 smart_quotes_to=None, is_html=False, exclude_encodings=[],
+                 user_encodings=None, override_encodings=None
+    ):
+        """Constructor.
+
+        :param markup: A bytestring representing markup in an unknown encoding.
+
+        :param known_definite_encodings: When determining the encoding
+            of `markup`, these encodings will be tried first, in
+            order. In HTML terms, this corresponds to the "known
+            definite encoding" step defined here:
+            https://html.spec.whatwg.org/multipage/parsing.html#parsing-with-a-known-character-encoding
+
+        :param user_encodings: These encodings will be tried after the
+            `known_definite_encodings` have been tried and failed, and
+            after an attempt to sniff the encoding by looking at a
+            byte order mark has failed. In HTML terms, this
+            corresponds to the step "user has explicitly instructed
+            the user agent to override the document's character
+            encoding", defined here:
+            https://html.spec.whatwg.org/multipage/parsing.html#determining-the-character-encoding
+
+        :param override_encodings: A deprecated alias for
+            known_definite_encodings. Any encodings here will be tried
+            immediately after the encodings in
+            known_definite_encodings.
+
+        :param smart_quotes_to: By default, Microsoft smart quotes will, like all other characters, be converted
+           to Unicode characters. Setting this to 'ascii' will convert them to ASCII quotes instead.
+           Setting it to 'xml' will convert them to XML entity references, and setting it to 'html'
+           will convert them to HTML entity references.
+        :param is_html: If True, this markup is considered to be HTML. Otherwise
+            it's assumed to be XML.
+        :param exclude_encodings: These encodings will not be considered, even
+            if the sniffing code thinks they might make sense.
+
+        """
         self.smart_quotes_to = smart_quotes_to
         self.tried_encodings = []
         self.contains_replacement_characters = False
         self.is_html = is_html
-
+        self.log = logging.getLogger(__name__)
         self.detector = EncodingDetector(
-            markup, override_encodings, is_html, exclude_encodings)
+            markup, known_definite_encodings, is_html, exclude_encodings,
+            user_encodings, override_encodings
+        )
 
         # Short-circuit if the data is in Unicode to begin with.
         if isinstance(markup, str) or markup == '':
@@ -368,9 +612,10 @@ class UnicodeDammit:
                 if encoding != "ascii":
                     u = self._convert_from(encoding, "replace")
                 if u is not None:
-                    logging.warning(
+                    self.log.warning(
                             "Some characters could not be decoded, and were "
-                            "replaced with REPLACEMENT CHARACTER.")
+                            "replaced with REPLACEMENT CHARACTER."
+                    )
                     self.contains_replacement_characters = True
                     break
 
@@ -399,6 +644,10 @@ class UnicodeDammit:
         return sub
 
     def _convert_from(self, proposed, errors="strict"):
+        """Attempt to convert the markup to the proposed encoding.
+
+        :param proposed: The name of a character encoding.
+        """
         proposed = self.find_codec(proposed)
         if not proposed or (proposed, errors) in self.tried_encodings:
             return None
@@ -413,30 +662,40 @@ class UnicodeDammit:
             markup = smart_quotes_compiled.sub(self._sub_ms_char, markup)
 
         try:
-            #print "Trying to convert document to %s (errors=%s)" % (
-            #    proposed, errors)
+            #print("Trying to convert document to %s (errors=%s)" % (
+            #    proposed, errors))
             u = self._to_unicode(markup, proposed, errors)
             self.markup = u
             self.original_encoding = proposed
         except Exception as e:
-            #print "That didn't work!"
-            #print e
+            #print("That didn't work!")
+            #print(e)
             return None
-        #print "Correct encoding: %s" % proposed
+        #print("Correct encoding: %s" % proposed)
         return self.markup
 
     def _to_unicode(self, data, encoding, errors="strict"):
-        '''Given a string and its encoding, decodes the string into Unicode.
-        %encoding is a string recognized by encodings.aliases'''
+        """Given a string and its encoding, decodes the string into Unicode.
+
+        :param encoding: The name of an encoding.
+        """
         return str(data, encoding, errors)
 
     @property
     def declared_html_encoding(self):
+        """If the markup is an HTML document, returns the encoding declared _within_
+        the document.
+        """
         if not self.is_html:
             return None
         return self.detector.declared_encoding
 
     def find_codec(self, charset):
+        """Convert the name of a character set to a codec name.
+
+        :param charset: The name of a character set.
+        :return: The name of a codec.
+        """
         value = (self._codec(self.CHARSET_ALIASES.get(charset, charset))
                or (charset and self._codec(charset.replace("-", "")))
                or (charset and self._codec(charset.replace("-", "_")))
@@ -726,7 +985,7 @@ class UnicodeDammit:
         0xde : b'\xc3\x9e',     # Þ
         0xdf : b'\xc3\x9f',     # ß
         0xe0 : b'\xc3\xa0',     # à
-        0xe1 : b'\xa1',     # á
+        0xe1 : b'\xa1',         # á
         0xe2 : b'\xc3\xa2',     # â
         0xe3 : b'\xc3\xa3',     # ã
         0xe4 : b'\xc3\xa4',     # ä
@@ -775,12 +1034,16 @@ class UnicodeDammit:
         Currently the only situation supported is Windows-1252 (or its
         subset ISO-8859-1), embedded in UTF-8.
 
-        The input must be a bytestring. If you've already converted
-        the document to Unicode, you're too late.
-
-        The output is a bytestring in which `embedded_encoding`
-        characters have been converted to their `main_encoding`
-        equivalents.
+        :param in_bytes: A bytestring that you suspect contains
+            characters from multiple encodings. Note that this _must_
+            be a bytestring. If you've already converted the document
+            to Unicode, you're too late.
+        :param main_encoding: The primary encoding of `in_bytes`.
+        :param embedded_encoding: The encoding that was used to embed characters
+            in the main document.
+        :return: A bytestring in which `embedded_encoding`
+          characters have been converted to their `main_encoding`
+          equivalents.
         """
         if embedded_encoding.replace('_', '-').lower() not in (
             'windows-1252', 'windows_1252'):
diff --git a/lib/bs4/diagnose.py b/lib/bs4/diagnose.py
index 083395fb46..e079772e69 100644
--- a/lib/bs4/diagnose.py
+++ b/lib/bs4/diagnose.py
@@ -1,9 +1,10 @@
 """Diagnostic functions, mainly for use when doing tech support."""
 
+# Use of this source code is governed by the MIT license.
 __license__ = "MIT"
 
 import cProfile
-from io import StringIO
+from io import BytesIO
 from html.parser import HTMLParser
 import bs4
 from bs4 import BeautifulSoup, __version__
@@ -19,9 +20,13 @@ import sys
 import cProfile
 
 def diagnose(data):
-    """Diagnostic suite for isolating common problems."""
-    print("Diagnostic running on Beautiful Soup %s" % __version__)
-    print("Python version %s" % sys.version)
+    """Diagnostic suite for isolating common problems.
+
+    :param data: A string containing markup that needs to be explained.
+    :return: None; diagnostics are printed to standard output.
+    """
+    print(("Diagnostic running on Beautiful Soup %s" % __version__))
+    print(("Python version %s" % sys.version))
 
     basic_parsers = ["html.parser", "html5lib", "lxml"]
     for name in basic_parsers:
@@ -35,61 +40,70 @@ def diagnose(data):
                 name))
 
     if 'lxml' in basic_parsers:
-        basic_parsers.append(["lxml", "xml"])
+        basic_parsers.append("lxml-xml")
         try:
             from lxml import etree
-            print("Found lxml version %s" % ".".join(map(str,etree.LXML_VERSION)))
+            print(("Found lxml version %s" % ".".join(map(str,etree.LXML_VERSION))))
         except ImportError as e:
-            print (
+            print(
                 "lxml is not installed or couldn't be imported.")
 
 
     if 'html5lib' in basic_parsers:
         try:
             import html5lib
-            print("Found html5lib version %s" % html5lib.__version__)
+            print(("Found html5lib version %s" % html5lib.__version__))
         except ImportError as e:
-            print (
+            print(
                 "html5lib is not installed or couldn't be imported.")
 
     if hasattr(data, 'read'):
         data = data.read()
-    elif os.path.exists(data):
-        print('"%s" looks like a filename. Reading data from the file.' % data)
-        data = open(data).read()
-    elif data.startswith("http:") or data.startswith("https:"):
-        print('"%s" looks like a URL. Beautiful Soup is not an HTTP client.' % data)
-        print("You need to use some other library to get the document behind the URL, and feed that document to Beautiful Soup.")
-        return
-    print()
 
     for parser in basic_parsers:
-        print("Trying to parse your markup with %s" % parser)
+        print(("Trying to parse your markup with %s" % parser))
         success = False
         try:
-            soup = BeautifulSoup(data, parser)
+            soup = BeautifulSoup(data, features=parser)
             success = True
         except Exception as e:
-            print("%s could not parse the markup." % parser)
+            print(("%s could not parse the markup." % parser))
             traceback.print_exc()
         if success:
-            print("Here's what %s did with the markup:" % parser)
-            print(soup.prettify())
+            print(("Here's what %s did with the markup:" % parser))
+            print((soup.prettify()))
 
-        print("-" * 80)
+        print(("-" * 80))
 
 def lxml_trace(data, html=True, **kwargs):
     """Print out the lxml events that occur during parsing.
 
     This lets you see how lxml parses a document when no Beautiful
-    Soup code is running.
+    Soup code is running. You can use this to determine whether
+    an lxml-specific problem is in Beautiful Soup's lxml tree builders
+    or in lxml itself.
+
+    :param data: Some markup.
+    :param html: If True, markup will be parsed with lxml's HTML parser.
+       if False, lxml's XML parser will be used.
     """
     from lxml import etree
-    for event, element in etree.iterparse(StringIO(data), html=html, **kwargs):
+    recover = kwargs.pop('recover', True)
+    if isinstance(data, str):
+        data = data.encode("utf8")
+    reader = BytesIO(data)
+    for event, element in etree.iterparse(
+        reader, html=html, recover=recover, **kwargs
+    ):
         print(("%s, %4s, %s" % (event, element.tag, element.text)))
 
 class AnnouncingParser(HTMLParser):
-    """Announces HTMLParser parse events, without doing anything else."""
+    """Subclass of HTMLParser that announces parse events, without doing
+    anything else.
+
+    You can use this to get a picture of how html.parser sees a given
+    document. The easiest way to do this is to call `htmlparser_trace`.
+    """
 
     def _p(self, s):
         print(s)
@@ -126,6 +140,8 @@ def htmlparser_trace(data):
 
     This lets you see how HTMLParser parses a document when no
     Beautiful Soup code is running.
+
+    :param data: Some markup.
     """
     parser = AnnouncingParser()
     parser.feed(data)
@@ -168,9 +184,9 @@ def rdoc(num_elements=1000):
 
 def benchmark_parsers(num_elements=100000):
     """Very basic head-to-head performance benchmark."""
-    print("Comparative parser benchmark on Beautiful Soup %s" % __version__)
+    print(("Comparative parser benchmark on Beautiful Soup %s" % __version__))
     data = rdoc(num_elements)
-    print("Generated a large invalid HTML document (%d bytes)." % len(data))
+    print(("Generated a large invalid HTML document (%d bytes)." % len(data)))
     
     for parser in ["lxml", ["lxml", "html"], "html5lib", "html.parser"]:
         success = False
@@ -180,26 +196,26 @@ def benchmark_parsers(num_elements=100000):
             b = time.time()
             success = True
         except Exception as e:
-            print("%s could not parse the markup." % parser)
+            print(("%s could not parse the markup." % parser))
             traceback.print_exc()
         if success:
-            print("BS4+%s parsed the markup in %.2fs." % (parser, b-a))
+            print(("BS4+%s parsed the markup in %.2fs." % (parser, b-a)))
 
     from lxml import etree
     a = time.time()
     etree.HTML(data)
     b = time.time()
-    print("Raw lxml parsed the markup in %.2fs." % (b-a))
+    print(("Raw lxml parsed the markup in %.2fs." % (b-a)))
 
     import html5lib
     parser = html5lib.HTMLParser()
     a = time.time()
     parser.parse(data)
     b = time.time()
-    print("Raw html5lib parsed the markup in %.2fs." % (b-a))
+    print(("Raw html5lib parsed the markup in %.2fs." % (b-a)))
 
 def profile(num_elements=100000, parser="lxml"):
-
+    """Use Python's profiler on a randomly generated document."""
     filehandle = tempfile.NamedTemporaryFile()
     filename = filehandle.name
 
@@ -212,5 +228,6 @@ def profile(num_elements=100000, parser="lxml"):
     stats.sort_stats("cumulative")
     stats.print_stats('_html5lib|bs4', 50)
 
+# If this file is run as a script, standard input is diagnosed.
 if __name__ == '__main__':
     diagnose(sys.stdin.read())
diff --git a/lib/bs4/element.py b/lib/bs4/element.py
index 68be42d138..0aefe734b2 100644
--- a/lib/bs4/element.py
+++ b/lib/bs4/element.py
@@ -1,14 +1,27 @@
+# Use of this source code is governed by the MIT license.
 __license__ = "MIT"
 
-import collections.abc
+try:
+    from collections.abc import Callable # Python 3.6
+except ImportError as e:
+    from collections import Callable
 import re
 import sys
 import warnings
-from bs4.dammit import EntitySubstitution
+
+from bs4.css import CSS
+from bs4.formatter import (
+    Formatter,
+    HTMLFormatter,
+    XMLFormatter,
+)
 
 DEFAULT_OUTPUT_ENCODING = "utf-8"
-PY3K = (sys.version_info[0] > 2)
 
+nonwhitespace_re = re.compile(r"\S+")
+
+# NOTE: This isn't used as of 4.7.0. I'm leaving it for a little bit on
+# the off chance someone imported it for their own use.
 whitespace_re = re.compile(r"\s+")
 
 def _alias(attr):
@@ -23,12 +36,49 @@ def _alias(attr):
     return alias
 
 
+# These encodings are recognized by Python (so PageElement.encode
+# could theoretically support them) but XML and HTML don't recognize
+# them (so they should not show up in an XML or HTML document as that
+# document's encoding).
+#
+# If an XML document is encoded in one of these encodings, no encoding
+# will be mentioned in the XML declaration. If an HTML document is
+# encoded in one of these encodings, and the HTML document has a
+# <meta> tag that mentions an encoding, the encoding will be given as
+# the empty string.
+#
+# Source:
+# https://docs.python.org/3/library/codecs.html#python-specific-encodings
+PYTHON_SPECIFIC_ENCODINGS = set([
+    "idna",
+    "mbcs",
+    "oem",
+    "palmos",
+    "punycode",
+    "raw_unicode_escape",
+    "undefined",
+    "unicode_escape",
+    "raw-unicode-escape",
+    "unicode-escape",
+    "string-escape",
+    "string_escape",
+])
+
+
 class NamespacedAttribute(str):
+    """A namespaced string (e.g. 'xml:lang') that remembers the namespace
+    ('xml') and the name ('lang') that were used to create it.
+    """
 
-    def __new__(cls, prefix, name, namespace=None):
-        if name is None:
+    def __new__(cls, prefix, name=None, namespace=None):
+        if not name:
+            # This is the default namespace. Its name "has no value"
+            # per https://www.w3.org/TR/xml-names/#defaulting
+            name = None
+
+        if not name:
             obj = str.__new__(cls, prefix)
-        elif prefix is None:
+        elif not prefix:
             # Not really namespaced.
             obj = str.__new__(cls, name)
         else:
@@ -54,6 +104,11 @@ class CharsetMetaAttributeValue(AttributeValueWithCharsetSubstitution):
         return obj
 
     def encode(self, encoding):
+        """When an HTML document is being encoded to a given encoding, the
+        value of a meta tag's 'charset' is the name of the encoding.
+        """
+        if encoding in PYTHON_SPECIFIC_ENCODINGS:
+            return ''
         return encoding
 
 
@@ -79,118 +134,44 @@ class ContentMetaAttributeValue(AttributeValueWithCharsetSubstitution):
         return obj
 
     def encode(self, encoding):
+        if encoding in PYTHON_SPECIFIC_ENCODINGS:
+            return ''
         def rewrite(match):
             return match.group(1) + encoding
         return self.CHARSET_RE.sub(rewrite, self.original_value)
 
-class HTMLAwareEntitySubstitution(EntitySubstitution):
-
-    """Entity substitution rules that are aware of some HTML quirks.
 
-    Specifically, the contents of <script> and <style> tags should not
-    undergo entity substitution.
+class PageElement(object):
+    """Contains the navigational information for some part of the page:
+    that is, its current location in the parse tree.
 
-    Incoming NavigableString objects are checked to see if they're the
-    direct children of a <script> or <style> tag.
+    NavigableString, Tag, etc. are all subclasses of PageElement.
     """
 
-    cdata_containing_tags = set(["script", "style"])
+    # In general, we can't tell just by looking at an element whether
+    # it's contained in an XML document or an HTML document. But for
+    # Tags (q.v.) we can store this information at parse time.
+    known_xml = None
 
-    preformatted_tags = set(["pre"])
-
-    @classmethod
-    def _substitute_if_appropriate(cls, ns, f):
-        if (isinstance(ns, NavigableString)
-            and ns.parent is not None
-            and ns.parent.name in cls.cdata_containing_tags):
-            # Do nothing.
-            return ns
-        # Substitute.
-        return f(ns)
+    def setup(self, parent=None, previous_element=None, next_element=None,
+              previous_sibling=None, next_sibling=None):
+        """Sets up the initial relations between this element and
+        other elements.
 
-    @classmethod
-    def substitute_html(cls, ns):
-        return cls._substitute_if_appropriate(
-            ns, EntitySubstitution.substitute_html)
+        :param parent: The parent of this element.
 
-    @classmethod
-    def substitute_xml(cls, ns):
-        return cls._substitute_if_appropriate(
-            ns, EntitySubstitution.substitute_xml)
+        :param previous_element: The element parsed immediately before
+            this one.
 
-class PageElement(object):
-    """Contains the navigational information for some part of the page
-    (either a tag or a piece of text)"""
-
-    # There are five possible values for the "formatter" argument passed in
-    # to methods like encode() and prettify():
-    #
-    # "html" - All Unicode characters with corresponding HTML entities
-    #   are converted to those entities on output.
-    # "minimal" - Bare ampersands and angle brackets are converted to
-    #   XML entities: &amp; &lt; &gt;
-    # None - The null formatter. Unicode characters are never
-    #   converted to entities.  This is not recommended, but it's
-    #   faster than "minimal".
-    # A function - This function will be called on every string that
-    #  needs to undergo entity substitution.
-    #
-
-    # In an HTML document, the default "html" and "minimal" functions
-    # will leave the contents of <script> and <style> tags alone. For
-    # an XML document, all tags will be given the same treatment.
-
-    HTML_FORMATTERS = {
-        "html" : HTMLAwareEntitySubstitution.substitute_html,
-        "minimal" : HTMLAwareEntitySubstitution.substitute_xml,
-        None : None
-        }
-
-    XML_FORMATTERS = {
-        "html" : EntitySubstitution.substitute_html,
-        "minimal" : EntitySubstitution.substitute_xml,
-        None : None
-        }
-
-    def format_string(self, s, formatter='minimal'):
-        """Format the given string using the given formatter."""
-        if not isinstance(formatter, collections.abc.Callable):
-            formatter = self._formatter_for_name(formatter)
-        if formatter is None:
-            output = s
-        else:
-            output = formatter(s)
-        return output
+        :param next_element: The element parsed immediately before
+            this one.
 
-    @property
-    def _is_xml(self):
-        """Is this element part of an XML tree or an HTML tree?
+        :param previous_sibling: The most recently encountered element
+            on the same level of the parse tree as this one.
 
-        This is used when mapping a formatter name ("minimal") to an
-        appropriate function (one that performs entity-substitution on
-        the contents of <script> and <style> tags, or not). It's
-        inefficient, but it should be called very rarely.
+        :param previous_sibling: The next element to be encountered
+            on the same level of the parse tree as this one.
         """
-        if self.parent is None:
-            # This is the top-level object. It should have .is_xml set
-            # from tree creation. If not, take a guess--BS is usually
-            # used on HTML markup.
-            return getattr(self, 'is_xml', False)
-        return self.parent._is_xml
-
-    def _formatter_for_name(self, name):
-        "Look up a formatter function based on its name and the tree."
-        if self._is_xml:
-            return self.XML_FORMATTERS.get(
-                name, EntitySubstitution.substitute_xml)
-        else:
-            return self.HTML_FORMATTERS.get(
-                name, HTMLAwareEntitySubstitution.substitute_xml)
-
-    def setup(self, parent=None, previous_element=None, next_element=None,
-              previous_sibling=None, next_sibling=None):
-        """Sets up the initial relations between this element and
-        other elements."""
         self.parent = parent
 
         self.previous_element = previous_element
@@ -198,48 +179,156 @@ class PageElement(object):
             self.previous_element.next_element = self
 
         self.next_element = next_element
-        if self.next_element:
+        if self.next_element is not None:
             self.next_element.previous_element = self
 
         self.next_sibling = next_sibling
-        if self.next_sibling:
+        if self.next_sibling is not None:
             self.next_sibling.previous_sibling = self
 
-        if (not previous_sibling
+        if (previous_sibling is None
             and self.parent is not None and self.parent.contents):
             previous_sibling = self.parent.contents[-1]
 
         self.previous_sibling = previous_sibling
-        if previous_sibling:
+        if previous_sibling is not None:
             self.previous_sibling.next_sibling = self
 
+    def format_string(self, s, formatter):
+        """Format the given string using the given formatter.
+
+        :param s: A string.
+        :param formatter: A Formatter object, or a string naming one of the standard formatters.
+        """
+        if formatter is None:
+            return s
+        if not isinstance(formatter, Formatter):
+            formatter = self.formatter_for_name(formatter)
+        output = formatter.substitute(s)
+        return output
+
+    def formatter_for_name(self, formatter):
+        """Look up or create a Formatter for the given identifier,
+        if necessary.
+
+        :param formatter: Can be a Formatter object (used as-is), a
+            function (used as the entity substitution hook for an
+            XMLFormatter or HTMLFormatter), or a string (used to look
+            up an XMLFormatter or HTMLFormatter in the appropriate
+            registry.
+        """
+        if isinstance(formatter, Formatter):
+            return formatter
+        if self._is_xml:
+            c = XMLFormatter
+        else:
+            c = HTMLFormatter
+        if isinstance(formatter, Callable):
+            return c(entity_substitution=formatter)
+        return c.REGISTRY[formatter]
+
+    @property
+    def _is_xml(self):
+        """Is this element part of an XML tree or an HTML tree?
+
+        This is used in formatter_for_name, when deciding whether an
+        XMLFormatter or HTMLFormatter is more appropriate. It can be
+        inefficient, but it should be called very rarely.
+        """
+        if self.known_xml is not None:
+            # Most of the time we will have determined this when the
+            # document is parsed.
+            return self.known_xml
+
+        # Otherwise, it's likely that this element was created by
+        # direct invocation of the constructor from within the user's
+        # Python code.
+        if self.parent is None:
+            # This is the top-level object. It should have .known_xml set
+            # from tree creation. If not, take a guess--BS is usually
+            # used on HTML markup.
+            return getattr(self, 'is_xml', False)
+        return self.parent._is_xml
+
     nextSibling = _alias("next_sibling")  # BS3
     previousSibling = _alias("previous_sibling")  # BS3
 
-    def replace_with(self, replace_with):
-        if not self.parent:
+    default = object()
+    def _all_strings(self, strip=False, types=default):
+        """Yield all strings of certain classes, possibly stripping them.
+
+        This is implemented differently in Tag and NavigableString.
+        """
+        raise NotImplementedError()
+
+    @property
+    def stripped_strings(self):
+        """Yield all strings in this PageElement, stripping them first.
+
+        :yield: A sequence of stripped strings.
+        """
+        for string in self._all_strings(True):
+            yield string
+
+    def get_text(self, separator="", strip=False,
+                 types=default):
+        """Get all child strings of this PageElement, concatenated using the
+        given separator.
+
+        :param separator: Strings will be concatenated using this separator.
+
+        :param strip: If True, strings will be stripped before being
+            concatenated.
+
+        :param types: A tuple of NavigableString subclasses. Any
+            strings of a subclass not found in this list will be
+            ignored. Although there are exceptions, the default
+            behavior in most cases is to consider only NavigableString
+            and CData objects. That means no comments, processing
+            instructions, etc.
+
+        :return: A string.
+        """
+        return separator.join([s for s in self._all_strings(
+                    strip, types=types)])
+    getText = get_text
+    text = property(get_text)
+
+    def replace_with(self, *args):
+        """Replace this PageElement with one or more PageElements, keeping the
+        rest of the tree the same.
+
+        :param args: One or more PageElements.
+        :return: `self`, no longer part of the tree.
+        """
+        if self.parent is None:
             raise ValueError(
-                "Cannot replace one element with another when the"
+                "Cannot replace one element with another when the "
                 "element to be replaced is not part of a tree.")
-        if replace_with is self:
+        if len(args) == 1 and args[0] is self:
             return
-        if replace_with is self.parent:
+        if any(x is self.parent for x in args):
             raise ValueError("Cannot replace a Tag with its parent.")
         old_parent = self.parent
         my_index = self.parent.index(self)
-        self.extract()
-        old_parent.insert(my_index, replace_with)
+        self.extract(_self_index=my_index)
+        for idx, replace_with in enumerate(args, start=my_index):
+            old_parent.insert(idx, replace_with)
         return self
     replaceWith = replace_with  # BS3
 
     def unwrap(self):
+        """Replace this PageElement with its contents.
+
+        :return: `self`, no longer part of the tree.
+        """
         my_parent = self.parent
-        if not self.parent:
+        if self.parent is None:
             raise ValueError(
                 "Cannot replace an element with its contents when that"
                 "element is not part of a tree.")
         my_index = self.parent.index(self)
-        self.extract()
+        self.extract(_self_index=my_index)
         for child in reversed(self.contents[:]):
             my_parent.insert(my_index, child)
         return self
@@ -247,14 +336,29 @@ class PageElement(object):
     replaceWithChildren = unwrap  # BS3
 
     def wrap(self, wrap_inside):
+        """Wrap this PageElement inside another one.
+
+        :param wrap_inside: A PageElement.
+        :return: `wrap_inside`, occupying the position in the tree that used
+           to be occupied by `self`, and with `self` inside it.
+        """
         me = self.replace_with(wrap_inside)
         wrap_inside.append(me)
         return wrap_inside
 
-    def extract(self):
-        """Destructively rips this element out of the tree."""
+    def extract(self, _self_index=None):
+        """Destructively rips this element out of the tree.
+
+        :param _self_index: The location of this element in its parent's
+           .contents, if known. Passing this in allows for a performance
+           optimization.
+
+        :return: `self`, no longer part of the tree.
+        """
         if self.parent is not None:
-            del self.parent.contents[self.parent.index(self)]
+            if _self_index is None:
+                _self_index = self.parent.index(self)
+            del self.parent.contents[_self_index]
 
         #Find the two elements that would be next to each other if
         #this element (and any children) hadn't been parsed. Connect
@@ -281,8 +385,13 @@ class PageElement(object):
         return self
 
     def _last_descendant(self, is_initialized=True, accept_self=True):
-        "Finds the last element beneath this object to be parsed."
-        if is_initialized and self.next_sibling:
+        """Finds the last element beneath this object to be parsed.
+
+        :param is_initialized: Has `setup` been called on this PageElement
+            yet?
+        :param accept_self: Is `self` an acceptable answer to the question?
+        """
+        if is_initialized and self.next_sibling is not None:
             last_child = self.next_sibling.previous_element
         else:
             last_child = self
@@ -295,6 +404,14 @@ class PageElement(object):
     _lastRecursiveChild = _last_descendant
 
     def insert(self, position, new_child):
+        """Insert a new PageElement in the list of this PageElement's children.
+
+        This works the same way as `list.insert`.
+
+        :param position: The numeric position that should be occupied
+           in `self.children` by the new PageElement.
+        :param new_child: A PageElement.
+        """
         if new_child is None:
             raise ValueError("Cannot insert None into a tag.")
         if new_child is self:
@@ -303,6 +420,14 @@ class PageElement(object):
             and not isinstance(new_child, NavigableString)):
             new_child = NavigableString(new_child)
 
+        from bs4 import BeautifulSoup
+        if isinstance(new_child, BeautifulSoup):
+            # We don't want to end up with a situation where one BeautifulSoup
+            # object contains another. Insert the children one at a time.
+            for subchild in list(new_child.contents):
+                self.insert(position, subchild)
+                position += 1
+            return
         position = min(position, len(self.contents))
         if hasattr(new_child, 'parent') and new_child.parent is not None:
             # We're 'inserting' an element that's already one
@@ -361,160 +486,326 @@ class PageElement(object):
         self.contents.insert(position, new_child)
 
     def append(self, tag):
-        """Appends the given tag to the contents of this tag."""
+        """Appends the given PageElement to the contents of this one.
+
+        :param tag: A PageElement.
+        """
         self.insert(len(self.contents), tag)
 
-    def insert_before(self, predecessor):
-        """Makes the given element the immediate predecessor of this one.
+    def extend(self, tags):
+        """Appends the given PageElements to this one's contents.
 
-        The two elements will have the same parent, and the given element
+        :param tags: A list of PageElements. If a single Tag is
+            provided instead, this PageElement's contents will be extended
+            with that Tag's contents.
+        """
+        if isinstance(tags, Tag):
+            tags = tags.contents
+        if isinstance(tags, list):
+            # Moving items around the tree may change their position in
+            # the original list. Make a list that won't change.
+            tags = list(tags)
+        for tag in tags:
+            self.append(tag)
+
+    def insert_before(self, *args):
+        """Makes the given element(s) the immediate predecessor of this one.
+
+        All the elements will have the same parent, and the given elements
         will be immediately before this one.
+
+        :param args: One or more PageElements.
         """
-        if self is predecessor:
-            raise ValueError("Can't insert an element before itself.")
         parent = self.parent
         if parent is None:
             raise ValueError(
                 "Element has no parent, so 'before' has no meaning.")
-        # Extract first so that the index won't be screwed up if they
-        # are siblings.
-        if isinstance(predecessor, PageElement):
-            predecessor.extract()
-        index = parent.index(self)
-        parent.insert(index, predecessor)
-
-    def insert_after(self, successor):
-        """Makes the given element the immediate successor of this one.
-
-        The two elements will have the same parent, and the given element
+        if any(x is self for x in args):
+                raise ValueError("Can't insert an element before itself.")
+        for predecessor in args:
+            # Extract first so that the index won't be screwed up if they
+            # are siblings.
+            if isinstance(predecessor, PageElement):
+                predecessor.extract()
+            index = parent.index(self)
+            parent.insert(index, predecessor)
+
+    def insert_after(self, *args):
+        """Makes the given element(s) the immediate successor of this one.
+
+        The elements will have the same parent, and the given elements
         will be immediately after this one.
+
+        :param args: One or more PageElements.
         """
-        if self is successor:
-            raise ValueError("Can't insert an element after itself.")
+        # Do all error checking before modifying the tree.
         parent = self.parent
         if parent is None:
             raise ValueError(
                 "Element has no parent, so 'after' has no meaning.")
-        # Extract first so that the index won't be screwed up if they
-        # are siblings.
-        if isinstance(successor, PageElement):
-            successor.extract()
-        index = parent.index(self)
-        parent.insert(index+1, successor)
-
-    def find_next(self, name=None, attrs={}, text=None, **kwargs):
-        """Returns the first item that matches the given criteria and
-        appears after this Tag in the document."""
-        return self._find_one(self.find_all_next, name, attrs, text, **kwargs)
+        if any(x is self for x in args):
+            raise ValueError("Can't insert an element after itself.")
+
+        offset = 0
+        for successor in args:
+            # Extract first so that the index won't be screwed up if they
+            # are siblings.
+            if isinstance(successor, PageElement):
+                successor.extract()
+            index = parent.index(self)
+            parent.insert(index+1+offset, successor)
+            offset += 1
+
+    def find_next(self, name=None, attrs={}, string=None, **kwargs):
+        """Find the first PageElement that matches the given criteria and
+        appears later in the document than this PageElement.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
+        return self._find_one(self.find_all_next, name, attrs, string, **kwargs)
     findNext = find_next  # BS3
 
-    def find_all_next(self, name=None, attrs={}, text=None, limit=None,
+    def find_all_next(self, name=None, attrs={}, string=None, limit=None,
                     **kwargs):
-        """Returns all items that match the given criteria and appear
-        after this Tag in the document."""
-        return self._find_all(name, attrs, text, limit, self.next_elements,
-                             **kwargs)
+        """Find all PageElements that match the given criteria and appear
+        later in the document than this PageElement.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A ResultSet containing PageElements.
+        """
+        _stacklevel = kwargs.pop('_stacklevel', 2)
+        return self._find_all(name, attrs, string, limit, self.next_elements,
+                              _stacklevel=_stacklevel+1, **kwargs)
     findAllNext = find_all_next  # BS3
 
-    def find_next_sibling(self, name=None, attrs={}, text=None, **kwargs):
-        """Returns the closest sibling to this Tag that matches the
-        given criteria and appears after this Tag in the document."""
-        return self._find_one(self.find_next_siblings, name, attrs, text,
+    def find_next_sibling(self, name=None, attrs={}, string=None, **kwargs):
+        """Find the closest sibling to this PageElement that matches the
+        given criteria and appears later in the document.
+
+        All find_* methods take a common set of arguments. See the
+        online documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
+        return self._find_one(self.find_next_siblings, name, attrs, string,
                              **kwargs)
     findNextSibling = find_next_sibling  # BS3
 
-    def find_next_siblings(self, name=None, attrs={}, text=None, limit=None,
+    def find_next_siblings(self, name=None, attrs={}, string=None, limit=None,
                            **kwargs):
-        """Returns the siblings of this Tag that match the given
-        criteria and appear after this Tag in the document."""
-        return self._find_all(name, attrs, text, limit,
-                              self.next_siblings, **kwargs)
+        """Find all siblings of this PageElement that match the given criteria
+        and appear later in the document.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A ResultSet of PageElements.
+        :rtype: bs4.element.ResultSet
+        """
+        _stacklevel = kwargs.pop('_stacklevel', 2)
+        return self._find_all(
+            name, attrs, string, limit,
+            self.next_siblings, _stacklevel=_stacklevel+1, **kwargs
+        )
     findNextSiblings = find_next_siblings   # BS3
     fetchNextSiblings = find_next_siblings  # BS2
 
-    def find_previous(self, name=None, attrs={}, text=None, **kwargs):
-        """Returns the first item that matches the given criteria and
-        appears before this Tag in the document."""
+    def find_previous(self, name=None, attrs={}, string=None, **kwargs):
+        """Look backwards in the document from this PageElement and find the
+        first PageElement that matches the given criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
         return self._find_one(
-            self.find_all_previous, name, attrs, text, **kwargs)
+            self.find_all_previous, name, attrs, string, **kwargs)
     findPrevious = find_previous  # BS3
 
-    def find_all_previous(self, name=None, attrs={}, text=None, limit=None,
+    def find_all_previous(self, name=None, attrs={}, string=None, limit=None,
                         **kwargs):
-        """Returns all items that match the given criteria and appear
-        before this Tag in the document."""
-        return self._find_all(name, attrs, text, limit, self.previous_elements,
-                           **kwargs)
+        """Look backwards in the document from this PageElement and find all
+        PageElements that match the given criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A ResultSet of PageElements.
+        :rtype: bs4.element.ResultSet
+        """
+        _stacklevel = kwargs.pop('_stacklevel', 2)
+        return self._find_all(
+            name, attrs, string, limit, self.previous_elements,
+            _stacklevel=_stacklevel+1, **kwargs
+        )
     findAllPrevious = find_all_previous  # BS3
     fetchPrevious = find_all_previous    # BS2
 
-    def find_previous_sibling(self, name=None, attrs={}, text=None, **kwargs):
-        """Returns the closest sibling to this Tag that matches the
-        given criteria and appears before this Tag in the document."""
-        return self._find_one(self.find_previous_siblings, name, attrs, text,
+    def find_previous_sibling(self, name=None, attrs={}, string=None, **kwargs):
+        """Returns the closest sibling to this PageElement that matches the
+        given criteria and appears earlier in the document.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
+        return self._find_one(self.find_previous_siblings, name, attrs, string,
                              **kwargs)
     findPreviousSibling = find_previous_sibling  # BS3
 
-    def find_previous_siblings(self, name=None, attrs={}, text=None,
+    def find_previous_siblings(self, name=None, attrs={}, string=None,
                                limit=None, **kwargs):
-        """Returns the siblings of this Tag that match the given
-        criteria and appear before this Tag in the document."""
-        return self._find_all(name, attrs, text, limit,
-                              self.previous_siblings, **kwargs)
+        """Returns all siblings to this PageElement that match the
+        given criteria and appear earlier in the document.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A ResultSet of PageElements.
+        :rtype: bs4.element.ResultSet
+        """
+        _stacklevel = kwargs.pop('_stacklevel', 2)
+        return self._find_all(
+            name, attrs, string, limit,
+            self.previous_siblings, _stacklevel=_stacklevel+1, **kwargs
+        )
     findPreviousSiblings = find_previous_siblings   # BS3
     fetchPreviousSiblings = find_previous_siblings  # BS2
 
     def find_parent(self, name=None, attrs={}, **kwargs):
-        """Returns the closest parent of this Tag that matches the given
-        criteria."""
+        """Find the closest parent of this PageElement that matches the given
+        criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :kwargs: A dictionary of filters on attribute values.
+
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
         # NOTE: We can't use _find_one because findParents takes a different
         # set of arguments.
         r = None
-        l = self.find_parents(name, attrs, 1, **kwargs)
+        l = self.find_parents(name, attrs, 1, _stacklevel=3, **kwargs)
         if l:
             r = l[0]
         return r
     findParent = find_parent  # BS3
 
     def find_parents(self, name=None, attrs={}, limit=None, **kwargs):
-        """Returns the parents of this Tag that match the given
-        criteria."""
+        """Find all parents of this PageElement that match the given criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
 
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
+        _stacklevel = kwargs.pop('_stacklevel', 2)
         return self._find_all(name, attrs, None, limit, self.parents,
-                             **kwargs)
+                              _stacklevel=_stacklevel+1, **kwargs)
     findParents = find_parents   # BS3
     fetchParents = find_parents  # BS2
 
     @property
     def next(self):
+        """The PageElement, if any, that was parsed just after this one.
+
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
         return self.next_element
 
     @property
     def previous(self):
+        """The PageElement, if any, that was parsed just before this one.
+
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
         return self.previous_element
 
     #These methods do the real heavy lifting.
 
-    def _find_one(self, method, name, attrs, text, **kwargs):
+    def _find_one(self, method, name, attrs, string, **kwargs):
         r = None
-        l = method(name, attrs, text, 1, **kwargs)
+        l = method(name, attrs, string, 1, _stacklevel=4, **kwargs)
         if l:
             r = l[0]
         return r
 
-    def _find_all(self, name, attrs, text, limit, generator, **kwargs):
+    def _find_all(self, name, attrs, string, limit, generator, **kwargs):
         "Iterates over a generator looking for things that match."
+        _stacklevel = kwargs.pop('_stacklevel', 3)
 
-        if text is None and 'string' in kwargs:
-            text = kwargs['string']
-            del kwargs['string']
+        if string is None and 'text' in kwargs:
+            string = kwargs.pop('text')
+            warnings.warn(
+                "The 'text' argument to find()-type methods is deprecated. Use 'string' instead.",
+                DeprecationWarning, stacklevel=_stacklevel
+            )
 
         if isinstance(name, SoupStrainer):
             strainer = name
         else:
-            strainer = SoupStrainer(name, attrs, text, **kwargs)
+            strainer = SoupStrainer(name, attrs, string, **kwargs)
 
-        if text is None and not limit and not attrs and not kwargs:
+        if string is None and not limit and not attrs and not kwargs:
             if name is True or name is None:
                 # Optimization to find all tags.
                 result = (element for element in generator
@@ -522,9 +813,23 @@ class PageElement(object):
                 return ResultSet(strainer, result)
             elif isinstance(name, str):
                 # Optimization to find all tags with a given name.
+                if name.count(':') == 1:
+                    # This is a name with a prefix. If this is a namespace-aware document,
+                    # we need to match the local name against tag.name. If not,
+                    # we need to match the fully-qualified name against tag.name.
+                    prefix, local_name = name.split(':', 1)
+                else:
+                    prefix = None
+                    local_name = name
                 result = (element for element in generator
                           if isinstance(element, Tag)
-                            and element.name == name)
+                          and (
+                              element.name == name
+                          ) or (
+                              element.name == local_name
+                              and (prefix is None or element.prefix == prefix)
+                          )
+                )
                 return ResultSet(strainer, result)
         results = ResultSet(strainer)
         while True:
@@ -544,6 +849,10 @@ class PageElement(object):
     #NavigableStrings and Tags.
     @property
     def next_elements(self):
+        """All PageElements that were parsed after this one.
+
+        :yield: A sequence of PageElements.
+        """
         i = self.next_element
         while i is not None:
             yield i
@@ -551,6 +860,11 @@ class PageElement(object):
 
     @property
     def next_siblings(self):
+        """All PageElements that are siblings of this one but were parsed
+        later.
+
+        :yield: A sequence of PageElements.
+        """
         i = self.next_sibling
         while i is not None:
             yield i
@@ -558,6 +872,10 @@ class PageElement(object):
 
     @property
     def previous_elements(self):
+        """All PageElements that were parsed before this one.
+
+        :yield: A sequence of PageElements.
+        """
         i = self.previous_element
         while i is not None:
             yield i
@@ -565,6 +883,11 @@ class PageElement(object):
 
     @property
     def previous_siblings(self):
+        """All PageElements that are siblings of this one but were parsed
+        earlier.
+
+        :yield: A sequence of PageElements.
+        """
         i = self.previous_sibling
         while i is not None:
             yield i
@@ -572,87 +895,23 @@ class PageElement(object):
 
     @property
     def parents(self):
+        """All PageElements that are parents of this PageElement.
+
+        :yield: A sequence of PageElements.
+        """
         i = self.parent
         while i is not None:
             yield i
             i = i.parent
 
-    # Methods for supporting CSS selectors.
-
-    tag_name_re = re.compile(r'^[a-zA-Z0-9][-.a-zA-Z0-9:_]*$')
-
-    # /^([a-zA-Z0-9][-.a-zA-Z0-9:_]*)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/
-    #   \---------------------------/  \---/\-------------/    \-------/
-    #     |                              |         |               |
-    #     |                              |         |           The value
-    #     |                              |    ~,|,^,$,* or =
-    #     |                           Attribute
-    #    Tag
-    attribselect_re = re.compile(
-        r'^(?P<tag>[a-zA-Z0-9][-.a-zA-Z0-9:_]*)?\[(?P<attribute>[\w-]+)(?P<operator>[=~\|\^\$\*]?)' +
-        r'=?"?(?P<value>[^\]"]*)"?\]$'
-        )
-
-    def _attr_value_as_string(self, value, default=None):
-        """Force an attribute value into a string representation.
+    @property
+    def decomposed(self):
+        """Check whether a PageElement has been decomposed.
 
-        A multi-valued attribute will be converted into a
-        space-separated stirng.
+        :rtype: bool
         """
-        value = self.get(value, default)
-        if isinstance(value, list) or isinstance(value, tuple):
-            value =" ".join(value)
-        return value
-
-    def _tag_name_matches_and(self, function, tag_name):
-        if not tag_name:
-            return function
-        else:
-            def _match(tag):
-                return tag.name == tag_name and function(tag)
-            return _match
-
-    def _attribute_checker(self, operator, attribute, value=''):
-        """Create a function that performs a CSS selector operation.
-
-        Takes an operator, attribute and optional value. Returns a
-        function that will return True for elements that match that
-        combination.
-        """
-        if operator == '=':
-            # string representation of `attribute` is equal to `value`
-            return lambda el: el._attr_value_as_string(attribute) == value
-        elif operator == '~':
-            # space-separated list representation of `attribute`
-            # contains `value`
-            def _includes_value(element):
-                attribute_value = element.get(attribute, [])
-                if not isinstance(attribute_value, list):
-                    attribute_value = attribute_value.split()
-                return value in attribute_value
-            return _includes_value
-        elif operator == '^':
-            # string representation of `attribute` starts with `value`
-            return lambda el: el._attr_value_as_string(
-                attribute, '').startswith(value)
-        elif operator == '$':
-            # string represenation of `attribute` ends with `value`
-            return lambda el: el._attr_value_as_string(
-                attribute, '').endswith(value)
-        elif operator == '*':
-            # string representation of `attribute` contains `value`
-            return lambda el: value in el._attr_value_as_string(attribute, '')
-        elif operator == '|':
-            # string representation of `attribute` is either exactly
-            # `value` or starts with `value` and then a dash.
-            def _is_or_starts_with_dash(element):
-                attribute_value = element._attr_value_as_string(attribute, '')
-                return (attribute_value == value or attribute_value.startswith(
-                        value + '-'))
-            return _is_or_starts_with_dash
-        else:
-            return lambda el: el.has_attr(attribute)
-
+        return getattr(self, '_decomposed', False) or False
+   
     # Old non-property versions of the generators, for backwards
     # compatibility with BS3.
     def nextGenerator(self):
@@ -672,6 +931,11 @@ class PageElement(object):
 
 
 class NavigableString(str, PageElement):
+    """A Python Unicode string that is part of a parse tree.
+
+    When Beautiful Soup parses the markup <b>penguin</b>, it will
+    create a NavigableString for the string "penguin".
+    """
 
     PREFIX = ''
     SUFFIX = ''
@@ -691,12 +955,22 @@ class NavigableString(str, PageElement):
         u.setup()
         return u
 
-    def __copy__(self):
+    def __deepcopy__(self, memo, recursive=False):
         """A copy of a NavigableString has the same contents and class
         as the original, but it is not connected to the parse tree.
+
+        :param recursive: This parameter is ignored; it's only defined
+           so that NavigableString.__deepcopy__ implements the same
+           signature as Tag.__deepcopy__.
         """
         return type(self)(self)
 
+    def __copy__(self):
+        """A copy of a NavigableString can only be a deep copy, because
+        only one PageElement can occupy a given place in a parse tree.
+        """
+        return self.__deepcopy__({})
+
     def __getnewargs__(self):
         return (str(self),)
 
@@ -712,55 +986,146 @@ class NavigableString(str, PageElement):
                     self.__class__.__name__, attr))
 
     def output_ready(self, formatter="minimal"):
+        """Run the string through the provided formatter.
+
+        :param formatter: A Formatter object, or a string naming one of the standard formatters.
+        """
         output = self.format_string(self, formatter)
         return self.PREFIX + output + self.SUFFIX
 
     @property
     def name(self):
+        """Since a NavigableString is not a Tag, it has no .name.
+
+        This property is implemented so that code like this doesn't crash
+        when run on a mixture of Tag and NavigableString objects:
+            [x.name for x in tag.children]
+        """
         return None
 
     @name.setter
     def name(self, name):
+        """Prevent NavigableString.name from ever being set."""
         raise AttributeError("A NavigableString cannot be given a name.")
 
+    def _all_strings(self, strip=False, types=PageElement.default):
+        """Yield all strings of certain classes, possibly stripping them.
+
+        This makes it easy for NavigableString to implement methods
+        like get_text() as conveniences, creating a consistent
+        text-extraction API across all PageElements.
+
+        :param strip: If True, all strings will be stripped before being
+            yielded.
+
+        :param types: A tuple of NavigableString subclasses. If this
+            NavigableString isn't one of those subclasses, the
+            sequence will be empty. By default, the subclasses
+            considered are NavigableString and CData objects. That
+            means no comments, processing instructions, etc.
+
+        :yield: A sequence that either contains this string, or is empty.
+
+        """
+        if types is self.default:
+            # This is kept in Tag because it's full of subclasses of
+            # this class, which aren't defined until later in the file.
+            types = Tag.DEFAULT_INTERESTING_STRING_TYPES
+
+        # Do nothing if the caller is looking for specific types of
+        # string, and we're of a different type.
+        #
+        # We check specific types instead of using isinstance(self,
+        # types) because all of these classes subclass
+        # NavigableString. Anyone who's using this feature probably
+        # wants generic NavigableStrings but not other stuff.
+        my_type = type(self)
+        if types is not None:
+            if isinstance(types, type):
+                # Looking for a single type.
+                if my_type is not types:
+                    return
+            elif my_type not in types:
+                # Looking for one of a list of types.
+                return
+
+        value = self
+        if strip:
+            value = value.strip()
+        if len(value) > 0:
+            yield value
+    strings = property(_all_strings)
+
 class PreformattedString(NavigableString):
     """A NavigableString not subject to the normal formatting rules.
 
-    The string will be passed into the formatter (to trigger side effects),
-    but the return value will be ignored.
+    This is an abstract class used for special kinds of strings such
+    as comments (the Comment class) and CDATA blocks (the CData
+    class).
     """
 
-    def output_ready(self, formatter="minimal"):
-        """CData strings are passed into the formatter.
-        But the return value is ignored."""
-        self.format_string(self, formatter)
+    PREFIX = ''
+    SUFFIX = ''
+
+    def output_ready(self, formatter=None):
+        """Make this string ready for output by adding any subclass-specific
+            prefix or suffix.
+
+        :param formatter: A Formatter object, or a string naming one
+            of the standard formatters. The string will be passed into the
+            Formatter, but only to trigger any side effects: the return
+            value is ignored.
+
+        :return: The string, with any subclass-specific prefix and
+           suffix added on.
+        """
+        if formatter is not None:
+            ignore = self.format_string(self, formatter)
         return self.PREFIX + self + self.SUFFIX
 
 class CData(PreformattedString):
-
+    """A CDATA block."""
     PREFIX = '<![CDATA['
     SUFFIX = ']]>'
 
 class ProcessingInstruction(PreformattedString):
+    """A SGML processing instruction."""
 
     PREFIX = '<?'
     SUFFIX = '>'
 
-class Comment(PreformattedString):
+class XMLProcessingInstruction(ProcessingInstruction):
+    """An XML processing instruction."""
+    PREFIX = '<?'
+    SUFFIX = '?>'
 
+class Comment(PreformattedString):
+    """An HTML or XML comment."""
     PREFIX = '<!--'
     SUFFIX = '-->'
 
 
 class Declaration(PreformattedString):
+    """An XML declaration."""
     PREFIX = '<?'
     SUFFIX = '?>'
 
 
 class Doctype(PreformattedString):
-
+    """A document type declaration."""
     @classmethod
     def for_name_and_ids(cls, name, pub_id, system_id):
+        """Generate an appropriate document type declaration for a given
+        public ID and system ID.
+
+        :param name: The name of the document's root element, e.g. 'html'.
+        :param pub_id: The Formal Public Identifier for this document type,
+            e.g. '-//W3C//DTD XHTML 1.1//EN'
+        :param system_id: The system identifier for this document type,
+            e.g. 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'
+
+        :return: A Doctype.
+        """
         value = name or ''
         if pub_id is not None:
             value += ' PUBLIC "%s"' % pub_id
@@ -775,14 +1140,105 @@ class Doctype(PreformattedString):
     SUFFIX = '>\n'
 
 
+class Stylesheet(NavigableString):
+    """A NavigableString representing an stylesheet (probably
+    CSS).
+
+    Used to distinguish embedded stylesheets from textual content.
+    """
+    pass
+
+
+class Script(NavigableString):
+    """A NavigableString representing an executable script (probably
+    Javascript).
+
+    Used to distinguish executable code from textual content.
+    """
+    pass
+
+
+class TemplateString(NavigableString):
+    """A NavigableString representing a string found inside an HTML
+    template embedded in a larger document.
+
+    Used to distinguish such strings from the main body of the document.
+    """
+    pass
+
+
+class RubyTextString(NavigableString):
+    """A NavigableString representing the contents of the <rt> HTML
+    element.
+
+    https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-rt-element
+
+    Can be used to distinguish such strings from the strings they're
+    annotating.
+    """
+    pass
+
+
+class RubyParenthesisString(NavigableString):
+    """A NavigableString representing the contents of the <rp> HTML
+    element.
+
+    https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-rp-element
+    """
+    pass
+
+
 class Tag(PageElement):
+    """Represents an HTML or XML tag that is part of a parse tree, along
+    with its attributes and contents.
 
-    """Represents a found HTML tag with its attributes and contents."""
+    When Beautiful Soup parses the markup <b>penguin</b>, it will
+    create a Tag object representing the <b> tag.
+    """
 
     def __init__(self, parser=None, builder=None, name=None, namespace=None,
-                 prefix=None, attrs=None, parent=None, previous=None):
-        "Basic constructor."
-
+                 prefix=None, attrs=None, parent=None, previous=None,
+                 is_xml=None, sourceline=None, sourcepos=None,
+                 can_be_empty_element=None, cdata_list_attributes=None,
+                 preserve_whitespace_tags=None,
+                 interesting_string_types=None,
+                 namespaces=None
+    ):
+        """Basic constructor.
+
+        :param parser: A BeautifulSoup object.
+        :param builder: A TreeBuilder.
+        :param name: The name of the tag.
+        :param namespace: The URI of this Tag's XML namespace, if any.
+        :param prefix: The prefix for this Tag's XML namespace, if any.
+        :param attrs: A dictionary of this Tag's attribute values.
+        :param parent: The PageElement to use as this Tag's parent.
+        :param previous: The PageElement that was parsed immediately before
+            this tag.
+        :param is_xml: If True, this is an XML tag. Otherwise, this is an
+            HTML tag.
+        :param sourceline: The line number where this tag was found in its
+            source document.
+        :param sourcepos: The character position within `sourceline` where this
+            tag was found.
+        :param can_be_empty_element: If True, this tag should be
+            represented as <tag/>. If False, this tag should be represented
+            as <tag></tag>.
+        :param cdata_list_attributes: A list of attributes whose values should
+            be treated as CDATA if they ever show up on this tag.
+        :param preserve_whitespace_tags: A list of tag names whose contents
+            should have their whitespace preserved.
+        :param interesting_string_types: This is a NavigableString
+            subclass or a tuple of them. When iterating over this
+            Tag's strings in methods like Tag.strings or Tag.get_text,
+            these are the types of strings that are interesting enough
+            to be considered. The default is to consider
+            NavigableString and CData the only interesting string
+            subtypes.
+        :param namespaces: A dictionary mapping currently active
+            namespace prefixes to URIs. This can be used later to
+            construct CSS selectors.
+        """
         if parser is None:
             self.parser_class = None
         else:
@@ -793,7 +1249,12 @@ class Tag(PageElement):
             raise ValueError("No value provided for new tag's name.")
         self.name = name
         self.namespace = namespace
+        self._namespaces = namespaces or {}
         self.prefix = prefix
+        if ((not builder or builder.store_line_numbers)
+            and (sourceline is not None or sourcepos is not None)):
+            self.sourceline = sourceline
+            self.sourcepos = sourcepos
         if attrs is None:
             attrs = {}
         elif attrs:
@@ -804,32 +1265,109 @@ class Tag(PageElement):
                 attrs = dict(attrs)
         else:
             attrs = dict(attrs)
+
+        # If possible, determine ahead of time whether this tag is an
+        # XML tag.
+        if builder:
+            self.known_xml = builder.is_xml
+        else:
+            self.known_xml = is_xml
         self.attrs = attrs
         self.contents = []
         self.setup(parent, previous)
         self.hidden = False
 
-        # Set up any substitutions, such as the charset in a META tag.
-        if builder is not None:
+        if builder is None:
+            # In the absence of a TreeBuilder, use whatever values were
+            # passed in here. They're probably None, unless this is a copy of some
+            # other tag.
+            self.can_be_empty_element = can_be_empty_element
+            self.cdata_list_attributes = cdata_list_attributes
+            self.preserve_whitespace_tags = preserve_whitespace_tags
+            self.interesting_string_types = interesting_string_types
+        else:
+            # Set up any substitutions for this tag, such as the charset in a META tag.
             builder.set_up_substitutions(self)
+
+            # Ask the TreeBuilder whether this tag might be an empty-element tag.
             self.can_be_empty_element = builder.can_be_empty_element(name)
-        else:
-            self.can_be_empty_element = False
+
+            # Keep track of the list of attributes of this tag that
+            # might need to be treated as a list.
+            #
+            # For performance reasons, we store the whole data structure
+            # rather than asking the question of every tag. Asking would
+            # require building a new data structure every time, and
+            # (unlike can_be_empty_element), we almost never need
+            # to check this.
+            self.cdata_list_attributes = builder.cdata_list_attributes
+
+            # Keep track of the names that might cause this tag to be treated as a
+            # whitespace-preserved tag.
+            self.preserve_whitespace_tags = builder.preserve_whitespace_tags
+
+            if self.name in builder.string_containers:
+                # This sort of tag uses a special string container
+                # subclass for most of its strings. When we ask the
+                self.interesting_string_types = builder.string_containers[self.name]
+            else:
+                self.interesting_string_types = self.DEFAULT_INTERESTING_STRING_TYPES
 
     parserClass = _alias("parser_class")  # BS3
 
-    def __copy__(self):
-        """A copy of a Tag is a new Tag, unconnected to the parse tree.
+    def __deepcopy__(self, memo, recursive=True):
+        """A deepcopy of a Tag is a new Tag, unconnected to the parse tree.
         Its contents are a copy of the old Tag's contents.
         """
-        clone = type(self)(None, self.builder, self.name, self.namespace,
-                           self.nsprefix, self.attrs)
+        clone = self._clone()
+
+        if recursive:
+            # Clone this tag's descendants recursively, but without
+            # making any recursive function calls.
+            tag_stack = [clone]
+            for event, element in self._event_stream(self.descendants):
+                if event is Tag.END_ELEMENT_EVENT:
+                    # Stop appending incoming Tags to the Tag that was
+                    # just closed.
+                    tag_stack.pop()
+                else:
+                    descendant_clone = element.__deepcopy__(
+                        memo, recursive=False
+                    )
+                    # Add to its parent's .contents
+                    tag_stack[-1].append(descendant_clone)
+
+                    if event is Tag.START_ELEMENT_EVENT:
+                        # Add the Tag itself to the stack so that its
+                        # children will be .appended to it.
+                        tag_stack.append(descendant_clone)
+        return clone
+
+    def __copy__(self):
+        """A copy of a Tag must always be a deep copy, because a Tag's
+        children can only have one parent at a time.
+        """
+        return self.__deepcopy__({})
+
+    def _clone(self):
+        """Create a new Tag just like this one, but with no
+        contents and unattached to any parse tree.
+
+        This is the first step in the deepcopy process.
+        """
+        clone = type(self)(
+            None, None, self.name, self.namespace,
+            self.prefix, self.attrs, is_xml=self._is_xml,
+            sourceline=self.sourceline, sourcepos=self.sourcepos,
+            can_be_empty_element=self.can_be_empty_element,
+            cdata_list_attributes=self.cdata_list_attributes,
+            preserve_whitespace_tags=self.preserve_whitespace_tags,
+            interesting_string_types=self.interesting_string_types
+        )
         for attr in ('can_be_empty_element', 'hidden'):
             setattr(clone, attr, getattr(self, attr))
-        for child in self.contents:
-            clone.append(child.__copy__())
         return clone
-
+    
     @property
     def is_empty_element(self):
         """Is this tag an empty-element tag? (aka a self-closing tag)
@@ -850,13 +1388,17 @@ class Tag(PageElement):
 
     @property
     def string(self):
-        """Convenience property to get the single string within this tag.
+        """Convenience property to get the single string within this
+        PageElement.
 
-        :Return: If this tag has a single string child, return value
-         is that string. If this tag has no children, or more than one
-         child, return value is None. If this tag has one child tag,
+        TODO It might make sense to have NavigableString.string return
+        itself.
+
+        :return: If this element has a single string child, return
+         value is that string. If this element has one child tag,
          return value is the 'string' attribute of the child tag,
-         recursively.
+         recursively. If this element is itself a string, has no
+         children, or has more than one child, return value is None.
         """
         if len(self.contents) != 1:
             return None
@@ -867,57 +1409,75 @@ class Tag(PageElement):
 
     @string.setter
     def string(self, string):
+        """Replace this PageElement's contents with `string`."""
         self.clear()
         self.append(string.__class__(string))
 
-    def _all_strings(self, strip=False, types=(NavigableString, CData)):
+    DEFAULT_INTERESTING_STRING_TYPES = (NavigableString, CData)
+    def _all_strings(self, strip=False, types=PageElement.default):
         """Yield all strings of certain classes, possibly stripping them.
 
-        By default, yields only NavigableString and CData objects. So
-        no comments, processing instructions, etc.
+        :param strip: If True, all strings will be stripped before being
+            yielded.
+
+        :param types: A tuple of NavigableString subclasses. Any strings of
+            a subclass not found in this list will be ignored. By
+            default, the subclasses considered are the ones found in
+            self.interesting_string_types. If that's not specified,
+            only NavigableString and CData objects will be
+            considered. That means no comments, processing
+            instructions, etc.
+
+        :yield: A sequence of strings.
+
         """
+        if types is self.default:
+            types = self.interesting_string_types
+
         for descendant in self.descendants:
-            if (
-                (types is None and not isinstance(descendant, NavigableString))
-                or
-                (types is not None and type(descendant) not in types)):
+            if (types is None and not isinstance(descendant, NavigableString)):
+                continue
+            descendant_type = type(descendant)
+            if isinstance(types, type):
+                if descendant_type is not types:
+                    # We're not interested in strings of this type.
+                    continue
+            elif types is not None and descendant_type not in types:
+                # We're not interested in strings of this type.
                 continue
             if strip:
                 descendant = descendant.strip()
                 if len(descendant) == 0:
                     continue
             yield descendant
-
     strings = property(_all_strings)
 
-    @property
-    def stripped_strings(self):
-        for string in self._all_strings(True):
-            yield string
+    def decompose(self):
+        """Recursively destroys this PageElement and its children.
 
-    def get_text(self, separator="", strip=False,
-                 types=(NavigableString, CData)):
-        """
-        Get all child strings, concatenated using the given separator.
-        """
-        return separator.join([s for s in self._all_strings(
-                    strip, types=types)])
-    getText = get_text
-    text = property(get_text)
+        This element will be removed from the tree and wiped out; so
+        will everything beneath it.
 
-    def decompose(self):
-        """Recursively destroys the contents of this tree."""
+        The behavior of a decomposed PageElement is undefined and you
+        should never use one for anything, but if you need to _check_
+        whether an element has been decomposed, you can use the
+        `decomposed` property.
+        """
         self.extract()
         i = self
         while i is not None:
-            next = i.next_element
+            n = i.next_element
             i.__dict__.clear()
             i.contents = []
-            i = next
+            i._decomposed = True
+            i = n
 
     def clear(self, decompose=False):
-        """
-        Extract all children. If decompose is True, decompose instead.
+        """Wipe out all children of this PageElement by calling extract()
+           on them.
+
+        :param decompose: If this is True, decompose() (a more
+            destructive method) will be called instead of extract().
         """
         if decompose:
             for element in self.contents[:]:
@@ -929,10 +1489,51 @@ class Tag(PageElement):
             for element in self.contents[:]:
                 element.extract()
 
-    def index(self, element):
+    def smooth(self):
+        """Smooth out this element's children by consolidating consecutive
+        strings.
+
+        This makes pretty-printed output look more natural following a
+        lot of operations that modified the tree.
         """
-        Find the index of a child by identity, not value. Avoids issues with
-        tag.contents.index(element) getting the index of equal elements.
+        # Mark the first position of every pair of children that need
+        # to be consolidated.  Do this rather than making a copy of
+        # self.contents, since in most cases very few strings will be
+        # affected.
+        marked = []
+        for i, a in enumerate(self.contents):
+            if isinstance(a, Tag):
+                # Recursively smooth children.
+                a.smooth()
+            if i == len(self.contents)-1:
+                # This is the last item in .contents, and it's not a
+                # tag. There's no chance it needs any work.
+                continue
+            b = self.contents[i+1]
+            if (isinstance(a, NavigableString)
+                and isinstance(b, NavigableString)
+                and not isinstance(a, PreformattedString)
+                and not isinstance(b, PreformattedString)
+            ):
+                marked.append(i)
+
+        # Go over the marked positions in reverse order, so that
+        # removing items from .contents won't affect the remaining
+        # positions.
+        for i in reversed(marked):
+            a = self.contents[i]
+            b = self.contents[i+1]
+            b.extract()
+            n = NavigableString(a+b)
+            a.replace_with(n)
+
+    def index(self, element):
+        """Find the index of a child by identity, not value.
+
+        Avoids issues with tag.contents.index(element) getting the
+        index of equal elements.
+
+        :param element: Look for this PageElement in `self.contents`.
         """
         for i, child in enumerate(self.contents):
             if child is element:
@@ -945,23 +1546,38 @@ class Tag(PageElement):
         attribute."""
         return self.attrs.get(key, default)
 
+    def get_attribute_list(self, key, default=None):
+        """The same as get(), but always returns a list.
+
+        :param key: The attribute to look for.
+        :param default: Use this value if the attribute is not present
+            on this PageElement.
+        :return: A list of values, probably containing only a single
+            value.
+        """
+        value = self.get(key, default)
+        if not isinstance(value, list):
+            value = [value]
+        return value
+
     def has_attr(self, key):
+        """Does this PageElement have an attribute with the given name?"""
         return key in self.attrs
 
     def __hash__(self):
         return str(self).__hash__()
 
     def __getitem__(self, key):
-        """tag[key] returns the value of the 'key' attribute for the tag,
+        """tag[key] returns the value of the 'key' attribute for the Tag,
         and throws an exception if it's not there."""
         return self.attrs[key]
 
     def __iter__(self):
-        "Iterating over a tag iterates over its contents."
+        "Iterating over a Tag iterates over its contents."
         return iter(self.contents)
 
     def __len__(self):
-        "The length of a tag is the length of its list of contents."
+        "The length of a Tag is the length of its list of contents."
         return len(self.contents)
 
     def __contains__(self, x):
@@ -981,29 +1597,33 @@ class Tag(PageElement):
         self.attrs.pop(key, None)
 
     def __call__(self, *args, **kwargs):
-        """Calling a tag like a function is the same as calling its
+        """Calling a Tag like a function is the same as calling its
         find_all() method. Eg. tag('a') returns a list of all the A tags
         found within this tag."""
         return self.find_all(*args, **kwargs)
 
     def __getattr__(self, tag):
-        #print "Getattr %s.%s" % (self.__class__, tag)
+        """Calling tag.subtag is the same as calling tag.find(name="subtag")"""
+        #print("Getattr %s.%s" % (self.__class__, tag))
         if len(tag) > 3 and tag.endswith('Tag'):
             # BS3: soup.aTag -> "soup.find("a")
             tag_name = tag[:-3]
             warnings.warn(
-                '.%sTag is deprecated, use .find("%s") instead.' % (
-                    tag_name, tag_name))
+                '.%(name)sTag is deprecated, use .find("%(name)s") instead. If you really were looking for a tag called %(name)sTag, use .find("%(name)sTag")' % dict(
+                    name=tag_name
+                ),
+                DeprecationWarning, stacklevel=2
+            )
             return self.find(tag_name)
         # We special case contents to avoid recursion.
-        elif not tag.startswith("__") and not tag=="contents":
+        elif not tag.startswith("__") and not tag == "contents":
             return self.find(tag)
         raise AttributeError(
             "'%s' object has no attribute '%s'" % (self.__class__, tag))
 
     def __eq__(self, other):
-        """Returns true iff this tag has the same name, the same attributes,
-        and the same contents (recursively) as the given tag."""
+        """Returns true iff this Tag has the same name, the same attributes,
+        and the same contents (recursively) as `other`."""
         if self is other:
             return True
         if (not hasattr(other, 'name') or
@@ -1019,69 +1639,235 @@ class Tag(PageElement):
         return True
 
     def __ne__(self, other):
-        """Returns true iff this tag is not identical to the other tag,
+        """Returns true iff this Tag is not identical to `other`,
         as defined in __eq__."""
         return not self == other
 
     def __repr__(self, encoding="unicode-escape"):
-        """Renders this tag as a string."""
-        if PY3K:
-            # "The return value must be a string object", i.e. Unicode
-            return self.decode()
-        else:
-            # "The return value must be a string object", i.e. a bytestring.
-            # By convention, the return value of __repr__ should also be
-            # an ASCII string.
-            return self.encode(encoding)
+        """Renders this PageElement as a string.
 
-    def __unicode__(self):
+        :param encoding: The encoding to use (Python 2 only).
+            TODO: This is now ignored and a warning should be issued
+            if a value is provided.
+        :return: A (Unicode) string.
+        """
+        # "The return value must be a string object", i.e. Unicode
         return self.decode()
 
-    def __str__(self):
-        if PY3K:
-            return self.decode()
-        else:
-            return self.encode()
+    def __unicode__(self):
+        """Renders this PageElement as a Unicode string."""
+        return self.decode()
 
-    if PY3K:
-        __str__ = __repr__ = __unicode__
+    __str__ = __repr__ = __unicode__
 
     def encode(self, encoding=DEFAULT_OUTPUT_ENCODING,
                indent_level=None, formatter="minimal",
                errors="xmlcharrefreplace"):
+        """Render a bytestring representation of this PageElement and its
+        contents.
+
+        :param encoding: The destination encoding.
+        :param indent_level: Each line of the rendering will be
+           indented this many levels. (The formatter decides what a
+           'level' means in terms of spaces or other characters
+           output.) Used internally in recursive calls while
+           pretty-printing.
+        :param formatter: A Formatter object, or a string naming one of
+            the standard formatters.
+        :param errors: An error handling strategy such as
+            'xmlcharrefreplace'. This value is passed along into
+            encode() and its value should be one of the constants
+            defined by Python.
+        :return: A bytestring.
+
+        """
         # Turn the data structure into Unicode, then encode the
         # Unicode.
         u = self.decode(indent_level, encoding, formatter)
         return u.encode(encoding, errors)
 
-    def _should_pretty_print(self, indent_level):
-        """Should this tag be pretty-printed?"""
-        return (
-            indent_level is not None and
-            (self.name not in HTMLAwareEntitySubstitution.preformatted_tags
-             or self._is_xml))
-
     def decode(self, indent_level=None,
                eventual_encoding=DEFAULT_OUTPUT_ENCODING,
-               formatter="minimal"):
-        """Returns a Unicode representation of this tag and its contents.
+               formatter="minimal",
+               iterator=None):
+        pieces = []
+        # First off, turn a non-Formatter `formatter` into a Formatter
+        # object. This will stop the lookup from happening over and
+        # over again.
+        if not isinstance(formatter, Formatter):
+            formatter = self.formatter_for_name(formatter)
+
+        if indent_level is True:
+            indent_level = 0
+
+        # The currently active tag that put us into string literal
+        # mode. Until this element is closed, children will be treated
+        # as string literals and not pretty-printed. String literal
+        # mode is turned on immediately after this tag begins, and
+        # turned off immediately before it's closed. This means there
+        # will be whitespace before and after the tag itself.
+        string_literal_tag = None
+
+        for event, element in self._event_stream(iterator):
+            if event in (Tag.START_ELEMENT_EVENT, Tag.EMPTY_ELEMENT_EVENT):
+                piece = element._format_tag(
+                    eventual_encoding, formatter, opening=True
+                )
+            elif event is Tag.END_ELEMENT_EVENT:
+                piece = element._format_tag(
+                    eventual_encoding, formatter, opening=False
+                )
+                if indent_level is not None:
+                    indent_level -= 1
+            else:
+                piece = element.output_ready(formatter)
+
+            # Now we need to apply the 'prettiness' -- extra
+            # whitespace before and/or after this tag. This can get
+            # complicated because certain tags, like <pre> and
+            # <script>, can't be prettified, since adding whitespace would
+            # change the meaning of the content.
+
+            # The default behavior is to add whitespace before and
+            # after an element when string literal mode is off, and to
+            # leave things as they are when string literal mode is on.
+            if string_literal_tag:
+                indent_before = indent_after = False
+            else:
+                indent_before = indent_after = True
+
+            # The only time the behavior is more complex than that is
+            # when we encounter an opening or closing tag that might
+            # put us into or out of string literal mode.
+            if (event is Tag.START_ELEMENT_EVENT
+                and not string_literal_tag
+                and not element._should_pretty_print()):
+                    # We are about to enter string literal mode. Add
+                    # whitespace before this tag, but not after. We
+                    # will stay in string literal mode until this tag
+                    # is closed.
+                    indent_before = True
+                    indent_after = False
+                    string_literal_tag = element
+            elif (event is Tag.END_ELEMENT_EVENT
+                  and element is string_literal_tag):
+                # We are about to exit string literal mode by closing
+                # the tag that sent us into that mode. Add whitespace
+                # after this tag, but not before.
+                indent_before = False
+                indent_after = True
+                string_literal_tag = None
+
+            # Now we know whether to add whitespace before and/or
+            # after this element.
+            if indent_level is not None:
+                if (indent_before or indent_after):
+                    if isinstance(element, NavigableString):
+                        piece = piece.strip()
+                    if piece:
+                        piece = self._indent_string(
+                            piece, indent_level, formatter,
+                            indent_before, indent_after
+                        )
+                if event == Tag.START_ELEMENT_EVENT:
+                    indent_level += 1
+            pieces.append(piece)
+        return "".join(pieces)
+
+    # Names for the different events yielded by _event_stream
+    START_ELEMENT_EVENT = object()
+    END_ELEMENT_EVENT = object()
+    EMPTY_ELEMENT_EVENT = object()
+    STRING_ELEMENT_EVENT = object()
+
+    def _event_stream(self, iterator=None):
+        """Yield a sequence of events that can be used to reconstruct the DOM
+        for this element.
+
+        This lets us recreate the nested structure of this element
+        (e.g. when formatting it as a string) without using recursive
+        method calls.
+
+        This is similar in concept to the SAX API, but it's a simpler
+        interface designed for internal use. The events are different
+        from SAX and the arguments associated with the events are Tags
+        and other Beautiful Soup objects.
+
+        :param iterator: An alternate iterator to use when traversing
+         the tree.
+        """
+        tag_stack = []
 
-        :param eventual_encoding: The tag is destined to be
-           encoded into this encoding. This method is _not_
-           responsible for performing that encoding. This information
-           is passed in so that it can be substituted in if the
-           document contains a <META> tag that mentions the document's
-           encoding.
+        iterator = iterator or self.self_and_descendants
+
+        for c in iterator:
+            # If the parent of the element we're about to yield is not
+            # the tag currently on the stack, it means that the tag on
+            # the stack closed before this element appeared.
+            while tag_stack and c.parent != tag_stack[-1]:
+                now_closed_tag = tag_stack.pop()
+                yield Tag.END_ELEMENT_EVENT, now_closed_tag
+
+            if isinstance(c, Tag):
+                if c.is_empty_element:
+                    yield Tag.EMPTY_ELEMENT_EVENT, c
+                else:
+                    yield Tag.START_ELEMENT_EVENT, c
+                    tag_stack.append(c)
+                    continue
+            else:
+                yield Tag.STRING_ELEMENT_EVENT, c
+
+        while tag_stack:
+            now_closed_tag = tag_stack.pop()
+            yield Tag.END_ELEMENT_EVENT, now_closed_tag
+
+    def _indent_string(self, s, indent_level, formatter,
+                       indent_before, indent_after):
+        """Add indentation whitespace before and/or after a string.
+
+        :param s: The string to amend with whitespace.
+        :param indent_level: The indentation level; affects how much
+           whitespace goes before the string.
+        :param indent_before: Whether or not to add whitespace
+           before the string.
+        :param indent_after: Whether or not to add whitespace
+           (a newline) after the string.
         """
+        space_before = ''
+        if indent_before and indent_level:
+            space_before = (formatter.indent * indent_level)
 
-        # First off, turn a string formatter into a function. This
-        # will stop the lookup from happening over and over again.
-        if not isinstance(formatter, collections.abc.Callable):
-            formatter = self._formatter_for_name(formatter)
+        space_after = ''
+        if indent_after:
+            space_after = "\n"
 
-        attrs = []
-        if self.attrs:
-            for key, val in sorted(self.attrs.items()):
+        return space_before + s + space_after
+
+    def _format_tag(self, eventual_encoding, formatter, opening):
+        if self.hidden:
+            # A hidden tag is invisible, although its contents
+            # are visible.
+            return ''
+
+        # A tag starts with the < character (see below).
+
+        # Then the / character, if this is a closing tag.
+        closing_slash = ''
+        if not opening:
+            closing_slash = '/'
+
+        # Then an optional namespace prefix.
+        prefix = ''
+        if self.prefix:
+            prefix = self.prefix + ":"
+
+        # Then a list of attribute values, if this is an opening tag.
+        attribute_string = ''
+        if opening:
+            attributes = formatter.attributes(self)
+            attrs = []
+            for key, val in attributes:
                 if val is None:
                     decoded = key
                 else:
@@ -1090,71 +1876,52 @@ class Tag(PageElement):
                     elif not isinstance(val, str):
                         val = str(val)
                     elif (
-                        isinstance(val, AttributeValueWithCharsetSubstitution)
-                        and eventual_encoding is not None):
+                            isinstance(val, AttributeValueWithCharsetSubstitution)
+                            and eventual_encoding is not None
+                    ):
                         val = val.encode(eventual_encoding)
 
-                    text = self.format_string(val, formatter)
+                    text = formatter.attribute_value(val)
                     decoded = (
                         str(key) + '='
-                        + EntitySubstitution.quoted_attribute_value(text))
+                        + formatter.quoted_attribute_value(text))
                 attrs.append(decoded)
-        close = ''
-        closeTag = ''
-
-        prefix = ''
-        if self.prefix:
-            prefix = self.prefix + ":"
+            if attrs:
+                attribute_string = ' ' + ' '.join(attrs)
 
+        # Then an optional closing slash (for a void element in an
+        # XML document).
+        void_element_closing_slash = ''
         if self.is_empty_element:
-            close = '/'
-        else:
-            closeTag = '</%s%s>' % (prefix, self.name)
-
-        pretty_print = self._should_pretty_print(indent_level)
-        space = ''
-        indent_space = ''
-        if indent_level is not None:
-            indent_space = (' ' * (indent_level - 1))
-        if pretty_print:
-            space = indent_space
-            indent_contents = indent_level + 1
-        else:
-            indent_contents = None
-        contents = self.decode_contents(
-            indent_contents, eventual_encoding, formatter)
+            void_element_closing_slash = formatter.void_element_close_prefix or ''
 
-        if self.hidden:
-            # This is the 'document root' object.
-            s = contents
-        else:
-            s = []
-            attribute_string = ''
-            if attrs:
-                attribute_string = ' ' + ' '.join(attrs)
-            if indent_level is not None:
-                # Even if this particular tag is not pretty-printed,
-                # we should indent up to the start of the tag.
-                s.append(indent_space)
-            s.append('<%s%s%s%s>' % (
-                    prefix, self.name, attribute_string, close))
-            if pretty_print:
-                s.append("\n")
-            s.append(contents)
-            if pretty_print and contents and contents[-1] != "\n":
-                s.append("\n")
-            if pretty_print and closeTag:
-                s.append(space)
-            s.append(closeTag)
-            if indent_level is not None and closeTag and self.next_sibling:
-                # Even if this particular tag is not pretty-printed,
-                # we're now done with the tag, and we should add a
-                # newline if appropriate.
-                s.append("\n")
-            s = ''.join(s)
-        return s
+        # Put it all together.
+        return '<' + closing_slash + prefix + self.name + attribute_string + void_element_closing_slash + '>'
+
+    def _should_pretty_print(self, indent_level=1):
+        """Should this tag be pretty-printed?
+
+        Most of them should, but some (such as <pre> in HTML
+        documents) should not.
+        """
+        return (
+            indent_level is not None
+            and (
+                not self.preserve_whitespace_tags
+                or self.name not in self.preserve_whitespace_tags
+            )
+        )
 
     def prettify(self, encoding=None, formatter="minimal"):
+        """Pretty-print this PageElement as a string.
+
+        :param encoding: The eventual encoding of the string. If this is None,
+            a Unicode string will be returned.
+        :param formatter: A Formatter object, or a string naming one of
+            the standard formatters.
+        :return: A Unicode string (if encoding==None) or a bytestring
+            (otherwise).
+        """
         if encoding is None:
             return self.decode(True, formatter=formatter)
         else:
@@ -1166,62 +1933,50 @@ class Tag(PageElement):
         """Renders the contents of this tag as a Unicode string.
 
         :param indent_level: Each line of the rendering will be
-           indented this many spaces.
+           indented this many levels. (The formatter decides what a
+           'level' means in terms of spaces or other characters
+           output.) Used internally in recursive calls while
+           pretty-printing.
 
         :param eventual_encoding: The tag is destined to be
-           encoded into this encoding. This method is _not_
+           encoded into this encoding. decode_contents() is _not_
            responsible for performing that encoding. This information
            is passed in so that it can be substituted in if the
            document contains a <META> tag that mentions the document's
            encoding.
 
-        :param formatter: The output formatter responsible for converting
-           entities to Unicode characters.
-        """
-        # First off, turn a string formatter into a function. This
-        # will stop the lookup from happening over and over again.
-        if not isinstance(formatter, collections.abc.Callable):
-            formatter = self._formatter_for_name(formatter)
-
-        pretty_print = (indent_level is not None)
-        s = []
-        for c in self:
-            text = None
-            if isinstance(c, NavigableString):
-                text = c.output_ready(formatter)
-            elif isinstance(c, Tag):
-                s.append(c.decode(indent_level, eventual_encoding,
-                                  formatter))
-            if text and indent_level and not self.name == 'pre':
-                text = text.strip()
-            if text:
-                if pretty_print and not self.name == 'pre':
-                    s.append(" " * (indent_level - 1))
-                s.append(text)
-                if pretty_print and not self.name == 'pre':
-                    s.append("\n")
-        return ''.join(s)
+        :param formatter: A Formatter object, or a string naming one of
+            the standard Formatters.
+
+        """
+        return self.decode(indent_level, eventual_encoding, formatter,
+                           iterator=self.descendants)
 
     def encode_contents(
         self, indent_level=None, encoding=DEFAULT_OUTPUT_ENCODING,
         formatter="minimal"):
-        """Renders the contents of this tag as a bytestring.
+        """Renders the contents of this PageElement as a bytestring.
 
         :param indent_level: Each line of the rendering will be
-           indented this many spaces.
+           indented this many levels. (The formatter decides what a
+           'level' means in terms of spaces or other characters
+           output.) Used internally in recursive calls while
+           pretty-printing.
 
         :param eventual_encoding: The bytestring will be in this encoding.
 
-        :param formatter: The output formatter responsible for converting
-           entities to Unicode characters.
-        """
+        :param formatter: A Formatter object, or a string naming one of
+            the standard Formatters.
 
+        :return: A bytestring.
+        """
         contents = self.decode_contents(indent_level, encoding, formatter)
         return contents.encode(encoding)
 
     # Old method for BS3 compatibility
     def renderContents(self, encoding=DEFAULT_OUTPUT_ENCODING,
                        prettyPrint=False, indentLevel=0):
+        """Deprecated method for BS3 compatibility."""
         if not prettyPrint:
             indentLevel = None
         return self.encode_contents(
@@ -1229,44 +1984,88 @@ class Tag(PageElement):
 
     #Soup methods
 
-    def find(self, name=None, attrs={}, recursive=True, text=None,
+    def find(self, name=None, attrs={}, recursive=True, string=None,
              **kwargs):
-        """Return only the first child of this Tag matching the given
-        criteria."""
+        """Look in the children of this PageElement and find the first
+        PageElement that matches the given criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param recursive: If this is True, find() will perform a
+            recursive search of this PageElement's children. Otherwise,
+            only the direct children will be considered.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A PageElement.
+        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        """
         r = None
-        l = self.find_all(name, attrs, recursive, text, 1, **kwargs)
+        l = self.find_all(name, attrs, recursive, string, 1, _stacklevel=3,
+                          **kwargs)
         if l:
             r = l[0]
         return r
-    findChild = find
+    findChild = find #BS2
 
-    def find_all(self, name=None, attrs={}, recursive=True, text=None,
+    def find_all(self, name=None, attrs={}, recursive=True, string=None,
                  limit=None, **kwargs):
-        """Extracts a list of Tag objects that match the given
-        criteria.  You can specify the name of the Tag and any
-        attributes you want the Tag to have.
-
-        The value of a key-value pair in the 'attrs' map can be a
-        string, a list of strings, a regular expression object, or a
-        callable that takes a string and returns whether or not the
-        string matches for some custom definition of 'matches'. The
-        same is true of the tag name."""
-
+        """Look in the children of this PageElement and find all
+        PageElements that match the given criteria.
+
+        All find_* methods take a common set of arguments. See the online
+        documentation for detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param recursive: If this is True, find_all() will perform a
+            recursive search of this PageElement's children. Otherwise,
+            only the direct children will be considered.
+        :param limit: Stop looking after finding this many results.
+        :kwargs: A dictionary of filters on attribute values.
+        :return: A ResultSet of PageElements.
+        :rtype: bs4.element.ResultSet
+        """
         generator = self.descendants
         if not recursive:
             generator = self.children
-        return self._find_all(name, attrs, text, limit, generator, **kwargs)
+        _stacklevel = kwargs.pop('_stacklevel', 2)
+        return self._find_all(name, attrs, string, limit, generator,
+                              _stacklevel=_stacklevel+1, **kwargs)
     findAll = find_all       # BS3
     findChildren = find_all  # BS2
 
     #Generator methods
     @property
     def children(self):
+        """Iterate over all direct children of this PageElement.
+
+        :yield: A sequence of PageElements.
+        """
         # return iter() to make the purpose of the method clear
         return iter(self.contents)  # XXX This seems to be untested.
 
+    @property
+    def self_and_descendants(self):
+        """Iterate over this PageElement and its children in a
+        breadth-first sequence.
+
+        :yield: A sequence of PageElements.
+        """
+        if not self.hidden:
+            yield self
+        for i in self.descendants:
+            yield i
+
     @property
     def descendants(self):
+        """Iterate over all children of this PageElement in a
+        breadth-first sequence.
+
+        :yield: A sequence of PageElements.
+        """
         if not len(self.contents):
             return
         stopNode = self._last_descendant().next_element
@@ -1276,262 +2075,102 @@ class Tag(PageElement):
             current = current.next_element
 
     # CSS selector code
+    def select_one(self, selector, namespaces=None, **kwargs):
+        """Perform a CSS selection operation on the current element.
 
-    _selector_combinators = ['>', '+', '~']
-    _select_debug = False
-    def select_one(self, selector):
-        """Perform a CSS selection operation on the current element."""
-        value = self.select(selector, limit=1)
-        if value:
-            return value[0]
-        return None
+        :param selector: A CSS selector.
 
-    def select(self, selector, _candidate_generator=None, limit=None):
-        """Perform a CSS selection operation on the current element."""
-
-        # Handle grouping selectors if ',' exists, ie: p,a
-        if ',' in selector:
-            context = []
-            for partial_selector in selector.split(','):
-                partial_selector = partial_selector.strip()
-                if partial_selector == '':
-                    raise ValueError('Invalid group selection syntax: %s' % selector)
-                candidates = self.select(partial_selector, limit=limit)
-                for candidate in candidates:
-                    if candidate not in context:
-                        context.append(candidate)
-
-                if limit and len(context) >= limit:
-                    break
-            return context
+        :param namespaces: A dictionary mapping namespace prefixes
+           used in the CSS selector to namespace URIs. By default,
+           Beautiful Soup will use the prefixes it encountered while
+           parsing the document.
 
-        tokens = selector.split()
-        current_context = [self]
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           soupsieve.select() method.
 
-        if tokens[-1] in self._selector_combinators:
-            raise ValueError(
-                'Final combinator "%s" is missing an argument.' % tokens[-1])
+        :return: A Tag.
+        :rtype: bs4.element.Tag
+        """
+        return self.css.select_one(selector, namespaces, **kwargs)
 
-        if self._select_debug:
-            print('Running CSS selector "%s"' % selector)
+    def select(self, selector, namespaces=None, limit=None, **kwargs):
+        """Perform a CSS selection operation on the current element.
 
-        for index, token in enumerate(tokens):
-            new_context = []
-            new_context_ids = set([])
+        This uses the SoupSieve library.
 
-            if tokens[index-1] in self._selector_combinators:
-                # This token was consumed by the previous combinator. Skip it.
-                if self._select_debug:
-                    print('  Token was consumed by the previous combinator.')
-                continue
+        :param selector: A string containing a CSS selector.
 
-            if self._select_debug:
-                print(' Considering token "%s"' % token)
-            recursive_candidate_generator = None
-            tag_name = None
-
-            # Each operation corresponds to a checker function, a rule
-            # for determining whether a candidate matches the
-            # selector. Candidates are generated by the active
-            # iterator.
-            checker = None
-
-            m = self.attribselect_re.match(token)
-            if m is not None:
-                # Attribute selector
-                tag_name, attribute, operator, value = m.groups()
-                checker = self._attribute_checker(operator, attribute, value)
-
-            elif '#' in token:
-                # ID selector
-                tag_name, tag_id = token.split('#', 1)
-                def id_matches(tag):
-                    return tag.get('id', None) == tag_id
-                checker = id_matches
-
-            elif '.' in token:
-                # Class selector
-                tag_name, klass = token.split('.', 1)
-                classes = set(klass.split('.'))
-                def classes_match(candidate):
-                    return classes.issubset(candidate.get('class', []))
-                checker = classes_match
-
-            elif ':' in token:
-                # Pseudo-class
-                tag_name, pseudo = token.split(':', 1)
-                if tag_name == '':
-                    raise ValueError(
-                        "A pseudo-class must be prefixed with a tag name.")
-                pseudo_attributes = re.match(r'([a-zA-Z\d-]+)\(([a-zA-Z\d]+)\)', pseudo)
-                found = []
-                if pseudo_attributes is None:
-                    pseudo_type = pseudo
-                    pseudo_value = None
-                else:
-                    pseudo_type, pseudo_value = pseudo_attributes.groups()
-                if pseudo_type == 'nth-of-type':
-                    try:
-                        pseudo_value = int(pseudo_value)
-                    except:
-                        raise NotImplementedError(
-                            'Only numeric values are currently supported for the nth-of-type pseudo-class.')
-                    if pseudo_value < 1:
-                        raise ValueError(
-                            'nth-of-type pseudo-class value must be at least 1.')
-                    class Counter(object):
-                        def __init__(self, destination):
-                            self.count = 0
-                            self.destination = destination
-
-                        def nth_child_of_type(self, tag):
-                            self.count += 1
-                            if self.count == self.destination:
-                                return True
-                            if self.count > self.destination:
-                                # Stop the generator that's sending us
-                                # these things.
-                                raise StopIteration()
-                            return False
-                    checker = Counter(pseudo_value).nth_child_of_type
-                else:
-                    raise NotImplementedError(
-                        'Only the following pseudo-classes are implemented: nth-of-type.')
-
-            elif token == '*':
-                # Star selector -- matches everything
-                pass
-            elif token == '>':
-                # Run the next token as a CSS selector against the
-                # direct children of each tag in the current context.
-                recursive_candidate_generator = lambda tag: tag.children
-            elif token == '~':
-                # Run the next token as a CSS selector against the
-                # siblings of each tag in the current context.
-                recursive_candidate_generator = lambda tag: tag.next_siblings
-            elif token == '+':
-                # For each tag in the current context, run the next
-                # token as a CSS selector against the tag's next
-                # sibling that's a tag.
-                def next_tag_sibling(tag):
-                    yield tag.find_next_sibling(True)
-                recursive_candidate_generator = next_tag_sibling
-
-            elif self.tag_name_re.match(token):
-                # Just a tag name.
-                tag_name = token
-            else:
-                raise ValueError(
-                    'Unsupported or invalid CSS selector: "%s"' % token)
-            if recursive_candidate_generator:
-                # This happens when the selector looks like  "> foo".
-                #
-                # The generator calls select() recursively on every
-                # member of the current context, passing in a different
-                # candidate generator and a different selector.
-                #
-                # In the case of "> foo", the candidate generator is
-                # one that yields a tag's direct children (">"), and
-                # the selector is "foo".
-                next_token = tokens[index+1]
-                def recursive_select(tag):
-                    if self._select_debug:
-                        print('    Calling select("%s") recursively on %s %s' % (next_token, tag.name, tag.attrs))
-                        print('-' * 40)
-                    for i in tag.select(next_token, recursive_candidate_generator):
-                        if self._select_debug:
-                            print('(Recursive select picked up candidate %s %s)' % (i.name, i.attrs))
-                        yield i
-                    if self._select_debug:
-                        print('-' * 40)
-                _use_candidate_generator = recursive_select
-            elif _candidate_generator is None:
-                # By default, a tag's candidates are all of its
-                # children. If tag_name is defined, only yield tags
-                # with that name.
-                if self._select_debug:
-                    if tag_name:
-                        check = "[any]"
-                    else:
-                        check = tag_name
-                    print('   Default candidate generator, tag name="%s"' % check)
-                if self._select_debug:
-                    # This is redundant with later code, but it stops
-                    # a bunch of bogus tags from cluttering up the
-                    # debug log.
-                    def default_candidate_generator(tag):
-                        for child in tag.descendants:
-                            if not isinstance(child, Tag):
-                                continue
-                            if tag_name and not child.name == tag_name:
-                                continue
-                            yield child
-                    _use_candidate_generator = default_candidate_generator
-                else:
-                    _use_candidate_generator = lambda tag: tag.descendants
-            else:
-                _use_candidate_generator = _candidate_generator
-
-            count = 0
-            for tag in current_context:
-                if self._select_debug:
-                    print("    Running candidate generator on %s %s" % (
-                        tag.name, repr(tag.attrs)))
-                for candidate in _use_candidate_generator(tag):
-                    if not isinstance(candidate, Tag):
-                        continue
-                    if tag_name and candidate.name != tag_name:
-                        continue
-                    if checker is not None:
-                        try:
-                            result = checker(candidate)
-                        except StopIteration:
-                            # The checker has decided we should no longer
-                            # run the generator.
-                            break
-                    if checker is None or result:
-                        if self._select_debug:
-                            print("     SUCCESS %s %s" % (candidate.name, repr(candidate.attrs)))
-                        if id(candidate) not in new_context_ids:
-                            # If a tag matches a selector more than once,
-                            # don't include it in the context more than once.
-                            new_context.append(candidate)
-                            new_context_ids.add(id(candidate))
-                            if limit and len(new_context) >= limit:
-                                break
-                    elif self._select_debug:
-                        print("     FAILURE %s %s" % (candidate.name, repr(candidate.attrs)))
-
-
-            current_context = new_context
-
-        if self._select_debug:
-            print("Final verdict:")
-            for i in current_context:
-                print(" %s %s" % (i.name, i.attrs))
-        return current_context
+        :param namespaces: A dictionary mapping namespace prefixes
+           used in the CSS selector to namespace URIs. By default,
+           Beautiful Soup will use the prefixes it encountered while
+           parsing the document.
+
+        :param limit: After finding this number of results, stop looking.
+
+        :param kwargs: Keyword arguments to be passed into SoupSieve's
+           soupsieve.select() method.
+
+        :return: A ResultSet of Tags.
+        :rtype: bs4.element.ResultSet
+        """
+        return self.css.select(selector, namespaces, limit, **kwargs)
+
+    @property
+    def css(self):
+        """Return an interface to the CSS selector API."""
+        return CSS(self)
 
     # Old names for backwards compatibility
     def childGenerator(self):
+        """Deprecated generator."""
         return self.children
 
     def recursiveChildGenerator(self):
+        """Deprecated generator."""
         return self.descendants
 
     def has_key(self, key):
-        """This was kind of misleading because has_key() (attributes)
-        was different from __in__ (contents). has_key() is gone in
-        Python 3, anyway."""
-        warnings.warn('has_key is deprecated. Use has_attr("%s") instead.' % (
-                key))
+        """Deprecated method. This was kind of misleading because has_key()
+        (attributes) was different from __in__ (contents).
+
+        has_key() is gone in Python 3, anyway.
+        """
+        warnings.warn(
+            'has_key is deprecated. Use has_attr(key) instead.',
+            DeprecationWarning, stacklevel=2
+        )
         return self.has_attr(key)
 
 # Next, a couple classes to represent queries and their results.
 class SoupStrainer(object):
     """Encapsulates a number of ways of matching a markup element (tag or
-    text)."""
+    string).
+
+    This is primarily used to underpin the find_* methods, but you can
+    create one yourself and pass it in as `parse_only` to the
+    `BeautifulSoup` constructor, to parse a subset of a large
+    document.
+    """
+
+    def __init__(self, name=None, attrs={}, string=None, **kwargs):
+        """Constructor.
+
+        The SoupStrainer constructor takes the same arguments passed
+        into the find_* methods. See the online documentation for
+        detailed explanations.
+
+        :param name: A filter on tag name.
+        :param attrs: A dictionary of filters on attribute values.
+        :param string: A filter for a NavigableString with specific text.
+        :kwargs: A dictionary of filters on attribute values.
+        """
+        if string is None and 'text' in kwargs:
+            string = kwargs.pop('text')
+            warnings.warn(
+                "The 'text' argument to the SoupStrainer constructor is deprecated. Use 'string' instead.",
+                DeprecationWarning, stacklevel=2
+            )
 
-    def __init__(self, name=None, attrs={}, text=None, **kwargs):
         self.name = self._normalize_search_value(name)
         if not isinstance(attrs, dict):
             # Treat a non-dict value for attrs as a search for the 'class'
@@ -1556,12 +2195,15 @@ class SoupStrainer(object):
             normalized_attrs[key] = self._normalize_search_value(value)
 
         self.attrs = normalized_attrs
-        self.text = self._normalize_search_value(text)
+        self.string = self._normalize_search_value(string)
+
+        # DEPRECATED but just in case someone is checking this.
+        self.text = self.string
 
     def _normalize_search_value(self, value):
         # Leave it alone if it's a Unicode string, a callable, a
         # regular expression, a boolean, or None.
-        if (isinstance(value, str) or isinstance(value, collections.abc.Callable) or hasattr(value, 'match')
+        if (isinstance(value, str) or isinstance(value, Callable) or hasattr(value, 'match')
             or isinstance(value, bool) or value is None):
             return value
 
@@ -1589,19 +2231,40 @@ class SoupStrainer(object):
         return str(str(value))
 
     def __str__(self):
-        if self.text:
-            return self.text
+        """A human-readable representation of this SoupStrainer."""
+        if self.string:
+            return self.string
         else:
             return "%s|%s" % (self.name, self.attrs)
 
     def search_tag(self, markup_name=None, markup_attrs={}):
+        """Check whether a Tag with the given name and attributes would
+        match this SoupStrainer.
+
+        Used prospectively to decide whether to even bother creating a Tag
+        object.
+
+        :param markup_name: A tag name as found in some markup.
+        :param markup_attrs: A dictionary of attributes as found in some markup.
+
+        :return: True if the prospective tag would match this SoupStrainer;
+            False otherwise.
+        """
         found = None
         markup = None
         if isinstance(markup_name, Tag):
             markup = markup_name
             markup_attrs = markup
+
+        if isinstance(self.name, str):
+            # Optimization for a very common case where the user is
+            # searching for a tag with one specific name, and we're
+            # looking at a tag with a different name.
+            if markup and not markup.prefix and self.name != markup.name:
+                 return False
+
         call_function_with_tag_data = (
-            isinstance(self.name, collections.abc.Callable)
+            isinstance(self.name, Callable)
             and not isinstance(markup_name, Tag))
 
         if ((not self.name)
@@ -1630,13 +2293,22 @@ class SoupStrainer(object):
                     found = markup
                 else:
                     found = markup_name
-        if found and self.text and not self._matches(found.string, self.text):
+        if found and self.string and not self._matches(found.string, self.string):
             found = None
         return found
+
+    # For BS3 compatibility.
     searchTag = search_tag
 
     def search(self, markup):
-        # print 'looking for %s in %s' % (self, markup)
+        """Find all items in `markup` that match this SoupStrainer.
+
+        Used by the core _find_all() method, which is ultimately
+        called by all find_* methods.
+
+        :param markup: A PageElement or a list of them.
+        """
+        # print('looking for %s in %s' % (self, markup))
         found = None
         # If given a list of items, scan it for a text element that
         # matches.
@@ -1649,49 +2321,44 @@ class SoupStrainer(object):
         # If it's a Tag, make sure its name or attributes match.
         # Don't bother with Tags if we're searching for text.
         elif isinstance(markup, Tag):
-            if not self.text or self.name or self.attrs:
+            if not self.string or self.name or self.attrs:
                 found = self.search_tag(markup)
         # If it's text, make sure the text matches.
         elif isinstance(markup, NavigableString) or \
                  isinstance(markup, str):
-            if not self.name and not self.attrs and self._matches(markup, self.text):
+            if not self.name and not self.attrs and self._matches(markup, self.string):
                 found = markup
         else:
             raise Exception(
                 "I don't know how to match against a %s" % markup.__class__)
         return found
 
-    def _matches(self, markup, match_against):
-        # print u"Matching %s against %s" % (markup, match_against)
+    def _matches(self, markup, match_against, already_tried=None):
+        # print(u"Matching %s against %s" % (markup, match_against))
         result = False
         if isinstance(markup, list) or isinstance(markup, tuple):
             # This should only happen when searching a multi-valued attribute
             # like 'class'.
-            if (isinstance(match_against, str)
-                and ' ' in match_against):
-                # A bit of a special case. If they try to match "foo
-                # bar" on a multivalue attribute's value, only accept
-                # the literal value "foo bar"
-                #
-                # XXX This is going to be pretty slow because we keep
-                # splitting match_against. But it shouldn't come up
-                # too often.
-                return (whitespace_re.split(match_against) == markup)
-            else:
-                for item in markup:
-                    if self._matches(item, match_against):
-                        return True
-                return False
+            for item in markup:
+                if self._matches(item, match_against):
+                    return True
+            # We didn't match any particular value of the multivalue
+            # attribute, but maybe we match the attribute value when
+            # considered as a string.
+            if self._matches(' '.join(markup), match_against):
+                return True
+            return False
 
         if match_against is True:
             # True matches any non-None value.
             return markup is not None
 
-        if isinstance(match_against, collections.abc.Callable):
+        if isinstance(match_against, Callable):
             return match_against(markup)
 
         # Custom callables take the tag as an argument, but all
         # other ways of matching match the tag name as a string.
+        original_markup = markup
         if isinstance(markup, Tag):
             markup = markup.name
 
@@ -1702,23 +2369,67 @@ class SoupStrainer(object):
             # None matches None, False, an empty string, an empty list, and so on.
             return not match_against
 
-        if isinstance(match_against, str):
+        if (hasattr(match_against, '__iter__')
+            and not isinstance(match_against, str)):
+            # We're asked to match against an iterable of items.
+            # The markup must be match at least one item in the
+            # iterable. We'll try each one in turn.
+            #
+            # To avoid infinite recursion we need to keep track of
+            # items we've already seen.
+            if not already_tried:
+                already_tried = set()
+            for item in match_against:
+                if item.__hash__:
+                    key = item
+                else:
+                    key = id(item)
+                if key in already_tried:
+                    continue
+                else:
+                    already_tried.add(key)
+                    if self._matches(original_markup, item, already_tried):
+                        return True
+            else:
+                return False
+
+        # Beyond this point we might need to run the test twice: once against
+        # the tag's name and once against its prefixed name.
+        match = False
+
+        if not match and isinstance(match_against, str):
             # Exact string match
-            return markup == match_against
+            match = markup == match_against
 
-        if hasattr(match_against, 'match'):
+        if not match and hasattr(match_against, 'search'):
             # Regexp match
             return match_against.search(markup)
 
-        if hasattr(match_against, '__iter__'):
-            # The markup must be an exact match against something
-            # in the iterable.
-            return markup in match_against
+        if (not match
+            and isinstance(original_markup, Tag)
+            and original_markup.prefix):
+            # Try the whole thing again with the prefixed tag name.
+            return self._matches(
+                original_markup.prefix + ':' + original_markup.name, match_against
+            )
+
+        return match
 
 
 class ResultSet(list):
     """A ResultSet is just a list that keeps track of the SoupStrainer
     that created it."""
     def __init__(self, source, result=()):
+        """Constructor.
+
+        :param source: A SoupStrainer.
+        :param result: A list of PageElements.
+        """
         super(ResultSet, self).__init__(result)
         self.source = source
+
+    def __getattr__(self, key):
+        """Raise a helpful exception to explain a common code fix."""
+        raise AttributeError(
+            "ResultSet object has no attribute '%s'. You're probably treating a list of elements like a single element. Did you call find_all() when you meant to call find()?" % key
+        )
diff --git a/lib/bs4/formatter.py b/lib/bs4/formatter.py
new file mode 100644
index 0000000000..9fa1b57cb6
--- /dev/null
+++ b/lib/bs4/formatter.py
@@ -0,0 +1,185 @@
+from bs4.dammit import EntitySubstitution
+
+class Formatter(EntitySubstitution):
+    """Describes a strategy to use when outputting a parse tree to a string.
+
+    Some parts of this strategy come from the distinction between
+    HTML4, HTML5, and XML. Others are configurable by the user.
+
+    Formatters are passed in as the `formatter` argument to methods
+    like `PageElement.encode`. Most people won't need to think about
+    formatters, and most people who need to think about them can pass
+    in one of these predefined strings as `formatter` rather than
+    making a new Formatter object:
+
+    For HTML documents:
+     * 'html' - HTML entity substitution for generic HTML documents. (default)
+     * 'html5' - HTML entity substitution for HTML5 documents, as
+                 well as some optimizations in the way tags are rendered.
+     * 'minimal' - Only make the substitutions necessary to guarantee
+                   valid HTML.
+     * None - Do not perform any substitution. This will be faster
+              but may result in invalid markup.
+
+    For XML documents:
+     * 'html' - Entity substitution for XHTML documents.
+     * 'minimal' - Only make the substitutions necessary to guarantee
+                   valid XML. (default)
+     * None - Do not perform any substitution. This will be faster
+              but may result in invalid markup.
+    """
+    # Registries of XML and HTML formatters.
+    XML_FORMATTERS = {}
+    HTML_FORMATTERS = {}
+
+    HTML = 'html'
+    XML = 'xml'
+
+    HTML_DEFAULTS = dict(
+        cdata_containing_tags=set(["script", "style"]),
+    )
+
+    def _default(self, language, value, kwarg):
+        if value is not None:
+            return value
+        if language == self.XML:
+            return set()
+        return self.HTML_DEFAULTS[kwarg]
+
+    def __init__(
+            self, language=None, entity_substitution=None,
+            void_element_close_prefix='/', cdata_containing_tags=None,
+            empty_attributes_are_booleans=False, indent=1,
+    ):
+        r"""Constructor.
+
+        :param language: This should be Formatter.XML if you are formatting
+           XML markup and Formatter.HTML if you are formatting HTML markup.
+
+        :param entity_substitution: A function to call to replace special
+           characters with XML/HTML entities. For examples, see 
+           bs4.dammit.EntitySubstitution.substitute_html and substitute_xml.
+        :param void_element_close_prefix: By default, void elements
+           are represented as <tag/> (XML rules) rather than <tag>
+           (HTML rules). To get <tag>, pass in the empty string.
+        :param cdata_containing_tags: The list of tags that are defined
+           as containing CDATA in this dialect. For example, in HTML,
+           <script> and <style> tags are defined as containing CDATA,
+           and their contents should not be formatted.
+        :param blank_attributes_are_booleans: Render attributes whose value
+            is the empty string as HTML-style boolean attributes.
+            (Attributes whose value is None are always rendered this way.)
+
+        :param indent: If indent is a non-negative integer or string,
+            then the contents of elements will be indented
+            appropriately when pretty-printing. An indent level of 0,
+            negative, or "" will only insert newlines. Using a
+            positive integer indent indents that many spaces per
+            level. If indent is a string (such as "\t"), that string
+            is used to indent each level. The default behavior is to
+            indent one space per level.
+        """
+        self.language = language
+        self.entity_substitution = entity_substitution
+        self.void_element_close_prefix = void_element_close_prefix
+        self.cdata_containing_tags = self._default(
+            language, cdata_containing_tags, 'cdata_containing_tags'
+        )
+        self.empty_attributes_are_booleans=empty_attributes_are_booleans
+        if indent is None:
+            indent = 0
+        if isinstance(indent, int):
+            if indent < 0:
+                indent = 0
+            indent = ' ' * indent
+        elif isinstance(indent, str):
+            indent = indent
+        else:
+            indent = ' '
+        self.indent = indent
+
+    def substitute(self, ns):
+        """Process a string that needs to undergo entity substitution.
+        This may be a string encountered in an attribute value or as
+        text.
+
+        :param ns: A string.
+        :return: A string with certain characters replaced by named
+           or numeric entities.
+        """
+        if not self.entity_substitution:
+            return ns
+        from .element import NavigableString
+        if (isinstance(ns, NavigableString)
+            and ns.parent is not None
+            and ns.parent.name in self.cdata_containing_tags):
+            # Do nothing.
+            return ns
+        # Substitute.
+        return self.entity_substitution(ns)
+
+    def attribute_value(self, value):
+        """Process the value of an attribute.
+
+        :param ns: A string.
+        :return: A string with certain characters replaced by named
+           or numeric entities.
+        """
+        return self.substitute(value)
+    
+    def attributes(self, tag):
+        """Reorder a tag's attributes however you want.
+        
+        By default, attributes are sorted alphabetically. This makes
+        behavior consistent between Python 2 and Python 3, and preserves
+        backwards compatibility with older versions of Beautiful Soup.
+
+        If `empty_boolean_attributes` is True, then attributes whose
+        values are set to the empty string will be treated as boolean
+        attributes.
+        """
+        if tag.attrs is None:
+            return []
+        return sorted(
+            (k, (None if self.empty_attributes_are_booleans and v == '' else v))
+            for k, v in list(tag.attrs.items())
+        )
+   
+class HTMLFormatter(Formatter):
+    """A generic Formatter for HTML."""
+    REGISTRY = {}
+    def __init__(self, *args, **kwargs):
+        super(HTMLFormatter, self).__init__(self.HTML, *args, **kwargs)
+
+    
+class XMLFormatter(Formatter):
+    """A generic Formatter for XML."""
+    REGISTRY = {}
+    def __init__(self, *args, **kwargs):
+        super(XMLFormatter, self).__init__(self.XML, *args, **kwargs)
+
+
+# Set up aliases for the default formatters.
+HTMLFormatter.REGISTRY['html'] = HTMLFormatter(
+    entity_substitution=EntitySubstitution.substitute_html
+)
+HTMLFormatter.REGISTRY["html5"] = HTMLFormatter(
+    entity_substitution=EntitySubstitution.substitute_html,
+    void_element_close_prefix=None,
+    empty_attributes_are_booleans=True,
+)
+HTMLFormatter.REGISTRY["minimal"] = HTMLFormatter(
+    entity_substitution=EntitySubstitution.substitute_xml
+)
+HTMLFormatter.REGISTRY[None] = HTMLFormatter(
+    entity_substitution=None
+)
+XMLFormatter.REGISTRY["html"] =  XMLFormatter(
+    entity_substitution=EntitySubstitution.substitute_html
+)
+XMLFormatter.REGISTRY["minimal"] = XMLFormatter(
+    entity_substitution=EntitySubstitution.substitute_xml
+)
+XMLFormatter.REGISTRY[None] = Formatter(
+    Formatter(Formatter.XML, entity_substitution=None)
+)
diff --git a/lib/bs4/testing.py b/lib/bs4/testing.py
deleted file mode 100644
index 6584ecf303..0000000000
--- a/lib/bs4/testing.py
+++ /dev/null
@@ -1,686 +0,0 @@
-"""Helper classes for tests."""
-
-__license__ = "MIT"
-
-import pickle
-import copy
-import unittest
-from unittest import TestCase
-from bs4 import BeautifulSoup
-from bs4.element import (
-    CharsetMetaAttributeValue,
-    Comment,
-    ContentMetaAttributeValue,
-    Doctype,
-    SoupStrainer,
-)
-
-from bs4.builder._htmlparser import HTMLParserTreeBuilder
-default_builder = HTMLParserTreeBuilder
-
-
-class SoupTest(unittest.TestCase):
-
-    @property
-    def default_builder(self):
-        return default_builder()
-
-    def soup(self, markup, **kwargs):
-        """Build a Beautiful Soup object from markup."""
-        builder = kwargs.pop('builder', self.default_builder)
-        return BeautifulSoup(markup, builder=builder, **kwargs)
-
-    def document_for(self, markup):
-        """Turn an HTML fragment into a document.
-
-        The details depend on the builder.
-        """
-        return self.default_builder.test_fragment_to_document(markup)
-
-    def assertSoupEquals(self, to_parse, compare_parsed_to=None):
-        builder = self.default_builder
-        obj = BeautifulSoup(to_parse, builder=builder)
-        if compare_parsed_to is None:
-            compare_parsed_to = to_parse
-
-        self.assertEqual(obj.decode(), self.document_for(compare_parsed_to))
-
-    def assertConnectedness(self, element):
-        """Ensure that next_element and previous_element are properly
-        set for all descendants of the given element.
-        """
-        earlier = None
-        for e in element.descendants:
-            if earlier:
-                self.assertEqual(e, earlier.next_element)
-                self.assertEqual(earlier, e.previous_element)
-            earlier = e
-
-class HTMLTreeBuilderSmokeTest(SoupTest):
-
-    """A basic test of a treebuilder's competence.
-
-    Any HTML treebuilder, present or future, should be able to pass
-    these tests. With invalid markup, there's room for interpretation,
-    and different parsers can handle it differently. But with the
-    markup in these tests, there's not much room for interpretation.
-    """
-
-    def test_pickle_and_unpickle_identity(self):
-        # Pickling a tree, then unpickling it, yields a tree identical
-        # to the original.
-        tree = self.soup("<a><b>foo</a>")
-        dumped = pickle.dumps(tree, 2)
-        loaded = pickle.loads(dumped)
-        self.assertEqual(loaded.__class__, BeautifulSoup)
-        self.assertEqual(loaded.decode(), tree.decode())
-
-    def assertDoctypeHandled(self, doctype_fragment):
-        """Assert that a given doctype string is handled correctly."""
-        doctype_str, soup = self._document_with_doctype(doctype_fragment)
-
-        # Make sure a Doctype object was created.
-        doctype = soup.contents[0]
-        self.assertEqual(doctype.__class__, Doctype)
-        self.assertEqual(doctype, doctype_fragment)
-        self.assertEqual(str(soup)[:len(doctype_str)], doctype_str)
-
-        # Make sure that the doctype was correctly associated with the
-        # parse tree and that the rest of the document parsed.
-        self.assertEqual(soup.p.contents[0], 'foo')
-
-    def _document_with_doctype(self, doctype_fragment):
-        """Generate and parse a document with the given doctype."""
-        doctype = '<!DOCTYPE %s>' % doctype_fragment
-        markup = doctype + '\n<p>foo</p>'
-        soup = self.soup(markup)
-        return doctype, soup
-
-    def test_normal_doctypes(self):
-        """Make sure normal, everyday HTML doctypes are handled correctly."""
-        self.assertDoctypeHandled("html")
-        self.assertDoctypeHandled(
-            'html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"')
-
-    def test_empty_doctype(self):
-        soup = self.soup("<!DOCTYPE>")
-        doctype = soup.contents[0]
-        self.assertEqual("", doctype.strip())
-
-    def test_public_doctype_with_url(self):
-        doctype = 'html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"'
-        self.assertDoctypeHandled(doctype)
-
-    def test_system_doctype(self):
-        self.assertDoctypeHandled('foo SYSTEM "http://www.example.com/"')
-
-    def test_namespaced_system_doctype(self):
-        # We can handle a namespaced doctype with a system ID.
-        self.assertDoctypeHandled('xsl:stylesheet SYSTEM "htmlent.dtd"')
-
-    def test_namespaced_public_doctype(self):
-        # Test a namespaced doctype with a public id.
-        self.assertDoctypeHandled('xsl:stylesheet PUBLIC "htmlent.dtd"')
-
-    def test_real_xhtml_document(self):
-        """A real XHTML document should come out more or less the same as it went in."""
-        markup = b"""<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
-<html xmlns="http://www.w3.org/1999/xhtml">
-<head><title>Hello.</title></head>
-<body>Goodbye.</body>
-</html>"""
-        soup = self.soup(markup)
-        self.assertEqual(
-            soup.encode("utf-8").replace(b"\n", b""),
-            markup.replace(b"\n", b""))
-
-    def test_processing_instruction(self):
-        markup = b"""<?PITarget PIContent?>"""
-        soup = self.soup(markup)
-        self.assertEqual(markup, soup.encode("utf8"))
-
-    def test_deepcopy(self):
-        """Make sure you can copy the tree builder.
-
-        This is important because the builder is part of a
-        BeautifulSoup object, and we want to be able to copy that.
-        """
-        copy.deepcopy(self.default_builder)
-
-    def test_p_tag_is_never_empty_element(self):
-        """A <p> tag is never designated as an empty-element tag.
-
-        Even if the markup shows it as an empty-element tag, it
-        shouldn't be presented that way.
-        """
-        soup = self.soup("<p/>")
-        self.assertFalse(soup.p.is_empty_element)
-        self.assertEqual(str(soup.p), "<p></p>")
-
-    def test_unclosed_tags_get_closed(self):
-        """A tag that's not closed by the end of the document should be closed.
-
-        This applies to all tags except empty-element tags.
-        """
-        self.assertSoupEquals("<p>", "<p></p>")
-        self.assertSoupEquals("<b>", "<b></b>")
-
-        self.assertSoupEquals("<br>", "<br/>")
-
-    def test_br_is_always_empty_element_tag(self):
-        """A <br> tag is designated as an empty-element tag.
-
-        Some parsers treat <br></br> as one <br/> tag, some parsers as
-        two tags, but it should always be an empty-element tag.
-        """
-        soup = self.soup("<br></br>")
-        self.assertTrue(soup.br.is_empty_element)
-        self.assertEqual(str(soup.br), "<br/>")
-
-    def test_nested_formatting_elements(self):
-        self.assertSoupEquals("<em><em></em></em>")
-
-    def test_double_head(self):
-        html = '''<!DOCTYPE html>
-<html>
-<head>
-<title>Ordinary HEAD element test</title>
-</head>
-<script type="text/javascript">
-alert("Help!");
-</script>
-<body>
-Hello, world!
-</body>
-</html>
-'''
-        soup = self.soup(html)
-        self.assertEqual("text/javascript", soup.find('script')['type'])
-
-    def test_comment(self):
-        # Comments are represented as Comment objects.
-        markup = "<p>foo<!--foobar-->baz</p>"
-        self.assertSoupEquals(markup)
-
-        soup = self.soup(markup)
-        comment = soup.find(text="foobar")
-        self.assertEqual(comment.__class__, Comment)
-
-        # The comment is properly integrated into the tree.
-        foo = soup.find(text="foo")
-        self.assertEqual(comment, foo.next_element)
-        baz = soup.find(text="baz")
-        self.assertEqual(comment, baz.previous_element)
-
-    def test_preserved_whitespace_in_pre_and_textarea(self):
-        """Whitespace must be preserved in <pre> and <textarea> tags."""
-        self.assertSoupEquals("<pre>   </pre>")
-        self.assertSoupEquals("<textarea> woo  </textarea>")
-
-    def test_nested_inline_elements(self):
-        """Inline elements can be nested indefinitely."""
-        b_tag = "<b>Inside a B tag</b>"
-        self.assertSoupEquals(b_tag)
-
-        nested_b_tag = "<p>A <i>nested <b>tag</b></i></p>"
-        self.assertSoupEquals(nested_b_tag)
-
-        double_nested_b_tag = "<p>A <a>doubly <i>nested <b>tag</b></i></a></p>"
-        self.assertSoupEquals(nested_b_tag)
-
-    def test_nested_block_level_elements(self):
-        """Block elements can be nested."""
-        soup = self.soup('<blockquote><p><b>Foo</b></p></blockquote>')
-        blockquote = soup.blockquote
-        self.assertEqual(blockquote.p.b.string, 'Foo')
-        self.assertEqual(blockquote.b.string, 'Foo')
-
-    def test_correctly_nested_tables(self):
-        """One table can go inside another one."""
-        markup = ('<table id="1">'
-                  '<tr>'
-                  "<td>Here's another table:"
-                  '<table id="2">'
-                  '<tr><td>foo</td></tr>'
-                  '</table></td>')
-
-        self.assertSoupEquals(
-            markup,
-            '<table id="1"><tr><td>Here\'s another table:'
-            '<table id="2"><tr><td>foo</td></tr></table>'
-            '</td></tr></table>')
-
-        self.assertSoupEquals(
-            "<table><thead><tr><td>Foo</td></tr></thead>"
-            "<tbody><tr><td>Bar</td></tr></tbody>"
-            "<tfoot><tr><td>Baz</td></tr></tfoot></table>")
-
-    def test_deeply_nested_multivalued_attribute(self):
-        # html5lib can set the attributes of the same tag many times
-        # as it rearranges the tree. This has caused problems with
-        # multivalued attributes.
-        markup = '<table><div><div class="css"></div></div></table>'
-        soup = self.soup(markup)
-        self.assertEqual(["css"], soup.div.div['class'])
-
-    def test_multivalued_attribute_on_html(self):
-        # html5lib uses a different API to set the attributes ot the
-        # <html> tag. This has caused problems with multivalued
-        # attributes.
-        markup = '<html class="a b"></html>'
-        soup = self.soup(markup)
-        self.assertEqual(["a", "b"], soup.html['class'])
-
-    def test_angle_brackets_in_attribute_values_are_escaped(self):
-        self.assertSoupEquals('<a b="<a>"></a>', '<a b="&lt;a&gt;"></a>')
-
-    def test_entities_in_attributes_converted_to_unicode(self):
-        expect = '<p id="pi\N{LATIN SMALL LETTER N WITH TILDE}ata"></p>'
-        self.assertSoupEquals('<p id="pi&#241;ata"></p>', expect)
-        self.assertSoupEquals('<p id="pi&#xf1;ata"></p>', expect)
-        self.assertSoupEquals('<p id="pi&#Xf1;ata"></p>', expect)
-        self.assertSoupEquals('<p id="pi&ntilde;ata"></p>', expect)
-
-    def test_entities_in_text_converted_to_unicode(self):
-        expect = '<p>pi\N{LATIN SMALL LETTER N WITH TILDE}ata</p>'
-        self.assertSoupEquals("<p>pi&#241;ata</p>", expect)
-        self.assertSoupEquals("<p>pi&#xf1;ata</p>", expect)
-        self.assertSoupEquals("<p>pi&#Xf1;ata</p>", expect)
-        self.assertSoupEquals("<p>pi&ntilde;ata</p>", expect)
-
-    def test_quot_entity_converted_to_quotation_mark(self):
-        self.assertSoupEquals("<p>I said &quot;good day!&quot;</p>",
-                              '<p>I said "good day!"</p>')
-
-    def test_out_of_range_entity(self):
-        expect = "\N{REPLACEMENT CHARACTER}"
-        self.assertSoupEquals("&#10000000000000;", expect)
-        self.assertSoupEquals("&#x10000000000000;", expect)
-        self.assertSoupEquals("&#1000000000;", expect)
-
-    def test_multipart_strings(self):
-        "Mostly to prevent a recurrence of a bug in the html5lib treebuilder."
-        soup = self.soup("<html><h2>\nfoo</h2><p></p></html>")
-        self.assertEqual("p", soup.h2.string.next_element.name)
-        self.assertEqual("p", soup.p.name)
-        self.assertConnectedness(soup)
-
-    def test_head_tag_between_head_and_body(self):
-        "Prevent recurrence of a bug in the html5lib treebuilder."
-        content = """<html><head></head>
-  <link></link>
-  <body>foo</body>
-</html>
-"""
-        soup = self.soup(content)
-        self.assertNotEqual(None, soup.html.body)
-        self.assertConnectedness(soup)
-
-    def test_multiple_copies_of_a_tag(self):
-        "Prevent recurrence of a bug in the html5lib treebuilder."
-        content = """<!DOCTYPE html>
-<html>
- <body>
-   <article id="a" >
-   <div><a href="1"></div>
-   <footer>
-     <a href="2"></a>
-   </footer>
-  </article>
-  </body>
-</html>
-"""
-        soup = self.soup(content)
-        self.assertConnectedness(soup.article)
-
-    def test_basic_namespaces(self):
-        """Parsers don't need to *understand* namespaces, but at the
-        very least they should not choke on namespaces or lose
-        data."""
-
-        markup = b'<html xmlns="http://www.w3.org/1999/xhtml" xmlns:mathml="http://www.w3.org/1998/Math/MathML" xmlns:svg="http://www.w3.org/2000/svg"><head></head><body><mathml:msqrt>4</mathml:msqrt><b svg:fill="red"></b></body></html>'
-        soup = self.soup(markup)
-        self.assertEqual(markup, soup.encode())
-        html = soup.html
-        self.assertEqual('http://www.w3.org/1999/xhtml', soup.html['xmlns'])
-        self.assertEqual(
-            'http://www.w3.org/1998/Math/MathML', soup.html['xmlns:mathml'])
-        self.assertEqual(
-            'http://www.w3.org/2000/svg', soup.html['xmlns:svg'])
-
-    def test_multivalued_attribute_value_becomes_list(self):
-        markup = b'<a class="foo bar">'
-        soup = self.soup(markup)
-        self.assertEqual(['foo', 'bar'], soup.a['class'])
-
-    #
-    # Generally speaking, tests below this point are more tests of
-    # Beautiful Soup than tests of the tree builders. But parsers are
-    # weird, so we run these tests separately for every tree builder
-    # to detect any differences between them.
-    #
-
-    def test_can_parse_unicode_document(self):
-        # A seemingly innocuous document... but it's in Unicode! And
-        # it contains characters that can't be represented in the
-        # encoding found in the  declaration! The horror!
-        markup = '<html><head><meta encoding="euc-jp"></head><body>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</body>'
-        soup = self.soup(markup)
-        self.assertEqual('Sacr\xe9 bleu!', soup.body.string)
-
-    def test_soupstrainer(self):
-        """Parsers should be able to work with SoupStrainers."""
-        strainer = SoupStrainer("b")
-        soup = self.soup("A <b>bold</b> <meta/> <i>statement</i>",
-                         parse_only=strainer)
-        self.assertEqual(soup.decode(), "<b>bold</b>")
-
-    def test_single_quote_attribute_values_become_double_quotes(self):
-        self.assertSoupEquals("<foo attr='bar'></foo>",
-                              '<foo attr="bar"></foo>')
-
-    def test_attribute_values_with_nested_quotes_are_left_alone(self):
-        text = """<foo attr='bar "brawls" happen'>a</foo>"""
-        self.assertSoupEquals(text)
-
-    def test_attribute_values_with_double_nested_quotes_get_quoted(self):
-        text = """<foo attr='bar "brawls" happen'>a</foo>"""
-        soup = self.soup(text)
-        soup.foo['attr'] = 'Brawls happen at "Bob\'s Bar"'
-        self.assertSoupEquals(
-            soup.foo.decode(),
-            """<foo attr="Brawls happen at &quot;Bob\'s Bar&quot;">a</foo>""")
-
-    def test_ampersand_in_attribute_value_gets_escaped(self):
-        self.assertSoupEquals('<this is="really messed up & stuff"></this>',
-                              '<this is="really messed up &amp; stuff"></this>')
-
-        self.assertSoupEquals(
-            '<a href="http://example.org?a=1&b=2;3">foo</a>',
-            '<a href="http://example.org?a=1&amp;b=2;3">foo</a>')
-
-    def test_escaped_ampersand_in_attribute_value_is_left_alone(self):
-        self.assertSoupEquals('<a href="http://example.org?a=1&amp;b=2;3"></a>')
-
-    def test_entities_in_strings_converted_during_parsing(self):
-        # Both XML and HTML entities are converted to Unicode characters
-        # during parsing.
-        text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
-        expected = "<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>"
-        self.assertSoupEquals(text, expected)
-
-    def test_smart_quotes_converted_on_the_way_in(self):
-        # Microsoft smart quotes are converted to Unicode characters during
-        # parsing.
-        quote = b"<p>\x91Foo\x92</p>"
-        soup = self.soup(quote)
-        self.assertEqual(
-            soup.p.string,
-            "\N{LEFT SINGLE QUOTATION MARK}Foo\N{RIGHT SINGLE QUOTATION MARK}")
-
-    def test_non_breaking_spaces_converted_on_the_way_in(self):
-        soup = self.soup("<a>&nbsp;&nbsp;</a>")
-        self.assertEqual(soup.a.string, "\N{NO-BREAK SPACE}" * 2)
-
-    def test_entities_converted_on_the_way_out(self):
-        text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
-        expected = "<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>".encode("utf-8")
-        soup = self.soup(text)
-        self.assertEqual(soup.p.encode("utf-8"), expected)
-
-    def test_real_iso_latin_document(self):
-        # Smoke test of interrelated functionality, using an
-        # easy-to-understand document.
-
-        # Here it is in Unicode. Note that it claims to be in ISO-Latin-1.
-        unicode_html = '<html><head><meta content="text/html; charset=ISO-Latin-1" http-equiv="Content-type"/></head><body><p>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</p></body></html>'
-
-        # That's because we're going to encode it into ISO-Latin-1, and use
-        # that to test.
-        iso_latin_html = unicode_html.encode("iso-8859-1")
-
-        # Parse the ISO-Latin-1 HTML.
-        soup = self.soup(iso_latin_html)
-        # Encode it to UTF-8.
-        result = soup.encode("utf-8")
-
-        # What do we expect the result to look like? Well, it would
-        # look like unicode_html, except that the META tag would say
-        # UTF-8 instead of ISO-Latin-1.
-        expected = unicode_html.replace("ISO-Latin-1", "utf-8")
-
-        # And, of course, it would be in UTF-8, not Unicode.
-        expected = expected.encode("utf-8")
-
-        # Ta-da!
-        self.assertEqual(result, expected)
-
-    def test_real_shift_jis_document(self):
-        # Smoke test to make sure the parser can handle a document in
-        # Shift-JIS encoding, without choking.
-        shift_jis_html = (
-            b'<html><head></head><body><pre>'
-            b'\x82\xb1\x82\xea\x82\xcdShift-JIS\x82\xc5\x83R\x81[\x83f'
-            b'\x83B\x83\x93\x83O\x82\xb3\x82\xea\x82\xbd\x93\xfa\x96{\x8c'
-            b'\xea\x82\xcc\x83t\x83@\x83C\x83\x8b\x82\xc5\x82\xb7\x81B'
-            b'</pre></body></html>')
-        unicode_html = shift_jis_html.decode("shift-jis")
-        soup = self.soup(unicode_html)
-
-        # Make sure the parse tree is correctly encoded to various
-        # encodings.
-        self.assertEqual(soup.encode("utf-8"), unicode_html.encode("utf-8"))
-        self.assertEqual(soup.encode("euc_jp"), unicode_html.encode("euc_jp"))
-
-    def test_real_hebrew_document(self):
-        # A real-world test to make sure we can convert ISO-8859-9 (a
-        # Hebrew encoding) to UTF-8.
-        hebrew_document = b'<html><head><title>Hebrew (ISO 8859-8) in Visual Directionality</title></head><body><h1>Hebrew (ISO 8859-8) in Visual Directionality</h1>\xed\xe5\xec\xf9</body></html>'
-        soup = self.soup(
-            hebrew_document, from_encoding="iso8859-8")
-        self.assertEqual(soup.original_encoding, 'iso8859-8')
-        self.assertEqual(
-            soup.encode('utf-8'),
-            hebrew_document.decode("iso8859-8").encode("utf-8"))
-
-    def test_meta_tag_reflects_current_encoding(self):
-        # Here's the <meta> tag saying that a document is
-        # encoded in Shift-JIS.
-        meta_tag = ('<meta content="text/html; charset=x-sjis" '
-                    'http-equiv="Content-type"/>')
-
-        # Here's a document incorporating that meta tag.
-        shift_jis_html = (
-            '<html><head>\n%s\n'
-            '<meta http-equiv="Content-language" content="ja"/>'
-            '</head><body>Shift-JIS markup goes here.') % meta_tag
-        soup = self.soup(shift_jis_html)
-
-        # Parse the document, and the charset is seemingly unaffected.
-        parsed_meta = soup.find('meta', {'http-equiv': 'Content-type'})
-        content = parsed_meta['content']
-        self.assertEqual('text/html; charset=x-sjis', content)
-
-        # But that value is actually a ContentMetaAttributeValue object.
-        self.assertTrue(isinstance(content, ContentMetaAttributeValue))
-
-        # And it will take on a value that reflects its current
-        # encoding.
-        self.assertEqual('text/html; charset=utf8', content.encode("utf8"))
-
-        # For the rest of the story, see TestSubstitutions in
-        # test_tree.py.
-
-    def test_html5_style_meta_tag_reflects_current_encoding(self):
-        # Here's the <meta> tag saying that a document is
-        # encoded in Shift-JIS.
-        meta_tag = ('<meta id="encoding" charset="x-sjis" />')
-
-        # Here's a document incorporating that meta tag.
-        shift_jis_html = (
-            '<html><head>\n%s\n'
-            '<meta http-equiv="Content-language" content="ja"/>'
-            '</head><body>Shift-JIS markup goes here.') % meta_tag
-        soup = self.soup(shift_jis_html)
-
-        # Parse the document, and the charset is seemingly unaffected.
-        parsed_meta = soup.find('meta', id="encoding")
-        charset = parsed_meta['charset']
-        self.assertEqual('x-sjis', charset)
-
-        # But that value is actually a CharsetMetaAttributeValue object.
-        self.assertTrue(isinstance(charset, CharsetMetaAttributeValue))
-
-        # And it will take on a value that reflects its current
-        # encoding.
-        self.assertEqual('utf8', charset.encode("utf8"))
-
-    def test_tag_with_no_attributes_can_have_attributes_added(self):
-        data = self.soup("<a>text</a>")
-        data.a['foo'] = 'bar'
-        self.assertEqual('<a foo="bar">text</a>', data.a.decode())
-
-class XMLTreeBuilderSmokeTest(SoupTest):
-
-    def test_pickle_and_unpickle_identity(self):
-        # Pickling a tree, then unpickling it, yields a tree identical
-        # to the original.
-        tree = self.soup("<a><b>foo</a>")
-        dumped = pickle.dumps(tree, 2)
-        loaded = pickle.loads(dumped)
-        self.assertEqual(loaded.__class__, BeautifulSoup)
-        self.assertEqual(loaded.decode(), tree.decode())
-
-    def test_docstring_generated(self):
-        soup = self.soup("<root/>")
-        self.assertEqual(
-            soup.encode(), b'<?xml version="1.0" encoding="utf-8"?>\n<root/>')
-
-    def test_xml_declaration(self):
-        markup = b"""<?xml version="1.0" encoding="utf8"?>\n<foo/>"""
-        soup = self.soup(markup)
-        self.assertEqual(markup, soup.encode("utf8"))
-
-    def test_real_xhtml_document(self):
-        """A real XHTML document should come out *exactly* the same as it went in."""
-        markup = b"""<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
-<html xmlns="http://www.w3.org/1999/xhtml">
-<head><title>Hello.</title></head>
-<body>Goodbye.</body>
-</html>"""
-        soup = self.soup(markup)
-        self.assertEqual(
-            soup.encode("utf-8"), markup)
-
-    def test_formatter_processes_script_tag_for_xml_documents(self):
-        doc = """
-  <script type="text/javascript">
-  </script>
-"""
-        soup = BeautifulSoup(doc, "lxml-xml")
-        # lxml would have stripped this while parsing, but we can add
-        # it later.
-        soup.script.string = 'console.log("< < hey > > ");'
-        encoded = soup.encode()
-        self.assertTrue(b"&lt; &lt; hey &gt; &gt;" in encoded)
-
-    def test_can_parse_unicode_document(self):
-        markup = '<?xml version="1.0" encoding="euc-jp"><root>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</root>'
-        soup = self.soup(markup)
-        self.assertEqual('Sacr\xe9 bleu!', soup.root.string)
-
-    def test_popping_namespaced_tag(self):
-        markup = '<rss xmlns:dc="foo"><dc:creator>b</dc:creator><dc:date>2012-07-02T20:33:42Z</dc:date><dc:rights>c</dc:rights><image>d</image></rss>'
-        soup = self.soup(markup)
-        self.assertEqual(
-            str(soup.rss), markup)
-
-    def test_docstring_includes_correct_encoding(self):
-        soup = self.soup("<root/>")
-        self.assertEqual(
-            soup.encode("latin1"),
-            b'<?xml version="1.0" encoding="latin1"?>\n<root/>')
-
-    def test_large_xml_document(self):
-        """A large XML document should come out the same as it went in."""
-        markup = (b'<?xml version="1.0" encoding="utf-8"?>\n<root>'
-                  + b'0' * (2**12)
-                  + b'</root>')
-        soup = self.soup(markup)
-        self.assertEqual(soup.encode("utf-8"), markup)
-
-
-    def test_tags_are_empty_element_if_and_only_if_they_are_empty(self):
-        self.assertSoupEquals("<p>", "<p/>")
-        self.assertSoupEquals("<p>foo</p>")
-
-    def test_namespaces_are_preserved(self):
-        markup = '<root xmlns:a="http://example.com/" xmlns:b="http://example.net/"><a:foo>This tag is in the a namespace</a:foo><b:foo>This tag is in the b namespace</b:foo></root>'
-        soup = self.soup(markup)
-        root = soup.root
-        self.assertEqual("http://example.com/", root['xmlns:a'])
-        self.assertEqual("http://example.net/", root['xmlns:b'])
-
-    def test_closing_namespaced_tag(self):
-        markup = '<p xmlns:dc="http://purl.org/dc/elements/1.1/"><dc:date>20010504</dc:date></p>'
-        soup = self.soup(markup)
-        self.assertEqual(str(soup.p), markup)
-
-    def test_namespaced_attributes(self):
-        markup = '<foo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><bar xsi:schemaLocation="http://www.example.com"/></foo>'
-        soup = self.soup(markup)
-        self.assertEqual(str(soup.foo), markup)
-
-    def test_namespaced_attributes_xml_namespace(self):
-        markup = '<foo xml:lang="fr">bar</foo>'
-        soup = self.soup(markup)
-        self.assertEqual(str(soup.foo), markup)
-
-class HTML5TreeBuilderSmokeTest(HTMLTreeBuilderSmokeTest):
-    """Smoke test for a tree builder that supports HTML5."""
-
-    def test_real_xhtml_document(self):
-        # Since XHTML is not HTML5, HTML5 parsers are not tested to handle
-        # XHTML documents in any particular way.
-        pass
-
-    def test_html_tags_have_namespace(self):
-        markup = "<a>"
-        soup = self.soup(markup)
-        self.assertEqual("http://www.w3.org/1999/xhtml", soup.a.namespace)
-
-    def test_svg_tags_have_namespace(self):
-        markup = '<svg><circle/></svg>'
-        soup = self.soup(markup)
-        namespace = "http://www.w3.org/2000/svg"
-        self.assertEqual(namespace, soup.svg.namespace)
-        self.assertEqual(namespace, soup.circle.namespace)
-
-
-    def test_mathml_tags_have_namespace(self):
-        markup = '<math><msqrt>5</msqrt></math>'
-        soup = self.soup(markup)
-        namespace = 'http://www.w3.org/1998/Math/MathML'
-        self.assertEqual(namespace, soup.math.namespace)
-        self.assertEqual(namespace, soup.msqrt.namespace)
-
-    def test_xml_declaration_becomes_comment(self):
-        markup = '<?xml version="1.0" encoding="utf-8"?><html></html>'
-        soup = self.soup(markup)
-        self.assertTrue(isinstance(soup.contents[0], Comment))
-        self.assertEqual(soup.contents[0], '?xml version="1.0" encoding="utf-8"?')
-        self.assertEqual("html", soup.contents[0].next_element.name)
-
-def skipIf(condition, reason):
-   def nothing(test, *args, **kwargs):
-       return None
-
-   def decorator(test_item):
-       if condition:
-           return nothing
-       else:
-           return test_item
-
-   return decorator
diff --git a/lib/bs4/tests/__init__.py b/lib/bs4/tests/__init__.py
deleted file mode 100644
index 142c8cc3f1..0000000000
--- a/lib/bs4/tests/__init__.py
+++ /dev/null
@@ -1 +0,0 @@
-"The beautifulsoup tests."
diff --git a/lib/bs4/tests/test_builder_registry.py b/lib/bs4/tests/test_builder_registry.py
deleted file mode 100644
index 90cad82933..0000000000
--- a/lib/bs4/tests/test_builder_registry.py
+++ /dev/null
@@ -1,147 +0,0 @@
-"""Tests of the builder registry."""
-
-import unittest
-import warnings
-
-from bs4 import BeautifulSoup
-from bs4.builder import (
-    builder_registry as registry,
-    HTMLParserTreeBuilder,
-    TreeBuilderRegistry,
-)
-
-try:
-    from bs4.builder import HTML5TreeBuilder
-    HTML5LIB_PRESENT = True
-except ImportError:
-    HTML5LIB_PRESENT = False
-
-try:
-    from bs4.builder import (
-        LXMLTreeBuilderForXML,
-        LXMLTreeBuilder,
-        )
-    LXML_PRESENT = True
-except ImportError:
-    LXML_PRESENT = False
-
-
-class BuiltInRegistryTest(unittest.TestCase):
-    """Test the built-in registry with the default builders registered."""
-
-    def test_combination(self):
-        if LXML_PRESENT:
-            self.assertEqual(registry.lookup('fast', 'html'),
-                             LXMLTreeBuilder)
-
-        if LXML_PRESENT:
-            self.assertEqual(registry.lookup('permissive', 'xml'),
-                             LXMLTreeBuilderForXML)
-        self.assertEqual(registry.lookup('strict', 'html'),
-                          HTMLParserTreeBuilder)
-        if HTML5LIB_PRESENT:
-            self.assertEqual(registry.lookup('html5lib', 'html'),
-                              HTML5TreeBuilder)
-
-    def test_lookup_by_markup_type(self):
-        if LXML_PRESENT:
-            self.assertEqual(registry.lookup('html'), LXMLTreeBuilder)
-            self.assertEqual(registry.lookup('xml'), LXMLTreeBuilderForXML)
-        else:
-            self.assertEqual(registry.lookup('xml'), None)
-            if HTML5LIB_PRESENT:
-                self.assertEqual(registry.lookup('html'), HTML5TreeBuilder)
-            else:
-                self.assertEqual(registry.lookup('html'), HTMLParserTreeBuilder)
-
-    def test_named_library(self):
-        if LXML_PRESENT:
-            self.assertEqual(registry.lookup('lxml', 'xml'),
-                             LXMLTreeBuilderForXML)
-            self.assertEqual(registry.lookup('lxml', 'html'),
-                             LXMLTreeBuilder)
-        if HTML5LIB_PRESENT:
-            self.assertEqual(registry.lookup('html5lib'),
-                              HTML5TreeBuilder)
-
-        self.assertEqual(registry.lookup('html.parser'),
-                          HTMLParserTreeBuilder)
-
-    def test_beautifulsoup_constructor_does_lookup(self):
-
-        with warnings.catch_warnings(record=True) as w:
-            # This will create a warning about not explicitly
-            # specifying a parser, but we'll ignore it.
-
-            # You can pass in a string.
-            BeautifulSoup("", features="html")
-            # Or a list of strings.
-            BeautifulSoup("", features=["html", "fast"])
-
-        # You'll get an exception if BS can't find an appropriate
-        # builder.
-        self.assertRaises(ValueError, BeautifulSoup,
-                          "", features="no-such-feature")
-
-class RegistryTest(unittest.TestCase):
-    """Test the TreeBuilderRegistry class in general."""
-
-    def setUp(self):
-        self.registry = TreeBuilderRegistry()
-
-    def builder_for_features(self, *feature_list):
-        cls = type('Builder_' + '_'.join(feature_list),
-                   (object,), {'features' : feature_list})
-
-        self.registry.register(cls)
-        return cls
-
-    def test_register_with_no_features(self):
-        builder = self.builder_for_features()
-
-        # Since the builder advertises no features, you can't find it
-        # by looking up features.
-        self.assertEqual(self.registry.lookup('foo'), None)
-
-        # But you can find it by doing a lookup with no features, if
-        # this happens to be the only registered builder.
-        self.assertEqual(self.registry.lookup(), builder)
-
-    def test_register_with_features_makes_lookup_succeed(self):
-        builder = self.builder_for_features('foo', 'bar')
-        self.assertEqual(self.registry.lookup('foo'), builder)
-        self.assertEqual(self.registry.lookup('bar'), builder)
-
-    def test_lookup_fails_when_no_builder_implements_feature(self):
-        builder = self.builder_for_features('foo', 'bar')
-        self.assertEqual(self.registry.lookup('baz'), None)
-
-    def test_lookup_gets_most_recent_registration_when_no_feature_specified(self):
-        builder1 = self.builder_for_features('foo')
-        builder2 = self.builder_for_features('bar')
-        self.assertEqual(self.registry.lookup(), builder2)
-
-    def test_lookup_fails_when_no_tree_builders_registered(self):
-        self.assertEqual(self.registry.lookup(), None)
-
-    def test_lookup_gets_most_recent_builder_supporting_all_features(self):
-        has_one = self.builder_for_features('foo')
-        has_the_other = self.builder_for_features('bar')
-        has_both_early = self.builder_for_features('foo', 'bar', 'baz')
-        has_both_late = self.builder_for_features('foo', 'bar', 'quux')
-        lacks_one = self.builder_for_features('bar')
-        has_the_other = self.builder_for_features('foo')
-
-        # There are two builders featuring 'foo' and 'bar', but
-        # the one that also features 'quux' was registered later.
-        self.assertEqual(self.registry.lookup('foo', 'bar'),
-                          has_both_late)
-
-        # There is only one builder featuring 'foo', 'bar', and 'baz'.
-        self.assertEqual(self.registry.lookup('foo', 'bar', 'baz'),
-                          has_both_early)
-
-    def test_lookup_fails_when_cannot_reconcile_requested_features(self):
-        builder1 = self.builder_for_features('foo', 'bar')
-        builder2 = self.builder_for_features('foo', 'baz')
-        self.assertEqual(self.registry.lookup('bar', 'baz'), None)
diff --git a/lib/bs4/tests/test_docs.py b/lib/bs4/tests/test_docs.py
deleted file mode 100644
index d1d76a33bf..0000000000
--- a/lib/bs4/tests/test_docs.py
+++ /dev/null
@@ -1,32 +0,0 @@
-"Test harness for doctests."
-
-# pylint: disable-msg=E0611,W0142
-
-__metaclass__ = type
-__all__ = [
-    'additional_tests',
-    ]
-
-import doctest
-#from pkg_resources import (
-#    resource_filename, resource_exists, resource_listdir, cleanup_resources)
-
-DOCTEST_FLAGS = (
-    doctest.ELLIPSIS |
-    doctest.NORMALIZE_WHITESPACE |
-    doctest.REPORT_NDIFF)
-
-# def additional_tests():
-#     "Run the doc tests (README.txt and docs/*, if any exist)"
-#     doctest_files = [
-#         os.path.abspath(resource_filename('bs4', 'README.txt'))]
-#     if resource_exists('bs4', 'docs'):
-#         for name in resource_listdir('bs4', 'docs'):
-#             if name.endswith('.txt'):
-#                 doctest_files.append(
-#                     os.path.abspath(
-#                         resource_filename('bs4', 'docs/%s' % name)))
-#     kwargs = dict(module_relative=False, optionflags=DOCTEST_FLAGS)
-#     atexit.register(cleanup_resources)
-#     return unittest.TestSuite((
-#         doctest.DocFileSuite(*doctest_files, **kwargs)))
diff --git a/lib/bs4/tests/test_html5lib.py b/lib/bs4/tests/test_html5lib.py
deleted file mode 100644
index a7494ca5ba..0000000000
--- a/lib/bs4/tests/test_html5lib.py
+++ /dev/null
@@ -1,98 +0,0 @@
-"""Tests to ensure that the html5lib tree builder generates good trees."""
-
-import warnings
-
-try:
-    from bs4.builder import HTML5TreeBuilder
-    HTML5LIB_PRESENT = True
-except ImportError as e:
-    HTML5LIB_PRESENT = False
-from bs4.element import SoupStrainer
-from bs4.testing import (
-    HTML5TreeBuilderSmokeTest,
-    SoupTest,
-    skipIf,
-)
-
-@skipIf(
-    not HTML5LIB_PRESENT,
-    "html5lib seems not to be present, not testing its tree builder.")
-class HTML5LibBuilderSmokeTest(SoupTest, HTML5TreeBuilderSmokeTest):
-    """See ``HTML5TreeBuilderSmokeTest``."""
-
-    @property
-    def default_builder(self):
-        return HTML5TreeBuilder()
-
-    def test_soupstrainer(self):
-        # The html5lib tree builder does not support SoupStrainers.
-        strainer = SoupStrainer("b")
-        markup = "<p>A <b>bold</b> statement.</p>"
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup(markup, parse_only=strainer)
-        self.assertEqual(
-            soup.decode(), self.document_for(markup))
-
-        self.assertTrue(
-            "the html5lib tree builder doesn't support parse_only" in
-            str(w[0].message))
-
-    def test_correctly_nested_tables(self):
-        """html5lib inserts <tbody> tags where other parsers don't."""
-        markup = ('<table id="1">'
-                  '<tr>'
-                  "<td>Here's another table:"
-                  '<table id="2">'
-                  '<tr><td>foo</td></tr>'
-                  '</table></td>')
-
-        self.assertSoupEquals(
-            markup,
-            '<table id="1"><tbody><tr><td>Here\'s another table:'
-            '<table id="2"><tbody><tr><td>foo</td></tr></tbody></table>'
-            '</td></tr></tbody></table>')
-
-        self.assertSoupEquals(
-            "<table><thead><tr><td>Foo</td></tr></thead>"
-            "<tbody><tr><td>Bar</td></tr></tbody>"
-            "<tfoot><tr><td>Baz</td></tr></tfoot></table>")
-
-    def test_xml_declaration_followed_by_doctype(self):
-        markup = '''<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html>
-<html>
-  <head>
-  </head>
-  <body>
-   <p>foo</p>
-  </body>
-</html>'''
-        soup = self.soup(markup)
-        # Verify that we can reach the <p> tag; this means the tree is connected.
-        self.assertEqual(b"<p>foo</p>", soup.p.encode())
-
-    def test_reparented_markup(self):
-        markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>'
-        soup = self.soup(markup)
-        self.assertEqual("<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p></body>", soup.body.decode())
-        self.assertEqual(2, len(soup.find_all('p')))
-
-
-    def test_reparented_markup_ends_with_whitespace(self):
-        markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>\n'
-        soup = self.soup(markup)
-        self.assertEqual("<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p>\n</body>", soup.body.decode())
-        self.assertEqual(2, len(soup.find_all('p')))
-
-    def test_processing_instruction(self):
-        """Processing instructions become comments."""
-        markup = b"""<?PITarget PIContent?>"""
-        soup = self.soup(markup)
-        assert str(soup).startswith("<!--?PITarget PIContent?-->")
-
-    def test_cloned_multivalue_node(self):
-        markup = b"""<a class="my_class"><p></a>"""
-        soup = self.soup(markup)
-        a1, a2 = soup.find_all('a')
-        self.assertEqual(a1, a2)
-        assert a1 is not a2
diff --git a/lib/bs4/tests/test_htmlparser.py b/lib/bs4/tests/test_htmlparser.py
deleted file mode 100644
index 30a25e6709..0000000000
--- a/lib/bs4/tests/test_htmlparser.py
+++ /dev/null
@@ -1,31 +0,0 @@
-"""Tests to ensure that the html.parser tree builder generates good
-trees."""
-
-import pickle
-from bs4.testing import SoupTest, HTMLTreeBuilderSmokeTest
-from bs4.builder import HTMLParserTreeBuilder
-
-class HTMLParserTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
-
-    @property
-    def default_builder(self):
-        return HTMLParserTreeBuilder()
-
-    def test_namespaced_system_doctype(self):
-        # html.parser can't handle namespaced doctypes, so skip this one.
-        pass
-
-    def test_namespaced_public_doctype(self):
-        # html.parser can't handle namespaced doctypes, so skip this one.
-        pass
-
-    def test_builder_is_pickled(self):
-        """Unlike most tree builders, HTMLParserTreeBuilder and will
-        be restored after pickling.
-        """
-        tree = self.soup("<a><b>foo</a>")
-        dumped = pickle.dumps(tree, 2)
-        loaded = pickle.loads(dumped)
-        self.assertTrue(isinstance(loaded.builder, type(tree.builder)))
-
-
diff --git a/lib/bs4/tests/test_lxml.py b/lib/bs4/tests/test_lxml.py
deleted file mode 100644
index 6b6cdd07cb..0000000000
--- a/lib/bs4/tests/test_lxml.py
+++ /dev/null
@@ -1,70 +0,0 @@
-"""Tests to ensure that the lxml tree builder generates good trees."""
-
-import warnings
-
-try:
-    import lxml.etree
-    LXML_PRESENT = True
-    LXML_VERSION = lxml.etree.LXML_VERSION
-except ImportError as e:
-    LXML_PRESENT = False
-    LXML_VERSION = (0,)
-
-if LXML_PRESENT:
-    from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
-
-from bs4 import BeautifulStoneSoup
-from bs4.testing import skipIf
-from bs4.testing import (
-    HTMLTreeBuilderSmokeTest,
-    XMLTreeBuilderSmokeTest,
-    SoupTest,
-    skipIf,
-)
-
-@skipIf(
-    not LXML_PRESENT,
-    "lxml seems not to be present, not testing its tree builder.")
-class LXMLTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
-    """See ``HTMLTreeBuilderSmokeTest``."""
-
-    @property
-    def default_builder(self):
-        return LXMLTreeBuilder()
-
-    def test_out_of_range_entity(self):
-        self.assertSoupEquals(
-            "<p>foo&#10000000000000;bar</p>", "<p>foobar</p>")
-        self.assertSoupEquals(
-            "<p>foo&#x10000000000000;bar</p>", "<p>foobar</p>")
-        self.assertSoupEquals(
-            "<p>foo&#1000000000;bar</p>", "<p>foobar</p>")
-
-    # In lxml < 2.3.5, an empty doctype causes a segfault. Skip this
-    # test if an old version of lxml is installed.
-
-    @skipIf(
-        not LXML_PRESENT or LXML_VERSION < (2,3,5,0),
-        "Skipping doctype test for old version of lxml to avoid segfault.")
-    def test_empty_doctype(self):
-        soup = self.soup("<!DOCTYPE>")
-        doctype = soup.contents[0]
-        self.assertEqual("", doctype.strip())
-
-    def test_beautifulstonesoup_is_xml_parser(self):
-        # Make sure that the deprecated BSS class uses an xml builder
-        # if one is installed.
-        with warnings.catch_warnings(record=True) as w:
-            soup = BeautifulStoneSoup("<b />")
-        self.assertEqual("<b/>", str(soup.b))
-        self.assertTrue("BeautifulStoneSoup class is deprecated" in str(w[0].message))
-
-@skipIf(
-    not LXML_PRESENT,
-    "lxml seems not to be present, not testing its XML tree builder.")
-class LXMLXMLTreeBuilderSmokeTest(SoupTest, XMLTreeBuilderSmokeTest):
-    """See ``HTMLTreeBuilderSmokeTest``."""
-
-    @property
-    def default_builder(self):
-        return LXMLTreeBuilderForXML()
diff --git a/lib/bs4/tests/test_soup.py b/lib/bs4/tests/test_soup.py
deleted file mode 100644
index 6ad3cb3765..0000000000
--- a/lib/bs4/tests/test_soup.py
+++ /dev/null
@@ -1,479 +0,0 @@
-# -*- coding: utf-8 -*-
-"""Tests of Beautiful Soup as a whole."""
-
-import logging
-import unittest
-import sys
-import tempfile
-
-from bs4 import BeautifulSoup
-from bs4.element import (
-    CharsetMetaAttributeValue,
-    ContentMetaAttributeValue,
-    SoupStrainer,
-    NamespacedAttribute,
-    )
-import bs4.dammit
-from bs4.dammit import (
-    EntitySubstitution,
-    UnicodeDammit,
-    EncodingDetector,
-)
-from bs4.testing import (
-    SoupTest,
-    skipIf,
-)
-import warnings
-
-try:
-    from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
-    LXML_PRESENT = True
-except ImportError as e:
-    LXML_PRESENT = False
-
-PYTHON_2_PRE_2_7 = (sys.version_info < (2,7))
-PYTHON_3_PRE_3_2 = (sys.version_info[0] == 3 and sys.version_info < (3,2))
-
-class TestConstructor(SoupTest):
-
-    def test_short_unicode_input(self):
-        data = "<h1>éé</h1>"
-        soup = self.soup(data)
-        self.assertEqual("éé", soup.h1.string)
-
-    def test_embedded_null(self):
-        data = "<h1>foo\0bar</h1>"
-        soup = self.soup(data)
-        self.assertEqual("foo\0bar", soup.h1.string)
-
-    def test_exclude_encodings(self):
-        utf8_data = "Räksmörgås".encode("utf-8")
-        soup = self.soup(utf8_data, exclude_encodings=["utf-8"])
-        self.assertEqual("windows-1252", soup.original_encoding)
-
-
-class TestWarnings(SoupTest):
-
-    def _no_parser_specified(self, s, is_there=True):
-        v = s.startswith(BeautifulSoup.NO_PARSER_SPECIFIED_WARNING[:80])
-        self.assertTrue(v)
-
-    def test_warning_if_no_parser_specified(self):
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("<a><b></b></a>")
-        msg = str(w[0].message)
-        self._assert_no_parser_specified(msg)
-
-    def test_warning_if_parser_specified_too_vague(self):
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("<a><b></b></a>", "html")
-        msg = str(w[0].message)
-        self._assert_no_parser_specified(msg)
-
-    def test_no_warning_if_explicit_parser_specified(self):
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("<a><b></b></a>", "html.parser")
-        self.assertEqual([], w)
-
-    def test_parseOnlyThese_renamed_to_parse_only(self):
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("<a><b></b></a>", parseOnlyThese=SoupStrainer("b"))
-        msg = str(w[0].message)
-        self.assertTrue("parseOnlyThese" in msg)
-        self.assertTrue("parse_only" in msg)
-        self.assertEqual(b"<b></b>", soup.encode())
-
-    def test_fromEncoding_renamed_to_from_encoding(self):
-        with warnings.catch_warnings(record=True) as w:
-            utf8 = b"\xc3\xa9"
-            soup = self.soup(utf8, fromEncoding="utf8")
-        msg = str(w[0].message)
-        self.assertTrue("fromEncoding" in msg)
-        self.assertTrue("from_encoding" in msg)
-        self.assertEqual("utf8", soup.original_encoding)
-
-    def test_unrecognized_keyword_argument(self):
-        self.assertRaises(
-            TypeError, self.soup, "<a>", no_such_argument=True)
-
-class TestWarnings(SoupTest):
-
-    def test_disk_file_warning(self):
-        filehandle = tempfile.NamedTemporaryFile()
-        filename = filehandle.name
-        try:
-            with warnings.catch_warnings(record=True) as w:
-                soup = self.soup(filename)
-            msg = str(w[0].message)
-            self.assertTrue("looks like a filename" in msg)
-        finally:
-            filehandle.close()
-
-        # The file no longer exists, so Beautiful Soup will no longer issue the warning.
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup(filename)
-        self.assertEqual(0, len(w))
-
-    def test_url_warning(self):
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("http://www.crummy.com/")
-        msg = str(w[0].message)
-        self.assertTrue("looks like a URL" in msg)
-
-        with warnings.catch_warnings(record=True) as w:
-            soup = self.soup("http://www.crummy.com/ is great")
-        self.assertEqual(0, len(w))
-
-class TestSelectiveParsing(SoupTest):
-
-    def test_parse_with_soupstrainer(self):
-        markup = "No<b>Yes</b><a>No<b>Yes <c>Yes</c></b>"
-        strainer = SoupStrainer("b")
-        soup = self.soup(markup, parse_only=strainer)
-        self.assertEqual(soup.encode(), b"<b>Yes</b><b>Yes <c>Yes</c></b>")
-
-
-class TestEntitySubstitution(unittest.TestCase):
-    """Standalone tests of the EntitySubstitution class."""
-    def setUp(self):
-        self.sub = EntitySubstitution
-
-    def test_simple_html_substitution(self):
-        # Unicode characters corresponding to named HTML entites
-        # are substituted, and no others.
-        s = "foo\u2200\N{SNOWMAN}\u00f5bar"
-        self.assertEqual(self.sub.substitute_html(s),
-                          "foo&forall;\N{SNOWMAN}&otilde;bar")
-
-    def test_smart_quote_substitution(self):
-        # MS smart quotes are a common source of frustration, so we
-        # give them a special test.
-        quotes = b"\x91\x92foo\x93\x94"
-        dammit = UnicodeDammit(quotes)
-        self.assertEqual(self.sub.substitute_html(dammit.markup),
-                          "&lsquo;&rsquo;foo&ldquo;&rdquo;")
-
-    def test_xml_converstion_includes_no_quotes_if_make_quoted_attribute_is_false(self):
-        s = 'Welcome to "my bar"'
-        self.assertEqual(self.sub.substitute_xml(s, False), s)
-
-    def test_xml_attribute_quoting_normally_uses_double_quotes(self):
-        self.assertEqual(self.sub.substitute_xml("Welcome", True),
-                          '"Welcome"')
-        self.assertEqual(self.sub.substitute_xml("Bob's Bar", True),
-                          '"Bob\'s Bar"')
-
-    def test_xml_attribute_quoting_uses_single_quotes_when_value_contains_double_quotes(self):
-        s = 'Welcome to "my bar"'
-        self.assertEqual(self.sub.substitute_xml(s, True),
-                          "'Welcome to \"my bar\"'")
-
-    def test_xml_attribute_quoting_escapes_single_quotes_when_value_contains_both_single_and_double_quotes(self):
-        s = 'Welcome to "Bob\'s Bar"'
-        self.assertEqual(
-            self.sub.substitute_xml(s, True),
-            '"Welcome to &quot;Bob\'s Bar&quot;"')
-
-    def test_xml_quotes_arent_escaped_when_value_is_not_being_quoted(self):
-        quoted = 'Welcome to "Bob\'s Bar"'
-        self.assertEqual(self.sub.substitute_xml(quoted), quoted)
-
-    def test_xml_quoting_handles_angle_brackets(self):
-        self.assertEqual(
-            self.sub.substitute_xml("foo<bar>"),
-            "foo&lt;bar&gt;")
-
-    def test_xml_quoting_handles_ampersands(self):
-        self.assertEqual(self.sub.substitute_xml("AT&T"), "AT&amp;T")
-
-    def test_xml_quoting_including_ampersands_when_they_are_part_of_an_entity(self):
-        self.assertEqual(
-            self.sub.substitute_xml("&Aacute;T&T"),
-            "&amp;Aacute;T&amp;T")
-
-    def test_xml_quoting_ignoring_ampersands_when_they_are_part_of_an_entity(self):
-        self.assertEqual(
-            self.sub.substitute_xml_containing_entities("&Aacute;T&T"),
-            "&Aacute;T&amp;T")
-
-    def test_quotes_not_html_substituted(self):
-        """There's no need to do this except inside attribute values."""
-        text = 'Bob\'s "bar"'
-        self.assertEqual(self.sub.substitute_html(text), text)
-
-
-class TestEncodingConversion(SoupTest):
-    # Test Beautiful Soup's ability to decode and encode from various
-    # encodings.
-
-    def setUp(self):
-        super(TestEncodingConversion, self).setUp()
-        self.unicode_data = '<html><head><meta charset="utf-8"/></head><body><foo>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</foo></body></html>'
-        self.utf8_data = self.unicode_data.encode("utf-8")
-        # Just so you know what it looks like.
-        self.assertEqual(
-            self.utf8_data,
-            b'<html><head><meta charset="utf-8"/></head><body><foo>Sacr\xc3\xa9 bleu!</foo></body></html>')
-
-    def test_ascii_in_unicode_out(self):
-        # ASCII input is converted to Unicode. The original_encoding
-        # attribute is set to 'utf-8', a superset of ASCII.
-        chardet = bs4.dammit.chardet_dammit
-        logging.disable(logging.WARNING)
-        try:
-            def noop(str):
-                return None
-            # Disable chardet, which will realize that the ASCII is ASCII.
-            bs4.dammit.chardet_dammit = noop
-            ascii = b"<foo>a</foo>"
-            soup_from_ascii = self.soup(ascii)
-            unicode_output = soup_from_ascii.decode()
-            self.assertTrue(isinstance(unicode_output, str))
-            self.assertEqual(unicode_output, self.document_for(ascii.decode()))
-            self.assertEqual(soup_from_ascii.original_encoding.lower(), "utf-8")
-        finally:
-            logging.disable(logging.NOTSET)
-            bs4.dammit.chardet_dammit = chardet
-
-    def test_unicode_in_unicode_out(self):
-        # Unicode input is left alone. The original_encoding attribute
-        # is not set.
-        soup_from_unicode = self.soup(self.unicode_data)
-        self.assertEqual(soup_from_unicode.decode(), self.unicode_data)
-        self.assertEqual(soup_from_unicode.foo.string, 'Sacr\xe9 bleu!')
-        self.assertEqual(soup_from_unicode.original_encoding, None)
-
-    def test_utf8_in_unicode_out(self):
-        # UTF-8 input is converted to Unicode. The original_encoding
-        # attribute is set.
-        soup_from_utf8 = self.soup(self.utf8_data)
-        self.assertEqual(soup_from_utf8.decode(), self.unicode_data)
-        self.assertEqual(soup_from_utf8.foo.string, 'Sacr\xe9 bleu!')
-
-    def test_utf8_out(self):
-        # The internal data structures can be encoded as UTF-8.
-        soup_from_unicode = self.soup(self.unicode_data)
-        self.assertEqual(soup_from_unicode.encode('utf-8'), self.utf8_data)
-
-    @skipIf(
-        PYTHON_2_PRE_2_7 or PYTHON_3_PRE_3_2,
-        "Bad HTMLParser detected; skipping test of non-ASCII characters in attribute name.")
-    def test_attribute_name_containing_unicode_characters(self):
-        markup = '<div><a \N{SNOWMAN}="snowman"></a></div>'
-        self.assertEqual(self.soup(markup).div.encode("utf8"), markup.encode("utf8"))
-
-class TestUnicodeDammit(unittest.TestCase):
-    """Standalone tests of UnicodeDammit."""
-
-    def test_unicode_input(self):
-        markup = "I'm already Unicode! \N{SNOWMAN}"
-        dammit = UnicodeDammit(markup)
-        self.assertEqual(dammit.unicode_markup, markup)
-
-    def test_smart_quotes_to_unicode(self):
-        markup = b"<foo>\x91\x92\x93\x94</foo>"
-        dammit = UnicodeDammit(markup)
-        self.assertEqual(
-            dammit.unicode_markup, "<foo>\u2018\u2019\u201c\u201d</foo>")
-
-    def test_smart_quotes_to_xml_entities(self):
-        markup = b"<foo>\x91\x92\x93\x94</foo>"
-        dammit = UnicodeDammit(markup, smart_quotes_to="xml")
-        self.assertEqual(
-            dammit.unicode_markup, "<foo>&#x2018;&#x2019;&#x201C;&#x201D;</foo>")
-
-    def test_smart_quotes_to_html_entities(self):
-        markup = b"<foo>\x91\x92\x93\x94</foo>"
-        dammit = UnicodeDammit(markup, smart_quotes_to="html")
-        self.assertEqual(
-            dammit.unicode_markup, "<foo>&lsquo;&rsquo;&ldquo;&rdquo;</foo>")
-
-    def test_smart_quotes_to_ascii(self):
-        markup = b"<foo>\x91\x92\x93\x94</foo>"
-        dammit = UnicodeDammit(markup, smart_quotes_to="ascii")
-        self.assertEqual(
-            dammit.unicode_markup, """<foo>''""</foo>""")
-
-    def test_detect_utf8(self):
-        utf8 = b"Sacr\xc3\xa9 bleu! \xe2\x98\x83"
-        dammit = UnicodeDammit(utf8)
-        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
-        self.assertEqual(dammit.unicode_markup, 'Sacr\xe9 bleu! \N{SNOWMAN}')
-
-
-    def test_convert_hebrew(self):
-        hebrew = b"\xed\xe5\xec\xf9"
-        dammit = UnicodeDammit(hebrew, ["iso-8859-8"])
-        self.assertEqual(dammit.original_encoding.lower(), 'iso-8859-8')
-        self.assertEqual(dammit.unicode_markup, '\u05dd\u05d5\u05dc\u05e9')
-
-    def test_dont_see_smart_quotes_where_there_are_none(self):
-        utf_8 = b"\343\202\261\343\203\274\343\202\277\343\202\244 Watch"
-        dammit = UnicodeDammit(utf_8)
-        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
-        self.assertEqual(dammit.unicode_markup.encode("utf-8"), utf_8)
-
-    def test_ignore_inappropriate_codecs(self):
-        utf8_data = "Räksmörgås".encode("utf-8")
-        dammit = UnicodeDammit(utf8_data, ["iso-8859-8"])
-        self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
-
-    def test_ignore_invalid_codecs(self):
-        utf8_data = "Räksmörgås".encode("utf-8")
-        for bad_encoding in ['.utf8', '...', 'utF---16.!']:
-            dammit = UnicodeDammit(utf8_data, [bad_encoding])
-            self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
-
-    def test_exclude_encodings(self):
-        # This is UTF-8.
-        utf8_data = "Räksmörgås".encode("utf-8")
-
-        # But if we exclude UTF-8 from consideration, the guess is
-        # Windows-1252.
-        dammit = UnicodeDammit(utf8_data, exclude_encodings=["utf-8"])
-        self.assertEqual(dammit.original_encoding.lower(), 'windows-1252')
-
-        # And if we exclude that, there is no valid guess at all.
-        dammit = UnicodeDammit(
-            utf8_data, exclude_encodings=["utf-8", "windows-1252"])
-        self.assertEqual(dammit.original_encoding, None)
-
-    def test_encoding_detector_replaces_junk_in_encoding_name_with_replacement_character(self):
-        detected = EncodingDetector(
-            b'<?xml version="1.0" encoding="UTF-\xdb" ?>')
-        encodings = list(detected.encodings)
-        assert 'utf-\N{REPLACEMENT CHARACTER}' in encodings
-
-    def test_detect_html5_style_meta_tag(self):
-
-        for data in (
-            b'<html><meta charset="euc-jp" /></html>',
-            b"<html><meta charset='euc-jp' /></html>",
-            b"<html><meta charset=euc-jp /></html>",
-            b"<html><meta charset=euc-jp/></html>"):
-            dammit = UnicodeDammit(data, is_html=True)
-            self.assertEqual(
-                "euc-jp", dammit.original_encoding)
-
-    def test_last_ditch_entity_replacement(self):
-        # This is a UTF-8 document that contains bytestrings
-        # completely incompatible with UTF-8 (ie. encoded with some other
-        # encoding).
-        #
-        # Since there is no consistent encoding for the document,
-        # Unicode, Dammit will eventually encode the document as UTF-8
-        # and encode the incompatible characters as REPLACEMENT
-        # CHARACTER.
-        #
-        # If chardet is installed, it will detect that the document
-        # can be converted into ISO-8859-1 without errors. This happens
-        # to be the wrong encoding, but it is a consistent encoding, so the
-        # code we're testing here won't run.
-        #
-        # So we temporarily disable chardet if it's present.
-        doc = b"""\357\273\277<?xml version="1.0" encoding="UTF-8"?>
-<html><b>\330\250\330\252\330\261</b>
-<i>\310\322\321\220\312\321\355\344</i></html>"""
-        chardet = bs4.dammit.chardet_dammit
-        logging.disable(logging.WARNING)
-        try:
-            def noop(str):
-                return None
-            bs4.dammit.chardet_dammit = noop
-            dammit = UnicodeDammit(doc)
-            self.assertEqual(True, dammit.contains_replacement_characters)
-            self.assertTrue("\ufffd" in dammit.unicode_markup)
-
-            soup = BeautifulSoup(doc, "html.parser")
-            self.assertTrue(soup.contains_replacement_characters)
-        finally:
-            logging.disable(logging.NOTSET)
-            bs4.dammit.chardet_dammit = chardet
-
-    def test_byte_order_mark_removed(self):
-        # A document written in UTF-16LE will have its byte order marker stripped.
-        data = b'\xff\xfe<\x00a\x00>\x00\xe1\x00\xe9\x00<\x00/\x00a\x00>\x00'
-        dammit = UnicodeDammit(data)
-        self.assertEqual("<a>áé</a>", dammit.unicode_markup)
-        self.assertEqual("utf-16le", dammit.original_encoding)
-
-    def test_detwingle(self):
-        # Here's a UTF8 document.
-        utf8 = ("\N{SNOWMAN}" * 3).encode("utf8")
-
-        # Here's a Windows-1252 document.
-        windows_1252 = (
-            "\N{LEFT DOUBLE QUOTATION MARK}Hi, I like Windows!"
-            "\N{RIGHT DOUBLE QUOTATION MARK}").encode("windows_1252")
-
-        # Through some unholy alchemy, they've been stuck together.
-        doc = utf8 + windows_1252 + utf8
-
-        # The document can't be turned into UTF-8:
-        self.assertRaises(UnicodeDecodeError, doc.decode, "utf8")
-
-        # Unicode, Dammit thinks the whole document is Windows-1252,
-        # and decodes it into "â˜ƒâ˜ƒâ˜ƒ“Hi, I like Windows!”â˜ƒâ˜ƒâ˜ƒ"
-
-        # But if we run it through fix_embedded_windows_1252, it's fixed:
-
-        fixed = UnicodeDammit.detwingle(doc)
-        self.assertEqual(
-            "☃☃☃“Hi, I like Windows!”☃☃☃", fixed.decode("utf8"))
-
-    def test_detwingle_ignores_multibyte_characters(self):
-        # Each of these characters has a UTF-8 representation ending
-        # in \x93. \x93 is a smart quote if interpreted as
-        # Windows-1252. But our code knows to skip over multibyte
-        # UTF-8 characters, so they'll survive the process unscathed.
-        for tricky_unicode_char in (
-            "\N{LATIN SMALL LIGATURE OE}", # 2-byte char '\xc5\x93'
-            "\N{LATIN SUBSCRIPT SMALL LETTER X}", # 3-byte char '\xe2\x82\x93'
-            "\xf0\x90\x90\x93", # This is a CJK character, not sure which one.
-            ):
-            input = tricky_unicode_char.encode("utf8")
-            self.assertTrue(input.endswith(b'\x93'))
-            output = UnicodeDammit.detwingle(input)
-            self.assertEqual(output, input)
-
-class TestNamedspacedAttribute(SoupTest):
-
-    def test_name_may_be_none(self):
-        a = NamespacedAttribute("xmlns", None)
-        self.assertEqual(a, "xmlns")
-
-    def test_attribute_is_equivalent_to_colon_separated_string(self):
-        a = NamespacedAttribute("a", "b")
-        self.assertEqual("a:b", a)
-
-    def test_attributes_are_equivalent_if_prefix_and_name_identical(self):
-        a = NamespacedAttribute("a", "b", "c")
-        b = NamespacedAttribute("a", "b", "c")
-        self.assertEqual(a, b)
-
-        # The actual namespace is not considered.
-        c = NamespacedAttribute("a", "b", None)
-        self.assertEqual(a, c)
-
-        # But name and prefix are important.
-        d = NamespacedAttribute("a", "z", "c")
-        self.assertNotEqual(a, d)
-
-        e = NamespacedAttribute("z", "b", "c")
-        self.assertNotEqual(a, e)
-
-
-class TestAttributeValueWithCharsetSubstitution(unittest.TestCase):
-
-    def test_content_meta_attribute_value(self):
-        value = CharsetMetaAttributeValue("euc-jp")
-        self.assertEqual("euc-jp", value)
-        self.assertEqual("euc-jp", value.original_value)
-        self.assertEqual("utf8", value.encode("utf8"))
-
-
-    def test_content_meta_attribute_value(self):
-        value = ContentMetaAttributeValue("text/html; charset=euc-jp")
-        self.assertEqual("text/html; charset=euc-jp", value)
-        self.assertEqual("text/html; charset=euc-jp", value.original_value)
-        self.assertEqual("text/html; charset=utf8", value.encode("utf8"))
diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
deleted file mode 100644
index cf0f1abe0c..0000000000
--- a/lib/bs4/tests/test_tree.py
+++ /dev/null
@@ -1,2004 +0,0 @@
-# -*- coding: utf-8 -*-
-"""Tests for Beautiful Soup's tree traversal methods.
-
-The tree traversal methods are the main advantage of using Beautiful
-Soup over just using a parser.
-
-Different parsers will build different Beautiful Soup trees given the
-same markup, but all Beautiful Soup trees can be traversed with the
-methods tested here.
-"""
-
-import copy
-import pickle
-import re
-import warnings
-from bs4 import BeautifulSoup
-from bs4.builder import builder_registry
-from bs4.element import (
-    PY3K,
-    CData,
-    Comment,
-    Declaration,
-    Doctype,
-    NavigableString,
-    SoupStrainer,
-    Tag,
-)
-from bs4.testing import SoupTest
-
-XML_BUILDER_PRESENT = (builder_registry.lookup("xml") is not None)
-LXML_PRESENT = (builder_registry.lookup("lxml") is not None)
-
-class TreeTest(SoupTest):
-
-    def assertSelects(self, tags, should_match):
-        """Make sure that the given tags have the correct text.
-
-        This is used in tests that define a bunch of tags, each
-        containing a single string, and then select certain strings by
-        some mechanism.
-        """
-        self.assertEqual([tag.string for tag in tags], should_match)
-
-    def assertSelectsIDs(self, tags, should_match):
-        """Make sure that the given tags have the correct IDs.
-
-        This is used in tests that define a bunch of tags, each
-        containing a single string, and then select certain strings by
-        some mechanism.
-        """
-        self.assertEqual([tag['id'] for tag in tags], should_match)
-
-
-class TestFind(TreeTest):
-    """Basic tests of the find() method.
-
-    find() just calls find_all() with limit=1, so it's not tested all
-    that thouroughly here.
-    """
-
-    def test_find_tag(self):
-        soup = self.soup("<a>1</a><b>2</b><a>3</a><b>4</b>")
-        self.assertEqual(soup.find("b").string, "2")
-
-    def test_unicode_text_find(self):
-        soup = self.soup('<h1>Räksmörgås</h1>')
-        self.assertEqual(soup.find(string='Räksmörgås'), 'Räksmörgås')
-
-    def test_unicode_attribute_find(self):
-        soup = self.soup('<h1 id="Räksmörgås">here it is</h1>')
-        str(soup)
-        self.assertEqual("here it is", soup.find(id='Räksmörgås').text)
-
-
-    def test_find_everything(self):
-        """Test an optimization that finds all tags."""
-        soup = self.soup("<a>foo</a><b>bar</b>")
-        self.assertEqual(2, len(soup.find_all()))
-
-    def test_find_everything_with_name(self):
-        """Test an optimization that finds all tags with a given name."""
-        soup = self.soup("<a>foo</a><b>bar</b><a>baz</a>")
-        self.assertEqual(2, len(soup.find_all('a')))
-
-class TestFindAll(TreeTest):
-    """Basic tests of the find_all() method."""
-
-    def test_find_all_text_nodes(self):
-        """You can search the tree for text nodes."""
-        soup = self.soup("<html>Foo<b>bar</b>\xbb</html>")
-        # Exact match.
-        self.assertEqual(soup.find_all(string="bar"), ["bar"])
-        self.assertEqual(soup.find_all(text="bar"), ["bar"])
-        # Match any of a number of strings.
-        self.assertEqual(
-            soup.find_all(text=["Foo", "bar"]), ["Foo", "bar"])
-        # Match a regular expression.
-        self.assertEqual(soup.find_all(text=re.compile('.*')),
-                         ["Foo", "bar", '\xbb'])
-        # Match anything.
-        self.assertEqual(soup.find_all(text=True),
-                         ["Foo", "bar", '\xbb'])
-
-    def test_find_all_limit(self):
-        """You can limit the number of items returned by find_all."""
-        soup = self.soup("<a>1</a><a>2</a><a>3</a><a>4</a><a>5</a>")
-        self.assertSelects(soup.find_all('a', limit=3), ["1", "2", "3"])
-        self.assertSelects(soup.find_all('a', limit=1), ["1"])
-        self.assertSelects(
-            soup.find_all('a', limit=10), ["1", "2", "3", "4", "5"])
-
-        # A limit of 0 means no limit.
-        self.assertSelects(
-            soup.find_all('a', limit=0), ["1", "2", "3", "4", "5"])
-
-    def test_calling_a_tag_is_calling_findall(self):
-        soup = self.soup("<a>1</a><b>2<a id='foo'>3</a></b>")
-        self.assertSelects(soup('a', limit=1), ["1"])
-        self.assertSelects(soup.b(id="foo"), ["3"])
-
-    def test_find_all_with_self_referential_data_structure_does_not_cause_infinite_recursion(self):
-        soup = self.soup("<a></a>")
-        # Create a self-referential list.
-        l = []
-        l.append(l)
-
-        # Without special code in _normalize_search_value, this would cause infinite
-        # recursion.
-        self.assertEqual([], soup.find_all(l))
-
-    def test_find_all_resultset(self):
-        """All find_all calls return a ResultSet"""
-        soup = self.soup("<a></a>")
-        result = soup.find_all("a")
-        self.assertTrue(hasattr(result, "source"))
-
-        result = soup.find_all(True)
-        self.assertTrue(hasattr(result, "source"))
-
-        result = soup.find_all(text="foo")
-        self.assertTrue(hasattr(result, "source"))
-
-
-class TestFindAllBasicNamespaces(TreeTest):
-
-    def test_find_by_namespaced_name(self):
-        soup = self.soup('<mathml:msqrt>4</mathml:msqrt><a svg:fill="red">')
-        self.assertEqual("4", soup.find("mathml:msqrt").string)
-        self.assertEqual("a", soup.find(attrs= { "svg:fill" : "red" }).name)
-
-
-class TestFindAllByName(TreeTest):
-    """Test ways of finding tags by tag name."""
-
-    def setUp(self):
-        super(TreeTest, self).setUp()
-        self.tree =  self.soup("""<a>First tag.</a>
-                                  <b>Second tag.</b>
-                                  <c>Third <a>Nested tag.</a> tag.</c>""")
-
-    def test_find_all_by_tag_name(self):
-        # Find all the <a> tags.
-        self.assertSelects(
-            self.tree.find_all('a'), ['First tag.', 'Nested tag.'])
-
-    def test_find_all_by_name_and_text(self):
-        self.assertSelects(
-            self.tree.find_all('a', text='First tag.'), ['First tag.'])
-
-        self.assertSelects(
-            self.tree.find_all('a', text=True), ['First tag.', 'Nested tag.'])
-
-        self.assertSelects(
-            self.tree.find_all('a', text=re.compile("tag")),
-            ['First tag.', 'Nested tag.'])
-
-
-    def test_find_all_on_non_root_element(self):
-        # You can call find_all on any node, not just the root.
-        self.assertSelects(self.tree.c.find_all('a'), ['Nested tag.'])
-
-    def test_calling_element_invokes_find_all(self):
-        self.assertSelects(self.tree('a'), ['First tag.', 'Nested tag.'])
-
-    def test_find_all_by_tag_strainer(self):
-        self.assertSelects(
-            self.tree.find_all(SoupStrainer('a')),
-            ['First tag.', 'Nested tag.'])
-
-    def test_find_all_by_tag_names(self):
-        self.assertSelects(
-            self.tree.find_all(['a', 'b']),
-            ['First tag.', 'Second tag.', 'Nested tag.'])
-
-    def test_find_all_by_tag_dict(self):
-        self.assertSelects(
-            self.tree.find_all({'a' : True, 'b' : True}),
-            ['First tag.', 'Second tag.', 'Nested tag.'])
-
-    def test_find_all_by_tag_re(self):
-        self.assertSelects(
-            self.tree.find_all(re.compile('^[ab]$')),
-            ['First tag.', 'Second tag.', 'Nested tag.'])
-
-    def test_find_all_with_tags_matching_method(self):
-        # You can define an oracle method that determines whether
-        # a tag matches the search.
-        def id_matches_name(tag):
-            return tag.name == tag.get('id')
-
-        tree = self.soup("""<a id="a">Match 1.</a>
-                            <a id="1">Does not match.</a>
-                            <b id="b">Match 2.</a>""")
-
-        self.assertSelects(
-            tree.find_all(id_matches_name), ["Match 1.", "Match 2."])
-
-
-class TestFindAllByAttribute(TreeTest):
-
-    def test_find_all_by_attribute_name(self):
-        # You can pass in keyword arguments to find_all to search by
-        # attribute.
-        tree = self.soup("""
-                         <a id="first">Matching a.</a>
-                         <a id="second">
-                          Non-matching <b id="first">Matching b.</b>a.
-                         </a>""")
-        self.assertSelects(tree.find_all(id='first'),
-                           ["Matching a.", "Matching b."])
-
-    def test_find_all_by_utf8_attribute_value(self):
-        peace = "םולש".encode("utf8")
-        data = '<a title="םולש"></a>'.encode("utf8")
-        soup = self.soup(data)
-        self.assertEqual([soup.a], soup.find_all(title=peace))
-        self.assertEqual([soup.a], soup.find_all(title=peace.decode("utf8")))
-        self.assertEqual([soup.a], soup.find_all(title=[peace, "something else"]))
-
-    def test_find_all_by_attribute_dict(self):
-        # You can pass in a dictionary as the argument 'attrs'. This
-        # lets you search for attributes like 'name' (a fixed argument
-        # to find_all) and 'class' (a reserved word in Python.)
-        tree = self.soup("""
-                         <a name="name1" class="class1">Name match.</a>
-                         <a name="name2" class="class2">Class match.</a>
-                         <a name="name3" class="class3">Non-match.</a>
-                         <name1>A tag called 'name1'.</name1>
-                         """)
-
-        # This doesn't do what you want.
-        self.assertSelects(tree.find_all(name='name1'),
-                           ["A tag called 'name1'."])
-        # This does what you want.
-        self.assertSelects(tree.find_all(attrs={'name' : 'name1'}),
-                           ["Name match."])
-
-        self.assertSelects(tree.find_all(attrs={'class' : 'class2'}),
-                           ["Class match."])
-
-    def test_find_all_by_class(self):
-        tree = self.soup("""
-                         <a class="1">Class 1.</a>
-                         <a class="2">Class 2.</a>
-                         <b class="1">Class 1.</b>
-                         <c class="3 4">Class 3 and 4.</c>
-                         """)
-
-        # Passing in the class_ keyword argument will search against
-        # the 'class' attribute.
-        self.assertSelects(tree.find_all('a', class_='1'), ['Class 1.'])
-        self.assertSelects(tree.find_all('c', class_='3'), ['Class 3 and 4.'])
-        self.assertSelects(tree.find_all('c', class_='4'), ['Class 3 and 4.'])
-
-        # Passing in a string to 'attrs' will also search the CSS class.
-        self.assertSelects(tree.find_all('a', '1'), ['Class 1.'])
-        self.assertSelects(tree.find_all(attrs='1'), ['Class 1.', 'Class 1.'])
-        self.assertSelects(tree.find_all('c', '3'), ['Class 3 and 4.'])
-        self.assertSelects(tree.find_all('c', '4'), ['Class 3 and 4.'])
-
-    def test_find_by_class_when_multiple_classes_present(self):
-        tree = self.soup("<gar class='foo bar'>Found it</gar>")
-
-        f = tree.find_all("gar", class_=re.compile("o"))
-        self.assertSelects(f, ["Found it"])
-
-        f = tree.find_all("gar", class_=re.compile("a"))
-        self.assertSelects(f, ["Found it"])
-
-        # Since the class is not the string "foo bar", but the two
-        # strings "foo" and "bar", this will not find anything.
-        f = tree.find_all("gar", class_=re.compile("o b"))
-        self.assertSelects(f, [])
-
-    def test_find_all_with_non_dictionary_for_attrs_finds_by_class(self):
-        soup = self.soup("<a class='bar'>Found it</a>")
-
-        self.assertSelects(soup.find_all("a", re.compile("ba")), ["Found it"])
-
-        def big_attribute_value(value):
-            return len(value) > 3
-
-        self.assertSelects(soup.find_all("a", big_attribute_value), [])
-
-        def small_attribute_value(value):
-            return len(value) <= 3
-
-        self.assertSelects(
-            soup.find_all("a", small_attribute_value), ["Found it"])
-
-    def test_find_all_with_string_for_attrs_finds_multiple_classes(self):
-        soup = self.soup('<a class="foo bar"></a><a class="foo"></a>')
-        a, a2 = soup.find_all("a")
-        self.assertEqual([a, a2], soup.find_all("a", "foo"))
-        self.assertEqual([a], soup.find_all("a", "bar"))
-
-        # If you specify the class as a string that contains a
-        # space, only that specific value will be found.
-        self.assertEqual([a], soup.find_all("a", class_="foo bar"))
-        self.assertEqual([a], soup.find_all("a", "foo bar"))
-        self.assertEqual([], soup.find_all("a", "bar foo"))
-
-    def test_find_all_by_attribute_soupstrainer(self):
-        tree = self.soup("""
-                         <a id="first">Match.</a>
-                         <a id="second">Non-match.</a>""")
-
-        strainer = SoupStrainer(attrs={'id' : 'first'})
-        self.assertSelects(tree.find_all(strainer), ['Match.'])
-
-    def test_find_all_with_missing_atribute(self):
-        # You can pass in None as the value of an attribute to find_all.
-        # This will match tags that do not have that attribute set.
-        tree = self.soup("""<a id="1">ID present.</a>
-                            <a>No ID present.</a>
-                            <a id="">ID is empty.</a>""")
-        self.assertSelects(tree.find_all('a', id=None), ["No ID present."])
-
-    def test_find_all_with_defined_attribute(self):
-        # You can pass in None as the value of an attribute to find_all.
-        # This will match tags that have that attribute set to any value.
-        tree = self.soup("""<a id="1">ID present.</a>
-                            <a>No ID present.</a>
-                            <a id="">ID is empty.</a>""")
-        self.assertSelects(
-            tree.find_all(id=True), ["ID present.", "ID is empty."])
-
-    def test_find_all_with_numeric_attribute(self):
-        # If you search for a number, it's treated as a string.
-        tree = self.soup("""<a id=1>Unquoted attribute.</a>
-                            <a id="1">Quoted attribute.</a>""")
-
-        expected = ["Unquoted attribute.", "Quoted attribute."]
-        self.assertSelects(tree.find_all(id=1), expected)
-        self.assertSelects(tree.find_all(id="1"), expected)
-
-    def test_find_all_with_list_attribute_values(self):
-        # You can pass a list of attribute values instead of just one,
-        # and you'll get tags that match any of the values.
-        tree = self.soup("""<a id="1">1</a>
-                            <a id="2">2</a>
-                            <a id="3">3</a>
-                            <a>No ID.</a>""")
-        self.assertSelects(tree.find_all(id=["1", "3", "4"]),
-                           ["1", "3"])
-
-    def test_find_all_with_regular_expression_attribute_value(self):
-        # You can pass a regular expression as an attribute value, and
-        # you'll get tags whose values for that attribute match the
-        # regular expression.
-        tree = self.soup("""<a id="a">One a.</a>
-                            <a id="aa">Two as.</a>
-                            <a id="ab">Mixed as and bs.</a>
-                            <a id="b">One b.</a>
-                            <a>No ID.</a>""")
-
-        self.assertSelects(tree.find_all(id=re.compile("^a+$")),
-                           ["One a.", "Two as."])
-
-    def test_find_by_name_and_containing_string(self):
-        soup = self.soup("<b>foo</b><b>bar</b><a>foo</a>")
-        a = soup.a
-
-        self.assertEqual([a], soup.find_all("a", text="foo"))
-        self.assertEqual([], soup.find_all("a", text="bar"))
-        self.assertEqual([], soup.find_all("a", text="bar"))
-
-    def test_find_by_name_and_containing_string_when_string_is_buried(self):
-        soup = self.soup("<a>foo</a><a><b><c>foo</c></b></a>")
-        self.assertEqual(soup.find_all("a"), soup.find_all("a", text="foo"))
-
-    def test_find_by_attribute_and_containing_string(self):
-        soup = self.soup('<b id="1">foo</b><a id="2">foo</a>')
-        a = soup.a
-
-        self.assertEqual([a], soup.find_all(id=2, text="foo"))
-        self.assertEqual([], soup.find_all(id=1, text="bar"))
-
-
-
-
-class TestIndex(TreeTest):
-    """Test Tag.index"""
-    def test_index(self):
-        tree = self.soup("""<div>
-                            <a>Identical</a>
-                            <b>Not identical</b>
-                            <a>Identical</a>
-
-                            <c><d>Identical with child</d></c>
-                            <b>Also not identical</b>
-                            <c><d>Identical with child</d></c>
-                            </div>""")
-        div = tree.div
-        for i, element in enumerate(div.contents):
-            self.assertEqual(i, div.index(element))
-        self.assertRaises(ValueError, tree.index, 1)
-
-
-class TestParentOperations(TreeTest):
-    """Test navigation and searching through an element's parents."""
-
-    def setUp(self):
-        super(TestParentOperations, self).setUp()
-        self.tree = self.soup('''<ul id="empty"></ul>
-                                 <ul id="top">
-                                  <ul id="middle">
-                                   <ul id="bottom">
-                                    <b>Start here</b>
-                                   </ul>
-                                  </ul>''')
-        self.start = self.tree.b
-
-
-    def test_parent(self):
-        self.assertEqual(self.start.parent['id'], 'bottom')
-        self.assertEqual(self.start.parent.parent['id'], 'middle')
-        self.assertEqual(self.start.parent.parent.parent['id'], 'top')
-
-    def test_parent_of_top_tag_is_soup_object(self):
-        top_tag = self.tree.contents[0]
-        self.assertEqual(top_tag.parent, self.tree)
-
-    def test_soup_object_has_no_parent(self):
-        self.assertEqual(None, self.tree.parent)
-
-    def test_find_parents(self):
-        self.assertSelectsIDs(
-            self.start.find_parents('ul'), ['bottom', 'middle', 'top'])
-        self.assertSelectsIDs(
-            self.start.find_parents('ul', id="middle"), ['middle'])
-
-    def test_find_parent(self):
-        self.assertEqual(self.start.find_parent('ul')['id'], 'bottom')
-        self.assertEqual(self.start.find_parent('ul', id='top')['id'], 'top')
-
-    def test_parent_of_text_element(self):
-        text = self.tree.find(text="Start here")
-        self.assertEqual(text.parent.name, 'b')
-
-    def test_text_element_find_parent(self):
-        text = self.tree.find(text="Start here")
-        self.assertEqual(text.find_parent('ul')['id'], 'bottom')
-
-    def test_parent_generator(self):
-        parents = [parent['id'] for parent in self.start.parents
-                   if parent is not None and 'id' in parent.attrs]
-        self.assertEqual(parents, ['bottom', 'middle', 'top'])
-
-
-class ProximityTest(TreeTest):
-
-    def setUp(self):
-        super(TreeTest, self).setUp()
-        self.tree = self.soup(
-            '<html id="start"><head></head><body><b id="1">One</b><b id="2">Two</b><b id="3">Three</b></body></html>')
-
-
-class TestNextOperations(ProximityTest):
-
-    def setUp(self):
-        super(TestNextOperations, self).setUp()
-        self.start = self.tree.b
-
-    def test_next(self):
-        self.assertEqual(self.start.next_element, "One")
-        self.assertEqual(self.start.next_element.next_element['id'], "2")
-
-    def test_next_of_last_item_is_none(self):
-        last = self.tree.find(text="Three")
-        self.assertEqual(last.next_element, None)
-
-    def test_next_of_root_is_none(self):
-        # The document root is outside the next/previous chain.
-        self.assertEqual(self.tree.next_element, None)
-
-    def test_find_all_next(self):
-        self.assertSelects(self.start.find_all_next('b'), ["Two", "Three"])
-        self.start.find_all_next(id=3)
-        self.assertSelects(self.start.find_all_next(id=3), ["Three"])
-
-    def test_find_next(self):
-        self.assertEqual(self.start.find_next('b')['id'], '2')
-        self.assertEqual(self.start.find_next(text="Three"), "Three")
-
-    def test_find_next_for_text_element(self):
-        text = self.tree.find(text="One")
-        self.assertEqual(text.find_next("b").string, "Two")
-        self.assertSelects(text.find_all_next("b"), ["Two", "Three"])
-
-    def test_next_generator(self):
-        start = self.tree.find(text="Two")
-        successors = [node for node in start.next_elements]
-        # There are two successors: the final <b> tag and its text contents.
-        tag, contents = successors
-        self.assertEqual(tag['id'], '3')
-        self.assertEqual(contents, "Three")
-
-class TestPreviousOperations(ProximityTest):
-
-    def setUp(self):
-        super(TestPreviousOperations, self).setUp()
-        self.end = self.tree.find(text="Three")
-
-    def test_previous(self):
-        self.assertEqual(self.end.previous_element['id'], "3")
-        self.assertEqual(self.end.previous_element.previous_element, "Two")
-
-    def test_previous_of_first_item_is_none(self):
-        first = self.tree.find('html')
-        self.assertEqual(first.previous_element, None)
-
-    def test_previous_of_root_is_none(self):
-        # The document root is outside the next/previous chain.
-        # XXX This is broken!
-        #self.assertEqual(self.tree.previous_element, None)
-        pass
-
-    def test_find_all_previous(self):
-        # The <b> tag containing the "Three" node is the predecessor
-        # of the "Three" node itself, which is why "Three" shows up
-        # here.
-        self.assertSelects(
-            self.end.find_all_previous('b'), ["Three", "Two", "One"])
-        self.assertSelects(self.end.find_all_previous(id=1), ["One"])
-
-    def test_find_previous(self):
-        self.assertEqual(self.end.find_previous('b')['id'], '3')
-        self.assertEqual(self.end.find_previous(text="One"), "One")
-
-    def test_find_previous_for_text_element(self):
-        text = self.tree.find(text="Three")
-        self.assertEqual(text.find_previous("b").string, "Three")
-        self.assertSelects(
-            text.find_all_previous("b"), ["Three", "Two", "One"])
-
-    def test_previous_generator(self):
-        start = self.tree.find(text="One")
-        predecessors = [node for node in start.previous_elements]
-
-        # There are four predecessors: the <b> tag containing "One"
-        # the <body> tag, the <head> tag, and the <html> tag.
-        b, body, head, html = predecessors
-        self.assertEqual(b['id'], '1')
-        self.assertEqual(body.name, "body")
-        self.assertEqual(head.name, "head")
-        self.assertEqual(html.name, "html")
-
-
-class SiblingTest(TreeTest):
-
-    def setUp(self):
-        super(SiblingTest, self).setUp()
-        markup = '''<html>
-                    <span id="1">
-                     <span id="1.1"></span>
-                    </span>
-                    <span id="2">
-                     <span id="2.1"></span>
-                    </span>
-                    <span id="3">
-                     <span id="3.1"></span>
-                    </span>
-                    <span id="4"></span>
-                    </html>'''
-        # All that whitespace looks good but makes the tests more
-        # difficult. Get rid of it.
-        markup = re.compile(r"\n\s*").sub("", markup)
-        self.tree = self.soup(markup)
-
-
-class TestNextSibling(SiblingTest):
-
-    def setUp(self):
-        super(TestNextSibling, self).setUp()
-        self.start = self.tree.find(id="1")
-
-    def test_next_sibling_of_root_is_none(self):
-        self.assertEqual(self.tree.next_sibling, None)
-
-    def test_next_sibling(self):
-        self.assertEqual(self.start.next_sibling['id'], '2')
-        self.assertEqual(self.start.next_sibling.next_sibling['id'], '3')
-
-        # Note the difference between next_sibling and next_element.
-        self.assertEqual(self.start.next_element['id'], '1.1')
-
-    def test_next_sibling_may_not_exist(self):
-        self.assertEqual(self.tree.html.next_sibling, None)
-
-        nested_span = self.tree.find(id="1.1")
-        self.assertEqual(nested_span.next_sibling, None)
-
-        last_span = self.tree.find(id="4")
-        self.assertEqual(last_span.next_sibling, None)
-
-    def test_find_next_sibling(self):
-        self.assertEqual(self.start.find_next_sibling('span')['id'], '2')
-
-    def test_next_siblings(self):
-        self.assertSelectsIDs(self.start.find_next_siblings("span"),
-                              ['2', '3', '4'])
-
-        self.assertSelectsIDs(self.start.find_next_siblings(id='3'), ['3'])
-
-    def test_next_sibling_for_text_element(self):
-        soup = self.soup("Foo<b>bar</b>baz")
-        start = soup.find(text="Foo")
-        self.assertEqual(start.next_sibling.name, 'b')
-        self.assertEqual(start.next_sibling.next_sibling, 'baz')
-
-        self.assertSelects(start.find_next_siblings('b'), ['bar'])
-        self.assertEqual(start.find_next_sibling(text="baz"), "baz")
-        self.assertEqual(start.find_next_sibling(text="nonesuch"), None)
-
-
-class TestPreviousSibling(SiblingTest):
-
-    def setUp(self):
-        super(TestPreviousSibling, self).setUp()
-        self.end = self.tree.find(id="4")
-
-    def test_previous_sibling_of_root_is_none(self):
-        self.assertEqual(self.tree.previous_sibling, None)
-
-    def test_previous_sibling(self):
-        self.assertEqual(self.end.previous_sibling['id'], '3')
-        self.assertEqual(self.end.previous_sibling.previous_sibling['id'], '2')
-
-        # Note the difference between previous_sibling and previous_element.
-        self.assertEqual(self.end.previous_element['id'], '3.1')
-
-    def test_previous_sibling_may_not_exist(self):
-        self.assertEqual(self.tree.html.previous_sibling, None)
-
-        nested_span = self.tree.find(id="1.1")
-        self.assertEqual(nested_span.previous_sibling, None)
-
-        first_span = self.tree.find(id="1")
-        self.assertEqual(first_span.previous_sibling, None)
-
-    def test_find_previous_sibling(self):
-        self.assertEqual(self.end.find_previous_sibling('span')['id'], '3')
-
-    def test_previous_siblings(self):
-        self.assertSelectsIDs(self.end.find_previous_siblings("span"),
-                              ['3', '2', '1'])
-
-        self.assertSelectsIDs(self.end.find_previous_siblings(id='1'), ['1'])
-
-    def test_previous_sibling_for_text_element(self):
-        soup = self.soup("Foo<b>bar</b>baz")
-        start = soup.find(text="baz")
-        self.assertEqual(start.previous_sibling.name, 'b')
-        self.assertEqual(start.previous_sibling.previous_sibling, 'Foo')
-
-        self.assertSelects(start.find_previous_siblings('b'), ['bar'])
-        self.assertEqual(start.find_previous_sibling(text="Foo"), "Foo")
-        self.assertEqual(start.find_previous_sibling(text="nonesuch"), None)
-
-
-class TestTagCreation(SoupTest):
-    """Test the ability to create new tags."""
-    def test_new_tag(self):
-        soup = self.soup("")
-        new_tag = soup.new_tag("foo", bar="baz")
-        self.assertTrue(isinstance(new_tag, Tag))
-        self.assertEqual("foo", new_tag.name)
-        self.assertEqual(dict(bar="baz"), new_tag.attrs)
-        self.assertEqual(None, new_tag.parent)
-
-    def test_tag_inherits_self_closing_rules_from_builder(self):
-        if XML_BUILDER_PRESENT:
-            xml_soup = BeautifulSoup("", "lxml-xml")
-            xml_br = xml_soup.new_tag("br")
-            xml_p = xml_soup.new_tag("p")
-
-            # Both the <br> and <p> tag are empty-element, just because
-            # they have no contents.
-            self.assertEqual(b"<br/>", xml_br.encode())
-            self.assertEqual(b"<p/>", xml_p.encode())
-
-        html_soup = BeautifulSoup("", "html.parser")
-        html_br = html_soup.new_tag("br")
-        html_p = html_soup.new_tag("p")
-
-        # The HTML builder users HTML's rules about which tags are
-        # empty-element tags, and the new tags reflect these rules.
-        self.assertEqual(b"<br/>", html_br.encode())
-        self.assertEqual(b"<p></p>", html_p.encode())
-
-    def test_new_string_creates_navigablestring(self):
-        soup = self.soup("")
-        s = soup.new_string("foo")
-        self.assertEqual("foo", s)
-        self.assertTrue(isinstance(s, NavigableString))
-
-    def test_new_string_can_create_navigablestring_subclass(self):
-        soup = self.soup("")
-        s = soup.new_string("foo", Comment)
-        self.assertEqual("foo", s)
-        self.assertTrue(isinstance(s, Comment))
-
-class TestTreeModification(SoupTest):
-
-    def test_attribute_modification(self):
-        soup = self.soup('<a id="1"></a>')
-        soup.a['id'] = 2
-        self.assertEqual(soup.decode(), self.document_for('<a id="2"></a>'))
-        del(soup.a['id'])
-        self.assertEqual(soup.decode(), self.document_for('<a></a>'))
-        soup.a['id2'] = 'foo'
-        self.assertEqual(soup.decode(), self.document_for('<a id2="foo"></a>'))
-
-    def test_new_tag_creation(self):
-        builder = builder_registry.lookup('html')()
-        soup = self.soup("<body></body>", builder=builder)
-        a = Tag(soup, builder, 'a')
-        ol = Tag(soup, builder, 'ol')
-        a['href'] = 'http://foo.com/'
-        soup.body.insert(0, a)
-        soup.body.insert(1, ol)
-        self.assertEqual(
-            soup.body.encode(),
-            b'<body><a href="http://foo.com/"></a><ol></ol></body>')
-
-    def test_append_to_contents_moves_tag(self):
-        doc = """<p id="1">Don't leave me <b>here</b>.</p>
-                <p id="2">Don\'t leave!</p>"""
-        soup = self.soup(doc)
-        second_para = soup.find(id='2')
-        bold = soup.b
-
-        # Move the <b> tag to the end of the second paragraph.
-        soup.find(id='2').append(soup.b)
-
-        # The <b> tag is now a child of the second paragraph.
-        self.assertEqual(bold.parent, second_para)
-
-        self.assertEqual(
-            soup.decode(), self.document_for(
-                '<p id="1">Don\'t leave me .</p>\n'
-                '<p id="2">Don\'t leave!<b>here</b></p>'))
-
-    def test_replace_with_returns_thing_that_was_replaced(self):
-        text = "<a></a><b><c></c></b>"
-        soup = self.soup(text)
-        a = soup.a
-        new_a = a.replace_with(soup.c)
-        self.assertEqual(a, new_a)
-
-    def test_unwrap_returns_thing_that_was_replaced(self):
-        text = "<a><b></b><c></c></a>"
-        soup = self.soup(text)
-        a = soup.a
-        new_a = a.unwrap()
-        self.assertEqual(a, new_a)
-
-    def test_replace_with_and_unwrap_give_useful_exception_when_tag_has_no_parent(self):
-        soup = self.soup("<a><b>Foo</b></a><c>Bar</c>")
-        a = soup.a
-        a.extract()
-        self.assertEqual(None, a.parent)
-        self.assertRaises(ValueError, a.unwrap)
-        self.assertRaises(ValueError, a.replace_with, soup.c)
-
-    def test_replace_tag_with_itself(self):
-        text = "<a><b></b><c>Foo<d></d></c></a><a><e></e></a>"
-        soup = self.soup(text)
-        c = soup.c
-        soup.c.replace_with(c)
-        self.assertEqual(soup.decode(), self.document_for(text))
-
-    def test_replace_tag_with_its_parent_raises_exception(self):
-        text = "<a><b></b></a>"
-        soup = self.soup(text)
-        self.assertRaises(ValueError, soup.b.replace_with, soup.a)
-
-    def test_insert_tag_into_itself_raises_exception(self):
-        text = "<a><b></b></a>"
-        soup = self.soup(text)
-        self.assertRaises(ValueError, soup.a.insert, 0, soup.a)
-
-    def test_replace_with_maintains_next_element_throughout(self):
-        soup = self.soup('<p><a>one</a><b>three</b></p>')
-        a = soup.a
-        b = a.contents[0]
-        # Make it so the <a> tag has two text children.
-        a.insert(1, "two")
-
-        # Now replace each one with the empty string.
-        left, right = a.contents
-        left.replaceWith('')
-        right.replaceWith('')
-
-        # The <b> tag is still connected to the tree.
-        self.assertEqual("three", soup.b.string)
-
-    def test_replace_final_node(self):
-        soup = self.soup("<b>Argh!</b>")
-        soup.find(text="Argh!").replace_with("Hooray!")
-        new_text = soup.find(text="Hooray!")
-        b = soup.b
-        self.assertEqual(new_text.previous_element, b)
-        self.assertEqual(new_text.parent, b)
-        self.assertEqual(new_text.previous_element.next_element, new_text)
-        self.assertEqual(new_text.next_element, None)
-
-    def test_consecutive_text_nodes(self):
-        # A builder should never create two consecutive text nodes,
-        # but if you insert one next to another, Beautiful Soup will
-        # handle it correctly.
-        soup = self.soup("<a><b>Argh!</b><c></c></a>")
-        soup.b.insert(1, "Hooray!")
-
-        self.assertEqual(
-            soup.decode(), self.document_for(
-                "<a><b>Argh!Hooray!</b><c></c></a>"))
-
-        new_text = soup.find(text="Hooray!")
-        self.assertEqual(new_text.previous_element, "Argh!")
-        self.assertEqual(new_text.previous_element.next_element, new_text)
-
-        self.assertEqual(new_text.previous_sibling, "Argh!")
-        self.assertEqual(new_text.previous_sibling.next_sibling, new_text)
-
-        self.assertEqual(new_text.next_sibling, None)
-        self.assertEqual(new_text.next_element, soup.c)
-
-    def test_insert_string(self):
-        soup = self.soup("<a></a>")
-        soup.a.insert(0, "bar")
-        soup.a.insert(0, "foo")
-        # The string were added to the tag.
-        self.assertEqual(["foo", "bar"], soup.a.contents)
-        # And they were converted to NavigableStrings.
-        self.assertEqual(soup.a.contents[0].next_element, "bar")
-
-    def test_insert_tag(self):
-        builder = self.default_builder
-        soup = self.soup(
-            "<a><b>Find</b><c>lady!</c><d></d></a>", builder=builder)
-        magic_tag = Tag(soup, builder, 'magictag')
-        magic_tag.insert(0, "the")
-        soup.a.insert(1, magic_tag)
-
-        self.assertEqual(
-            soup.decode(), self.document_for(
-                "<a><b>Find</b><magictag>the</magictag><c>lady!</c><d></d></a>"))
-
-        # Make sure all the relationships are hooked up correctly.
-        b_tag = soup.b
-        self.assertEqual(b_tag.next_sibling, magic_tag)
-        self.assertEqual(magic_tag.previous_sibling, b_tag)
-
-        find = b_tag.find(text="Find")
-        self.assertEqual(find.next_element, magic_tag)
-        self.assertEqual(magic_tag.previous_element, find)
-
-        c_tag = soup.c
-        self.assertEqual(magic_tag.next_sibling, c_tag)
-        self.assertEqual(c_tag.previous_sibling, magic_tag)
-
-        the = magic_tag.find(text="the")
-        self.assertEqual(the.parent, magic_tag)
-        self.assertEqual(the.next_element, c_tag)
-        self.assertEqual(c_tag.previous_element, the)
-
-    def test_append_child_thats_already_at_the_end(self):
-        data = "<a><b></b></a>"
-        soup = self.soup(data)
-        soup.a.append(soup.b)
-        self.assertEqual(data, soup.decode())
-
-    def test_move_tag_to_beginning_of_parent(self):
-        data = "<a><b></b><c></c><d></d></a>"
-        soup = self.soup(data)
-        soup.a.insert(0, soup.d)
-        self.assertEqual("<a><d></d><b></b><c></c></a>", soup.decode())
-
-    def test_insert_works_on_empty_element_tag(self):
-        # This is a little strange, since most HTML parsers don't allow
-        # markup like this to come through. But in general, we don't
-        # know what the parser would or wouldn't have allowed, so
-        # I'm letting this succeed for now.
-        soup = self.soup("<br/>")
-        soup.br.insert(1, "Contents")
-        self.assertEqual(str(soup.br), "<br>Contents</br>")
-
-    def test_insert_before(self):
-        soup = self.soup("<a>foo</a><b>bar</b>")
-        soup.b.insert_before("BAZ")
-        soup.a.insert_before("QUUX")
-        self.assertEqual(
-            soup.decode(), self.document_for("QUUX<a>foo</a>BAZ<b>bar</b>"))
-
-        soup.a.insert_before(soup.b)
-        self.assertEqual(
-            soup.decode(), self.document_for("QUUX<b>bar</b><a>foo</a>BAZ"))
-
-    def test_insert_after(self):
-        soup = self.soup("<a>foo</a><b>bar</b>")
-        soup.b.insert_after("BAZ")
-        soup.a.insert_after("QUUX")
-        self.assertEqual(
-            soup.decode(), self.document_for("<a>foo</a>QUUX<b>bar</b>BAZ"))
-        soup.b.insert_after(soup.a)
-        self.assertEqual(
-            soup.decode(), self.document_for("QUUX<b>bar</b><a>foo</a>BAZ"))
-
-    def test_insert_after_raises_exception_if_after_has_no_meaning(self):
-        soup = self.soup("")
-        tag = soup.new_tag("a")
-        string = soup.new_string("")
-        self.assertRaises(ValueError, string.insert_after, tag)
-        self.assertRaises(NotImplementedError, soup.insert_after, tag)
-        self.assertRaises(ValueError, tag.insert_after, tag)
-
-    def test_insert_before_raises_notimplementederror_if_before_has_no_meaning(self):
-        soup = self.soup("")
-        tag = soup.new_tag("a")
-        string = soup.new_string("")
-        self.assertRaises(ValueError, string.insert_before, tag)
-        self.assertRaises(NotImplementedError, soup.insert_before, tag)
-        self.assertRaises(ValueError, tag.insert_before, tag)
-
-    def test_replace_with(self):
-        soup = self.soup(
-                "<p>There's <b>no</b> business like <b>show</b> business</p>")
-        no, show = soup.find_all('b')
-        show.replace_with(no)
-        self.assertEqual(
-            soup.decode(),
-            self.document_for(
-                "<p>There's  business like <b>no</b> business</p>"))
-
-        self.assertEqual(show.parent, None)
-        self.assertEqual(no.parent, soup.p)
-        self.assertEqual(no.next_element, "no")
-        self.assertEqual(no.next_sibling, " business")
-
-    def test_replace_first_child(self):
-        data = "<a><b></b><c></c></a>"
-        soup = self.soup(data)
-        soup.b.replace_with(soup.c)
-        self.assertEqual("<a><c></c></a>", soup.decode())
-
-    def test_replace_last_child(self):
-        data = "<a><b></b><c></c></a>"
-        soup = self.soup(data)
-        soup.c.replace_with(soup.b)
-        self.assertEqual("<a><b></b></a>", soup.decode())
-
-    def test_nested_tag_replace_with(self):
-        soup = self.soup(
-            """<a>We<b>reserve<c>the</c><d>right</d></b></a><e>to<f>refuse</f><g>service</g></e>""")
-
-        # Replace the entire <b> tag and its contents ("reserve the
-        # right") with the <f> tag ("refuse").
-        remove_tag = soup.b
-        move_tag = soup.f
-        remove_tag.replace_with(move_tag)
-
-        self.assertEqual(
-            soup.decode(), self.document_for(
-                "<a>We<f>refuse</f></a><e>to<g>service</g></e>"))
-
-        # The <b> tag is now an orphan.
-        self.assertEqual(remove_tag.parent, None)
-        self.assertEqual(remove_tag.find(text="right").next_element, None)
-        self.assertEqual(remove_tag.previous_element, None)
-        self.assertEqual(remove_tag.next_sibling, None)
-        self.assertEqual(remove_tag.previous_sibling, None)
-
-        # The <f> tag is now connected to the <a> tag.
-        self.assertEqual(move_tag.parent, soup.a)
-        self.assertEqual(move_tag.previous_element, "We")
-        self.assertEqual(move_tag.next_element.next_element, soup.e)
-        self.assertEqual(move_tag.next_sibling, None)
-
-        # The gap where the <f> tag used to be has been mended, and
-        # the word "to" is now connected to the <g> tag.
-        to_text = soup.find(text="to")
-        g_tag = soup.g
-        self.assertEqual(to_text.next_element, g_tag)
-        self.assertEqual(to_text.next_sibling, g_tag)
-        self.assertEqual(g_tag.previous_element, to_text)
-        self.assertEqual(g_tag.previous_sibling, to_text)
-
-    def test_unwrap(self):
-        tree = self.soup("""
-            <p>Unneeded <em>formatting</em> is unneeded</p>
-            """)
-        tree.em.unwrap()
-        self.assertEqual(tree.em, None)
-        self.assertEqual(tree.p.text, "Unneeded formatting is unneeded")
-
-    def test_wrap(self):
-        soup = self.soup("I wish I was bold.")
-        value = soup.string.wrap(soup.new_tag("b"))
-        self.assertEqual(value.decode(), "<b>I wish I was bold.</b>")
-        self.assertEqual(
-            soup.decode(), self.document_for("<b>I wish I was bold.</b>"))
-
-    def test_wrap_extracts_tag_from_elsewhere(self):
-        soup = self.soup("<b></b>I wish I was bold.")
-        soup.b.next_sibling.wrap(soup.b)
-        self.assertEqual(
-            soup.decode(), self.document_for("<b>I wish I was bold.</b>"))
-
-    def test_wrap_puts_new_contents_at_the_end(self):
-        soup = self.soup("<b>I like being bold.</b>I wish I was bold.")
-        soup.b.next_sibling.wrap(soup.b)
-        self.assertEqual(2, len(soup.b.contents))
-        self.assertEqual(
-            soup.decode(), self.document_for(
-                "<b>I like being bold.I wish I was bold.</b>"))
-
-    def test_extract(self):
-        soup = self.soup(
-            '<html><body>Some content. <div id="nav">Nav crap</div> More content.</body></html>')
-
-        self.assertEqual(len(soup.body.contents), 3)
-        extracted = soup.find(id="nav").extract()
-
-        self.assertEqual(
-            soup.decode(), "<html><body>Some content.  More content.</body></html>")
-        self.assertEqual(extracted.decode(), '<div id="nav">Nav crap</div>')
-
-        # The extracted tag is now an orphan.
-        self.assertEqual(len(soup.body.contents), 2)
-        self.assertEqual(extracted.parent, None)
-        self.assertEqual(extracted.previous_element, None)
-        self.assertEqual(extracted.next_element.next_element, None)
-
-        # The gap where the extracted tag used to be has been mended.
-        content_1 = soup.find(text="Some content. ")
-        content_2 = soup.find(text=" More content.")
-        self.assertEqual(content_1.next_element, content_2)
-        self.assertEqual(content_1.next_sibling, content_2)
-        self.assertEqual(content_2.previous_element, content_1)
-        self.assertEqual(content_2.previous_sibling, content_1)
-
-    def test_extract_distinguishes_between_identical_strings(self):
-        soup = self.soup("<a>foo</a><b>bar</b>")
-        foo_1 = soup.a.string
-        bar_1 = soup.b.string
-        foo_2 = soup.new_string("foo")
-        bar_2 = soup.new_string("bar")
-        soup.a.append(foo_2)
-        soup.b.append(bar_2)
-
-        # Now there are two identical strings in the <a> tag, and two
-        # in the <b> tag. Let's remove the first "foo" and the second
-        # "bar".
-        foo_1.extract()
-        bar_2.extract()
-        self.assertEqual(foo_2, soup.a.string)
-        self.assertEqual(bar_2, soup.b.string)
-
-    def test_extract_multiples_of_same_tag(self):
-        soup = self.soup("""
-<html>
-<head>
-<script>foo</script>
-</head>
-<body>
- <script>bar</script>
- <a></a>
-</body>
-<script>baz</script>
-</html>""")
-        [soup.script.extract() for i in soup.find_all("script")]
-        self.assertEqual("<body>\n\n<a></a>\n</body>", str(soup.body))
-
-
-    def test_extract_works_when_element_is_surrounded_by_identical_strings(self):
-        soup = self.soup(
- '<html>\n'
- '<body>hi</body>\n'
- '</html>')
-        soup.find('body').extract()
-        self.assertEqual(None, soup.find('body'))
-
-
-    def test_clear(self):
-        """Tag.clear()"""
-        soup = self.soup("<p><a>String <em>Italicized</em></a> and another</p>")
-        # clear using extract()
-        a = soup.a
-        soup.p.clear()
-        self.assertEqual(len(soup.p.contents), 0)
-        self.assertTrue(hasattr(a, "contents"))
-
-        # clear using decompose()
-        em = a.em
-        a.clear(decompose=True)
-        self.assertEqual(0, len(em.contents))
-
-    def test_string_set(self):
-        """Tag.string = 'string'"""
-        soup = self.soup("<a></a> <b><c></c></b>")
-        soup.a.string = "foo"
-        self.assertEqual(soup.a.contents, ["foo"])
-        soup.b.string = "bar"
-        self.assertEqual(soup.b.contents, ["bar"])
-
-    def test_string_set_does_not_affect_original_string(self):
-        soup = self.soup("<a><b>foo</b><c>bar</c>")
-        soup.b.string = soup.c.string
-        self.assertEqual(soup.a.encode(), b"<a><b>bar</b><c>bar</c></a>")
-
-    def test_set_string_preserves_class_of_string(self):
-        soup = self.soup("<a></a>")
-        cdata = CData("foo")
-        soup.a.string = cdata
-        self.assertTrue(isinstance(soup.a.string, CData))
-
-class TestElementObjects(SoupTest):
-    """Test various features of element objects."""
-
-    def test_len(self):
-        """The length of an element is its number of children."""
-        soup = self.soup("<top>1<b>2</b>3</top>")
-
-        # The BeautifulSoup object itself contains one element: the
-        # <top> tag.
-        self.assertEqual(len(soup.contents), 1)
-        self.assertEqual(len(soup), 1)
-
-        # The <top> tag contains three elements: the text node "1", the
-        # <b> tag, and the text node "3".
-        self.assertEqual(len(soup.top), 3)
-        self.assertEqual(len(soup.top.contents), 3)
-
-    def test_member_access_invokes_find(self):
-        """Accessing a Python member .foo invokes find('foo')"""
-        soup = self.soup('<b><i></i></b>')
-        self.assertEqual(soup.b, soup.find('b'))
-        self.assertEqual(soup.b.i, soup.find('b').find('i'))
-        self.assertEqual(soup.a, None)
-
-    def test_deprecated_member_access(self):
-        soup = self.soup('<b><i></i></b>')
-        with warnings.catch_warnings(record=True) as w:
-            tag = soup.bTag
-        self.assertEqual(soup.b, tag)
-        self.assertEqual(
-            '.bTag is deprecated, use .find("b") instead.',
-            str(w[0].message))
-
-    def test_has_attr(self):
-        """has_attr() checks for the presence of an attribute.
-
-        Please note note: has_attr() is different from
-        __in__. has_attr() checks the tag's attributes and __in__
-        checks the tag's chidlren.
-        """
-        soup = self.soup("<foo attr='bar'>")
-        self.assertTrue(soup.foo.has_attr('attr'))
-        self.assertFalse(soup.foo.has_attr('attr2'))
-
-
-    def test_attributes_come_out_in_alphabetical_order(self):
-        markup = '<b a="1" z="5" m="3" f="2" y="4"></b>'
-        self.assertSoupEquals(markup, '<b a="1" f="2" m="3" y="4" z="5"></b>')
-
-    def test_string(self):
-        # A tag that contains only a text node makes that node
-        # available as .string.
-        soup = self.soup("<b>foo</b>")
-        self.assertEqual(soup.b.string, 'foo')
-
-    def test_empty_tag_has_no_string(self):
-        # A tag with no children has no .stirng.
-        soup = self.soup("<b></b>")
-        self.assertEqual(soup.b.string, None)
-
-    def test_tag_with_multiple_children_has_no_string(self):
-        # A tag with no children has no .string.
-        soup = self.soup("<a>foo<b></b><b></b></b>")
-        self.assertEqual(soup.b.string, None)
-
-        soup = self.soup("<a>foo<b></b>bar</b>")
-        self.assertEqual(soup.b.string, None)
-
-        # Even if all the children are strings, due to trickery,
-        # it won't work--but this would be a good optimization.
-        soup = self.soup("<a>foo</b>")
-        soup.a.insert(1, "bar")
-        self.assertEqual(soup.a.string, None)
-
-    def test_tag_with_recursive_string_has_string(self):
-        # A tag with a single child which has a .string inherits that
-        # .string.
-        soup = self.soup("<a><b>foo</b></a>")
-        self.assertEqual(soup.a.string, "foo")
-        self.assertEqual(soup.string, "foo")
-
-    def test_lack_of_string(self):
-        """Only a tag containing a single text node has a .string."""
-        soup = self.soup("<b>f<i>e</i>o</b>")
-        self.assertFalse(soup.b.string)
-
-        soup = self.soup("<b></b>")
-        self.assertFalse(soup.b.string)
-
-    def test_all_text(self):
-        """Tag.text and Tag.get_text(sep=u"") -> all child text, concatenated"""
-        soup = self.soup("<a>a<b>r</b>   <r> t </r></a>")
-        self.assertEqual(soup.a.text, "ar  t ")
-        self.assertEqual(soup.a.get_text(strip=True), "art")
-        self.assertEqual(soup.a.get_text(","), "a,r, , t ")
-        self.assertEqual(soup.a.get_text(",", strip=True), "a,r,t")
-
-    def test_get_text_ignores_comments(self):
-        soup = self.soup("foo<!--IGNORE-->bar")
-        self.assertEqual(soup.get_text(), "foobar")
-
-        self.assertEqual(
-            soup.get_text(types=(NavigableString, Comment)), "fooIGNOREbar")
-        self.assertEqual(
-            soup.get_text(types=None), "fooIGNOREbar")
-
-    def test_all_strings_ignores_comments(self):
-        soup = self.soup("foo<!--IGNORE-->bar")
-        self.assertEqual(['foo', 'bar'], list(soup.strings))
-
-class TestCDAtaListAttributes(SoupTest):
-
-    """Testing cdata-list attributes like 'class'.
-    """
-    def test_single_value_becomes_list(self):
-        soup = self.soup("<a class='foo'>")
-        self.assertEqual(["foo"],soup.a['class'])
-
-    def test_multiple_values_becomes_list(self):
-        soup = self.soup("<a class='foo bar'>")
-        self.assertEqual(["foo", "bar"], soup.a['class'])
-
-    def test_multiple_values_separated_by_weird_whitespace(self):
-        soup = self.soup("<a class='foo\tbar\nbaz'>")
-        self.assertEqual(["foo", "bar", "baz"],soup.a['class'])
-
-    def test_attributes_joined_into_string_on_output(self):
-        soup = self.soup("<a class='foo\tbar'>")
-        self.assertEqual(b'<a class="foo bar"></a>', soup.a.encode())
-
-    def test_accept_charset(self):
-        soup = self.soup('<form accept-charset="ISO-8859-1 UTF-8">')
-        self.assertEqual(['ISO-8859-1', 'UTF-8'], soup.form['accept-charset'])
-
-    def test_cdata_attribute_applying_only_to_one_tag(self):
-        data = '<a accept-charset="ISO-8859-1 UTF-8"></a>'
-        soup = self.soup(data)
-        # We saw in another test that accept-charset is a cdata-list
-        # attribute for the <form> tag. But it's not a cdata-list
-        # attribute for any other tag.
-        self.assertEqual('ISO-8859-1 UTF-8', soup.a['accept-charset'])
-
-    def test_string_has_immutable_name_property(self):
-        string = self.soup("s").string
-        self.assertEqual(None, string.name)
-        def t():
-            string.name = 'foo'
-        self.assertRaises(AttributeError, t)
-
-class TestPersistence(SoupTest):
-    "Testing features like pickle and deepcopy."
-
-    def setUp(self):
-        super(TestPersistence, self).setUp()
-        self.page = """<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"
-"http://www.w3.org/TR/REC-html40/transitional.dtd">
-<html>
-<head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
-<title>Beautiful Soup: We called him Tortoise because he taught us.</title>
-<link rev="made" href="mailto:leonardr@segfault.org">
-<meta name="Description" content="Beautiful Soup: an HTML parser optimized for screen-scraping.">
-<meta name="generator" content="Markov Approximation 1.4 (module: leonardr)">
-<meta name="author" content="Leonard Richardson">
-</head>
-<body>
-<a href="foo">foo</a>
-<a href="foo"><b>bar</b></a>
-</body>
-</html>"""
-        self.tree = self.soup(self.page)
-
-    def test_pickle_and_unpickle_identity(self):
-        # Pickling a tree, then unpickling it, yields a tree identical
-        # to the original.
-        dumped = pickle.dumps(self.tree, 2)
-        loaded = pickle.loads(dumped)
-        self.assertEqual(loaded.__class__, BeautifulSoup)
-        self.assertEqual(loaded.decode(), self.tree.decode())
-
-    def test_deepcopy_identity(self):
-        # Making a deepcopy of a tree yields an identical tree.
-        copied = copy.deepcopy(self.tree)
-        self.assertEqual(copied.decode(), self.tree.decode())
-
-    def test_unicode_pickle(self):
-        # A tree containing Unicode characters can be pickled.
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        dumped = pickle.dumps(soup, pickle.HIGHEST_PROTOCOL)
-        loaded = pickle.loads(dumped)
-        self.assertEqual(loaded.decode(), soup.decode())
-
-    def test_copy_navigablestring_is_not_attached_to_tree(self):
-        html = "<b>Foo<a></a></b><b>Bar</b>"
-        soup = self.soup(html)
-        s1 = soup.find(string="Foo")
-        s2 = copy.copy(s1)
-        self.assertEqual(s1, s2)
-        self.assertEqual(None, s2.parent)
-        self.assertEqual(None, s2.next_element)
-        self.assertNotEqual(None, s1.next_sibling)
-        self.assertEqual(None, s2.next_sibling)
-        self.assertEqual(None, s2.previous_element)
-
-    def test_copy_navigablestring_subclass_has_same_type(self):
-        html = "<b><!--Foo--></b>"
-        soup = self.soup(html)
-        s1 = soup.string
-        s2 = copy.copy(s1)
-        self.assertEqual(s1, s2)
-        self.assertTrue(isinstance(s2, Comment))
-
-    def test_copy_entire_soup(self):
-        html = "<div><b>Foo<a></a></b><b>Bar</b></div>end"
-        soup = self.soup(html)
-        soup_copy = copy.copy(soup)
-        self.assertEqual(soup, soup_copy)
-
-    def test_copy_tag_copies_contents(self):
-        html = "<div><b>Foo<a></a></b><b>Bar</b></div>end"
-        soup = self.soup(html)
-        div = soup.div
-        div_copy = copy.copy(div)
-
-        # The two tags look the same, and evaluate to equal.
-        self.assertEqual(str(div), str(div_copy))
-        self.assertEqual(div, div_copy)
-
-        # But they're not the same object.
-        self.assertFalse(div is div_copy)
-
-        # And they don't have the same relation to the parse tree. The
-        # copy is not associated with a parse tree at all.
-        self.assertEqual(None, div_copy.parent)
-        self.assertEqual(None, div_copy.previous_element)
-        self.assertEqual(None, div_copy.find(string='Bar').next_element)
-        self.assertNotEqual(None, div.find(string='Bar').next_element)
-
-class TestSubstitutions(SoupTest):
-
-    def test_default_formatter_is_minimal(self):
-        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
-        soup = self.soup(markup)
-        decoded = soup.decode(formatter="minimal")
-        # The < is converted back into &lt; but the e-with-acute is left alone.
-        self.assertEqual(
-            decoded,
-            self.document_for(
-                "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
-
-    def test_formatter_html(self):
-        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
-        soup = self.soup(markup)
-        decoded = soup.decode(formatter="html")
-        self.assertEqual(
-            decoded,
-            self.document_for("<b>&lt;&lt;Sacr&eacute; bleu!&gt;&gt;</b>"))
-
-    def test_formatter_minimal(self):
-        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
-        soup = self.soup(markup)
-        decoded = soup.decode(formatter="minimal")
-        # The < is converted back into &lt; but the e-with-acute is left alone.
-        self.assertEqual(
-            decoded,
-            self.document_for(
-                "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
-
-    def test_formatter_null(self):
-        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
-        soup = self.soup(markup)
-        decoded = soup.decode(formatter=None)
-        # Neither the angle brackets nor the e-with-acute are converted.
-        # This is not valid HTML, but it's what the user wanted.
-        self.assertEqual(decoded,
-                          self.document_for("<b><<Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!>></b>"))
-
-    def test_formatter_custom(self):
-        markup = "<b>&lt;foo&gt;</b><b>bar</b>"
-        soup = self.soup(markup)
-        decoded = soup.decode(formatter = lambda x: x.upper())
-        # Instead of normal entity conversion code, the custom
-        # callable is called on every string.
-        self.assertEqual(
-            decoded,
-            self.document_for("<b><FOO></b><b>BAR</b>"))
-
-    def test_formatter_is_run_on_attribute_values(self):
-        markup = '<a href="http://a.com?a=b&c=é">e</a>'
-        soup = self.soup(markup)
-        a = soup.a
-
-        expect_minimal = '<a href="http://a.com?a=b&amp;c=é">e</a>'
-
-        self.assertEqual(expect_minimal, a.decode())
-        self.assertEqual(expect_minimal, a.decode(formatter="minimal"))
-
-        expect_html = '<a href="http://a.com?a=b&amp;c=&eacute;">e</a>'
-        self.assertEqual(expect_html, a.decode(formatter="html"))
-
-        self.assertEqual(markup, a.decode(formatter=None))
-        expect_upper = '<a href="HTTP://A.COM?A=B&C=É">E</a>'
-        self.assertEqual(expect_upper, a.decode(formatter=lambda x: x.upper()))
-
-    def test_formatter_skips_script_tag_for_html_documents(self):
-        doc = """
-  <script type="text/javascript">
-   console.log("< < hey > > ");
-  </script>
-"""
-        encoded = BeautifulSoup(doc, 'html.parser').encode()
-        self.assertTrue(b"< < hey > >" in encoded)
-
-    def test_formatter_skips_style_tag_for_html_documents(self):
-        doc = """
-  <style type="text/css">
-   console.log("< < hey > > ");
-  </style>
-"""
-        encoded = BeautifulSoup(doc, 'html.parser').encode()
-        self.assertTrue(b"< < hey > >" in encoded)
-
-    def test_prettify_leaves_preformatted_text_alone(self):
-        soup = self.soup("<div>  foo  <pre>  \tbar\n  \n  </pre>  baz  ")
-        # Everything outside the <pre> tag is reformatted, but everything
-        # inside is left alone.
-        self.assertEqual(
-            '<div>\n foo\n <pre>  \tbar\n  \n  </pre>\n baz\n</div>',
-            soup.div.prettify())
-
-    def test_prettify_accepts_formatter(self):
-        soup = BeautifulSoup("<html><body>foo</body></html>", 'html.parser')
-        pretty = soup.prettify(formatter = lambda x: x.upper())
-        self.assertTrue("FOO" in pretty)
-
-    def test_prettify_outputs_unicode_by_default(self):
-        soup = self.soup("<a></a>")
-        self.assertEqual(str, type(soup.prettify()))
-
-    def test_prettify_can_encode_data(self):
-        soup = self.soup("<a></a>")
-        self.assertEqual(bytes, type(soup.prettify("utf-8")))
-
-    def test_html_entity_substitution_off_by_default(self):
-        markup = "<b>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</b>"
-        soup = self.soup(markup)
-        encoded = soup.b.encode("utf-8")
-        self.assertEqual(encoded, markup.encode('utf-8'))
-
-    def test_encoding_substitution(self):
-        # Here's the <meta> tag saying that a document is
-        # encoded in Shift-JIS.
-        meta_tag = ('<meta content="text/html; charset=x-sjis" '
-                    'http-equiv="Content-type"/>')
-        soup = self.soup(meta_tag)
-
-        # Parse the document, and the charset apprears unchanged.
-        self.assertEqual(soup.meta['content'], 'text/html; charset=x-sjis')
-
-        # Encode the document into some encoding, and the encoding is
-        # substituted into the meta tag.
-        utf_8 = soup.encode("utf-8")
-        self.assertTrue(b"charset=utf-8" in utf_8)
-
-        euc_jp = soup.encode("euc_jp")
-        self.assertTrue(b"charset=euc_jp" in euc_jp)
-
-        shift_jis = soup.encode("shift-jis")
-        self.assertTrue(b"charset=shift-jis" in shift_jis)
-
-        utf_16_u = soup.encode("utf-16").decode("utf-16")
-        self.assertTrue("charset=utf-16" in utf_16_u)
-
-    def test_encoding_substitution_doesnt_happen_if_tag_is_strained(self):
-        markup = ('<head><meta content="text/html; charset=x-sjis" '
-                    'http-equiv="Content-type"/></head><pre>foo</pre>')
-
-        # Beautiful Soup used to try to rewrite the meta tag even if the
-        # meta tag got filtered out by the strainer. This test makes
-        # sure that doesn't happen.
-        strainer = SoupStrainer('pre')
-        soup = self.soup(markup, parse_only=strainer)
-        self.assertEqual(soup.contents[0].name, 'pre')
-
-class TestEncoding(SoupTest):
-    """Test the ability to encode objects into strings."""
-
-    def test_unicode_string_can_be_encoded(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual(soup.b.string.encode("utf-8"),
-                          "\N{SNOWMAN}".encode("utf-8"))
-
-    def test_tag_containing_unicode_string_can_be_encoded(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual(
-            soup.b.encode("utf-8"), html.encode("utf-8"))
-
-    def test_encoding_substitutes_unrecognized_characters_by_default(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual(soup.b.encode("ascii"), b"<b>&#9731;</b>")
-
-    def test_encoding_can_be_made_strict(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertRaises(
-            UnicodeEncodeError, soup.encode, "ascii", errors="strict")
-
-    def test_decode_contents(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual("\N{SNOWMAN}", soup.b.decode_contents())
-
-    def test_encode_contents(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual(
-            "\N{SNOWMAN}".encode("utf8"), soup.b.encode_contents(
-                encoding="utf8"))
-
-    def test_deprecated_renderContents(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        self.assertEqual(
-            "\N{SNOWMAN}".encode("utf8"), soup.b.renderContents())
-
-    def test_repr(self):
-        html = "<b>\N{SNOWMAN}</b>"
-        soup = self.soup(html)
-        if PY3K:
-            self.assertEqual(html, repr(soup))
-        else:
-            self.assertEqual(b'<b>\\u2603</b>', repr(soup))
-
-class TestNavigableStringSubclasses(SoupTest):
-
-    def test_cdata(self):
-        # None of the current builders turn CDATA sections into CData
-        # objects, but you can create them manually.
-        soup = self.soup("")
-        cdata = CData("foo")
-        soup.insert(1, cdata)
-        self.assertEqual(str(soup), "<![CDATA[foo]]>")
-        self.assertEqual(soup.find(text="foo"), "foo")
-        self.assertEqual(soup.contents[0], "foo")
-
-    def test_cdata_is_never_formatted(self):
-        """Text inside a CData object is passed into the formatter.
-
-        But the return value is ignored.
-        """
-
-        self.count = 0
-        def increment(*args):
-            self.count += 1
-            return "BITTER FAILURE"
-
-        soup = self.soup("")
-        cdata = CData("<><><>")
-        soup.insert(1, cdata)
-        self.assertEqual(
-            b"<![CDATA[<><><>]]>", soup.encode(formatter=increment))
-        self.assertEqual(1, self.count)
-
-    def test_doctype_ends_in_newline(self):
-        # Unlike other NavigableString subclasses, a DOCTYPE always ends
-        # in a newline.
-        doctype = Doctype("foo")
-        soup = self.soup("")
-        soup.insert(1, doctype)
-        self.assertEqual(soup.encode(), b"<!DOCTYPE foo>\n")
-
-    def test_declaration(self):
-        d = Declaration("foo")
-        self.assertEqual("<?foo?>", d.output_ready())
-
-class TestSoupSelector(TreeTest):
-
-    HTML = """
-<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
-"http://www.w3.org/TR/html4/strict.dtd">
-<html>
-<head>
-<title>The title</title>
-<link rel="stylesheet" href="blah.css" type="text/css" id="l1">
-</head>
-<body>
-<custom-dashed-tag class="dashed" id="dash1">Hello there.</custom-dashed-tag>
-<div id="main" class="fancy">
-<div id="inner">
-<h1 id="header1">An H1</h1>
-<p>Some text</p>
-<p class="onep" id="p1">Some more text</p>
-<h2 id="header2">An H2</h2>
-<p class="class1 class2 class3" id="pmulti">Another</p>
-<a href="http://bob.example.org/" rel="friend met" id="bob">Bob</a>
-<h2 id="header3">Another H2</h2>
-<a id="me" href="http://simonwillison.net/" rel="me">me</a>
-<span class="s1">
-<a href="#" id="s1a1">span1a1</a>
-<a href="#" id="s1a2">span1a2 <span id="s1a2s1">test</span></a>
-<span class="span2">
-<a href="#" id="s2a1">span2a1</a>
-</span>
-<span class="span3"></span>
-<custom-dashed-tag class="dashed" id="dash2"/>
-<div data-tag="dashedvalue" id="data1"/>
-</span>
-</div>
-<x id="xid">
-<z id="zida"/>
-<z id="zidab"/>
-<z id="zidac"/>
-</x>
-<y id="yid">
-<z id="zidb"/>
-</y>
-<p lang="en" id="lang-en">English</p>
-<p lang="en-gb" id="lang-en-gb">English UK</p>
-<p lang="en-us" id="lang-en-us">English US</p>
-<p lang="fr" id="lang-fr">French</p>
-</div>
-
-<div id="footer">
-</div>
-"""
-
-    def setUp(self):
-        self.soup = BeautifulSoup(self.HTML, 'html.parser')
-
-    def assertSelects(self, selector, expected_ids):
-        el_ids = [el['id'] for el in self.soup.select(selector)]
-        el_ids.sort()
-        expected_ids.sort()
-        self.assertEqual(expected_ids, el_ids,
-            "Selector %s, expected [%s], got [%s]" % (
-                selector, ', '.join(expected_ids), ', '.join(el_ids)
-            )
-        )
-
-    assertSelect = assertSelects
-
-    def assertSelectMultiple(self, *tests):
-        for selector, expected_ids in tests:
-            self.assertSelect(selector, expected_ids)
-
-    def test_one_tag_one(self):
-        els = self.soup.select('title')
-        self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].name, 'title')
-        self.assertEqual(els[0].contents, ['The title'])
-
-    def test_one_tag_many(self):
-        els = self.soup.select('div')
-        self.assertEqual(len(els), 4)
-        for div in els:
-            self.assertEqual(div.name, 'div')
-
-        el = self.soup.select_one('div')
-        self.assertEqual('main', el['id'])
-
-    def test_select_one_returns_none_if_no_match(self):
-        match = self.soup.select_one('nonexistenttag')
-        self.assertEqual(None, match)
-
-
-    def test_tag_in_tag_one(self):
-        els = self.soup.select('div div')
-        self.assertSelects('div div', ['inner', 'data1'])
-
-    def test_tag_in_tag_many(self):
-        for selector in ('html div', 'html body div', 'body div'):
-            self.assertSelects(selector, ['data1', 'main', 'inner', 'footer'])
-
-    def test_tag_no_match(self):
-        self.assertEqual(len(self.soup.select('del')), 0)
-
-    def test_invalid_tag(self):
-        self.assertRaises(ValueError, self.soup.select, 'tag%t')
-
-    def test_select_dashed_tag_ids(self):
-        self.assertSelects('custom-dashed-tag', ['dash1', 'dash2'])
-
-    def test_select_dashed_by_id(self):
-        dashed = self.soup.select('custom-dashed-tag[id=\"dash2\"]')
-        self.assertEqual(dashed[0].name, 'custom-dashed-tag')
-        self.assertEqual(dashed[0]['id'], 'dash2')
-
-    def test_dashed_tag_text(self):
-        self.assertEqual(self.soup.select('body > custom-dashed-tag')[0].text, 'Hello there.')
-
-    def test_select_dashed_matches_find_all(self):
-        self.assertEqual(self.soup.select('custom-dashed-tag'), self.soup.find_all('custom-dashed-tag'))
-
-    def test_header_tags(self):
-        self.assertSelectMultiple(
-            ('h1', ['header1']),
-            ('h2', ['header2', 'header3']),
-        )
-
-    def test_class_one(self):
-        for selector in ('.onep', 'p.onep', 'html p.onep'):
-            els = self.soup.select(selector)
-            self.assertEqual(len(els), 1)
-            self.assertEqual(els[0].name, 'p')
-            self.assertEqual(els[0]['class'], ['onep'])
-
-    def test_class_mismatched_tag(self):
-        els = self.soup.select('div.onep')
-        self.assertEqual(len(els), 0)
-
-    def test_one_id(self):
-        for selector in ('div#inner', '#inner', 'div div#inner'):
-            self.assertSelects(selector, ['inner'])
-
-    def test_bad_id(self):
-        els = self.soup.select('#doesnotexist')
-        self.assertEqual(len(els), 0)
-
-    def test_items_in_id(self):
-        els = self.soup.select('div#inner p')
-        self.assertEqual(len(els), 3)
-        for el in els:
-            self.assertEqual(el.name, 'p')
-        self.assertEqual(els[1]['class'], ['onep'])
-        self.assertFalse(els[0].has_attr('class'))
-
-    def test_a_bunch_of_emptys(self):
-        for selector in ('div#main del', 'div#main div.oops', 'div div#main'):
-            self.assertEqual(len(self.soup.select(selector)), 0)
-
-    def test_multi_class_support(self):
-        for selector in ('.class1', 'p.class1', '.class2', 'p.class2',
-            '.class3', 'p.class3', 'html p.class2', 'div#inner .class2'):
-            self.assertSelects(selector, ['pmulti'])
-
-    def test_multi_class_selection(self):
-        for selector in ('.class1.class3', '.class3.class2',
-                         '.class1.class2.class3'):
-            self.assertSelects(selector, ['pmulti'])
-
-    def test_child_selector(self):
-        self.assertSelects('.s1 > a', ['s1a1', 's1a2'])
-        self.assertSelects('.s1 > a span', ['s1a2s1'])
-
-    def test_child_selector_id(self):
-        self.assertSelects('.s1 > a#s1a2 span', ['s1a2s1'])
-
-    def test_attribute_equals(self):
-        self.assertSelectMultiple(
-            ('p[class="onep"]', ['p1']),
-            ('p[id="p1"]', ['p1']),
-            ('[class="onep"]', ['p1']),
-            ('[id="p1"]', ['p1']),
-            ('link[rel="stylesheet"]', ['l1']),
-            ('link[type="text/css"]', ['l1']),
-            ('link[href="blah.css"]', ['l1']),
-            ('link[href="no-blah.css"]', []),
-            ('[rel="stylesheet"]', ['l1']),
-            ('[type="text/css"]', ['l1']),
-            ('[href="blah.css"]', ['l1']),
-            ('[href="no-blah.css"]', []),
-            ('p[href="no-blah.css"]', []),
-            ('[href="no-blah.css"]', []),
-        )
-
-    def test_attribute_tilde(self):
-        self.assertSelectMultiple(
-            ('p[class~="class1"]', ['pmulti']),
-            ('p[class~="class2"]', ['pmulti']),
-            ('p[class~="class3"]', ['pmulti']),
-            ('[class~="class1"]', ['pmulti']),
-            ('[class~="class2"]', ['pmulti']),
-            ('[class~="class3"]', ['pmulti']),
-            ('a[rel~="friend"]', ['bob']),
-            ('a[rel~="met"]', ['bob']),
-            ('[rel~="friend"]', ['bob']),
-            ('[rel~="met"]', ['bob']),
-        )
-
-    def test_attribute_startswith(self):
-        self.assertSelectMultiple(
-            ('[rel^="style"]', ['l1']),
-            ('link[rel^="style"]', ['l1']),
-            ('notlink[rel^="notstyle"]', []),
-            ('[rel^="notstyle"]', []),
-            ('link[rel^="notstyle"]', []),
-            ('link[href^="bla"]', ['l1']),
-            ('a[href^="http://"]', ['bob', 'me']),
-            ('[href^="http://"]', ['bob', 'me']),
-            ('[id^="p"]', ['pmulti', 'p1']),
-            ('[id^="m"]', ['me', 'main']),
-            ('div[id^="m"]', ['main']),
-            ('a[id^="m"]', ['me']),
-            ('div[data-tag^="dashed"]', ['data1'])
-        )
-
-    def test_attribute_endswith(self):
-        self.assertSelectMultiple(
-            ('[href$=".css"]', ['l1']),
-            ('link[href$=".css"]', ['l1']),
-            ('link[id$="1"]', ['l1']),
-            ('[id$="1"]', ['data1', 'l1', 'p1', 'header1', 's1a1', 's2a1', 's1a2s1', 'dash1']),
-            ('div[id$="1"]', ['data1']),
-            ('[id$="noending"]', []),
-        )
-
-    def test_attribute_contains(self):
-        self.assertSelectMultiple(
-            # From test_attribute_startswith
-            ('[rel*="style"]', ['l1']),
-            ('link[rel*="style"]', ['l1']),
-            ('notlink[rel*="notstyle"]', []),
-            ('[rel*="notstyle"]', []),
-            ('link[rel*="notstyle"]', []),
-            ('link[href*="bla"]', ['l1']),
-            ('[href*="http://"]', ['bob', 'me']),
-            ('[id*="p"]', ['pmulti', 'p1']),
-            ('div[id*="m"]', ['main']),
-            ('a[id*="m"]', ['me']),
-            # From test_attribute_endswith
-            ('[href*=".css"]', ['l1']),
-            ('link[href*=".css"]', ['l1']),
-            ('link[id*="1"]', ['l1']),
-            ('[id*="1"]', ['data1', 'l1', 'p1', 'header1', 's1a1', 's1a2', 's2a1', 's1a2s1', 'dash1']),
-            ('div[id*="1"]', ['data1']),
-            ('[id*="noending"]', []),
-            # New for this test
-            ('[href*="."]', ['bob', 'me', 'l1']),
-            ('a[href*="."]', ['bob', 'me']),
-            ('link[href*="."]', ['l1']),
-            ('div[id*="n"]', ['main', 'inner']),
-            ('div[id*="nn"]', ['inner']),
-            ('div[data-tag*="edval"]', ['data1'])
-        )
-
-    def test_attribute_exact_or_hypen(self):
-        self.assertSelectMultiple(
-            ('p[lang|="en"]', ['lang-en', 'lang-en-gb', 'lang-en-us']),
-            ('[lang|="en"]', ['lang-en', 'lang-en-gb', 'lang-en-us']),
-            ('p[lang|="fr"]', ['lang-fr']),
-            ('p[lang|="gb"]', []),
-        )
-
-    def test_attribute_exists(self):
-        self.assertSelectMultiple(
-            ('[rel]', ['l1', 'bob', 'me']),
-            ('link[rel]', ['l1']),
-            ('a[rel]', ['bob', 'me']),
-            ('[lang]', ['lang-en', 'lang-en-gb', 'lang-en-us', 'lang-fr']),
-            ('p[class]', ['p1', 'pmulti']),
-            ('[blah]', []),
-            ('p[blah]', []),
-            ('div[data-tag]', ['data1'])
-        )
-
-    def test_unsupported_pseudoclass(self):
-        self.assertRaises(
-            NotImplementedError, self.soup.select, "a:no-such-pseudoclass")
-
-        self.assertRaises(
-            NotImplementedError, self.soup.select, "a:nth-of-type(a)")
-
-
-    def test_nth_of_type(self):
-        # Try to select first paragraph
-        els = self.soup.select('div#inner p:nth-of-type(1)')
-        self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, 'Some text')
-
-        # Try to select third paragraph
-        els = self.soup.select('div#inner p:nth-of-type(3)')
-        self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, 'Another')
-
-        # Try to select (non-existent!) fourth paragraph
-        els = self.soup.select('div#inner p:nth-of-type(4)')
-        self.assertEqual(len(els), 0)
-
-        # Pass in an invalid value.
-        self.assertRaises(
-            ValueError, self.soup.select, 'div p:nth-of-type(0)')
-
-    def test_nth_of_type_direct_descendant(self):
-        els = self.soup.select('div#inner > p:nth-of-type(1)')
-        self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, 'Some text')
-
-    def test_id_child_selector_nth_of_type(self):
-        self.assertSelects('#inner > p:nth-of-type(2)', ['p1'])
-
-    def test_select_on_element(self):
-        # Other tests operate on the tree; this operates on an element
-        # within the tree.
-        inner = self.soup.find("div", id="main")
-        selected = inner.select("div")
-        # The <div id="inner"> tag was selected. The <div id="footer">
-        # tag was not.
-        self.assertSelectsIDs(selected, ['inner', 'data1'])
-
-    def test_overspecified_child_id(self):
-        self.assertSelects(".fancy #inner", ['inner'])
-        self.assertSelects(".normal #inner", [])
-
-    def test_adjacent_sibling_selector(self):
-        self.assertSelects('#p1 + h2', ['header2'])
-        self.assertSelects('#p1 + h2 + p', ['pmulti'])
-        self.assertSelects('#p1 + #header2 + .class1', ['pmulti'])
-        self.assertEqual([], self.soup.select('#p1 + p'))
-
-    def test_general_sibling_selector(self):
-        self.assertSelects('#p1 ~ h2', ['header2', 'header3'])
-        self.assertSelects('#p1 ~ #header2', ['header2'])
-        self.assertSelects('#p1 ~ h2 + a', ['me'])
-        self.assertSelects('#p1 ~ h2 + [rel="me"]', ['me'])
-        self.assertEqual([], self.soup.select('#inner ~ h2'))
-
-    def test_dangling_combinator(self):
-        self.assertRaises(ValueError, self.soup.select, 'h1 >')
-
-    def test_sibling_combinator_wont_select_same_tag_twice(self):
-        self.assertSelects('p[lang] ~ p', ['lang-en-gb', 'lang-en-us', 'lang-fr'])
-
-    # Test the selector grouping operator (the comma)
-    def test_multiple_select(self):
-        self.assertSelects('x, y', ['xid', 'yid'])
-
-    def test_multiple_select_with_no_space(self):
-        self.assertSelects('x,y', ['xid', 'yid'])
-
-    def test_multiple_select_with_more_space(self):
-        self.assertSelects('x,    y', ['xid', 'yid'])
-
-    def test_multiple_select_duplicated(self):
-        self.assertSelects('x, x', ['xid'])
-
-    def test_multiple_select_sibling(self):
-        self.assertSelects('x, y ~ p[lang=fr]', ['xid', 'lang-fr'])
-
-    def test_multiple_select_tag_and_direct_descendant(self):
-        self.assertSelects('x, y > z', ['xid', 'zidb'])
-
-    def test_multiple_select_direct_descendant_and_tags(self):
-        self.assertSelects('div > x, y, z', ['xid', 'yid', 'zida', 'zidb', 'zidab', 'zidac'])
-
-    def test_multiple_select_indirect_descendant(self):
-        self.assertSelects('div x,y,  z', ['xid', 'yid', 'zida', 'zidb', 'zidab', 'zidac'])
-
-    def test_invalid_multiple_select(self):
-        self.assertRaises(ValueError, self.soup.select, ',x, y')
-        self.assertRaises(ValueError, self.soup.select, 'x,,y')
-
-    def test_multiple_select_attrs(self):
-        self.assertSelects('p[lang=en], p[lang=en-gb]', ['lang-en', 'lang-en-gb'])
-
-    def test_multiple_select_ids(self):
-        self.assertSelects('x, y > z[id=zida], z[id=zidab], z[id=zidb]', ['xid', 'zidb', 'zidab'])
-
-    def test_multiple_select_nested(self):
-        self.assertSelects('body > div > x, y > z', ['xid', 'zidb'])
-
-
-

