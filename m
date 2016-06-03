Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B3A5C77519
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 12:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53CcaQD009908 for <bitbake-devel@lists.openembedded.org>;
	Fri, 3 Jun 2016 13:38:36 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QgE3C5hkXoeD for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 13:38:36 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53CcXkp009904
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 3 Jun 2016 13:38:34 +0100
Message-ID: <1464957513.13979.16.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 03 Jun 2016 13:38:33 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [OE-core] [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Fri, 03 Jun 2016 12:38:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

"hash() is randomised by default each time you start a new instance of
recent
versions (Python3.3+) to prevent dictionary insertion DOS attacks"

which means we need to use hashlib.md5 to get consistent values for
the codeparser cache under python 3. Prior to this, the codeparser
cache was effectively useless under python3 as shown by performance
regressions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/codeparser.py
b/bitbake/lib/bb/codeparser.py
index b1d067a..00551ba 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -6,12 +6,16 @@ import pickle
 import bb.pysh as pysh
 import os.path
 import bb.utils, bb.data
+import hashlib
 from itertools import chain
 from bb.pysh import pyshyacc, pyshlex, sherrors
 from bb.cache import MultiProcessCache
 
 logger = logging.getLogger('BitBake.CodeParser')
 
+def bbhash(s):
+    return hashlib.md5(s.encode("utf-8")).hexdigest()
+
 def check_indent(codestr):
     """If the code is indented, add a top level piece of code to
'remove' the indentation"""
 
@@ -269,7 +273,7 @@ class PythonParser():
         if not node or not node.strip():
             return
 
-        h = hash(str(node))
+        h = bbhash(str(node))
 
         if h in codeparsercache.pythoncache:
             self.references = set(codeparsercache.pythoncache[h].refs)
@@ -314,7 +318,7 @@ class ShellParser():
         commands it executes.
         """
 
-        h = hash(str(value))
+        h = bbhash(str(value))
 
         if h in codeparsercache.shellcache:
             self.execs = set(codeparsercache.shellcache[h].execs)



