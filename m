Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DE8AB71633
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9gcYX032556 for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:42:38 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tBOnYFeJUTSR for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:42:38 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9gN1E032521
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:42:35 GMT
Message-ID: <1421314943.31262.48.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Jan 2015 09:42:23 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] ConfHandler: Clean up bogus imports
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
X-List-Received-Date: Thu, 15 Jan 2015 09:42:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The import statements here are plain bizarre. Remove them, tweaking
some of the function calls to match current practices. I can't find any
reason these old imports are as they are.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 9d592f7..861faf0 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -27,7 +27,7 @@
 import re, os
 import logging
 import bb.utils
-from bb.parse import ParseError, resolve_file, ast, logger
+from bb.parse import ParseError, resolve_file, ast, logger, handle
 
 __config_regexp__  = re.compile( r"""
     ^
@@ -75,7 +75,6 @@ def include(parentfn, fn, lineno, data, error_out):
     if parentfn == fn: # prevent infinite recursion
         return None
 
-    import bb
     fn = data.expand(fn)
     parentfn = data.expand(parentfn)
 
@@ -84,17 +83,16 @@ def include(parentfn, fn, lineno, data, error_out):
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
         abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
         if abs_fn and bb.parse.check_dependency(data, abs_fn):
-            bb.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
+            logger.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
         for af in attempts:
             bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
     elif bb.parse.check_dependency(data, fn):
-        bb.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
+        logger.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
 
-    from bb.parse import handle
     try:
-        ret = handle(fn, data, True)
+        ret = bb.parse.handle(fn, data, True)
     except (IOError, OSError):
         if error_out:
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), parentfn, lineno)



