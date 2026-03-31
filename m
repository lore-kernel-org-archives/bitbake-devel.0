Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E08A109B485
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22113.1774968807904257196
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XRfgI20S;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3DA274792;
	Tue, 31 Mar 2026 14:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=0d5CNGxg8JeZjZigH0QTLLBiQgeFSRwfQxs//03MdcI=; b=
	XRfgI20Sz1JKGfOv4PNcGPS9LAD1u6pzpawodKPloDjhS99+GBOPEwY9qtL6DYth
	zpluwWv8pBvOX43x6/YZvS68EEkTTVohGN1yzr9WnRjujbPqoWzHM3ptXeaAFNw6
	ZVjK0/1JAdNWfhOimiPPZzALB9LUJs2SXv9DoM//IKjE53DJ5qgnz+vGnaeKSY2A
	fpqJQt7x3C329PMZqnBiokGVzznelxZEta1/F6TOLsDRuxHQ6U60ajz5KH3Ra737
	zDP7+CIXBFbuOL4rCWVybt6K7G2vjFJ6rc9x0aEu47aZvnAMYHKh6Isoo/fJf52z
	3opD8AYjVD2XpDb0qD5qPw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 07:53:20 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 07:53:20 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 5/6] lib: Vendorize bundled third-party libraries under bb._vendor
Date: Tue, 31 Mar 2026 07:53:18 -0700
Message-ID: <20260331145319.3125456-6-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331145319.3125456-1-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe6 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=sdMhlzqdCMuPHYe87FcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfX+Xym1mPDSdnD
 QHY3FDJcEFHxTIab9WpXNa46q120c1VfONHSoGLgIVBgimTGF+6PtCDew+wdT3BO0uEY5z0PwYL
 y6Wm5jw7GV/Trd2C9Lq3V1839rCPwYGxdiIEH/n2FFq4sdoC9dmbQ6kEAfA4LooHQLHQ5CgDRjr
 tnXd/rS8sAgP94kL1EEoJVwZpub++cDXdgLn4XFIARfFQ/zX9Yw1hTNOjBDp0jNadxc1H+yDFcg
 UD9SLZ3Cw2K8ktQP3PTHxsY3bbL/dSEioHKrEEWYLkjzdhXTsgm63ohHy77W+fIdnRar7LlA0YL
 +u450cj+lHhVtXmFJ1qW0phexIWCzL/gld/QESUK/HqjTB5fNQPJdnULvJOnH8QRY0Nm+P1KgZk
 igR5hdMRTA/S7VFSZKUk0BqgXXWmEbmGIRKw8mvD9NzbnekddYYg3cWZqU7ePZBxURPAYzJZ76q
 FczM4eU97iOI8QJwVBw==
X-Proofpoint-GUID: EP4UDBAAKUcXoF5NxupBPzTcT0AaisKr
X-Proofpoint-ORIG-GUID: EP4UDBAAKUcXoF5NxupBPzTcT0AaisKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310144
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19297

Move ply, progressbar, simplediff, and bs4 from lib/ into
lib/bb/_vendor/ to avoid conflicts with system-installed versions
and to support proper packaging. These libraries contain local
modifications from their upstream versions.

- Create lib/bb/_vendor/__init__.py
- Move ply/, progressbar/, simplediff/, bs4/ into bb/_vendor/
- Convert absolute self-references to relative imports within
  ply (yacc.py) and bs4 (20 import sites across 8 files)
- Update all external import sites to use bb._vendor prefix:
  bb/pysh/pyshlex.py, bb/pysh/pyshyacc.py, bb/ui/knotty.py,
  bb/siggen.py, bb/fetch2/wget.py, toaster/tests/views/test_views.py

Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/_vendor/__init__.py                     | 18 ++++++++++++++++++
 lib/{ => bb/_vendor}/bs4/AUTHORS               |  0
 lib/{ => bb/_vendor}/bs4/CHANGELOG             |  0
 lib/{ => bb/_vendor}/bs4/LICENSE               |  0
 lib/{ => bb/_vendor}/bs4/__init__.py           |  0
 lib/{ => bb/_vendor}/bs4/builder/__init__.py   |  2 +-
 lib/{ => bb/_vendor}/bs4/builder/_html5lib.py  | 12 ++++++------
 .../_vendor}/bs4/builder/_htmlparser.py        |  6 +++---
 lib/{ => bb/_vendor}/bs4/builder/_lxml.py      |  6 +++---
 lib/{ => bb/_vendor}/bs4/css.py                |  2 +-
 lib/{ => bb/_vendor}/bs4/dammit.py             |  0
 lib/{ => bb/_vendor}/bs4/diagnose.py           |  9 ++++-----
 lib/{ => bb/_vendor}/bs4/element.py            |  6 +++---
 lib/{ => bb/_vendor}/bs4/formatter.py          |  2 +-
 lib/{ => bb/_vendor}/ply/__init__.py           |  0
 lib/{ => bb/_vendor}/ply/lex.py                |  0
 lib/{ => bb/_vendor}/ply/yacc.py               |  6 +-----
 lib/{ => bb/_vendor}/progressbar/LICENSE.txt   |  0
 lib/{ => bb/_vendor}/progressbar/__init__.py   |  0
 lib/{ => bb/_vendor}/progressbar/compat.py     |  0
 .../_vendor}/progressbar/progressbar.py        |  0
 lib/{ => bb/_vendor}/progressbar/widgets.py    |  0
 lib/{ => bb/_vendor}/simplediff/LICENSE        |  0
 lib/{ => bb/_vendor}/simplediff/__init__.py    |  0
 lib/bb/fetch2/wget.py                          |  4 ++--
 lib/bb/pysh/pyshlex.py                         |  2 +-
 lib/bb/pysh/pyshyacc.py                        |  2 +-
 lib/bb/siggen.py                               |  2 +-
 lib/bb/ui/knotty.py                            |  2 +-
 lib/toaster/tests/views/test_views.py          |  2 +-
 30 files changed, 48 insertions(+), 35 deletions(-)
 create mode 100644 lib/bb/_vendor/__init__.py
 rename lib/{ => bb/_vendor}/bs4/AUTHORS (100%)
 rename lib/{ => bb/_vendor}/bs4/CHANGELOG (100%)
 rename lib/{ => bb/_vendor}/bs4/LICENSE (100%)
 rename lib/{ => bb/_vendor}/bs4/__init__.py (100%)
 rename lib/{ => bb/_vendor}/bs4/builder/__init__.py (99%)
 rename lib/{ => bb/_vendor}/bs4/builder/_html5lib.py (98%)
 rename lib/{ => bb/_vendor}/bs4/builder/_htmlparser.py (99%)
 rename lib/{ => bb/_vendor}/bs4/builder/_lxml.py (99%)
 rename lib/{ => bb/_vendor}/bs4/css.py (99%)
 rename lib/{ => bb/_vendor}/bs4/dammit.py (100%)
 rename lib/{ => bb/_vendor}/bs4/diagnose.py (96%)
 rename lib/{ => bb/_vendor}/bs4/element.py (99%)
 rename lib/{ => bb/_vendor}/bs4/formatter.py (99%)
 rename lib/{ => bb/_vendor}/ply/__init__.py (100%)
 rename lib/{ => bb/_vendor}/ply/lex.py (100%)
 rename lib/{ => bb/_vendor}/ply/yacc.py (99%)
 rename lib/{ => bb/_vendor}/progressbar/LICENSE.txt (100%)
 rename lib/{ => bb/_vendor}/progressbar/__init__.py (100%)
 rename lib/{ => bb/_vendor}/progressbar/compat.py (100%)
 rename lib/{ => bb/_vendor}/progressbar/progressbar.py (100%)
 rename lib/{ => bb/_vendor}/progressbar/widgets.py (100%)
 rename lib/{ => bb/_vendor}/simplediff/LICENSE (100%)
 rename lib/{ => bb/_vendor}/simplediff/__init__.py (100%)

diff --git a/lib/bb/_vendor/__init__.py b/lib/bb/_vendor/__init__.py
new file mode 100644
index 00000000..3c054dc3
--- /dev/null
+++ b/lib/bb/_vendor/__init__.py
@@ -0,0 +1,18 @@
+#
+# Copyright BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+"""
+Vendored third-party libraries for BitBake.
+
+These libraries have been modified from their upstream versions and are
+bundled here to avoid conflicts with system-installed packages.
+
+Vendored packages:
+    - bs4 (BeautifulSoup4)
+    - ply
+    - progressbar
+    - simplediff
+"""
diff --git a/lib/bs4/AUTHORS b/lib/bb/_vendor/bs4/AUTHORS
similarity index 100%
rename from lib/bs4/AUTHORS
rename to lib/bb/_vendor/bs4/AUTHORS
diff --git a/lib/bs4/CHANGELOG b/lib/bb/_vendor/bs4/CHANGELOG
similarity index 100%
rename from lib/bs4/CHANGELOG
rename to lib/bb/_vendor/bs4/CHANGELOG
diff --git a/lib/bs4/LICENSE b/lib/bb/_vendor/bs4/LICENSE
similarity index 100%
rename from lib/bs4/LICENSE
rename to lib/bb/_vendor/bs4/LICENSE
diff --git a/lib/bs4/__init__.py b/lib/bb/_vendor/bs4/__init__.py
similarity index 100%
rename from lib/bs4/__init__.py
rename to lib/bb/_vendor/bs4/__init__.py
diff --git a/lib/bs4/builder/__init__.py b/lib/bb/_vendor/bs4/builder/__init__.py
similarity index 99%
rename from lib/bs4/builder/__init__.py
rename to lib/bb/_vendor/bs4/builder/__init__.py
index ffb31fc2..d60a9a67 100644
--- a/lib/bs4/builder/__init__.py
+++ b/lib/bb/_vendor/bs4/builder/__init__.py
@@ -6,7 +6,7 @@ import itertools
 import re
 import warnings
 import sys
-from bs4.element import (
+from ..element import (
     CharsetMetaAttributeValue,
     ContentMetaAttributeValue,
     RubyParenthesisString,
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bb/_vendor/bs4/builder/_html5lib.py
similarity index 98%
rename from lib/bs4/builder/_html5lib.py
rename to lib/bb/_vendor/bs4/builder/_html5lib.py
index 7c46a851..8ca19fec 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bb/_vendor/bs4/builder/_html5lib.py
@@ -7,14 +7,14 @@ __all__ = [
 
 import warnings
 import re
-from bs4.builder import (
+from . import (
     DetectsXMLParsedAsHTML,
     PERMISSIVE,
     HTML,
     HTML_5,
     HTMLTreeBuilder,
     )
-from bs4.element import (
+from ..element import (
     NamespacedAttribute,
     nonwhitespace_re,
 )
@@ -23,7 +23,7 @@ from html5lib.constants import (
     namespaces,
     prefixes,
     )
-from bs4.element import (
+from ..element import (
     Comment,
     Doctype,
     NavigableString,
@@ -134,7 +134,7 @@ class TreeBuilderForHtml5lib(treebuilder_base.TreeBuilder):
         if soup:
             self.soup = soup
         else:
-            from bs4 import BeautifulSoup
+            from .. import BeautifulSoup
             # TODO: Why is the parser 'html.parser' here? To avoid an
             # infinite loop?
             self.soup = BeautifulSoup(
@@ -180,7 +180,7 @@ class TreeBuilderForHtml5lib(treebuilder_base.TreeBuilder):
         return TextNode(Comment(data), self.soup)
 
     def fragmentClass(self):
-        from bs4 import BeautifulSoup
+        from .. import BeautifulSoup
         # TODO: Why is the parser 'html.parser' here? To avoid an
         # infinite loop?
         self.soup = BeautifulSoup("", "html.parser")
@@ -198,7 +198,7 @@ class TreeBuilderForHtml5lib(treebuilder_base.TreeBuilder):
         return treebuilder_base.TreeBuilder.getFragment(self).element
 
     def testSerializer(self, element):
-        from bs4 import BeautifulSoup
+        from .. import BeautifulSoup
         rv = []
         doctype_re = re.compile(r'^(.*?)(?: PUBLIC "(.*?)"(?: "(.*?)")?| SYSTEM "(.*?)")?$')
 
diff --git a/lib/bs4/builder/_htmlparser.py b/lib/bb/_vendor/bs4/builder/_htmlparser.py
similarity index 99%
rename from lib/bs4/builder/_htmlparser.py
rename to lib/bb/_vendor/bs4/builder/_htmlparser.py
index 3cc187f8..f55cbadf 100644
--- a/lib/bs4/builder/_htmlparser.py
+++ b/lib/bb/_vendor/bs4/builder/_htmlparser.py
@@ -13,16 +13,16 @@ from html.parser import HTMLParser
 import sys
 import warnings
 
-from bs4.element import (
+from ..element import (
     CData,
     Comment,
     Declaration,
     Doctype,
     ProcessingInstruction,
     )
-from bs4.dammit import EntitySubstitution, UnicodeDammit
+from ..dammit import EntitySubstitution, UnicodeDammit
 
-from bs4.builder import (
+from . import (
     DetectsXMLParsedAsHTML,
     ParserRejectedMarkup,
     HTML,
diff --git a/lib/bs4/builder/_lxml.py b/lib/bb/_vendor/bs4/builder/_lxml.py
similarity index 99%
rename from lib/bs4/builder/_lxml.py
rename to lib/bb/_vendor/bs4/builder/_lxml.py
index 4f7cf746..fc80133b 100644
--- a/lib/bs4/builder/_lxml.py
+++ b/lib/bb/_vendor/bs4/builder/_lxml.py
@@ -14,14 +14,14 @@ except ImportError as e:
 from io import BytesIO
 from io import StringIO
 from lxml import etree
-from bs4.element import (
+from ..element import (
     Comment,
     Doctype,
     NamespacedAttribute,
     ProcessingInstruction,
     XMLProcessingInstruction,
 )
-from bs4.builder import (
+from . import (
     DetectsXMLParsedAsHTML,
     FAST,
     HTML,
@@ -30,7 +30,7 @@ from bs4.builder import (
     ParserRejectedMarkup,
     TreeBuilder,
     XML)
-from bs4.dammit import EncodingDetector
+from ..dammit import EncodingDetector
 
 LXML = 'lxml'
 
diff --git a/lib/bs4/css.py b/lib/bb/_vendor/bs4/css.py
similarity index 99%
rename from lib/bs4/css.py
rename to lib/bb/_vendor/bs4/css.py
index cd1fd2df..7cbeb83c 100644
--- a/lib/bs4/css.py
+++ b/lib/bb/_vendor/bs4/css.py
@@ -68,7 +68,7 @@ class CSS(object):
         result (a common mistake).
         """
         # Import here to avoid circular import
-        from bs4.element import ResultSet
+        from .element import ResultSet
         return ResultSet(None, results)
 
     def compile(self, select, namespaces=None, flags=0, **kwargs):
diff --git a/lib/bs4/dammit.py b/lib/bb/_vendor/bs4/dammit.py
similarity index 100%
rename from lib/bs4/dammit.py
rename to lib/bb/_vendor/bs4/dammit.py
diff --git a/lib/bs4/diagnose.py b/lib/bb/_vendor/bs4/diagnose.py
similarity index 96%
rename from lib/bs4/diagnose.py
rename to lib/bb/_vendor/bs4/diagnose.py
index 46927953..76d0be8f 100644
--- a/lib/bs4/diagnose.py
+++ b/lib/bb/_vendor/bs4/diagnose.py
@@ -6,9 +6,8 @@ __license__ = "MIT"
 import cProfile
 from io import BytesIO
 from html.parser import HTMLParser
-import bs4
-from bs4 import BeautifulSoup, __version__
-from bs4.builder import builder_registry
+from . import BeautifulSoup, __version__
+from .builder import builder_registry
 
 import os
 import pstats
@@ -219,8 +218,8 @@ def profile(num_elements=100000, parser="lxml"):
     filename = filehandle.name
 
     data = rdoc(num_elements)
-    vars = dict(bs4=bs4, data=data, parser=parser)
-    cProfile.runctx('bs4.BeautifulSoup(data, parser)' , vars, vars, filename)
+    vars = dict(BeautifulSoup=BeautifulSoup, data=data, parser=parser)
+    cProfile.runctx('BeautifulSoup(data, parser)' , vars, vars, filename)
 
     stats = pstats.Stats(filename)
     # stats.strip_dirs()
diff --git a/lib/bs4/element.py b/lib/bb/_vendor/bs4/element.py
similarity index 99%
rename from lib/bs4/element.py
rename to lib/bb/_vendor/bs4/element.py
index 0aefe734..38ca2dc2 100644
--- a/lib/bs4/element.py
+++ b/lib/bb/_vendor/bs4/element.py
@@ -9,8 +9,8 @@ import re
 import sys
 import warnings
 
-from bs4.css import CSS
-from bs4.formatter import (
+from .css import CSS
+from .formatter import (
     Formatter,
     HTMLFormatter,
     XMLFormatter,
@@ -420,7 +420,7 @@ class PageElement(object):
             and not isinstance(new_child, NavigableString)):
             new_child = NavigableString(new_child)
 
-        from bs4 import BeautifulSoup
+        from . import BeautifulSoup
         if isinstance(new_child, BeautifulSoup):
             # We don't want to end up with a situation where one BeautifulSoup
             # object contains another. Insert the children one at a time.
diff --git a/lib/bs4/formatter.py b/lib/bb/_vendor/bs4/formatter.py
similarity index 99%
rename from lib/bs4/formatter.py
rename to lib/bb/_vendor/bs4/formatter.py
index 9fa1b57c..50f775ae 100644
--- a/lib/bs4/formatter.py
+++ b/lib/bb/_vendor/bs4/formatter.py
@@ -1,4 +1,4 @@
-from bs4.dammit import EntitySubstitution
+from .dammit import EntitySubstitution
 
 class Formatter(EntitySubstitution):
     """Describes a strategy to use when outputting a parse tree to a string.
diff --git a/lib/ply/__init__.py b/lib/bb/_vendor/ply/__init__.py
similarity index 100%
rename from lib/ply/__init__.py
rename to lib/bb/_vendor/ply/__init__.py
diff --git a/lib/ply/lex.py b/lib/bb/_vendor/ply/lex.py
similarity index 100%
rename from lib/ply/lex.py
rename to lib/bb/_vendor/ply/lex.py
diff --git a/lib/ply/yacc.py b/lib/bb/_vendor/ply/yacc.py
similarity index 99%
rename from lib/ply/yacc.py
rename to lib/bb/_vendor/ply/yacc.py
index 529f85b0..0cd9b522 100644
--- a/lib/ply/yacc.py
+++ b/lib/bb/_vendor/ply/yacc.py
@@ -100,12 +100,8 @@ try:
 except AttributeError:
     MAXINT = sys.maxsize
 
-# Python 2.x/3.0 compatibility.
 def load_ply_lex():
-    if sys.version_info[0] < 3:
-        import lex
-    else:
-        import ply.lex as lex
+    from . import lex
     return lex
 
 # This object is a stand-in for a logging object created by the 
diff --git a/lib/progressbar/LICENSE.txt b/lib/bb/_vendor/progressbar/LICENSE.txt
similarity index 100%
rename from lib/progressbar/LICENSE.txt
rename to lib/bb/_vendor/progressbar/LICENSE.txt
diff --git a/lib/progressbar/__init__.py b/lib/bb/_vendor/progressbar/__init__.py
similarity index 100%
rename from lib/progressbar/__init__.py
rename to lib/bb/_vendor/progressbar/__init__.py
diff --git a/lib/progressbar/compat.py b/lib/bb/_vendor/progressbar/compat.py
similarity index 100%
rename from lib/progressbar/compat.py
rename to lib/bb/_vendor/progressbar/compat.py
diff --git a/lib/progressbar/progressbar.py b/lib/bb/_vendor/progressbar/progressbar.py
similarity index 100%
rename from lib/progressbar/progressbar.py
rename to lib/bb/_vendor/progressbar/progressbar.py
diff --git a/lib/progressbar/widgets.py b/lib/bb/_vendor/progressbar/widgets.py
similarity index 100%
rename from lib/progressbar/widgets.py
rename to lib/bb/_vendor/progressbar/widgets.py
diff --git a/lib/simplediff/LICENSE b/lib/bb/_vendor/simplediff/LICENSE
similarity index 100%
rename from lib/simplediff/LICENSE
rename to lib/bb/_vendor/simplediff/LICENSE
diff --git a/lib/simplediff/__init__.py b/lib/bb/_vendor/simplediff/__init__.py
similarity index 100%
rename from lib/simplediff/__init__.py
rename to lib/bb/_vendor/simplediff/__init__.py
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ca4959ab..aaa5027f 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -27,8 +27,8 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
-from   bs4 import BeautifulSoup
-from   bs4 import SoupStrainer
+from   bb._vendor.bs4 import BeautifulSoup
+from   bb._vendor.bs4 import SoupStrainer
 
 class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
     """
diff --git a/lib/bb/pysh/pyshlex.py b/lib/bb/pysh/pyshlex.py
index a42c2944..3f99cd1b 100644
--- a/lib/bb/pysh/pyshlex.py
+++ b/lib/bb/pysh/pyshlex.py
@@ -14,7 +14,7 @@
 # that hard to enable pull mode.
 import re
 
-from ply import lex
+from bb._vendor.ply import lex
 from bb.pysh.sherrors import *
 
 class NeedMore(Exception):
diff --git a/lib/bb/pysh/pyshyacc.py b/lib/bb/pysh/pyshyacc.py
index 924860a6..67e22c96 100644
--- a/lib/bb/pysh/pyshyacc.py
+++ b/lib/bb/pysh/pyshyacc.py
@@ -13,7 +13,7 @@ import sys
 import bb.pysh.pyshlex as pyshlex
 tokens = pyshlex.tokens
 
-from ply import yacc
+from bb._vendor.ply import yacc
 import bb.pysh.sherrors as sherrors
     
 class IORedirect:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 985fa7e4..4d0aa4ac 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -12,7 +12,7 @@ import tempfile
 import pickle
 import bb.data
 import difflib
-import simplediff
+from bb._vendor import simplediff
 import json
 import types
 from contextlib import contextmanager
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 82531ef8..15025e8d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -14,7 +14,7 @@ import io
 import os
 import sys
 import logging
-import progressbar
+from bb._vendor import progressbar
 import signal
 import bb.msg
 import time
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index e1adfcf8..5e64e819 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -27,7 +27,7 @@ import toastergui
 
 from toastergui.tables import SoftwareRecipesTable
 import json
-from bs4 import BeautifulSoup
+from bb._vendor.bs4 import BeautifulSoup
 import string
 
 PROJECT_NAME = "test project"
-- 
2.49.0


