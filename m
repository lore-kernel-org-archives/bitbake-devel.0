Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 561637726C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Ca6ai006999; Wed, 1 Jun 2016 13:36:52 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z7Ltg4eaFUAf; Wed,  1 Jun 2016 13:36:52 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Caogs007439
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:36:51 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85OE-0000nG-GZ; Wed, 01 Jun 2016 13:36:50 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:20 +0100
Message-Id: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 01 Jun 2016 14:17:24 +0000
Subject: [PATCH 01/28] bitbake/bs4: Upgrade 4.3.2 -> 4.4.1 (python 3 version)
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
X-List-Received-Date: Wed, 01 Jun 2016 12:36:56 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Upgrade to 4.4.1 which has been run through 2to3 as per the maintainers
recommendation for v3 use.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bs4/__init__.py                    | 112 ++++++++---
 lib/bs4/builder/__init__.py            |   7 +-
 lib/bs4/builder/_html5lib.py           |  71 +++++--
 lib/bs4/builder/_htmlparser.py         |  56 +++---
 lib/bs4/builder/_lxml.py               |  47 +++--
 lib/bs4/dammit.py                      |  31 ++-
 lib/bs4/diagnose.py                    |  68 ++++---
 lib/bs4/element.py                     | 346 ++++++++++++++++++++++-----------
 lib/bs4/testing.py                     | 129 ++++++++++--
 lib/bs4/tests/test_builder_registry.py |  14 +-
 lib/bs4/tests/test_html5lib.py         |  19 +-
 lib/bs4/tests/test_htmlparser.py       |  13 ++
 lib/bs4/tests/test_lxml.py             |  19 +-
 lib/bs4/tests/test_soup.py             | 107 +++++++---
 lib/bs4/tests/test_tree.py             | 294 ++++++++++++++++++++++------
 15 files changed, 972 insertions(+), 361 deletions(-)

diff --git a/lib/bs4/__init__.py b/lib/bs4/__init__.py
index 7ba3426..f6fdfd5 100644
--- a/lib/bs4/__init__.py
+++ b/lib/bs4/__init__.py
@@ -17,8 +17,8 @@ http://www.crummy.com/software/BeautifulSoup/bs4/doc/
 """
 
 __author__ = "Leonard Richardson (leonardr@segfault.org)"
-__version__ = "4.3.2"
-__copyright__ = "Copyright (c) 2004-2013 Leonard Richardson"
+__version__ = "4.4.1"
+__copyright__ = "Copyright (c) 2004-2015 Leonard Richardson"
 __license__ = "MIT"
 
 __all__ = ['BeautifulSoup']
@@ -45,7 +45,7 @@ from .element import (
 
 # The very first thing we do is give a useful error if someone is
 # running this code under Python 3 without converting it.
-syntax_error = u'You are trying to run the Python 2 version of Beautiful Soup under Python 3. This will not work. You need to convert the code, either by installing it (`python setup.py install`) or by running 2to3 (`2to3 -w bs4`).'
+'You are trying to run the Python 2 version of Beautiful Soup under Python 3. This will not work.'!='You need to convert the code, either by installing it (`python setup.py install`) or by running 2to3 (`2to3 -w bs4`).'
 
 class BeautifulSoup(Tag):
     """
@@ -69,7 +69,7 @@ class BeautifulSoup(Tag):
     like HTML's <br> tag), call handle_starttag and then
     handle_endtag.
     """
-    ROOT_TAG_NAME = u'[document]'
+    ROOT_TAG_NAME = '[document]'
 
     # If the end-user gives no indication which tree builder they
     # want, look for one with these features.
@@ -77,8 +77,11 @@ class BeautifulSoup(Tag):
 
     ASCII_SPACES = '\x20\x0a\x09\x0c\x0d'
 
+    NO_PARSER_SPECIFIED_WARNING = "No parser was explicitly specified, so I'm using the best available %(markup_type)s parser for this system (\"%(parser)s\"). This usually isn't a problem, but if you run this code on another system, or in a different virtual environment, it may use a different parser and behave differently.\n\nTo get rid of this warning, change this:\n\n BeautifulSoup([your markup])\n\nto this:\n\n BeautifulSoup([your markup], \"%(parser)s\")\n"
+
     def __init__(self, markup="", features=None, builder=None,
-                 parse_only=None, from_encoding=None, **kwargs):
+                 parse_only=None, from_encoding=None, exclude_encodings=None,
+                 **kwargs):
         """The Soup object is initialized as the 'root tag', and the
         provided markup (which can be a string or a file-like object)
         is fed into the underlying parser."""
@@ -114,9 +117,9 @@ class BeautifulSoup(Tag):
             del kwargs['isHTML']
             warnings.warn(
                 "BS4 does not respect the isHTML argument to the "
-                "BeautifulSoup constructor. You can pass in features='html' "
-                "or features='xml' to get a builder capable of handling "
-                "one or the other.")
+                "BeautifulSoup constructor. Suggest you use "
+                "features='lxml' for HTML and features='lxml-xml' for "
+                "XML.")
 
         def deprecated_argument(old_name, new_name):
             if old_name in kwargs:
@@ -135,12 +138,13 @@ class BeautifulSoup(Tag):
             "fromEncoding", "from_encoding")
 
         if len(kwargs) > 0:
-            arg = kwargs.keys().pop()
+            arg = list(kwargs.keys()).pop()
             raise TypeError(
                 "__init__() got an unexpected keyword argument '%s'" % arg)
 
         if builder is None:
-            if isinstance(features, basestring):
+            original_features = features
+            if isinstance(features, str):
                 features = [features]
             if features is None or len(features) == 0:
                 features = self.DEFAULT_BUILDER_FEATURES
@@ -151,6 +155,16 @@ class BeautifulSoup(Tag):
                     "requested: %s. Do you need to install a parser library?"
                     % ",".join(features))
             builder = builder_class()
+            if not (original_features == builder.NAME or
+                    original_features in builder.ALTERNATE_NAMES):
+                if builder.is_xml:
+                    markup_type = "XML"
+                else:
+                    markup_type = "HTML"
+                warnings.warn(self.NO_PARSER_SPECIFIED_WARNING % dict(
+                    parser=builder.NAME,
+                    markup_type=markup_type))
+
         self.builder = builder
         self.is_xml = builder.is_xml
         self.builder.soup = self
@@ -164,7 +178,7 @@ class BeautifulSoup(Tag):
             # involving passing non-markup to Beautiful Soup.
             # Beautiful Soup will still parse the input as markup,
             # just in case that's what the user really wants.
-            if (isinstance(markup, unicode)
+            if (isinstance(markup, str)
                 and not os.path.supports_unicode_filenames):
                 possible_filename = markup.encode("utf8")
             else:
@@ -172,25 +186,30 @@ class BeautifulSoup(Tag):
             is_file = False
             try:
                 is_file = os.path.exists(possible_filename)
-            except Exception, e:
+            except Exception as e:
                 # This is almost certainly a problem involving
                 # characters not valid in filenames on this
                 # system. Just let it go.
                 pass
             if is_file:
+                if isinstance(markup, str):
+                    markup = markup.encode("utf8")
                 warnings.warn(
                     '"%s" looks like a filename, not markup. You should probably open this file and pass the filehandle into Beautiful Soup.' % markup)
             if markup[:5] == "http:" or markup[:6] == "https:":
                 # TODO: This is ugly but I couldn't get it to work in
                 # Python 3 otherwise.
                 if ((isinstance(markup, bytes) and not b' ' in markup)
-                    or (isinstance(markup, unicode) and not u' ' in markup)):
+                    or (isinstance(markup, str) and not ' ' in markup)):
+                    if isinstance(markup, str):
+                        markup = markup.encode("utf8")
                     warnings.warn(
                         '"%s" looks like a URL. Beautiful Soup is not an HTTP client. You should probably use an HTTP client to get the document behind the URL, and feed that document to Beautiful Soup.' % markup)
 
         for (self.markup, self.original_encoding, self.declared_html_encoding,
          self.contains_replacement_characters) in (
-            self.builder.prepare_markup(markup, from_encoding)):
+             self.builder.prepare_markup(
+                 markup, from_encoding, exclude_encodings=exclude_encodings)):
             self.reset()
             try:
                 self._feed()
@@ -203,6 +222,16 @@ class BeautifulSoup(Tag):
         self.markup = None
         self.builder.soup = None
 
+    def __copy__(self):
+        return type(self)(self.encode(), builder=self.builder)
+
+    def __getstate__(self):
+        # Frequently a tree builder can't be pickled.
+        d = dict(self.__dict__)
+        if 'builder' in d and not self.builder.picklable:
+            del d['builder']
+        return d
+
     def _feed(self):
         # Convert the document to Unicode.
         self.builder.reset()
@@ -229,9 +258,7 @@ class BeautifulSoup(Tag):
 
     def new_string(self, s, subclass=NavigableString):
         """Create a new NavigableString associated with this soup."""
-        navigable = subclass(s)
-        navigable.setup()
-        return navigable
+        return subclass(s)
 
     def insert_before(self, successor):
         raise NotImplementedError("BeautifulSoup objects don't support insert_before().")
@@ -259,7 +286,7 @@ class BeautifulSoup(Tag):
 
     def endData(self, containerClass=NavigableString):
         if self.current_data:
-            current_data = u''.join(self.current_data)
+            current_data = ''.join(self.current_data)
             # If whitespace is not preserved, and this string contains
             # nothing but ASCII spaces, replace it with a single space
             # or newline.
@@ -290,14 +317,49 @@ class BeautifulSoup(Tag):
     def object_was_parsed(self, o, parent=None, most_recent_element=None):
         """Add an object to the parse tree."""
         parent = parent or self.currentTag
-        most_recent_element = most_recent_element or self._most_recent_element
-        o.setup(parent, most_recent_element)
+        previous_element = most_recent_element or self._most_recent_element
+
+        next_element = previous_sibling = next_sibling = None
+        if isinstance(o, Tag):
+            next_element = o.next_element
+            next_sibling = o.next_sibling
+            previous_sibling = o.previous_sibling
+            if not previous_element:
+                previous_element = o.previous_element
+
+        o.setup(parent, previous_element, next_element, previous_sibling, next_sibling)
 
-        if most_recent_element is not None:
-            most_recent_element.next_element = o
         self._most_recent_element = o
         parent.contents.append(o)
 
+        if parent.next_sibling:
+            # This node is being inserted into an element that has
+            # already been parsed. Deal with any dangling references.
+            index = parent.contents.index(o)
+            if index == 0:
+                previous_element = parent
+                previous_sibling = None
+            else:
+                previous_element = previous_sibling = parent.contents[index-1]
+            if index == len(parent.contents)-1:
+                next_element = parent.next_sibling
+                next_sibling = None
+            else:
+                next_element = next_sibling = parent.contents[index+1]
+
+            o.previous_element = previous_element
+            if previous_element:
+                previous_element.next_element = o
+            o.next_element = next_element
+            if next_element:
+                next_element.previous_element = o
+            o.next_sibling = next_sibling
+            if next_sibling:
+                next_sibling.previous_sibling = o
+            o.previous_sibling = previous_sibling
+            if previous_sibling:
+                previous_sibling.next_sibling = o
+
     def _popToTag(self, name, nsprefix=None, inclusivePop=True):
         """Pops the tag stack up to and including the most recent
         instance of the given tag. If inclusivePop is false, pops the tag
@@ -367,9 +429,9 @@ class BeautifulSoup(Tag):
             encoding_part = ''
             if eventual_encoding != None:
                 encoding_part = ' encoding="%s"' % eventual_encoding
-            prefix = u'<?xml version="1.0"%s?>\n' % encoding_part
+            prefix = '<?xml version="1.0"%s?>\n' % encoding_part
         else:
-            prefix = u''
+            prefix = ''
         if not pretty_print:
             indent_level = None
         else:
@@ -403,4 +465,4 @@ class FeatureNotFound(ValueError):
 if __name__ == '__main__':
     import sys
     soup = BeautifulSoup(sys.stdin)
-    print soup.prettify()
+    print(soup.prettify())
diff --git a/lib/bs4/builder/__init__.py b/lib/bs4/builder/__init__.py
index 740f5f2..6ccd4d2 100644
--- a/lib/bs4/builder/__init__.py
+++ b/lib/bs4/builder/__init__.py
@@ -80,9 +80,12 @@ builder_registry = TreeBuilderRegistry()
 class TreeBuilder(object):
     """Turn a document into a Beautiful Soup object tree."""
 
+    NAME = "[Unknown tree builder]"
+    ALTERNATE_NAMES = []
     features = []
 
     is_xml = False
+    picklable = False
     preserve_whitespace_tags = set()
     empty_element_tags = None # A tag will be considered an empty-element
                               # tag when and only when it has no contents.
@@ -153,13 +156,13 @@ class TreeBuilder(object):
             universal = self.cdata_list_attributes.get('*', [])
             tag_specific = self.cdata_list_attributes.get(
                 tag_name.lower(), None)
-            for attr in attrs.keys():
+            for attr in list(attrs.keys()):
                 if attr in universal or (tag_specific and attr in tag_specific):
                     # We have a "class"-type attribute whose string
                     # value is a whitespace-separated list of
                     # values. Split it into a list.
                     value = attrs[attr]
-                    if isinstance(value, basestring):
+                    if isinstance(value, str):
                         values = whitespace_re.split(value)
                     else:
                         # html5lib sometimes calls setAttributes twice
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index 7de36ae..f0e5924 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -2,6 +2,7 @@ __all__ = [
     'HTML5TreeBuilder',
     ]
 
+from pdb import set_trace
 import warnings
 from bs4.builder import (
     PERMISSIVE,
@@ -9,7 +10,10 @@ from bs4.builder import (
     HTML_5,
     HTMLTreeBuilder,
     )
-from bs4.element import NamespacedAttribute
+from bs4.element import (
+    NamespacedAttribute,
+    whitespace_re,
+)
 import html5lib
 from html5lib.constants import namespaces
 from bs4.element import (
@@ -22,11 +26,20 @@ from bs4.element import (
 class HTML5TreeBuilder(HTMLTreeBuilder):
     """Use html5lib to build a tree."""
 
-    features = ['html5lib', PERMISSIVE, HTML_5, HTML]
+    NAME = "html5lib"
+
+    features = [NAME, PERMISSIVE, HTML_5, HTML]
 
-    def prepare_markup(self, markup, user_specified_encoding):
+    def prepare_markup(self, markup, user_specified_encoding,
+                       document_declared_encoding=None, exclude_encodings=None):
         # Store the user-specified encoding for use later on.
         self.user_specified_encoding = user_specified_encoding
+
+        # document_declared_encoding and exclude_encodings aren't used
+        # ATM because the html5lib TreeBuilder doesn't use
+        # UnicodeDammit.
+        if exclude_encodings:
+            warnings.warn("You provided a value for exclude_encoding, but the html5lib tree builder doesn't support exclude_encoding.")
         yield (markup, None, None, False)
 
     # These methods are defined by Beautiful Soup.
@@ -37,7 +50,7 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
         doc = parser.parse(markup, encoding=self.user_specified_encoding)
 
         # Set the character encoding detected by the tokenizer.
-        if isinstance(markup, unicode):
+        if isinstance(markup, str):
             # We need to special-case this because html5lib sets
             # charEncoding to UTF-8 if it gets Unicode input.
             doc.original_encoding = None
@@ -51,7 +64,7 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
 
     def test_fragment_to_document(self, fragment):
         """See `TreeBuilder`."""
-        return u'<html><head></head><body>%s</body></html>' % fragment
+        return '<html><head></head><body>%s</body></html>' % fragment
 
 
 class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
@@ -101,7 +114,16 @@ class AttrList(object):
     def __iter__(self):
         return list(self.attrs.items()).__iter__()
     def __setitem__(self, name, value):
-        "set attr", name, value
+        # If this attribute is a multi-valued attribute for this element,
+        # turn its value into a list.
+        list_attr = HTML5TreeBuilder.cdata_list_attributes
+        if (name in list_attr['*']
+            or (self.element.name in list_attr
+                and name in list_attr[self.element.name])):
+            # A node that is being cloned may have already undergone
+            # this procedure.
+            if not isinstance(value, list):
+                value = whitespace_re.split(value)
         self.element[name] = value
     def items(self):
         return list(self.attrs.items())
@@ -124,7 +146,7 @@ class Element(html5lib.treebuilders._base.Node):
 
     def appendChild(self, node):
         string_child = child = None
-        if isinstance(node, basestring):
+        if isinstance(node, str):
             # Some other piece of code decided to pass in a string
             # instead of creating a TextElement object to contain the
             # string.
@@ -139,7 +161,7 @@ class Element(html5lib.treebuilders._base.Node):
         else:
             child = node.element
 
-        if not isinstance(child, basestring) and child.parent is not None:
+        if not isinstance(child, str) and child.parent is not None:
             node.element.extract()
 
         if (string_child and self.element.contents
@@ -152,7 +174,7 @@ class Element(html5lib.treebuilders._base.Node):
             old_element.replace_with(new_element)
             self.soup._most_recent_element = new_element
         else:
-            if isinstance(node, basestring):
+            if isinstance(node, str):
                 # Create a brand new NavigableString from this string.
                 child = self.soup.new_string(node)
 
@@ -161,6 +183,12 @@ class Element(html5lib.treebuilders._base.Node):
             # immediately after the parent, if it has no children.)
             if self.element.contents:
                 most_recent_element = self.element._last_descendant(False)
+            elif self.element.next_element is not None:
+                # Something from further ahead in the parse tree is
+                # being inserted into this earlier element. This is
+                # very annoying because it means an expensive search
+                # for the last element in the tree.
+                most_recent_element = self.soup._last_descendant()
             else:
                 most_recent_element = self.element
 
@@ -172,6 +200,7 @@ class Element(html5lib.treebuilders._base.Node):
         return AttrList(self.element)
 
     def setAttributes(self, attributes):
+
         if attributes is not None and len(attributes) > 0:
 
             converted_attributes = []
@@ -183,7 +212,7 @@ class Element(html5lib.treebuilders._base.Node):
 
             self.soup.builder._replace_cdata_list_attribute_values(
                 self.name, attributes)
-            for name, value in attributes.items():
+            for name, value in list(attributes.items()):
                 self.element[name] = value
 
             # The attributes may contain variables that need substitution.
@@ -218,6 +247,9 @@ class Element(html5lib.treebuilders._base.Node):
 
     def reparentChildren(self, new_parent):
         """Move all of this tag's children into another tag."""
+        # print "MOVE", self.element.contents
+        # print "FROM", self.element
+        # print "TO", new_parent.element
         element = self.element
         new_parent_element = new_parent.element
         # Determine what this tag's next_element will be once all the children
@@ -236,17 +268,28 @@ class Element(html5lib.treebuilders._base.Node):
             new_parents_last_descendant_next_element = new_parent_element.next_element
 
         to_append = element.contents
-        append_after = new_parent.element.contents
+        append_after = new_parent_element.contents
         if len(to_append) > 0:
             # Set the first child's previous_element and previous_sibling
             # to elements within the new parent
             first_child = to_append[0]
-            first_child.previous_element = new_parents_last_descendant
+            if new_parents_last_descendant:
+                first_child.previous_element = new_parents_last_descendant
+            else:
+                first_child.previous_element = new_parent_element
             first_child.previous_sibling = new_parents_last_child
+            if new_parents_last_descendant:
+                new_parents_last_descendant.next_element = first_child
+            else:
+                new_parent_element.next_element = first_child
+            if new_parents_last_child:
+                new_parents_last_child.next_sibling = first_child
 
             # Fix the last child's next_element and next_sibling
             last_child = to_append[-1]
             last_child.next_element = new_parents_last_descendant_next_element
+            if new_parents_last_descendant_next_element:
+                new_parents_last_descendant_next_element.previous_element = last_child
             last_child.next_sibling = None
 
         for child in to_append:
@@ -257,6 +300,10 @@ class Element(html5lib.treebuilders._base.Node):
         element.contents = []
         element.next_element = final_next_element
 
+        # print "DONE WITH MOVE"
+        # print "FROM", self.element
+        # print "TO", new_parent_element
+
     def cloneNode(self):
         tag = self.soup.new_tag(self.element.name, self.namespace)
         node = Element(tag, self.soup, self.namespace)
diff --git a/lib/bs4/builder/_htmlparser.py b/lib/bs4/builder/_htmlparser.py
index ca8d8b8..bb0a63f 100644
--- a/lib/bs4/builder/_htmlparser.py
+++ b/lib/bs4/builder/_htmlparser.py
@@ -4,10 +4,16 @@ __all__ = [
     'HTMLParserTreeBuilder',
     ]
 
-from HTMLParser import (
-    HTMLParser,
-    HTMLParseError,
-    )
+from html.parser import HTMLParser
+
+try:
+    from html.parser import HTMLParseError
+except ImportError as e:
+    # HTMLParseError is removed in Python 3.5. Since it can never be
+    # thrown in 3.5, we can just define our own class as a placeholder.
+    class HTMLParseError(Exception):
+        pass
+
 import sys
 import warnings
 
@@ -19,10 +25,10 @@ import warnings
 # At the end of this file, we monkeypatch HTMLParser so that
 # strict=True works well on Python 3.2.2.
 major, minor, release = sys.version_info[:3]
-CONSTRUCTOR_TAKES_STRICT = (
-    major > 3
-    or (major == 3 and minor > 2)
-    or (major == 3 and minor == 2 and release >= 3))
+CONSTRUCTOR_TAKES_STRICT = major == 3 and minor == 2 and release >= 3
+CONSTRUCTOR_STRICT_IS_DEPRECATED = major == 3 and minor == 3
+CONSTRUCTOR_TAKES_CONVERT_CHARREFS = major == 3 and minor >= 4
+
 
 from bs4.element import (
     CData,
@@ -63,7 +69,8 @@ class BeautifulSoupHTMLParser(HTMLParser):
 
     def handle_charref(self, name):
         # XXX workaround for a bug in HTMLParser. Remove this once
-        # it's fixed.
+        # it's fixed in all supported versions.
+        # http://bugs.python.org/issue13633
         if name.startswith('x'):
             real_name = int(name.lstrip('x'), 16)
         elif name.startswith('X'):
@@ -72,9 +79,9 @@ class BeautifulSoupHTMLParser(HTMLParser):
             real_name = int(name)
 
         try:
-            data = unichr(real_name)
-        except (ValueError, OverflowError), e:
-            data = u"\N{REPLACEMENT CHARACTER}"
+            data = chr(real_name)
+        except (ValueError, OverflowError) as e:
+            data = "\N{REPLACEMENT CHARACTER}"
 
         self.handle_data(data)
 
@@ -113,14 +120,6 @@ class BeautifulSoupHTMLParser(HTMLParser):
 
     def handle_pi(self, data):
         self.soup.endData()
-        if data.endswith("?") and data.lower().startswith("xml"):
-            # "An XHTML processing instruction using the trailing '?'
-            # will cause the '?' to be included in data." - HTMLParser
-            # docs.
-            #
-            # Strip the question mark so we don't end up with two
-            # question marks.
-            data = data[:-1]
         self.soup.handle_data(data)
         self.soup.endData(ProcessingInstruction)
 
@@ -128,26 +127,31 @@ class BeautifulSoupHTMLParser(HTMLParser):
 class HTMLParserTreeBuilder(HTMLTreeBuilder):
 
     is_xml = False
-    features = [HTML, STRICT, HTMLPARSER]
+    picklable = True
+    NAME = HTMLPARSER
+    features = [NAME, HTML, STRICT]
 
     def __init__(self, *args, **kwargs):
-        if CONSTRUCTOR_TAKES_STRICT:
+        if CONSTRUCTOR_TAKES_STRICT and not CONSTRUCTOR_STRICT_IS_DEPRECATED:
             kwargs['strict'] = False
+        if CONSTRUCTOR_TAKES_CONVERT_CHARREFS:
+            kwargs['convert_charrefs'] = False
         self.parser_args = (args, kwargs)
 
     def prepare_markup(self, markup, user_specified_encoding=None,
-                       document_declared_encoding=None):
+                       document_declared_encoding=None, exclude_encodings=None):
         """
         :return: A 4-tuple (markup, original encoding, encoding
         declared within markup, whether any characters had to be
         replaced with REPLACEMENT CHARACTER).
         """
-        if isinstance(markup, unicode):
+        if isinstance(markup, str):
             yield (markup, None, None, False)
             return
 
         try_encodings = [user_specified_encoding, document_declared_encoding]
-        dammit = UnicodeDammit(markup, try_encodings, is_html=True)
+        dammit = UnicodeDammit(markup, try_encodings, is_html=True,
+                               exclude_encodings=exclude_encodings)
         yield (dammit.markup, dammit.original_encoding,
                dammit.declared_html_encoding,
                dammit.contains_replacement_characters)
@@ -158,7 +162,7 @@ class HTMLParserTreeBuilder(HTMLTreeBuilder):
         parser.soup = self.soup
         try:
             parser.feed(markup)
-        except HTMLParseError, e:
+        except HTMLParseError as e:
             warnings.warn(RuntimeWarning(
                 "Python's built-in HTMLParser cannot parse the given document. This is not a bug in Beautiful Soup. The best solution is to install an external parser (lxml or html5lib), and use Beautiful Soup with that parser. See http://www.crummy.com/software/BeautifulSoup/bs4/doc/#installing-a-parser for help."))
             raise e
diff --git a/lib/bs4/builder/_lxml.py b/lib/bs4/builder/_lxml.py
index fa5d498..9c6c14e 100644
--- a/lib/bs4/builder/_lxml.py
+++ b/lib/bs4/builder/_lxml.py
@@ -4,10 +4,15 @@ __all__ = [
     ]
 
 from io import BytesIO
-from StringIO import StringIO
+from io import StringIO
 import collections
 from lxml import etree
-from bs4.element import Comment, Doctype, NamespacedAttribute
+from bs4.element import (
+    Comment,
+    Doctype,
+    NamespacedAttribute,
+    ProcessingInstruction,
+)
 from bs4.builder import (
     FAST,
     HTML,
@@ -25,8 +30,11 @@ class LXMLTreeBuilderForXML(TreeBuilder):
 
     is_xml = True
 
+    NAME = "lxml-xml"
+    ALTERNATE_NAMES = ["xml"]
+
     # Well, it's permissive by XML parser standards.
-    features = [LXML, XML, FAST, PERMISSIVE]
+    features = [NAME, LXML, XML, FAST, PERMISSIVE]
 
     CHUNK_SIZE = 512
 
@@ -70,6 +78,7 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             return (None, tag)
 
     def prepare_markup(self, markup, user_specified_encoding=None,
+                       exclude_encodings=None,
                        document_declared_encoding=None):
         """
         :yield: A series of 4-tuples.
@@ -78,12 +87,12 @@ class LXMLTreeBuilderForXML(TreeBuilder):
 
         Each 4-tuple represents a strategy for parsing the document.
         """
-        if isinstance(markup, unicode):
+        if isinstance(markup, str):
             # We were given Unicode. Maybe lxml can parse Unicode on
             # this system?
             yield markup, None, document_declared_encoding, False
 
-        if isinstance(markup, unicode):
+        if isinstance(markup, str):
             # No, apparently not. Convert the Unicode to UTF-8 and
             # tell lxml to parse it as UTF-8.
             yield (markup.encode("utf8"), "utf8",
@@ -95,14 +104,15 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         # the document as each one in turn.
         is_html = not self.is_xml
         try_encodings = [user_specified_encoding, document_declared_encoding]
-        detector = EncodingDetector(markup, try_encodings, is_html)
+        detector = EncodingDetector(
+            markup, try_encodings, is_html, exclude_encodings)
         for encoding in detector.encodings:
             yield (detector.markup, encoding, document_declared_encoding, False)
 
     def feed(self, markup):
         if isinstance(markup, bytes):
             markup = BytesIO(markup)
-        elif isinstance(markup, unicode):
+        elif isinstance(markup, str):
             markup = StringIO(markup)
 
         # Call feed() at least once, even if the markup is empty,
@@ -117,7 +127,7 @@ class LXMLTreeBuilderForXML(TreeBuilder):
                 if len(data) != 0:
                     self.parser.feed(data)
             self.parser.close()
-        except (UnicodeDecodeError, LookupError, etree.ParserError), e:
+        except (UnicodeDecodeError, LookupError, etree.ParserError) as e:
             raise ParserRejectedMarkup(str(e))
 
     def close(self):
@@ -135,12 +145,12 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             self.nsmaps.append(None)
         elif len(nsmap) > 0:
             # A new namespace mapping has come into play.
-            inverted_nsmap = dict((value, key) for key, value in nsmap.items())
+            inverted_nsmap = dict((value, key) for key, value in list(nsmap.items()))
             self.nsmaps.append(inverted_nsmap)
             # Also treat the namespace mapping as a set of attributes on the
             # tag, so we can recreate it later.
             attrs = attrs.copy()
-            for prefix, namespace in nsmap.items():
+            for prefix, namespace in list(nsmap.items()):
                 attribute = NamespacedAttribute(
                     "xmlns", prefix, "http://www.w3.org/2000/xmlns/")
                 attrs[attribute] = namespace
@@ -149,7 +159,7 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         # from lxml with namespaces attached to their names, and
         # turn then into NamespacedAttribute objects.
         new_attrs = {}
-        for attr, value in attrs.items():
+        for attr, value in list(attrs.items()):
             namespace, attr = self._getNsTag(attr)
             if namespace is None:
                 new_attrs[attr] = value
@@ -189,7 +199,9 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             self.nsmaps.pop()
 
     def pi(self, target, data):
-        pass
+        self.soup.endData()
+        self.soup.handle_data(target + ' ' + data)
+        self.soup.endData(ProcessingInstruction)
 
     def data(self, content):
         self.soup.handle_data(content)
@@ -207,12 +219,15 @@ class LXMLTreeBuilderForXML(TreeBuilder):
 
     def test_fragment_to_document(self, fragment):
         """See `TreeBuilder`."""
-        return u'<?xml version="1.0" encoding="utf-8"?>\n%s' % fragment
+        return '<?xml version="1.0" encoding="utf-8"?>\n%s' % fragment
 
 
 class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
 
-    features = [LXML, HTML, FAST, PERMISSIVE]
+    NAME = LXML
+    ALTERNATE_NAMES = ["lxml-html"]
+
+    features = ALTERNATE_NAMES + [NAME, HTML, FAST, PERMISSIVE]
     is_xml = False
 
     def default_parser(self, encoding):
@@ -224,10 +239,10 @@ class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
             self.parser = self.parser_for(encoding)
             self.parser.feed(markup)
             self.parser.close()
-        except (UnicodeDecodeError, LookupError, etree.ParserError), e:
+        except (UnicodeDecodeError, LookupError, etree.ParserError) as e:
             raise ParserRejectedMarkup(str(e))
 
 
     def test_fragment_to_document(self, fragment):
         """See `TreeBuilder`."""
-        return u'<html><body>%s</body></html>' % fragment
+        return '<html><body>%s</body></html>' % fragment
diff --git a/lib/bs4/dammit.py b/lib/bs4/dammit.py
index 59640b7..68d419f 100644
--- a/lib/bs4/dammit.py
+++ b/lib/bs4/dammit.py
@@ -3,12 +3,14 @@
 
 This library converts a bytestream to Unicode through any means
 necessary. It is heavily based on code from Mark Pilgrim's Universal
-Feed Parser. It works best on XML and XML, but it does not rewrite the
+Feed Parser. It works best on XML and HTML, but it does not rewrite the
 XML or HTML to reflect a new encoding; that's the tree builder's job.
 """
+__license__ = "MIT"
 
+from pdb import set_trace
 import codecs
-from htmlentitydefs import codepoint2name
+from html.entities import codepoint2name
 import re
 import logging
 import string
@@ -56,7 +58,7 @@ class EntitySubstitution(object):
         reverse_lookup = {}
         characters_for_re = []
         for codepoint, name in list(codepoint2name.items()):
-            character = unichr(codepoint)
+            character = chr(codepoint)
             if codepoint != 34:
                 # There's no point in turning the quotation mark into
                 # &quot;, unless it happens within an attribute value, which
@@ -212,8 +214,11 @@ class EncodingDetector:
 
     5. Windows-1252.
     """
-    def __init__(self, markup, override_encodings=None, is_html=False):
+    def __init__(self, markup, override_encodings=None, is_html=False,
+                 exclude_encodings=None):
         self.override_encodings = override_encodings or []
+        exclude_encodings = exclude_encodings or []
+        self.exclude_encodings = set([x.lower() for x in exclude_encodings])
         self.chardet_encoding = None
         self.is_html = is_html
         self.declared_encoding = None
@@ -224,6 +229,8 @@ class EncodingDetector:
     def _usable(self, encoding, tried):
         if encoding is not None:
             encoding = encoding.lower()
+            if encoding in self.exclude_encodings:
+                return False
             if encoding not in tried:
                 tried.add(encoding)
                 return True
@@ -266,6 +273,9 @@ class EncodingDetector:
     def strip_byte_order_mark(cls, data):
         """If a byte-order mark is present, strip it and return the encoding it implies."""
         encoding = None
+        if isinstance(data, str):
+            # Unicode data cannot have a byte-order mark.
+            return data, encoding
         if (len(data) >= 4) and (data[:2] == b'\xfe\xff') \
                and (data[2:4] != '\x00\x00'):
             encoding = 'utf-16be'
@@ -306,7 +316,7 @@ class EncodingDetector:
             declared_encoding_match = html_meta_re.search(markup, endpos=html_endpos)
         if declared_encoding_match is not None:
             declared_encoding = declared_encoding_match.groups()[0].decode(
-                'ascii')
+                'ascii', 'replace')
         if declared_encoding:
             return declared_encoding.lower()
         return None
@@ -331,18 +341,19 @@ class UnicodeDammit:
         ]
 
     def __init__(self, markup, override_encodings=[],
-                 smart_quotes_to=None, is_html=False):
+                 smart_quotes_to=None, is_html=False, exclude_encodings=[]):
         self.smart_quotes_to = smart_quotes_to
         self.tried_encodings = []
         self.contains_replacement_characters = False
         self.is_html = is_html
 
-        self.detector = EncodingDetector(markup, override_encodings, is_html)
+        self.detector = EncodingDetector(
+            markup, override_encodings, is_html, exclude_encodings)
 
         # Short-circuit if the data is in Unicode to begin with.
-        if isinstance(markup, unicode) or markup == '':
+        if isinstance(markup, str) or markup == '':
             self.markup = markup
-            self.unicode_markup = unicode(markup)
+            self.unicode_markup = str(markup)
             self.original_encoding = None
             return
 
@@ -425,7 +436,7 @@ class UnicodeDammit:
     def _to_unicode(self, data, encoding, errors="strict"):
         '''Given a string and its encoding, decodes the string into Unicode.
         %encoding is a string recognized by encodings.aliases'''
-        return unicode(data, encoding, errors)
+        return str(data, encoding, errors)
 
     @property
     def declared_html_encoding(self):
diff --git a/lib/bs4/diagnose.py b/lib/bs4/diagnose.py
index 4d0b00a..083395f 100644
--- a/lib/bs4/diagnose.py
+++ b/lib/bs4/diagnose.py
@@ -1,7 +1,10 @@
 """Diagnostic functions, mainly for use when doing tech support."""
+
+__license__ = "MIT"
+
 import cProfile
-from StringIO import StringIO
-from HTMLParser import HTMLParser
+from io import StringIO
+from html.parser import HTMLParser
 import bs4
 from bs4 import BeautifulSoup, __version__
 from bs4.builder import builder_registry
@@ -17,8 +20,8 @@ import cProfile
 
 def diagnose(data):
     """Diagnostic suite for isolating common problems."""
-    print "Diagnostic running on Beautiful Soup %s" % __version__
-    print "Python version %s" % sys.version
+    print("Diagnostic running on Beautiful Soup %s" % __version__)
+    print("Python version %s" % sys.version)
 
     basic_parsers = ["html.parser", "html5lib", "lxml"]
     for name in basic_parsers:
@@ -27,44 +30,53 @@ def diagnose(data):
                 break
         else:
             basic_parsers.remove(name)
-            print (
+            print((
                 "I noticed that %s is not installed. Installing it may help." %
-                name)
+                name))
 
     if 'lxml' in basic_parsers:
         basic_parsers.append(["lxml", "xml"])
-        from lxml import etree
-        print "Found lxml version %s" % ".".join(map(str,etree.LXML_VERSION))
+        try:
+            from lxml import etree
+            print("Found lxml version %s" % ".".join(map(str,etree.LXML_VERSION)))
+        except ImportError as e:
+            print (
+                "lxml is not installed or couldn't be imported.")
+
 
     if 'html5lib' in basic_parsers:
-        import html5lib
-        print "Found html5lib version %s" % html5lib.__version__
+        try:
+            import html5lib
+            print("Found html5lib version %s" % html5lib.__version__)
+        except ImportError as e:
+            print (
+                "html5lib is not installed or couldn't be imported.")
 
     if hasattr(data, 'read'):
         data = data.read()
     elif os.path.exists(data):
-        print '"%s" looks like a filename. Reading data from the file.' % data
+        print('"%s" looks like a filename. Reading data from the file.' % data)
         data = open(data).read()
     elif data.startswith("http:") or data.startswith("https:"):
-        print '"%s" looks like a URL. Beautiful Soup is not an HTTP client.' % data
-        print "You need to use some other library to get the document behind the URL, and feed that document to Beautiful Soup."
+        print('"%s" looks like a URL. Beautiful Soup is not an HTTP client.' % data)
+        print("You need to use some other library to get the document behind the URL, and feed that document to Beautiful Soup.")
         return
-    print
+    print()
 
     for parser in basic_parsers:
-        print "Trying to parse your markup with %s" % parser
+        print("Trying to parse your markup with %s" % parser)
         success = False
         try:
             soup = BeautifulSoup(data, parser)
             success = True
-        except Exception, e:
-            print "%s could not parse the markup." % parser
+        except Exception as e:
+            print("%s could not parse the markup." % parser)
             traceback.print_exc()
         if success:
-            print "Here's what %s did with the markup:" % parser
-            print soup.prettify()
+            print("Here's what %s did with the markup:" % parser)
+            print(soup.prettify())
 
-        print "-" * 80
+        print("-" * 80)
 
 def lxml_trace(data, html=True, **kwargs):
     """Print out the lxml events that occur during parsing.
@@ -74,7 +86,7 @@ def lxml_trace(data, html=True, **kwargs):
     """
     from lxml import etree
     for event, element in etree.iterparse(StringIO(data), html=html, **kwargs):
-        print("%s, %4s, %s" % (event, element.tag, element.text))
+        print(("%s, %4s, %s" % (event, element.tag, element.text)))
 
 class AnnouncingParser(HTMLParser):
     """Announces HTMLParser parse events, without doing anything else."""
@@ -156,9 +168,9 @@ def rdoc(num_elements=1000):
 
 def benchmark_parsers(num_elements=100000):
     """Very basic head-to-head performance benchmark."""
-    print "Comparative parser benchmark on Beautiful Soup %s" % __version__
+    print("Comparative parser benchmark on Beautiful Soup %s" % __version__)
     data = rdoc(num_elements)
-    print "Generated a large invalid HTML document (%d bytes)." % len(data)
+    print("Generated a large invalid HTML document (%d bytes)." % len(data))
     
     for parser in ["lxml", ["lxml", "html"], "html5lib", "html.parser"]:
         success = False
@@ -167,24 +179,24 @@ def benchmark_parsers(num_elements=100000):
             soup = BeautifulSoup(data, parser)
             b = time.time()
             success = True
-        except Exception, e:
-            print "%s could not parse the markup." % parser
+        except Exception as e:
+            print("%s could not parse the markup." % parser)
             traceback.print_exc()
         if success:
-            print "BS4+%s parsed the markup in %.2fs." % (parser, b-a)
+            print("BS4+%s parsed the markup in %.2fs." % (parser, b-a))
 
     from lxml import etree
     a = time.time()
     etree.HTML(data)
     b = time.time()
-    print "Raw lxml parsed the markup in %.2fs." % (b-a)
+    print("Raw lxml parsed the markup in %.2fs." % (b-a))
 
     import html5lib
     parser = html5lib.HTMLParser()
     a = time.time()
     parser.parse(data)
     b = time.time()
-    print "Raw html5lib parsed the markup in %.2fs." % (b-a)
+    print("Raw html5lib parsed the markup in %.2fs." % (b-a))
 
 def profile(num_elements=100000, parser="lxml"):
 
diff --git a/lib/bs4/element.py b/lib/bs4/element.py
index da9afdf..0e62c2e 100644
--- a/lib/bs4/element.py
+++ b/lib/bs4/element.py
@@ -1,3 +1,6 @@
+__license__ = "MIT"
+
+from pdb import set_trace
 import collections
 import re
 import sys
@@ -21,22 +24,22 @@ def _alias(attr):
     return alias
 
 
-class NamespacedAttribute(unicode):
+class NamespacedAttribute(str):
 
     def __new__(cls, prefix, name, namespace=None):
         if name is None:
-            obj = unicode.__new__(cls, prefix)
+            obj = str.__new__(cls, prefix)
         elif prefix is None:
             # Not really namespaced.
-            obj = unicode.__new__(cls, name)
+            obj = str.__new__(cls, name)
         else:
-            obj = unicode.__new__(cls, prefix + ":" + name)
+            obj = str.__new__(cls, prefix + ":" + name)
         obj.prefix = prefix
         obj.name = name
         obj.namespace = namespace
         return obj
 
-class AttributeValueWithCharsetSubstitution(unicode):
+class AttributeValueWithCharsetSubstitution(str):
     """A stand-in object for a character encoding specified in HTML."""
 
 class CharsetMetaAttributeValue(AttributeValueWithCharsetSubstitution):
@@ -47,7 +50,7 @@ class CharsetMetaAttributeValue(AttributeValueWithCharsetSubstitution):
     """
 
     def __new__(cls, original_value):
-        obj = unicode.__new__(cls, original_value)
+        obj = str.__new__(cls, original_value)
         obj.original_value = original_value
         return obj
 
@@ -70,9 +73,9 @@ class ContentMetaAttributeValue(AttributeValueWithCharsetSubstitution):
         match = cls.CHARSET_RE.search(original_value)
         if match is None:
             # No substitution necessary.
-            return unicode.__new__(unicode, original_value)
+            return str.__new__(str, original_value)
 
-        obj = unicode.__new__(cls, original_value)
+        obj = str.__new__(cls, original_value)
         obj.original_value = original_value
         return obj
 
@@ -152,7 +155,7 @@ class PageElement(object):
 
     def format_string(self, s, formatter='minimal'):
         """Format the given string using the given formatter."""
-        if not callable(formatter):
+        if not isinstance(formatter, collections.Callable):
             formatter = self._formatter_for_name(formatter)
         if formatter is None:
             output = s
@@ -185,24 +188,40 @@ class PageElement(object):
             return self.HTML_FORMATTERS.get(
                 name, HTMLAwareEntitySubstitution.substitute_xml)
 
-    def setup(self, parent=None, previous_element=None):
+    def setup(self, parent=None, previous_element=None, next_element=None,
+              previous_sibling=None, next_sibling=None):
         """Sets up the initial relations between this element and
         other elements."""
         self.parent = parent
+
         self.previous_element = previous_element
         if previous_element is not None:
             self.previous_element.next_element = self
-        self.next_element = None
-        self.previous_sibling = None
-        self.next_sibling = None
-        if self.parent is not None and self.parent.contents:
-            self.previous_sibling = self.parent.contents[-1]
+
+        self.next_element = next_element
+        if self.next_element:
+            self.next_element.previous_element = self
+
+        self.next_sibling = next_sibling
+        if self.next_sibling:
+            self.next_sibling.previous_sibling = self
+
+        if (not previous_sibling
+            and self.parent is not None and self.parent.contents):
+            previous_sibling = self.parent.contents[-1]
+
+        self.previous_sibling = previous_sibling
+        if previous_sibling:
             self.previous_sibling.next_sibling = self
 
     nextSibling = _alias("next_sibling")  # BS3
     previousSibling = _alias("previous_sibling")  # BS3
 
     def replace_with(self, replace_with):
+        if not self.parent:
+            raise ValueError(
+                "Cannot replace one element with another when the"
+                "element to be replaced is not part of a tree.")
         if replace_with is self:
             return
         if replace_with is self.parent:
@@ -216,6 +235,10 @@ class PageElement(object):
 
     def unwrap(self):
         my_parent = self.parent
+        if not self.parent:
+            raise ValueError(
+                "Cannot replace an element with its contents when that"
+                "element is not part of a tree.")
         my_index = self.parent.index(self)
         self.extract()
         for child in reversed(self.contents[:]):
@@ -240,17 +263,20 @@ class PageElement(object):
         last_child = self._last_descendant()
         next_element = last_child.next_element
 
-        if self.previous_element is not None:
+        if (self.previous_element is not None and
+            self.previous_element is not next_element):
             self.previous_element.next_element = next_element
-        if next_element is not None:
+        if next_element is not None and next_element is not self.previous_element:
             next_element.previous_element = self.previous_element
         self.previous_element = None
         last_child.next_element = None
 
         self.parent = None
-        if self.previous_sibling is not None:
+        if (self.previous_sibling is not None
+            and self.previous_sibling is not self.next_sibling):
             self.previous_sibling.next_sibling = self.next_sibling
-        if self.next_sibling is not None:
+        if (self.next_sibling is not None
+            and self.next_sibling is not self.previous_sibling):
             self.next_sibling.previous_sibling = self.previous_sibling
         self.previous_sibling = self.next_sibling = None
         return self
@@ -263,16 +289,18 @@ class PageElement(object):
             last_child = self
             while isinstance(last_child, Tag) and last_child.contents:
                 last_child = last_child.contents[-1]
-        if not accept_self and last_child == self:
+        if not accept_self and last_child is self:
             last_child = None
         return last_child
     # BS3: Not part of the API!
     _lastRecursiveChild = _last_descendant
 
     def insert(self, position, new_child):
+        if new_child is None:
+            raise ValueError("Cannot insert None into a tag.")
         if new_child is self:
             raise ValueError("Cannot insert a tag into itself.")
-        if (isinstance(new_child, basestring)
+        if (isinstance(new_child, str)
             and not isinstance(new_child, NavigableString)):
             new_child = NavigableString(new_child)
 
@@ -478,6 +506,10 @@ class PageElement(object):
     def _find_all(self, name, attrs, text, limit, generator, **kwargs):
         "Iterates over a generator looking for things that match."
 
+        if text is None and 'string' in kwargs:
+            text = kwargs['string']
+            del kwargs['string']
+
         if isinstance(name, SoupStrainer):
             strainer = name
         else:
@@ -489,7 +521,7 @@ class PageElement(object):
                 result = (element for element in generator
                           if isinstance(element, Tag))
                 return ResultSet(strainer, result)
-            elif isinstance(name, basestring):
+            elif isinstance(name, str):
                 # Optimization to find all tags with a given name.
                 result = (element for element in generator
                           if isinstance(element, Tag)
@@ -548,17 +580,17 @@ class PageElement(object):
 
     # Methods for supporting CSS selectors.
 
-    tag_name_re = re.compile('^[a-z0-9]+$')
+    tag_name_re = re.compile('^[a-zA-Z0-9][-.a-zA-Z0-9:_]*$')
 
-    # /^(\w+)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/
-    #   \---/  \---/\-------------/    \-------/
-    #     |      |         |               |
-    #     |      |         |           The value
-    #     |      |    ~,|,^,$,* or =
-    #     |   Attribute
+    # /^([a-zA-Z0-9][-.a-zA-Z0-9:_]*)\[(\w+)([=~\|\^\$\*]?)=?"?([^\]"]*)"?\]$/
+    #   \---------------------------/  \---/\-------------/    \-------/
+    #     |                              |         |               |
+    #     |                              |         |           The value
+    #     |                              |    ~,|,^,$,* or =
+    #     |                           Attribute
     #    Tag
     attribselect_re = re.compile(
-        r'^(?P<tag>\w+)?\[(?P<attribute>\w+)(?P<operator>[=~\|\^\$\*]?)' +
+        r'^(?P<tag>[a-zA-Z0-9][-.a-zA-Z0-9:_]*)?\[(?P<attribute>[\w-]+)(?P<operator>[=~\|\^\$\*]?)' +
         r'=?"?(?P<value>[^\]"]*)"?\]$'
         )
 
@@ -640,7 +672,7 @@ class PageElement(object):
         return self.parents
 
 
-class NavigableString(unicode, PageElement):
+class NavigableString(str, PageElement):
 
     PREFIX = ''
     SUFFIX = ''
@@ -653,15 +685,21 @@ class NavigableString(unicode, PageElement):
         passed in to the superclass's __new__ or the superclass won't know
         how to handle non-ASCII characters.
         """
-        if isinstance(value, unicode):
-            return unicode.__new__(cls, value)
-        return unicode.__new__(cls, value, DEFAULT_OUTPUT_ENCODING)
+        if isinstance(value, str):
+            u = str.__new__(cls, value)
+        else:
+            u = str.__new__(cls, value, DEFAULT_OUTPUT_ENCODING)
+        u.setup()
+        return u
 
     def __copy__(self):
-        return self
+        """A copy of a NavigableString has the same contents and class
+        as the original, but it is not connected to the parse tree.
+        """
+        return type(self)(self)
 
     def __getnewargs__(self):
-        return (unicode(self),)
+        return (str(self),)
 
     def __getattr__(self, attr):
         """text.string gives you text. This is for backwards
@@ -701,23 +739,23 @@ class PreformattedString(NavigableString):
 
 class CData(PreformattedString):
 
-    PREFIX = u'<![CDATA['
-    SUFFIX = u']]>'
+    PREFIX = '<![CDATA['
+    SUFFIX = ']]>'
 
 class ProcessingInstruction(PreformattedString):
 
-    PREFIX = u'<?'
-    SUFFIX = u'?>'
+    PREFIX = '<?'
+    SUFFIX = '>'
 
 class Comment(PreformattedString):
 
-    PREFIX = u'<!--'
-    SUFFIX = u'-->'
+    PREFIX = '<!--'
+    SUFFIX = '-->'
 
 
 class Declaration(PreformattedString):
-    PREFIX = u'<!'
-    SUFFIX = u'!>'
+    PREFIX = '<?'
+    SUFFIX = '?>'
 
 
 class Doctype(PreformattedString):
@@ -734,8 +772,8 @@ class Doctype(PreformattedString):
 
         return Doctype(value)
 
-    PREFIX = u'<!DOCTYPE '
-    SUFFIX = u'>\n'
+    PREFIX = '<!DOCTYPE '
+    SUFFIX = '>\n'
 
 
 class Tag(PageElement):
@@ -759,9 +797,12 @@ class Tag(PageElement):
         self.prefix = prefix
         if attrs is None:
             attrs = {}
-        elif attrs and builder.cdata_list_attributes:
-            attrs = builder._replace_cdata_list_attribute_values(
-                self.name, attrs)
+        elif attrs:
+            if builder is not None and builder.cdata_list_attributes:
+                attrs = builder._replace_cdata_list_attribute_values(
+                    self.name, attrs)
+            else:
+                attrs = dict(attrs)
         else:
             attrs = dict(attrs)
         self.attrs = attrs
@@ -778,6 +819,18 @@ class Tag(PageElement):
 
     parserClass = _alias("parser_class")  # BS3
 
+    def __copy__(self):
+        """A copy of a Tag is a new Tag, unconnected to the parse tree.
+        Its contents are a copy of the old Tag's contents.
+        """
+        clone = type(self)(None, self.builder, self.name, self.namespace,
+                           self.nsprefix, self.attrs)
+        for attr in ('can_be_empty_element', 'hidden'):
+            setattr(clone, attr, getattr(self, attr))
+        for child in self.contents:
+            clone.append(child.__copy__())
+        return clone
+
     @property
     def is_empty_element(self):
         """Is this tag an empty-element tag? (aka a self-closing tag)
@@ -843,7 +896,7 @@ class Tag(PageElement):
         for string in self._all_strings(True):
             yield string
 
-    def get_text(self, separator=u"", strip=False,
+    def get_text(self, separator="", strip=False,
                  types=(NavigableString, CData)):
         """
         Get all child strings, concatenated using the given separator.
@@ -915,7 +968,7 @@ class Tag(PageElement):
     def __contains__(self, x):
         return x in self.contents
 
-    def __nonzero__(self):
+    def __bool__(self):
         "A tag is non-None even if it has no contents."
         return True
 
@@ -971,15 +1024,25 @@ class Tag(PageElement):
         as defined in __eq__."""
         return not self == other
 
-    def __repr__(self, encoding=DEFAULT_OUTPUT_ENCODING):
+    def __repr__(self, encoding="unicode-escape"):
         """Renders this tag as a string."""
-        return self.encode(encoding)
+        if PY3K:
+            # "The return value must be a string object", i.e. Unicode
+            return self.decode()
+        else:
+            # "The return value must be a string object", i.e. a bytestring.
+            # By convention, the return value of __repr__ should also be
+            # an ASCII string.
+            return self.encode(encoding)
 
     def __unicode__(self):
         return self.decode()
 
     def __str__(self):
-        return self.encode()
+        if PY3K:
+            return self.decode()
+        else:
+            return self.encode()
 
     if PY3K:
         __str__ = __repr__ = __unicode__
@@ -1014,7 +1077,7 @@ class Tag(PageElement):
 
         # First off, turn a string formatter into a function. This
         # will stop the lookup from happening over and over again.
-        if not callable(formatter):
+        if not isinstance(formatter, collections.Callable):
             formatter = self._formatter_for_name(formatter)
 
         attrs = []
@@ -1025,8 +1088,8 @@ class Tag(PageElement):
                 else:
                     if isinstance(val, list) or isinstance(val, tuple):
                         val = ' '.join(val)
-                    elif not isinstance(val, basestring):
-                        val = unicode(val)
+                    elif not isinstance(val, str):
+                        val = str(val)
                     elif (
                         isinstance(val, AttributeValueWithCharsetSubstitution)
                         and eventual_encoding is not None):
@@ -1034,7 +1097,7 @@ class Tag(PageElement):
 
                     text = self.format_string(val, formatter)
                     decoded = (
-                        unicode(key) + '='
+                        str(key) + '='
                         + EntitySubstitution.quoted_attribute_value(text))
                 attrs.append(decoded)
         close = ''
@@ -1103,16 +1166,22 @@ class Tag(PageElement):
                        formatter="minimal"):
         """Renders the contents of this tag as a Unicode string.
 
+        :param indent_level: Each line of the rendering will be
+           indented this many spaces.
+
         :param eventual_encoding: The tag is destined to be
            encoded into this encoding. This method is _not_
            responsible for performing that encoding. This information
            is passed in so that it can be substituted in if the
            document contains a <META> tag that mentions the document's
            encoding.
+
+        :param formatter: The output formatter responsible for converting
+           entities to Unicode characters.
         """
         # First off, turn a string formatter into a function. This
         # will stop the lookup from happening over and over again.
-        if not callable(formatter):
+        if not isinstance(formatter, collections.Callable):
             formatter = self._formatter_for_name(formatter)
 
         pretty_print = (indent_level is not None)
@@ -1137,7 +1206,17 @@ class Tag(PageElement):
     def encode_contents(
         self, indent_level=None, encoding=DEFAULT_OUTPUT_ENCODING,
         formatter="minimal"):
-        """Renders the contents of this tag as a bytestring."""
+        """Renders the contents of this tag as a bytestring.
+
+        :param indent_level: Each line of the rendering will be
+           indented this many spaces.
+
+        :param eventual_encoding: The bytestring will be in this encoding.
+
+        :param formatter: The output formatter responsible for converting
+           entities to Unicode characters.
+        """
+
         contents = self.decode_contents(indent_level, encoding, formatter)
         return contents.encode(encoding)
 
@@ -1201,26 +1280,57 @@ class Tag(PageElement):
 
     _selector_combinators = ['>', '+', '~']
     _select_debug = False
-    def select(self, selector, _candidate_generator=None):
+    def select_one(self, selector):
+        """Perform a CSS selection operation on the current element."""
+        value = self.select(selector, limit=1)
+        if value:
+            return value[0]
+        return None
+
+    def select(self, selector, _candidate_generator=None, limit=None):
         """Perform a CSS selection operation on the current element."""
+
+        # Handle grouping selectors if ',' exists, ie: p,a
+        if ',' in selector:
+            context = []
+            for partial_selector in selector.split(','):
+                partial_selector = partial_selector.strip()
+                if partial_selector == '':
+                    raise ValueError('Invalid group selection syntax: %s' % selector)
+                candidates = self.select(partial_selector, limit=limit)
+                for candidate in candidates:
+                    if candidate not in context:
+                        context.append(candidate)
+
+                if limit and len(context) >= limit:
+                    break
+            return context
+
         tokens = selector.split()
         current_context = [self]
 
         if tokens[-1] in self._selector_combinators:
             raise ValueError(
                 'Final combinator "%s" is missing an argument.' % tokens[-1])
+
         if self._select_debug:
-            print 'Running CSS selector "%s"' % selector
+            print('Running CSS selector "%s"' % selector)
+
         for index, token in enumerate(tokens):
-            if self._select_debug:
-                print ' Considering token "%s"' % token
-            recursive_candidate_generator = None
-            tag_name = None
+            new_context = []
+            new_context_ids = set([])
+
             if tokens[index-1] in self._selector_combinators:
                 # This token was consumed by the previous combinator. Skip it.
                 if self._select_debug:
-                    print '  Token was consumed by the previous combinator.'
+                    print('  Token was consumed by the previous combinator.')
                 continue
+
+            if self._select_debug:
+                print(' Considering token "%s"' % token)
+            recursive_candidate_generator = None
+            tag_name = None
+
             # Each operation corresponds to a checker function, a rule
             # for determining whether a candidate matches the
             # selector. Candidates are generated by the active
@@ -1256,35 +1366,38 @@ class Tag(PageElement):
                         "A pseudo-class must be prefixed with a tag name.")
                 pseudo_attributes = re.match('([a-zA-Z\d-]+)\(([a-zA-Z\d]+)\)', pseudo)
                 found = []
-                if pseudo_attributes is not None:
+                if pseudo_attributes is None:
+                    pseudo_type = pseudo
+                    pseudo_value = None
+                else:
                     pseudo_type, pseudo_value = pseudo_attributes.groups()
-                    if pseudo_type == 'nth-of-type':
-                        try:
-                            pseudo_value = int(pseudo_value)
-                        except:
-                            raise NotImplementedError(
-                                'Only numeric values are currently supported for the nth-of-type pseudo-class.')
-                        if pseudo_value < 1:
-                            raise ValueError(
-                                'nth-of-type pseudo-class value must be at least 1.')
-                        class Counter(object):
-                            def __init__(self, destination):
-                                self.count = 0
-                                self.destination = destination
-
-                            def nth_child_of_type(self, tag):
-                                self.count += 1
-                                if self.count == self.destination:
-                                    return True
-                                if self.count > self.destination:
-                                    # Stop the generator that's sending us
-                                    # these things.
-                                    raise StopIteration()
-                                return False
-                        checker = Counter(pseudo_value).nth_child_of_type
-                    else:
+                if pseudo_type == 'nth-of-type':
+                    try:
+                        pseudo_value = int(pseudo_value)
+                    except:
                         raise NotImplementedError(
-                            'Only the following pseudo-classes are implemented: nth-of-type.')
+                            'Only numeric values are currently supported for the nth-of-type pseudo-class.')
+                    if pseudo_value < 1:
+                        raise ValueError(
+                            'nth-of-type pseudo-class value must be at least 1.')
+                    class Counter(object):
+                        def __init__(self, destination):
+                            self.count = 0
+                            self.destination = destination
+
+                        def nth_child_of_type(self, tag):
+                            self.count += 1
+                            if self.count == self.destination:
+                                return True
+                            if self.count > self.destination:
+                                # Stop the generator that's sending us
+                                # these things.
+                                raise StopIteration()
+                            return False
+                    checker = Counter(pseudo_value).nth_child_of_type
+                else:
+                    raise NotImplementedError(
+                        'Only the following pseudo-classes are implemented: nth-of-type.')
 
             elif token == '*':
                 # Star selector -- matches everything
@@ -1311,7 +1424,6 @@ class Tag(PageElement):
             else:
                 raise ValueError(
                     'Unsupported or invalid CSS selector: "%s"' % token)
-
             if recursive_candidate_generator:
                 # This happens when the selector looks like  "> foo".
                 #
@@ -1325,14 +1437,14 @@ class Tag(PageElement):
                 next_token = tokens[index+1]
                 def recursive_select(tag):
                     if self._select_debug:
-                        print '    Calling select("%s") recursively on %s %s' % (next_token, tag.name, tag.attrs)
-                        print '-' * 40
+                        print('    Calling select("%s") recursively on %s %s' % (next_token, tag.name, tag.attrs))
+                        print('-' * 40)
                     for i in tag.select(next_token, recursive_candidate_generator):
                         if self._select_debug:
-                            print '(Recursive select picked up candidate %s %s)' % (i.name, i.attrs)
+                            print('(Recursive select picked up candidate %s %s)' % (i.name, i.attrs))
                         yield i
                     if self._select_debug:
-                        print '-' * 40
+                        print('-' * 40)
                 _use_candidate_generator = recursive_select
             elif _candidate_generator is None:
                 # By default, a tag's candidates are all of its
@@ -1343,7 +1455,7 @@ class Tag(PageElement):
                         check = "[any]"
                     else:
                         check = tag_name
-                    print '   Default candidate generator, tag name="%s"' % check
+                    print('   Default candidate generator, tag name="%s"' % check)
                 if self._select_debug:
                     # This is redundant with later code, but it stops
                     # a bunch of bogus tags from cluttering up the
@@ -1361,12 +1473,11 @@ class Tag(PageElement):
             else:
                 _use_candidate_generator = _candidate_generator
 
-            new_context = []
-            new_context_ids = set([])
+            count = 0
             for tag in current_context:
                 if self._select_debug:
-                    print "    Running candidate generator on %s %s" % (
-                        tag.name, repr(tag.attrs))
+                    print("    Running candidate generator on %s %s" % (
+                        tag.name, repr(tag.attrs)))
                 for candidate in _use_candidate_generator(tag):
                     if not isinstance(candidate, Tag):
                         continue
@@ -1381,21 +1492,24 @@ class Tag(PageElement):
                             break
                     if checker is None or result:
                         if self._select_debug:
-                            print "     SUCCESS %s %s" % (candidate.name, repr(candidate.attrs))
+                            print("     SUCCESS %s %s" % (candidate.name, repr(candidate.attrs)))
                         if id(candidate) not in new_context_ids:
                             # If a tag matches a selector more than once,
                             # don't include it in the context more than once.
                             new_context.append(candidate)
                             new_context_ids.add(id(candidate))
+                            if limit and len(new_context) >= limit:
+                                break
                     elif self._select_debug:
-                        print "     FAILURE %s %s" % (candidate.name, repr(candidate.attrs))
+                        print("     FAILURE %s %s" % (candidate.name, repr(candidate.attrs)))
+
 
             current_context = new_context
 
         if self._select_debug:
-            print "Final verdict:"
+            print("Final verdict:")
             for i in current_context:
-                print " %s %s" % (i.name, i.attrs)
+                print(" %s %s" % (i.name, i.attrs))
         return current_context
 
     # Old names for backwards compatibility
@@ -1439,7 +1553,7 @@ class SoupStrainer(object):
             else:
                 attrs = kwargs
         normalized_attrs = {}
-        for key, value in attrs.items():
+        for key, value in list(attrs.items()):
             normalized_attrs[key] = self._normalize_search_value(value)
 
         self.attrs = normalized_attrs
@@ -1448,7 +1562,7 @@ class SoupStrainer(object):
     def _normalize_search_value(self, value):
         # Leave it alone if it's a Unicode string, a callable, a
         # regular expression, a boolean, or None.
-        if (isinstance(value, unicode) or callable(value) or hasattr(value, 'match')
+        if (isinstance(value, str) or isinstance(value, collections.Callable) or hasattr(value, 'match')
             or isinstance(value, bool) or value is None):
             return value
 
@@ -1461,7 +1575,7 @@ class SoupStrainer(object):
             new_value = []
             for v in value:
                 if (hasattr(v, '__iter__') and not isinstance(v, bytes)
-                    and not isinstance(v, unicode)):
+                    and not isinstance(v, str)):
                     # This is almost certainly the user's mistake. In the
                     # interests of avoiding infinite loops, we'll let
                     # it through as-is rather than doing a recursive call.
@@ -1473,7 +1587,7 @@ class SoupStrainer(object):
         # Otherwise, convert it into a Unicode string.
         # The unicode(str()) thing is so this will do the same thing on Python 2
         # and Python 3.
-        return unicode(str(value))
+        return str(str(value))
 
     def __str__(self):
         if self.text:
@@ -1527,7 +1641,7 @@ class SoupStrainer(object):
         found = None
         # If given a list of items, scan it for a text element that
         # matches.
-        if hasattr(markup, '__iter__') and not isinstance(markup, (Tag, basestring)):
+        if hasattr(markup, '__iter__') and not isinstance(markup, (Tag, str)):
             for element in markup:
                 if isinstance(element, NavigableString) \
                        and self.search(element):
@@ -1540,7 +1654,7 @@ class SoupStrainer(object):
                 found = self.search_tag(markup)
         # If it's text, make sure the text matches.
         elif isinstance(markup, NavigableString) or \
-                 isinstance(markup, basestring):
+                 isinstance(markup, str):
             if not self.name and not self.attrs and self._matches(markup, self.text):
                 found = markup
         else:
@@ -1554,7 +1668,7 @@ class SoupStrainer(object):
         if isinstance(markup, list) or isinstance(markup, tuple):
             # This should only happen when searching a multi-valued attribute
             # like 'class'.
-            if (isinstance(match_against, unicode)
+            if (isinstance(match_against, str)
                 and ' ' in match_against):
                 # A bit of a special case. If they try to match "foo
                 # bar" on a multivalue attribute's value, only accept
@@ -1589,7 +1703,7 @@ class SoupStrainer(object):
             # None matches None, False, an empty string, an empty list, and so on.
             return not match_against
 
-        if isinstance(match_against, unicode):
+        if isinstance(match_against, str):
             # Exact string match
             return markup == match_against
 
diff --git a/lib/bs4/testing.py b/lib/bs4/testing.py
index fd4495a..3a2f260 100644
--- a/lib/bs4/testing.py
+++ b/lib/bs4/testing.py
@@ -1,5 +1,8 @@
 """Helper classes for tests."""
 
+__license__ = "MIT"
+
+import pickle
 import copy
 import functools
 import unittest
@@ -43,6 +46,16 @@ class SoupTest(unittest.TestCase):
 
         self.assertEqual(obj.decode(), self.document_for(compare_parsed_to))
 
+    def assertConnectedness(self, element):
+        """Ensure that next_element and previous_element are properly
+        set for all descendants of the given element.
+        """
+        earlier = None
+        for e in element.descendants:
+            if earlier:
+                self.assertEqual(e, earlier.next_element)
+                self.assertEqual(earlier, e.previous_element)
+            earlier = e
 
 class HTMLTreeBuilderSmokeTest(object):
 
@@ -54,6 +67,15 @@ class HTMLTreeBuilderSmokeTest(object):
     markup in these tests, there's not much room for interpretation.
     """
 
+    def test_pickle_and_unpickle_identity(self):
+        # Pickling a tree, then unpickling it, yields a tree identical
+        # to the original.
+        tree = self.soup("<a><b>foo</a>")
+        dumped = pickle.dumps(tree, 2)
+        loaded = pickle.loads(dumped)
+        self.assertEqual(loaded.__class__, BeautifulSoup)
+        self.assertEqual(loaded.decode(), tree.decode())
+
     def assertDoctypeHandled(self, doctype_fragment):
         """Assert that a given doctype string is handled correctly."""
         doctype_str, soup = self._document_with_doctype(doctype_fragment)
@@ -114,6 +136,11 @@ class HTMLTreeBuilderSmokeTest(object):
             soup.encode("utf-8").replace(b"\n", b""),
             markup.replace(b"\n", b""))
 
+    def test_processing_instruction(self):
+        markup = b"""<?PITarget PIContent?>"""
+        soup = self.soup(markup)
+        self.assertEqual(markup, soup.encode("utf8"))
+
     def test_deepcopy(self):
         """Make sure you can copy the tree builder.
 
@@ -155,6 +182,23 @@ class HTMLTreeBuilderSmokeTest(object):
     def test_nested_formatting_elements(self):
         self.assertSoupEquals("<em><em></em></em>")
 
+    def test_double_head(self):
+        html = '''<!DOCTYPE html>
+<html>
+<head>
+<title>Ordinary HEAD element test</title>
+</head>
+<script type="text/javascript">
+alert("Help!");
+</script>
+<body>
+Hello, world!
+</body>
+</html>
+'''
+        soup = self.soup(html)
+        self.assertEqual("text/javascript", soup.find('script')['type'])
+
     def test_comment(self):
         # Comments are represented as Comment objects.
         markup = "<p>foo<!--foobar-->baz</p>"
@@ -221,18 +265,26 @@ class HTMLTreeBuilderSmokeTest(object):
         soup = self.soup(markup)
         self.assertEqual(["css"], soup.div.div['class'])
 
+    def test_multivalued_attribute_on_html(self):
+        # html5lib uses a different API to set the attributes ot the
+        # <html> tag. This has caused problems with multivalued
+        # attributes.
+        markup = '<html class="a b"></html>'
+        soup = self.soup(markup)
+        self.assertEqual(["a", "b"], soup.html['class'])
+
     def test_angle_brackets_in_attribute_values_are_escaped(self):
         self.assertSoupEquals('<a b="<a>"></a>', '<a b="&lt;a&gt;"></a>')
 
     def test_entities_in_attributes_converted_to_unicode(self):
-        expect = u'<p id="pi\N{LATIN SMALL LETTER N WITH TILDE}ata"></p>'
+        expect = '<p id="pi\N{LATIN SMALL LETTER N WITH TILDE}ata"></p>'
         self.assertSoupEquals('<p id="pi&#241;ata"></p>', expect)
         self.assertSoupEquals('<p id="pi&#xf1;ata"></p>', expect)
         self.assertSoupEquals('<p id="pi&#Xf1;ata"></p>', expect)
         self.assertSoupEquals('<p id="pi&ntilde;ata"></p>', expect)
 
     def test_entities_in_text_converted_to_unicode(self):
-        expect = u'<p>pi\N{LATIN SMALL LETTER N WITH TILDE}ata</p>'
+        expect = '<p>pi\N{LATIN SMALL LETTER N WITH TILDE}ata</p>'
         self.assertSoupEquals("<p>pi&#241;ata</p>", expect)
         self.assertSoupEquals("<p>pi&#xf1;ata</p>", expect)
         self.assertSoupEquals("<p>pi&#Xf1;ata</p>", expect)
@@ -243,7 +295,7 @@ class HTMLTreeBuilderSmokeTest(object):
                               '<p>I said "good day!"</p>')
 
     def test_out_of_range_entity(self):
-        expect = u"\N{REPLACEMENT CHARACTER}"
+        expect = "\N{REPLACEMENT CHARACTER}"
         self.assertSoupEquals("&#10000000000000;", expect)
         self.assertSoupEquals("&#x10000000000000;", expect)
         self.assertSoupEquals("&#1000000000;", expect)
@@ -253,6 +305,35 @@ class HTMLTreeBuilderSmokeTest(object):
         soup = self.soup("<html><h2>\nfoo</h2><p></p></html>")
         self.assertEqual("p", soup.h2.string.next_element.name)
         self.assertEqual("p", soup.p.name)
+        self.assertConnectedness(soup)
+
+    def test_head_tag_between_head_and_body(self):
+        "Prevent recurrence of a bug in the html5lib treebuilder."
+        content = """<html><head></head>
+  <link></link>
+  <body>foo</body>
+</html>
+"""
+        soup = self.soup(content)
+        self.assertNotEqual(None, soup.html.body)
+        self.assertConnectedness(soup)
+
+    def test_multiple_copies_of_a_tag(self):
+        "Prevent recurrence of a bug in the html5lib treebuilder."
+        content = """<!DOCTYPE html>
+<html>
+ <body>
+   <article id="a" >
+   <div><a href="1"></div>
+   <footer>
+     <a href="2"></a>
+   </footer>
+  </article>
+  </body>
+</html>
+"""
+        soup = self.soup(content)
+        self.assertConnectedness(soup.article)
 
     def test_basic_namespaces(self):
         """Parsers don't need to *understand* namespaces, but at the
@@ -285,9 +366,9 @@ class HTMLTreeBuilderSmokeTest(object):
         # A seemingly innocuous document... but it's in Unicode! And
         # it contains characters that can't be represented in the
         # encoding found in the  declaration! The horror!
-        markup = u'<html><head><meta encoding="euc-jp"></head><body>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</body>'
+        markup = '<html><head><meta encoding="euc-jp"></head><body>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</body>'
         soup = self.soup(markup)
-        self.assertEqual(u'Sacr\xe9 bleu!', soup.body.string)
+        self.assertEqual('Sacr\xe9 bleu!', soup.body.string)
 
     def test_soupstrainer(self):
         """Parsers should be able to work with SoupStrainers."""
@@ -327,7 +408,7 @@ class HTMLTreeBuilderSmokeTest(object):
         # Both XML and HTML entities are converted to Unicode characters
         # during parsing.
         text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
-        expected = u"<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>"
+        expected = "<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>"
         self.assertSoupEquals(text, expected)
 
     def test_smart_quotes_converted_on_the_way_in(self):
@@ -337,15 +418,15 @@ class HTMLTreeBuilderSmokeTest(object):
         soup = self.soup(quote)
         self.assertEqual(
             soup.p.string,
-            u"\N{LEFT SINGLE QUOTATION MARK}Foo\N{RIGHT SINGLE QUOTATION MARK}")
+            "\N{LEFT SINGLE QUOTATION MARK}Foo\N{RIGHT SINGLE QUOTATION MARK}")
 
     def test_non_breaking_spaces_converted_on_the_way_in(self):
         soup = self.soup("<a>&nbsp;&nbsp;</a>")
-        self.assertEqual(soup.a.string, u"\N{NO-BREAK SPACE}" * 2)
+        self.assertEqual(soup.a.string, "\N{NO-BREAK SPACE}" * 2)
 
     def test_entities_converted_on_the_way_out(self):
         text = "<p>&lt;&lt;sacr&eacute;&#32;bleu!&gt;&gt;</p>"
-        expected = u"<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>".encode("utf-8")
+        expected = "<p>&lt;&lt;sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</p>".encode("utf-8")
         soup = self.soup(text)
         self.assertEqual(soup.p.encode("utf-8"), expected)
 
@@ -354,7 +435,7 @@ class HTMLTreeBuilderSmokeTest(object):
         # easy-to-understand document.
 
         # Here it is in Unicode. Note that it claims to be in ISO-Latin-1.
-        unicode_html = u'<html><head><meta content="text/html; charset=ISO-Latin-1" http-equiv="Content-type"/></head><body><p>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</p></body></html>'
+        unicode_html = '<html><head><meta content="text/html; charset=ISO-Latin-1" http-equiv="Content-type"/></head><body><p>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</p></body></html>'
 
         # That's because we're going to encode it into ISO-Latin-1, and use
         # that to test.
@@ -463,11 +544,25 @@ class HTMLTreeBuilderSmokeTest(object):
 
 class XMLTreeBuilderSmokeTest(object):
 
+    def test_pickle_and_unpickle_identity(self):
+        # Pickling a tree, then unpickling it, yields a tree identical
+        # to the original.
+        tree = self.soup("<a><b>foo</a>")
+        dumped = pickle.dumps(tree, 2)
+        loaded = pickle.loads(dumped)
+        self.assertEqual(loaded.__class__, BeautifulSoup)
+        self.assertEqual(loaded.decode(), tree.decode())
+
     def test_docstring_generated(self):
         soup = self.soup("<root/>")
         self.assertEqual(
             soup.encode(), b'<?xml version="1.0" encoding="utf-8"?>\n<root/>')
 
+    def test_xml_declaration(self):
+        markup = b"""<?xml version="1.0" encoding="utf8"?>\n<foo/>"""
+        soup = self.soup(markup)
+        self.assertEqual(markup, soup.encode("utf8"))
+
     def test_real_xhtml_document(self):
         """A real XHTML document should come out *exactly* the same as it went in."""
         markup = b"""<?xml version="1.0" encoding="utf-8"?>
@@ -485,7 +580,7 @@ class XMLTreeBuilderSmokeTest(object):
   <script type="text/javascript">
   </script>
 """
-        soup = BeautifulSoup(doc, "xml")
+        soup = BeautifulSoup(doc, "lxml-xml")
         # lxml would have stripped this while parsing, but we can add
         # it later.
         soup.script.string = 'console.log("< < hey > > ");'
@@ -493,15 +588,15 @@ class XMLTreeBuilderSmokeTest(object):
         self.assertTrue(b"&lt; &lt; hey &gt; &gt;" in encoded)
 
     def test_can_parse_unicode_document(self):
-        markup = u'<?xml version="1.0" encoding="euc-jp"><root>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</root>'
+        markup = '<?xml version="1.0" encoding="euc-jp"><root>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</root>'
         soup = self.soup(markup)
-        self.assertEqual(u'Sacr\xe9 bleu!', soup.root.string)
+        self.assertEqual('Sacr\xe9 bleu!', soup.root.string)
 
     def test_popping_namespaced_tag(self):
         markup = '<rss xmlns:dc="foo"><dc:creator>b</dc:creator><dc:date>2012-07-02T20:33:42Z</dc:date><dc:rights>c</dc:rights><image>d</image></rss>'
         soup = self.soup(markup)
         self.assertEqual(
-            unicode(soup.rss), markup)
+            str(soup.rss), markup)
 
     def test_docstring_includes_correct_encoding(self):
         soup = self.soup("<root/>")
@@ -532,17 +627,17 @@ class XMLTreeBuilderSmokeTest(object):
     def test_closing_namespaced_tag(self):
         markup = '<p xmlns:dc="http://purl.org/dc/elements/1.1/"><dc:date>20010504</dc:date></p>'
         soup = self.soup(markup)
-        self.assertEqual(unicode(soup.p), markup)
+        self.assertEqual(str(soup.p), markup)
 
     def test_namespaced_attributes(self):
         markup = '<foo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><bar xsi:schemaLocation="http://www.example.com"/></foo>'
         soup = self.soup(markup)
-        self.assertEqual(unicode(soup.foo), markup)
+        self.assertEqual(str(soup.foo), markup)
 
     def test_namespaced_attributes_xml_namespace(self):
         markup = '<foo xml:lang="fr">bar</foo>'
         soup = self.soup(markup)
-        self.assertEqual(unicode(soup.foo), markup)
+        self.assertEqual(str(soup.foo), markup)
 
 class HTML5TreeBuilderSmokeTest(HTMLTreeBuilderSmokeTest):
     """Smoke test for a tree builder that supports HTML5."""
diff --git a/lib/bs4/tests/test_builder_registry.py b/lib/bs4/tests/test_builder_registry.py
index 92ad10f..90cad82 100644
--- a/lib/bs4/tests/test_builder_registry.py
+++ b/lib/bs4/tests/test_builder_registry.py
@@ -1,6 +1,7 @@
 """Tests of the builder registry."""
 
 import unittest
+import warnings
 
 from bs4 import BeautifulSoup
 from bs4.builder import (
@@ -67,10 +68,15 @@ class BuiltInRegistryTest(unittest.TestCase):
                           HTMLParserTreeBuilder)
 
     def test_beautifulsoup_constructor_does_lookup(self):
-        # You can pass in a string.
-        BeautifulSoup("", features="html")
-        # Or a list of strings.
-        BeautifulSoup("", features=["html", "fast"])
+
+        with warnings.catch_warnings(record=True) as w:
+            # This will create a warning about not explicitly
+            # specifying a parser, but we'll ignore it.
+
+            # You can pass in a string.
+            BeautifulSoup("", features="html")
+            # Or a list of strings.
+            BeautifulSoup("", features=["html", "fast"])
 
         # You'll get an exception if BS can't find an appropriate
         # builder.
diff --git a/lib/bs4/tests/test_html5lib.py b/lib/bs4/tests/test_html5lib.py
index 594c3e1..a7494ca 100644
--- a/lib/bs4/tests/test_html5lib.py
+++ b/lib/bs4/tests/test_html5lib.py
@@ -5,7 +5,7 @@ import warnings
 try:
     from bs4.builder import HTML5TreeBuilder
     HTML5LIB_PRESENT = True
-except ImportError, e:
+except ImportError as e:
     HTML5LIB_PRESENT = False
 from bs4.element import SoupStrainer
 from bs4.testing import (
@@ -74,12 +74,25 @@ class HTML5LibBuilderSmokeTest(SoupTest, HTML5TreeBuilderSmokeTest):
     def test_reparented_markup(self):
         markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>'
         soup = self.soup(markup)
-        self.assertEqual(u"<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p></body>", soup.body.decode())
+        self.assertEqual("<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p></body>", soup.body.decode())
         self.assertEqual(2, len(soup.find_all('p')))
 
 
     def test_reparented_markup_ends_with_whitespace(self):
         markup = '<p><em>foo</p>\n<p>bar<a></a></em></p>\n'
         soup = self.soup(markup)
-        self.assertEqual(u"<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p>\n</body>", soup.body.decode())
+        self.assertEqual("<body><p><em>foo</em></p><em>\n</em><p><em>bar<a></a></em></p>\n</body>", soup.body.decode())
         self.assertEqual(2, len(soup.find_all('p')))
+
+    def test_processing_instruction(self):
+        """Processing instructions become comments."""
+        markup = b"""<?PITarget PIContent?>"""
+        soup = self.soup(markup)
+        assert str(soup).startswith("<!--?PITarget PIContent?-->")
+
+    def test_cloned_multivalue_node(self):
+        markup = b"""<a class="my_class"><p></a>"""
+        soup = self.soup(markup)
+        a1, a2 = soup.find_all('a')
+        self.assertEqual(a1, a2)
+        assert a1 is not a2
diff --git a/lib/bs4/tests/test_htmlparser.py b/lib/bs4/tests/test_htmlparser.py
index bcb5ed2..b45e35f 100644
--- a/lib/bs4/tests/test_htmlparser.py
+++ b/lib/bs4/tests/test_htmlparser.py
@@ -1,6 +1,8 @@
 """Tests to ensure that the html.parser tree builder generates good
 trees."""
 
+from pdb import set_trace
+import pickle
 from bs4.testing import SoupTest, HTMLTreeBuilderSmokeTest
 from bs4.builder import HTMLParserTreeBuilder
 
@@ -17,3 +19,14 @@ class HTMLParserTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
     def test_namespaced_public_doctype(self):
         # html.parser can't handle namespaced doctypes, so skip this one.
         pass
+
+    def test_builder_is_pickled(self):
+        """Unlike most tree builders, HTMLParserTreeBuilder and will
+        be restored after pickling.
+        """
+        tree = self.soup("<a><b>foo</a>")
+        dumped = pickle.dumps(tree, 2)
+        loaded = pickle.loads(dumped)
+        self.assertTrue(isinstance(loaded.builder, type(tree.builder)))
+
+
diff --git a/lib/bs4/tests/test_lxml.py b/lib/bs4/tests/test_lxml.py
index 2b2e9b7..6c2a1d7 100644
--- a/lib/bs4/tests/test_lxml.py
+++ b/lib/bs4/tests/test_lxml.py
@@ -7,7 +7,7 @@ try:
     import lxml.etree
     LXML_PRESENT = True
     LXML_VERSION = lxml.etree.LXML_VERSION
-except ImportError, e:
+except ImportError as e:
     LXML_PRESENT = False
     LXML_VERSION = (0,)
 
@@ -62,24 +62,9 @@ class LXMLTreeBuilderSmokeTest(SoupTest, HTMLTreeBuilderSmokeTest):
         # if one is installed.
         with warnings.catch_warnings(record=True) as w:
             soup = BeautifulStoneSoup("<b />")
-        self.assertEqual(u"<b/>", unicode(soup.b))
+        self.assertEqual("<b/>", str(soup.b))
         self.assertTrue("BeautifulStoneSoup class is deprecated" in str(w[0].message))
 
-    def test_real_xhtml_document(self):
-        """lxml strips the XML definition from an XHTML doc, which is fine."""
-        markup = b"""<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
-<html xmlns="http://www.w3.org/1999/xhtml">
-<head><title>Hello.</title></head>
-<body>Goodbye.</body>
-</html>"""
-        soup = self.soup(markup)
-        self.assertEqual(
-            soup.encode("utf-8").replace(b"\n", b''),
-            markup.replace(b'\n', b'').replace(
-                b'<?xml version="1.0" encoding="utf-8"?>', b''))
-
-
 @skipIf(
     not LXML_PRESENT,
     "lxml seems not to be present, not testing its XML tree builder.")
diff --git a/lib/bs4/tests/test_soup.py b/lib/bs4/tests/test_soup.py
index 47ac245..f87949e 100644
--- a/lib/bs4/tests/test_soup.py
+++ b/lib/bs4/tests/test_soup.py
@@ -1,6 +1,7 @@
 # -*- coding: utf-8 -*-
 """Tests of Beautiful Soup as a whole."""
 
+from pdb import set_trace
 import logging
 import unittest
 import sys
@@ -20,6 +21,7 @@ import bs4.dammit
 from bs4.dammit import (
     EntitySubstitution,
     UnicodeDammit,
+    EncodingDetector,
 )
 from bs4.testing import (
     SoupTest,
@@ -30,7 +32,7 @@ import warnings
 try:
     from bs4.builder import LXMLTreeBuilder, LXMLTreeBuilderForXML
     LXML_PRESENT = True
-except ImportError, e:
+except ImportError as e:
     LXML_PRESENT = False
 
 PYTHON_2_PRE_2_7 = (sys.version_info < (2,7))
@@ -39,17 +41,43 @@ PYTHON_3_PRE_3_2 = (sys.version_info[0] == 3 and sys.version_info < (3,2))
 class TestConstructor(SoupTest):
 
     def test_short_unicode_input(self):
-        data = u"<h1>éé</h1>"
+        data = "<h1>éé</h1>"
         soup = self.soup(data)
-        self.assertEqual(u"éé", soup.h1.string)
+        self.assertEqual("éé", soup.h1.string)
 
     def test_embedded_null(self):
-        data = u"<h1>foo\0bar</h1>"
+        data = "<h1>foo\0bar</h1>"
         soup = self.soup(data)
-        self.assertEqual(u"foo\0bar", soup.h1.string)
+        self.assertEqual("foo\0bar", soup.h1.string)
 
+    def test_exclude_encodings(self):
+        utf8_data = "Räksmörgås".encode("utf-8")
+        soup = self.soup(utf8_data, exclude_encodings=["utf-8"])
+        self.assertEqual("windows-1252", soup.original_encoding)
 
-class TestDeprecatedConstructorArguments(SoupTest):
+
+class TestWarnings(SoupTest):
+
+    def _no_parser_specified(self, s, is_there=True):
+        v = s.startswith(BeautifulSoup.NO_PARSER_SPECIFIED_WARNING[:80])
+        self.assertTrue(v)
+
+    def test_warning_if_no_parser_specified(self):
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("<a><b></b></a>")
+        msg = str(w[0].message)
+        self._assert_no_parser_specified(msg)
+
+    def test_warning_if_parser_specified_too_vague(self):
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("<a><b></b></a>", "html")
+        msg = str(w[0].message)
+        self._assert_no_parser_specified(msg)
+
+    def test_no_warning_if_explicit_parser_specified(self):
+        with warnings.catch_warnings(record=True) as w:
+            soup = self.soup("<a><b></b></a>", "html.parser")
+        self.assertEqual([], w)
 
     def test_parseOnlyThese_renamed_to_parse_only(self):
         with warnings.catch_warnings(record=True) as w:
@@ -117,9 +145,9 @@ class TestEntitySubstitution(unittest.TestCase):
     def test_simple_html_substitution(self):
         # Unicode characters corresponding to named HTML entites
         # are substituted, and no others.
-        s = u"foo\u2200\N{SNOWMAN}\u00f5bar"
+        s = "foo\u2200\N{SNOWMAN}\u00f5bar"
         self.assertEqual(self.sub.substitute_html(s),
-                          u"foo&forall;\N{SNOWMAN}&otilde;bar")
+                          "foo&forall;\N{SNOWMAN}&otilde;bar")
 
     def test_smart_quote_substitution(self):
         # MS smart quotes are a common source of frustration, so we
@@ -184,7 +212,7 @@ class TestEncodingConversion(SoupTest):
 
     def setUp(self):
         super(TestEncodingConversion, self).setUp()
-        self.unicode_data = u'<html><head><meta charset="utf-8"/></head><body><foo>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</foo></body></html>'
+        self.unicode_data = '<html><head><meta charset="utf-8"/></head><body><foo>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</foo></body></html>'
         self.utf8_data = self.unicode_data.encode("utf-8")
         # Just so you know what it looks like.
         self.assertEqual(
@@ -204,7 +232,7 @@ class TestEncodingConversion(SoupTest):
             ascii = b"<foo>a</foo>"
             soup_from_ascii = self.soup(ascii)
             unicode_output = soup_from_ascii.decode()
-            self.assertTrue(isinstance(unicode_output, unicode))
+            self.assertTrue(isinstance(unicode_output, str))
             self.assertEqual(unicode_output, self.document_for(ascii.decode()))
             self.assertEqual(soup_from_ascii.original_encoding.lower(), "utf-8")
         finally:
@@ -216,7 +244,7 @@ class TestEncodingConversion(SoupTest):
         # is not set.
         soup_from_unicode = self.soup(self.unicode_data)
         self.assertEqual(soup_from_unicode.decode(), self.unicode_data)
-        self.assertEqual(soup_from_unicode.foo.string, u'Sacr\xe9 bleu!')
+        self.assertEqual(soup_from_unicode.foo.string, 'Sacr\xe9 bleu!')
         self.assertEqual(soup_from_unicode.original_encoding, None)
 
     def test_utf8_in_unicode_out(self):
@@ -224,7 +252,7 @@ class TestEncodingConversion(SoupTest):
         # attribute is set.
         soup_from_utf8 = self.soup(self.utf8_data)
         self.assertEqual(soup_from_utf8.decode(), self.unicode_data)
-        self.assertEqual(soup_from_utf8.foo.string, u'Sacr\xe9 bleu!')
+        self.assertEqual(soup_from_utf8.foo.string, 'Sacr\xe9 bleu!')
 
     def test_utf8_out(self):
         # The internal data structures can be encoded as UTF-8.
@@ -235,14 +263,14 @@ class TestEncodingConversion(SoupTest):
         PYTHON_2_PRE_2_7 or PYTHON_3_PRE_3_2,
         "Bad HTMLParser detected; skipping test of non-ASCII characters in attribute name.")
     def test_attribute_name_containing_unicode_characters(self):
-        markup = u'<div><a \N{SNOWMAN}="snowman"></a></div>'
+        markup = '<div><a \N{SNOWMAN}="snowman"></a></div>'
         self.assertEqual(self.soup(markup).div.encode("utf8"), markup.encode("utf8"))
 
 class TestUnicodeDammit(unittest.TestCase):
     """Standalone tests of UnicodeDammit."""
 
     def test_unicode_input(self):
-        markup = u"I'm already Unicode! \N{SNOWMAN}"
+        markup = "I'm already Unicode! \N{SNOWMAN}"
         dammit = UnicodeDammit(markup)
         self.assertEqual(dammit.unicode_markup, markup)
 
@@ -250,7 +278,7 @@ class TestUnicodeDammit(unittest.TestCase):
         markup = b"<foo>\x91\x92\x93\x94</foo>"
         dammit = UnicodeDammit(markup)
         self.assertEqual(
-            dammit.unicode_markup, u"<foo>\u2018\u2019\u201c\u201d</foo>")
+            dammit.unicode_markup, "<foo>\u2018\u2019\u201c\u201d</foo>")
 
     def test_smart_quotes_to_xml_entities(self):
         markup = b"<foo>\x91\x92\x93\x94</foo>"
@@ -271,16 +299,17 @@ class TestUnicodeDammit(unittest.TestCase):
             dammit.unicode_markup, """<foo>''""</foo>""")
 
     def test_detect_utf8(self):
-        utf8 = b"\xc3\xa9"
+        utf8 = b"Sacr\xc3\xa9 bleu! \xe2\x98\x83"
         dammit = UnicodeDammit(utf8)
-        self.assertEqual(dammit.unicode_markup, u'\xe9')
         self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
+        self.assertEqual(dammit.unicode_markup, 'Sacr\xe9 bleu! \N{SNOWMAN}')
+
 
     def test_convert_hebrew(self):
         hebrew = b"\xed\xe5\xec\xf9"
         dammit = UnicodeDammit(hebrew, ["iso-8859-8"])
         self.assertEqual(dammit.original_encoding.lower(), 'iso-8859-8')
-        self.assertEqual(dammit.unicode_markup, u'\u05dd\u05d5\u05dc\u05e9')
+        self.assertEqual(dammit.unicode_markup, '\u05dd\u05d5\u05dc\u05e9')
 
     def test_dont_see_smart_quotes_where_there_are_none(self):
         utf_8 = b"\343\202\261\343\203\274\343\202\277\343\202\244 Watch"
@@ -289,16 +318,36 @@ class TestUnicodeDammit(unittest.TestCase):
         self.assertEqual(dammit.unicode_markup.encode("utf-8"), utf_8)
 
     def test_ignore_inappropriate_codecs(self):
-        utf8_data = u"Räksmörgås".encode("utf-8")
+        utf8_data = "Räksmörgås".encode("utf-8")
         dammit = UnicodeDammit(utf8_data, ["iso-8859-8"])
         self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
 
     def test_ignore_invalid_codecs(self):
-        utf8_data = u"Räksmörgås".encode("utf-8")
+        utf8_data = "Räksmörgås".encode("utf-8")
         for bad_encoding in ['.utf8', '...', 'utF---16.!']:
             dammit = UnicodeDammit(utf8_data, [bad_encoding])
             self.assertEqual(dammit.original_encoding.lower(), 'utf-8')
 
+    def test_exclude_encodings(self):
+        # This is UTF-8.
+        utf8_data = "Räksmörgås".encode("utf-8")
+
+        # But if we exclude UTF-8 from consideration, the guess is
+        # Windows-1252.
+        dammit = UnicodeDammit(utf8_data, exclude_encodings=["utf-8"])
+        self.assertEqual(dammit.original_encoding.lower(), 'windows-1252')
+
+        # And if we exclude that, there is no valid guess at all.
+        dammit = UnicodeDammit(
+            utf8_data, exclude_encodings=["utf-8", "windows-1252"])
+        self.assertEqual(dammit.original_encoding, None)
+
+    def test_encoding_detector_replaces_junk_in_encoding_name_with_replacement_character(self):
+        detected = EncodingDetector(
+            b'<?xml version="1.0" encoding="UTF-\xdb" ?>')
+        encodings = list(detected.encodings)
+        assert 'utf-\N{REPLACEMENT CHARACTER}' in encodings
+
     def test_detect_html5_style_meta_tag(self):
 
         for data in (
@@ -337,7 +386,7 @@ class TestUnicodeDammit(unittest.TestCase):
             bs4.dammit.chardet_dammit = noop
             dammit = UnicodeDammit(doc)
             self.assertEqual(True, dammit.contains_replacement_characters)
-            self.assertTrue(u"\ufffd" in dammit.unicode_markup)
+            self.assertTrue("\ufffd" in dammit.unicode_markup)
 
             soup = BeautifulSoup(doc, "html.parser")
             self.assertTrue(soup.contains_replacement_characters)
@@ -349,17 +398,17 @@ class TestUnicodeDammit(unittest.TestCase):
         # A document written in UTF-16LE will have its byte order marker stripped.
         data = b'\xff\xfe<\x00a\x00>\x00\xe1\x00\xe9\x00<\x00/\x00a\x00>\x00'
         dammit = UnicodeDammit(data)
-        self.assertEqual(u"<a>áé</a>", dammit.unicode_markup)
+        self.assertEqual("<a>áé</a>", dammit.unicode_markup)
         self.assertEqual("utf-16le", dammit.original_encoding)
 
     def test_detwingle(self):
         # Here's a UTF8 document.
-        utf8 = (u"\N{SNOWMAN}" * 3).encode("utf8")
+        utf8 = ("\N{SNOWMAN}" * 3).encode("utf8")
 
         # Here's a Windows-1252 document.
         windows_1252 = (
-            u"\N{LEFT DOUBLE QUOTATION MARK}Hi, I like Windows!"
-            u"\N{RIGHT DOUBLE QUOTATION MARK}").encode("windows_1252")
+            "\N{LEFT DOUBLE QUOTATION MARK}Hi, I like Windows!"
+            "\N{RIGHT DOUBLE QUOTATION MARK}").encode("windows_1252")
 
         # Through some unholy alchemy, they've been stuck together.
         doc = utf8 + windows_1252 + utf8
@@ -374,7 +423,7 @@ class TestUnicodeDammit(unittest.TestCase):
 
         fixed = UnicodeDammit.detwingle(doc)
         self.assertEqual(
-            u"☃☃☃“Hi, I like Windows!”☃☃☃", fixed.decode("utf8"))
+            "☃☃☃“Hi, I like Windows!”☃☃☃", fixed.decode("utf8"))
 
     def test_detwingle_ignores_multibyte_characters(self):
         # Each of these characters has a UTF-8 representation ending
@@ -382,9 +431,9 @@ class TestUnicodeDammit(unittest.TestCase):
         # Windows-1252. But our code knows to skip over multibyte
         # UTF-8 characters, so they'll survive the process unscathed.
         for tricky_unicode_char in (
-            u"\N{LATIN SMALL LIGATURE OE}", # 2-byte char '\xc5\x93'
-            u"\N{LATIN SUBSCRIPT SMALL LETTER X}", # 3-byte char '\xe2\x82\x93'
-            u"\xf0\x90\x90\x93", # This is a CJK character, not sure which one.
+            "\N{LATIN SMALL LIGATURE OE}", # 2-byte char '\xc5\x93'
+            "\N{LATIN SUBSCRIPT SMALL LETTER X}", # 3-byte char '\xe2\x82\x93'
+            "\xf0\x90\x90\x93", # This is a CJK character, not sure which one.
             ):
             input = tricky_unicode_char.encode("utf8")
             self.assertTrue(input.endswith(b'\x93'))
diff --git a/lib/bs4/tests/test_tree.py b/lib/bs4/tests/test_tree.py
index f8515c0..6d3e67f 100644
--- a/lib/bs4/tests/test_tree.py
+++ b/lib/bs4/tests/test_tree.py
@@ -9,6 +9,7 @@ same markup, but all Beautiful Soup trees can be traversed with the
 methods tested here.
 """
 
+from pdb import set_trace
 import copy
 import pickle
 import re
@@ -19,8 +20,10 @@ from bs4.builder import (
     HTMLParserTreeBuilder,
 )
 from bs4.element import (
+    PY3K,
     CData,
     Comment,
+    Declaration,
     Doctype,
     NavigableString,
     SoupStrainer,
@@ -67,8 +70,14 @@ class TestFind(TreeTest):
         self.assertEqual(soup.find("b").string, "2")
 
     def test_unicode_text_find(self):
-        soup = self.soup(u'<h1>Räksmörgås</h1>')
-        self.assertEqual(soup.find(text=u'Räksmörgås'), u'Räksmörgås')
+        soup = self.soup('<h1>Räksmörgås</h1>')
+        self.assertEqual(soup.find(string='Räksmörgås'), 'Räksmörgås')
+
+    def test_unicode_attribute_find(self):
+        soup = self.soup('<h1 id="Räksmörgås">here it is</h1>')
+        str(soup)
+        self.assertEqual("here it is", soup.find(id='Räksmörgås').text)
+
 
     def test_find_everything(self):
         """Test an optimization that finds all tags."""
@@ -87,16 +96,17 @@ class TestFindAll(TreeTest):
         """You can search the tree for text nodes."""
         soup = self.soup("<html>Foo<b>bar</b>\xbb</html>")
         # Exact match.
-        self.assertEqual(soup.find_all(text="bar"), [u"bar"])
+        self.assertEqual(soup.find_all(string="bar"), ["bar"])
+        self.assertEqual(soup.find_all(text="bar"), ["bar"])
         # Match any of a number of strings.
         self.assertEqual(
-            soup.find_all(text=["Foo", "bar"]), [u"Foo", u"bar"])
+            soup.find_all(text=["Foo", "bar"]), ["Foo", "bar"])
         # Match a regular expression.
         self.assertEqual(soup.find_all(text=re.compile('.*')),
-                         [u"Foo", u"bar", u'\xbb'])
+                         ["Foo", "bar", '\xbb'])
         # Match anything.
         self.assertEqual(soup.find_all(text=True),
-                         [u"Foo", u"bar", u'\xbb'])
+                         ["Foo", "bar", '\xbb'])
 
     def test_find_all_limit(self):
         """You can limit the number of items returned by find_all."""
@@ -227,8 +237,8 @@ class TestFindAllByAttribute(TreeTest):
                            ["Matching a.", "Matching b."])
 
     def test_find_all_by_utf8_attribute_value(self):
-        peace = u"םולש".encode("utf8")
-        data = u'<a title="םולש"></a>'.encode("utf8")
+        peace = "םולש".encode("utf8")
+        data = '<a title="םולש"></a>'.encode("utf8")
         soup = self.soup(data)
         self.assertEqual([soup.a], soup.find_all(title=peace))
         self.assertEqual([soup.a], soup.find_all(title=peace.decode("utf8")))
@@ -688,7 +698,7 @@ class TestTagCreation(SoupTest):
 
     def test_tag_inherits_self_closing_rules_from_builder(self):
         if XML_BUILDER_PRESENT:
-            xml_soup = BeautifulSoup("", "xml")
+            xml_soup = BeautifulSoup("", "lxml-xml")
             xml_br = xml_soup.new_tag("br")
             xml_p = xml_soup.new_tag("p")
 
@@ -697,7 +707,7 @@ class TestTagCreation(SoupTest):
             self.assertEqual(b"<br/>", xml_br.encode())
             self.assertEqual(b"<p/>", xml_p.encode())
 
-        html_soup = BeautifulSoup("", "html")
+        html_soup = BeautifulSoup("", "html.parser")
         html_br = html_soup.new_tag("br")
         html_p = html_soup.new_tag("p")
 
@@ -773,6 +783,14 @@ class TestTreeModification(SoupTest):
         new_a = a.unwrap()
         self.assertEqual(a, new_a)
 
+    def test_replace_with_and_unwrap_give_useful_exception_when_tag_has_no_parent(self):
+        soup = self.soup("<a><b>Foo</b></a><c>Bar</c>")
+        a = soup.a
+        a.extract()
+        self.assertEqual(None, a.parent)
+        self.assertRaises(ValueError, a.unwrap)
+        self.assertRaises(ValueError, a.replace_with, soup.c)
+
     def test_replace_tag_with_itself(self):
         text = "<a><b></b><c>Foo<d></d></c></a><a><e></e></a>"
         soup = self.soup(text)
@@ -1067,6 +1085,31 @@ class TestTreeModification(SoupTest):
         self.assertEqual(foo_2, soup.a.string)
         self.assertEqual(bar_2, soup.b.string)
 
+    def test_extract_multiples_of_same_tag(self):
+        soup = self.soup("""
+<html>
+<head>
+<script>foo</script>
+</head>
+<body>
+ <script>bar</script>
+ <a></a>
+</body>
+<script>baz</script>
+</html>""")
+        [soup.script.extract() for i in soup.find_all("script")]
+        self.assertEqual("<body>\n\n<a></a>\n</body>", str(soup.body))
+
+
+    def test_extract_works_when_element_is_surrounded_by_identical_strings(self):
+        soup = self.soup(
+ '<html>\n'
+ '<body>hi</body>\n'
+ '</html>')
+        soup.find('body').extract()
+        self.assertEqual(None, soup.find('body'))
+
+
     def test_clear(self):
         """Tag.clear()"""
         soup = self.soup("<p><a>String <em>Italicized</em></a> and another</p>")
@@ -1287,27 +1330,72 @@ class TestPersistence(SoupTest):
 
     def test_unicode_pickle(self):
         # A tree containing Unicode characters can be pickled.
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         dumped = pickle.dumps(soup, pickle.HIGHEST_PROTOCOL)
         loaded = pickle.loads(dumped)
         self.assertEqual(loaded.decode(), soup.decode())
 
+    def test_copy_navigablestring_is_not_attached_to_tree(self):
+        html = "<b>Foo<a></a></b><b>Bar</b>"
+        soup = self.soup(html)
+        s1 = soup.find(string="Foo")
+        s2 = copy.copy(s1)
+        self.assertEqual(s1, s2)
+        self.assertEqual(None, s2.parent)
+        self.assertEqual(None, s2.next_element)
+        self.assertNotEqual(None, s1.next_sibling)
+        self.assertEqual(None, s2.next_sibling)
+        self.assertEqual(None, s2.previous_element)
+
+    def test_copy_navigablestring_subclass_has_same_type(self):
+        html = "<b><!--Foo--></b>"
+        soup = self.soup(html)
+        s1 = soup.string
+        s2 = copy.copy(s1)
+        self.assertEqual(s1, s2)
+        self.assertTrue(isinstance(s2, Comment))
+
+    def test_copy_entire_soup(self):
+        html = "<div><b>Foo<a></a></b><b>Bar</b></div>end"
+        soup = self.soup(html)
+        soup_copy = copy.copy(soup)
+        self.assertEqual(soup, soup_copy)
+
+    def test_copy_tag_copies_contents(self):
+        html = "<div><b>Foo<a></a></b><b>Bar</b></div>end"
+        soup = self.soup(html)
+        div = soup.div
+        div_copy = copy.copy(div)
+
+        # The two tags look the same, and evaluate to equal.
+        self.assertEqual(str(div), str(div_copy))
+        self.assertEqual(div, div_copy)
+
+        # But they're not the same object.
+        self.assertFalse(div is div_copy)
+
+        # And they don't have the same relation to the parse tree. The
+        # copy is not associated with a parse tree at all.
+        self.assertEqual(None, div_copy.parent)
+        self.assertEqual(None, div_copy.previous_element)
+        self.assertEqual(None, div_copy.find(string='Bar').next_element)
+        self.assertNotEqual(None, div.find(string='Bar').next_element)
 
 class TestSubstitutions(SoupTest):
 
     def test_default_formatter_is_minimal(self):
-        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
         soup = self.soup(markup)
         decoded = soup.decode(formatter="minimal")
         # The < is converted back into &lt; but the e-with-acute is left alone.
         self.assertEqual(
             decoded,
             self.document_for(
-                u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
+                "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
 
     def test_formatter_html(self):
-        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
         soup = self.soup(markup)
         decoded = soup.decode(formatter="html")
         self.assertEqual(
@@ -1315,49 +1403,49 @@ class TestSubstitutions(SoupTest):
             self.document_for("<b>&lt;&lt;Sacr&eacute; bleu!&gt;&gt;</b>"))
 
     def test_formatter_minimal(self):
-        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
         soup = self.soup(markup)
         decoded = soup.decode(formatter="minimal")
         # The < is converted back into &lt; but the e-with-acute is left alone.
         self.assertEqual(
             decoded,
             self.document_for(
-                u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
+                "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"))
 
     def test_formatter_null(self):
-        markup = u"<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
+        markup = "<b>&lt;&lt;Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!&gt;&gt;</b>"
         soup = self.soup(markup)
         decoded = soup.decode(formatter=None)
         # Neither the angle brackets nor the e-with-acute are converted.
         # This is not valid HTML, but it's what the user wanted.
         self.assertEqual(decoded,
-                          self.document_for(u"<b><<Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!>></b>"))
+                          self.document_for("<b><<Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!>></b>"))
 
     def test_formatter_custom(self):
-        markup = u"<b>&lt;foo&gt;</b><b>bar</b>"
+        markup = "<b>&lt;foo&gt;</b><b>bar</b>"
         soup = self.soup(markup)
         decoded = soup.decode(formatter = lambda x: x.upper())
         # Instead of normal entity conversion code, the custom
         # callable is called on every string.
         self.assertEqual(
             decoded,
-            self.document_for(u"<b><FOO></b><b>BAR</b>"))
+            self.document_for("<b><FOO></b><b>BAR</b>"))
 
     def test_formatter_is_run_on_attribute_values(self):
-        markup = u'<a href="http://a.com?a=b&c=é">e</a>'
+        markup = '<a href="http://a.com?a=b&c=é">e</a>'
         soup = self.soup(markup)
         a = soup.a
 
-        expect_minimal = u'<a href="http://a.com?a=b&amp;c=é">e</a>'
+        expect_minimal = '<a href="http://a.com?a=b&amp;c=é">e</a>'
 
         self.assertEqual(expect_minimal, a.decode())
         self.assertEqual(expect_minimal, a.decode(formatter="minimal"))
 
-        expect_html = u'<a href="http://a.com?a=b&amp;c=&eacute;">e</a>'
+        expect_html = '<a href="http://a.com?a=b&amp;c=&eacute;">e</a>'
         self.assertEqual(expect_html, a.decode(formatter="html"))
 
         self.assertEqual(markup, a.decode(formatter=None))
-        expect_upper = u'<a href="HTTP://A.COM?A=B&C=É">E</a>'
+        expect_upper = '<a href="HTTP://A.COM?A=B&C=É">E</a>'
         self.assertEqual(expect_upper, a.decode(formatter=lambda x: x.upper()))
 
     def test_formatter_skips_script_tag_for_html_documents(self):
@@ -1366,7 +1454,7 @@ class TestSubstitutions(SoupTest):
    console.log("< < hey > > ");
   </script>
 """
-        encoded = BeautifulSoup(doc).encode()
+        encoded = BeautifulSoup(doc, 'html.parser').encode()
         self.assertTrue(b"< < hey > >" in encoded)
 
     def test_formatter_skips_style_tag_for_html_documents(self):
@@ -1375,7 +1463,7 @@ class TestSubstitutions(SoupTest):
    console.log("< < hey > > ");
   </style>
 """
-        encoded = BeautifulSoup(doc).encode()
+        encoded = BeautifulSoup(doc, 'html.parser').encode()
         self.assertTrue(b"< < hey > >" in encoded)
 
     def test_prettify_leaves_preformatted_text_alone(self):
@@ -1383,24 +1471,24 @@ class TestSubstitutions(SoupTest):
         # Everything outside the <pre> tag is reformatted, but everything
         # inside is left alone.
         self.assertEqual(
-            u'<div>\n foo\n <pre>  \tbar\n  \n  </pre>\n baz\n</div>',
+            '<div>\n foo\n <pre>  \tbar\n  \n  </pre>\n baz\n</div>',
             soup.div.prettify())
 
     def test_prettify_accepts_formatter(self):
-        soup = BeautifulSoup("<html><body>foo</body></html>")
+        soup = BeautifulSoup("<html><body>foo</body></html>", 'html.parser')
         pretty = soup.prettify(formatter = lambda x: x.upper())
         self.assertTrue("FOO" in pretty)
 
     def test_prettify_outputs_unicode_by_default(self):
         soup = self.soup("<a></a>")
-        self.assertEqual(unicode, type(soup.prettify()))
+        self.assertEqual(str, type(soup.prettify()))
 
     def test_prettify_can_encode_data(self):
         soup = self.soup("<a></a>")
         self.assertEqual(bytes, type(soup.prettify("utf-8")))
 
     def test_html_entity_substitution_off_by_default(self):
-        markup = u"<b>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</b>"
+        markup = "<b>Sacr\N{LATIN SMALL LETTER E WITH ACUTE} bleu!</b>"
         soup = self.soup(markup)
         encoded = soup.b.encode("utf-8")
         self.assertEqual(encoded, markup.encode('utf-8'))
@@ -1444,45 +1532,53 @@ class TestEncoding(SoupTest):
     """Test the ability to encode objects into strings."""
 
     def test_unicode_string_can_be_encoded(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertEqual(soup.b.string.encode("utf-8"),
-                          u"\N{SNOWMAN}".encode("utf-8"))
+                          "\N{SNOWMAN}".encode("utf-8"))
 
     def test_tag_containing_unicode_string_can_be_encoded(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertEqual(
             soup.b.encode("utf-8"), html.encode("utf-8"))
 
     def test_encoding_substitutes_unrecognized_characters_by_default(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertEqual(soup.b.encode("ascii"), b"<b>&#9731;</b>")
 
     def test_encoding_can_be_made_strict(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertRaises(
             UnicodeEncodeError, soup.encode, "ascii", errors="strict")
 
     def test_decode_contents(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
-        self.assertEqual(u"\N{SNOWMAN}", soup.b.decode_contents())
+        self.assertEqual("\N{SNOWMAN}", soup.b.decode_contents())
 
     def test_encode_contents(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertEqual(
-            u"\N{SNOWMAN}".encode("utf8"), soup.b.encode_contents(
+            "\N{SNOWMAN}".encode("utf8"), soup.b.encode_contents(
                 encoding="utf8"))
 
     def test_deprecated_renderContents(self):
-        html = u"<b>\N{SNOWMAN}</b>"
+        html = "<b>\N{SNOWMAN}</b>"
         soup = self.soup(html)
         self.assertEqual(
-            u"\N{SNOWMAN}".encode("utf8"), soup.b.renderContents())
+            "\N{SNOWMAN}".encode("utf8"), soup.b.renderContents())
+
+    def test_repr(self):
+        html = "<b>\N{SNOWMAN}</b>"
+        soup = self.soup(html)
+        if PY3K:
+            self.assertEqual(html, repr(soup))
+        else:
+            self.assertEqual(b'<b>\\u2603</b>', repr(soup))
 
 class TestNavigableStringSubclasses(SoupTest):
 
@@ -1522,6 +1618,9 @@ class TestNavigableStringSubclasses(SoupTest):
         soup.insert(1, doctype)
         self.assertEqual(soup.encode(), b"<!DOCTYPE foo>\n")
 
+    def test_declaration(self):
+        d = Declaration("foo")
+        self.assertEqual("<?foo?>", d.output_ready())
 
 class TestSoupSelector(TreeTest):
 
@@ -1534,7 +1633,7 @@ class TestSoupSelector(TreeTest):
 <link rel="stylesheet" href="blah.css" type="text/css" id="l1">
 </head>
 <body>
-
+<custom-dashed-tag class="dashed" id="dash1">Hello there.</custom-dashed-tag>
 <div id="main" class="fancy">
 <div id="inner">
 <h1 id="header1">An H1</h1>
@@ -1552,8 +1651,18 @@ class TestSoupSelector(TreeTest):
 <a href="#" id="s2a1">span2a1</a>
 </span>
 <span class="span3"></span>
+<custom-dashed-tag class="dashed" id="dash2"/>
+<div data-tag="dashedvalue" id="data1"/>
 </span>
 </div>
+<x id="xid">
+<z id="zida"/>
+<z id="zidab"/>
+<z id="zidac"/>
+</x>
+<y id="yid">
+<z id="zidb"/>
+</y>
 <p lang="en" id="lang-en">English</p>
 <p lang="en-gb" id="lang-en-gb">English UK</p>
 <p lang="en-us" id="lang-en-us">English US</p>
@@ -1565,7 +1674,7 @@ class TestSoupSelector(TreeTest):
 """
 
     def setUp(self):
-        self.soup = BeautifulSoup(self.HTML)
+        self.soup = BeautifulSoup(self.HTML, 'html.parser')
 
     def assertSelects(self, selector, expected_ids):
         el_ids = [el['id'] for el in self.soup.select(selector)]
@@ -1587,21 +1696,29 @@ class TestSoupSelector(TreeTest):
         els = self.soup.select('title')
         self.assertEqual(len(els), 1)
         self.assertEqual(els[0].name, 'title')
-        self.assertEqual(els[0].contents, [u'The title'])
+        self.assertEqual(els[0].contents, ['The title'])
 
     def test_one_tag_many(self):
         els = self.soup.select('div')
-        self.assertEqual(len(els), 3)
+        self.assertEqual(len(els), 4)
         for div in els:
             self.assertEqual(div.name, 'div')
 
+        el = self.soup.select_one('div')
+        self.assertEqual('main', el['id'])
+
+    def test_select_one_returns_none_if_no_match(self):
+        match = self.soup.select_one('nonexistenttag')
+        self.assertEqual(None, match)
+
+
     def test_tag_in_tag_one(self):
         els = self.soup.select('div div')
-        self.assertSelects('div div', ['inner'])
+        self.assertSelects('div div', ['inner', 'data1'])
 
     def test_tag_in_tag_many(self):
         for selector in ('html div', 'html body div', 'body div'):
-            self.assertSelects(selector, ['main', 'inner', 'footer'])
+            self.assertSelects(selector, ['data1', 'main', 'inner', 'footer'])
 
     def test_tag_no_match(self):
         self.assertEqual(len(self.soup.select('del')), 0)
@@ -1609,6 +1726,20 @@ class TestSoupSelector(TreeTest):
     def test_invalid_tag(self):
         self.assertRaises(ValueError, self.soup.select, 'tag%t')
 
+    def test_select_dashed_tag_ids(self):
+        self.assertSelects('custom-dashed-tag', ['dash1', 'dash2'])
+
+    def test_select_dashed_by_id(self):
+        dashed = self.soup.select('custom-dashed-tag[id=\"dash2\"]')
+        self.assertEqual(dashed[0].name, 'custom-dashed-tag')
+        self.assertEqual(dashed[0]['id'], 'dash2')
+
+    def test_dashed_tag_text(self):
+        self.assertEqual(self.soup.select('body > custom-dashed-tag')[0].text, 'Hello there.')
+
+    def test_select_dashed_matches_find_all(self):
+        self.assertEqual(self.soup.select('custom-dashed-tag'), self.soup.find_all('custom-dashed-tag'))
+
     def test_header_tags(self):
         self.assertSelectMultiple(
             ('h1', ['header1']),
@@ -1709,6 +1840,7 @@ class TestSoupSelector(TreeTest):
             ('[id^="m"]', ['me', 'main']),
             ('div[id^="m"]', ['main']),
             ('a[id^="m"]', ['me']),
+            ('div[data-tag^="dashed"]', ['data1'])
         )
 
     def test_attribute_endswith(self):
@@ -1716,8 +1848,8 @@ class TestSoupSelector(TreeTest):
             ('[href$=".css"]', ['l1']),
             ('link[href$=".css"]', ['l1']),
             ('link[id$="1"]', ['l1']),
-            ('[id$="1"]', ['l1', 'p1', 'header1', 's1a1', 's2a1', 's1a2s1']),
-            ('div[id$="1"]', []),
+            ('[id$="1"]', ['data1', 'l1', 'p1', 'header1', 's1a1', 's2a1', 's1a2s1', 'dash1']),
+            ('div[id$="1"]', ['data1']),
             ('[id$="noending"]', []),
         )
 
@@ -1730,7 +1862,6 @@ class TestSoupSelector(TreeTest):
             ('[rel*="notstyle"]', []),
             ('link[rel*="notstyle"]', []),
             ('link[href*="bla"]', ['l1']),
-            ('a[href*="http://"]', ['bob', 'me']),
             ('[href*="http://"]', ['bob', 'me']),
             ('[id*="p"]', ['pmulti', 'p1']),
             ('div[id*="m"]', ['main']),
@@ -1739,8 +1870,8 @@ class TestSoupSelector(TreeTest):
             ('[href*=".css"]', ['l1']),
             ('link[href*=".css"]', ['l1']),
             ('link[id*="1"]', ['l1']),
-            ('[id*="1"]', ['l1', 'p1', 'header1', 's1a1', 's1a2', 's2a1', 's1a2s1']),
-            ('div[id*="1"]', []),
+            ('[id*="1"]', ['data1', 'l1', 'p1', 'header1', 's1a1', 's1a2', 's2a1', 's1a2s1', 'dash1']),
+            ('div[id*="1"]', ['data1']),
             ('[id*="noending"]', []),
             # New for this test
             ('[href*="."]', ['bob', 'me', 'l1']),
@@ -1748,6 +1879,7 @@ class TestSoupSelector(TreeTest):
             ('link[href*="."]', ['l1']),
             ('div[id*="n"]', ['main', 'inner']),
             ('div[id*="nn"]', ['inner']),
+            ('div[data-tag*="edval"]', ['data1'])
         )
 
     def test_attribute_exact_or_hypen(self):
@@ -1767,18 +1899,27 @@ class TestSoupSelector(TreeTest):
             ('p[class]', ['p1', 'pmulti']),
             ('[blah]', []),
             ('p[blah]', []),
+            ('div[data-tag]', ['data1'])
         )
 
+    def test_unsupported_pseudoclass(self):
+        self.assertRaises(
+            NotImplementedError, self.soup.select, "a:no-such-pseudoclass")
+
+        self.assertRaises(
+            NotImplementedError, self.soup.select, "a:nth-of-type(a)")
+
+
     def test_nth_of_type(self):
         # Try to select first paragraph
         els = self.soup.select('div#inner p:nth-of-type(1)')
         self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, u'Some text')
+        self.assertEqual(els[0].string, 'Some text')
 
         # Try to select third paragraph
         els = self.soup.select('div#inner p:nth-of-type(3)')
         self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, u'Another')
+        self.assertEqual(els[0].string, 'Another')
 
         # Try to select (non-existent!) fourth paragraph
         els = self.soup.select('div#inner p:nth-of-type(4)')
@@ -1791,7 +1932,7 @@ class TestSoupSelector(TreeTest):
     def test_nth_of_type_direct_descendant(self):
         els = self.soup.select('div#inner > p:nth-of-type(1)')
         self.assertEqual(len(els), 1)
-        self.assertEqual(els[0].string, u'Some text')
+        self.assertEqual(els[0].string, 'Some text')
 
     def test_id_child_selector_nth_of_type(self):
         self.assertSelects('#inner > p:nth-of-type(2)', ['p1'])
@@ -1803,7 +1944,7 @@ class TestSoupSelector(TreeTest):
         selected = inner.select("div")
         # The <div id="inner"> tag was selected. The <div id="footer">
         # tag was not.
-        self.assertSelectsIDs(selected, ['inner'])
+        self.assertSelectsIDs(selected, ['inner', 'data1'])
 
     def test_overspecified_child_id(self):
         self.assertSelects(".fancy #inner", ['inner'])
@@ -1827,3 +1968,44 @@ class TestSoupSelector(TreeTest):
 
     def test_sibling_combinator_wont_select_same_tag_twice(self):
         self.assertSelects('p[lang] ~ p', ['lang-en-gb', 'lang-en-us', 'lang-fr'])
+
+    # Test the selector grouping operator (the comma)
+    def test_multiple_select(self):
+        self.assertSelects('x, y', ['xid', 'yid'])
+
+    def test_multiple_select_with_no_space(self):
+        self.assertSelects('x,y', ['xid', 'yid'])
+
+    def test_multiple_select_with_more_space(self):
+        self.assertSelects('x,    y', ['xid', 'yid'])
+
+    def test_multiple_select_duplicated(self):
+        self.assertSelects('x, x', ['xid'])
+
+    def test_multiple_select_sibling(self):
+        self.assertSelects('x, y ~ p[lang=fr]', ['xid', 'lang-fr'])
+
+    def test_multiple_select_tag_and_direct_descendant(self):
+        self.assertSelects('x, y > z', ['xid', 'zidb'])
+
+    def test_multiple_select_direct_descendant_and_tags(self):
+        self.assertSelects('div > x, y, z', ['xid', 'yid', 'zida', 'zidb', 'zidab', 'zidac'])
+
+    def test_multiple_select_indirect_descendant(self):
+        self.assertSelects('div x,y,  z', ['xid', 'yid', 'zida', 'zidb', 'zidab', 'zidac'])
+
+    def test_invalid_multiple_select(self):
+        self.assertRaises(ValueError, self.soup.select, ',x, y')
+        self.assertRaises(ValueError, self.soup.select, 'x,,y')
+
+    def test_multiple_select_attrs(self):
+        self.assertSelects('p[lang=en], p[lang=en-gb]', ['lang-en', 'lang-en-gb'])
+
+    def test_multiple_select_ids(self):
+        self.assertSelects('x, y > z[id=zida], z[id=zidab], z[id=zidb]', ['xid', 'zidb', 'zidab'])
+
+    def test_multiple_select_nested(self):
+        self.assertSelects('body > div > x, y > z', ['xid', 'zidb'])
+
+
+
-- 
2.5.0


