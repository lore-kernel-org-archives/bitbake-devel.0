Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3593871633
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9fINM032457 for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:41:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id muxH8r0GT913 for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:41:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9fNGk032463
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:41:35 GMT
Message-ID: <1421314883.31262.47.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Jan 2015 09:41:23 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] ConfHandler: Rename oldfn to parentfn to be clearer
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
X-List-Received-Date: Thu, 15 Jan 2015 09:41:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Looking at this function I had no idea what oldfn was, I doubt anyone
else would either without looking up what the caller does. "parentfn"
would seem a more appropriate name so rename it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 978ebe4..9d592f7 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -66,21 +66,21 @@ def init(data):
 def supports(fn, d):
     return fn[-5:] == ".conf"
 
-def include(oldfn, fn, lineno, data, error_out):
+def include(parentfn, fn, lineno, data, error_out):
     """
     error_out: A string indicating the verb (e.g. "include", "inherit") to be
     used in a ParseError that will be raised if the file to be included could
     not be included. Specify False to avoid raising an error in this case.
     """
-    if oldfn == fn: # prevent infinite recursion
+    if parentfn == fn: # prevent infinite recursion
         return None
 
     import bb
     fn = data.expand(fn)
-    oldfn = data.expand(oldfn)
+    parentfn = data.expand(parentfn)
 
     if not os.path.isabs(fn):
-        dname = os.path.dirname(oldfn)
+        dname = os.path.dirname(parentfn)
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
         abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
         if abs_fn and bb.parse.check_dependency(data, abs_fn):
@@ -97,7 +97,7 @@ def include(oldfn, fn, lineno, data, error_out):
         ret = handle(fn, data, True)
     except (IOError, OSError):
         if error_out:
-            raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
+            raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), parentfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
         bb.parse.mark_dependency(data, fn)
 



