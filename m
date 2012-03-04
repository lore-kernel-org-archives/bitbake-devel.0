Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S431B-0004zi-0I for bitbake-devel@lists.openembedded.org;
	Sun, 04 Mar 2012 05:25:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q244HOGJ020294
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 04:17:24 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20117-03 for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Mar 2012 04:17:20 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q244HE8T020269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 04:17:17 GMT
Message-ID: <1330834637.3949.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 Mar 2012 20:17:17 -0800
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] parse/ast: Expand inherit statements before splitting them
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 04 Mar 2012 04:25:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This means that statements that expand to more then one entry
such as:

CLASSES = "a b"
inherit ${CLASSES}

work correctly instead of trying to inherit a class called "a b".

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py                   |    2 +-
 bitbake/lib/bb/parse/ast.py                |    4 ++--
 bitbake/lib/bb/parse/parse_py/BBHandler.py |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 558eadd..d6e1bf8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1431,7 +1431,7 @@ def _parse(fn, data, include=True):
 
 @catch_parse_error
 def _inherit(bbclass, data):
-    bb.parse.BBHandler.inherit([bbclass], "configuration INHERITs", 0, data)
+    bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
     return data
 
 class ParsingFailure(Exception):
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 7cef3d0..eae840f 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -304,7 +304,7 @@ def handleBBHandlers(statements, filename, lineno, m):
 
 def handleInherit(statements, filename, lineno, m):
     classes = m.group(1)
-    statements.append(InheritNode(filename, lineno, classes.split()))
+    statements.append(InheritNode(filename, lineno, classes))
 
 def finalize(fn, d, variant = None):
     all_handlers = {}
@@ -452,7 +452,7 @@ def multi_finalize(fn, d):
                 d.setVar("BBEXTENDVARIANT", variantmap[name])
             else:
                 d.setVar("PN", "%s-%s" % (pn, name))
-            bb.parse.BBHandler.inherit([extendedmap[name]], fn, 0, d)
+            bb.parse.BBHandler.inherit(extendedmap[name], fn, 0, d)
 
         safe_d.setVar("BBCLASSEXTEND", extended)
         _create_variants(datastores, extendedmap.keys(), extendfunc)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 125f458..815bce1 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -70,8 +70,8 @@ def supports(fn, d):
 
 def inherit(files, fn, lineno, d):
     __inherit_cache = data.getVar('__inherit_cache', d) or []
+    files = d.expand(files).split()
     for file in files:
-        file = data.expand(file, d)
         if not os.path.isabs(file) and not file.endswith(".bbclass"):
             file = os.path.join('classes', '%s.bbclass' % file)
 




