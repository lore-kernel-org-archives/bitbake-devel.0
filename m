Return-Path: <daniel@lublin.se>
X-Greylist: delayed 401 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 05 Dec 2016 17:48:50 UTC
Received: from eltanin.uberspace.de (eltanin.uberspace.de [185.26.156.28])
	by mail.openembedded.org (Postfix) with ESMTP id 41F886011F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Dec 2016 17:48:50 +0000 (UTC)
Received: (qmail 17056 invoked from network); 5 Dec 2016 17:42:09 -0000
Received: from localhost (HELO ot.lan) (127.0.0.1)
	by eltanin.uberspace.de with SMTP; 5 Dec 2016 17:42:09 -0000
From: daniel@lublin.se
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Dec 2016 18:42:05 +0100
Message-Id: <3eac24b21231a2ec1ec41590b2b0506b5e6469b5.1480693130.git.daniel@lublin.se>
X-Mailer: git-send-email 2.10.2
Subject: [PATCH 1/1] bitbake: Fix imports from html5lib >= 0.9999999/1.0b8
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
X-List-Received-Date: Mon, 05 Dec 2016 17:48:51 -0000

From: Daniel Lublin <daniel@lublin.se>

As of html5lib 0.9999999/1.0b8 (released on July 14, 2016), some modules
have moved from _base to base. Handle this, while staying compatible
with earlier versions.

Signed-off-by: Daniel Lublin <daniel@lublin.se>
---
 lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index f0e5924..2b7a70a 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -15,7 +15,14 @@ from bs4.element import (
     whitespace_re,
 )
 import html5lib
+try:
+    # html5lib >= 0.99999999/1.0b9
+    from html5lib.treebuilders import base as treebuildersbase
+except ImportError:
+    # html5lib <= 0.9999999/1.0b8
+    from html5lib.treebuilders import _base as treebuildersbase
 from html5lib.constants import namespaces
+
 from bs4.element import (
     Comment,
     Doctype,
@@ -67,7 +74,7 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
         return '<html><head></head><body>%s</body></html>' % fragment
 
 
-class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
+class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
 
     def __init__(self, soup, namespaceHTMLElements):
         self.soup = soup
@@ -105,7 +112,7 @@ class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
         return self.soup
 
     def getFragment(self):
-        return html5lib.treebuilders._base.TreeBuilder.getFragment(self).element
+        return treebuildersbase.TreeBuilder.getFragment(self).element
 
 class AttrList(object):
     def __init__(self, element):
@@ -137,9 +144,9 @@ class AttrList(object):
         return name in list(self.attrs.keys())
 
 
-class Element(html5lib.treebuilders._base.Node):
+class Element(treebuildersbase.Node):
     def __init__(self, element, soup, namespace):
-        html5lib.treebuilders._base.Node.__init__(self, element.name)
+        treebuildersbase.Node.__init__(self, element.name)
         self.element = element
         self.soup = soup
         self.namespace = namespace
@@ -324,7 +331,7 @@ class Element(html5lib.treebuilders._base.Node):
 
 class TextNode(Element):
     def __init__(self, element, soup):
-        html5lib.treebuilders._base.Node.__init__(self, None)
+        treebuildersbase.Node.__init__(self, None)
         self.element = element
         self.soup = soup
 
-- 
2.10.2


