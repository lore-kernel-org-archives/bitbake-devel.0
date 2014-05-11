Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9806D60173
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 12:05:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4BC5mvn017724 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:05:49 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id resEBDWOT7VS for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:05:48 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4BC5kJ1017720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 May 2014 13:05:48 +0100
Message-ID: <1399809940.31891.106.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 May 2014 13:05:40 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] parse: Improve file inheritance logging
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
X-List-Received-Date: Sun, 11 May 2014 12:06:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The file inheritance logging has been here since the dawn of time. It
duplicates output many times over and logs to debug level 2. When running
with the debug option, its understandable the user may want to see the
paths of files included in the build.

These changes remove pointless/duplicate output and print the
include paths clearly at debug level one in a form which
users should be able to more easily parse.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index e4a44dd..bf5ed05 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -121,7 +121,6 @@ def resolve_file(fn, d):
     if not os.path.isfile(fn):
         raise IOError("file %s not found" % fn)
 
-    logger.debug(2, "LOAD %s", fn)
     return fn
 
 # Used by OpenEmbedded metadata
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 408890e..a8627e9 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -86,7 +86,7 @@ def inherit(files, fn, lineno, d):
                 file = abs_fn
 
         if not file in __inherit_cache:
-            logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
+            logger.debug(1, "Inheriting %s (from %s:%d)" % (file, fn, lineno))
             __inherit_cache.append( file )
             d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
@@ -124,12 +124,6 @@ def handle(fn, d, include):
     __classname__ = ""
     __residue__ = []
 
-
-    if include == 0:
-        logger.debug(2, "BB %s: handle(data)", fn)
-    else:
-        logger.debug(2, "BB %s: handle(data, include)", fn)
-
     base_name = os.path.basename(fn)
     (root, ext) = os.path.splitext(base_name)
     init(d)



