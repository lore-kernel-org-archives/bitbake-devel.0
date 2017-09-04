Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id CBBFE600E3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 11:44:16 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id v2so3390305wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Sep 2017 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=EjrVfe8vvfbvj6wyroHHSbARYPdGrmiA+XpsDtV9wKY=;
	b=MNZgP3da+UrHyClUtaUqGOwsnzjNasGNzMznoW36wasoqepz10mLvtaZdECE6848aj
	5mnI2W/jpXBGycmHfnoPz5aUu38H58P5pwfrtkRJXXCyTNwJh0trGJvq0vKoCCTivYbC
	k4o7ciXXuiPsx+pb87RRZVUW4Z0D//tuytx0KMk9N79yppTU7mHSYbXWXqu0W5eTKMMq
	P0PFyjQdYt0nk7MzLmnFct+vnXVGwaeRt2nRrIajbYM20Ot7AY6QiL2Ls97eXzr2Uh6H
	5nB4SPYuNmrkjTaY6/xkN9B0N06QsIcDvaTqZgsD3Fpbvz5e5T+gaKcswMjTfqlk+Btq
	fufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=EjrVfe8vvfbvj6wyroHHSbARYPdGrmiA+XpsDtV9wKY=;
	b=MBReZLPEPuU4y0Gm+pJlA+hHNQ5At+fwjcjCdT1n9Cm+UCxHqpGPujEIgABdcD4mwt
	24ZTzHMGNKModHF+KgwH/pgjsSo9z/hirnc5wNukSJKzwoHs59bw86LhN6FpYaotx6vn
	f7oLy+wh1PXbJJ0lg+wLWZwsk5hv8pmKcQxQXlruh2enRe/09PsKBd454cPwxUSDjBnm
	qlAxrcEAGp2VTq7yWA3li2/LZQ1XqbxjuGic8Z/YKm2JlBX+eh4axv5U5MJc4lKQ5JgM
	JM2QjYWncVzlYASAQENboqSzz6f9Nk44HnCs0Uw+hiowA9dWiITHcGcIs1RuOfGlszju
	hlcg==
X-Gm-Message-State: AHPjjUiW0ZPBVyZf7bj7+YbBR8bmfS/1aWNKX54aDxtQXV8hW2c0zw13
	ESlS7sFnHTv0wpz82fI=
X-Google-Smtp-Source: ADKCNb6aO9r5fW4J1HcynEwX0r6HFsmNzLJXD1PFcCNvOZnxbj6Dl49Kwy1UIS8O42TYgBDeoOIaKg==
X-Received: by 10.28.30.140 with SMTP id e134mr135393wme.11.1504525457142;
	Mon, 04 Sep 2017 04:44:17 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id 72sm380567wmh.47.2017.09.04.04.44.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Sep 2017 04:44:16 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Sep 2017 12:44:12 +0100
Message-Id: <20170904114412.25495-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH][1.30] lib/bs4: Fix imports from html5lib >= 0.9999999/1.0b8
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
X-List-Received-Date: Mon, 04 Sep 2017 11:44:17 -0000

From: Daniel Lublin <daniel@lublin.se>

As of html5lib 0.9999999/1.0b8 (released on July 14, 2016), some modules
have moved from _base to base. Handle this, while staying compatible
with earlier versions.

Signed-off-by: Daniel Lublin <daniel@lublin.se>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index 7de36ae7..0f4007a9 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -11,7 +11,14 @@ from bs4.builder import (
     )
 from bs4.element import NamespacedAttribute
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
@@ -54,7 +61,7 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
         return u'<html><head></head><body>%s</body></html>' % fragment
 
 
-class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
+class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
 
     def __init__(self, soup, namespaceHTMLElements):
         self.soup = soup
@@ -92,7 +99,7 @@ class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
         return self.soup
 
     def getFragment(self):
-        return html5lib.treebuilders._base.TreeBuilder.getFragment(self).element
+        return treebuildersbase.TreeBuilder.getFragment(self).element
 
 class AttrList(object):
     def __init__(self, element):
@@ -115,9 +122,9 @@ class AttrList(object):
         return name in list(self.attrs.keys())
 
 
-class Element(html5lib.treebuilders._base.Node):
+class Element(treebuildersbase.Node):
     def __init__(self, element, soup, namespace):
-        html5lib.treebuilders._base.Node.__init__(self, element.name)
+        treebuildersbase.Node.__init__(self, element.name)
         self.element = element
         self.soup = soup
         self.namespace = namespace
@@ -277,7 +284,7 @@ class Element(html5lib.treebuilders._base.Node):
 
 class TextNode(Element):
     def __init__(self, element, soup):
-        html5lib.treebuilders._base.Node.__init__(self, None)
+        treebuildersbase.Node.__init__(self, None)
         self.element = element
         self.soup = soup
 
-- 
2.11.0


