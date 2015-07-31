Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 2CCC576645
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 18:16:51 +0000 (UTC)
Received: by pdbbh15 with SMTP id bh15so46289629pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xcIiB3TP6ULUqcuHa3MjOedDP5ER9PYH7xne6+rracE=;
	b=zMF4V8n1w2M/Lkgh2FASaaUvdzYeSo63t6qqTxwc7lF92LF3QLitvw9fD8XF+EfbQ4
	MLMdcu3SJUpwRHsaa74wjlw1HITUIe5WVRhENOnhPU7onT/tVWOmuKnnLRKQI/yXiVH9
	tNJIF5PLzh49IkG6/SxIASrOM4y7nkW49mZ8hKfkRd96zlnxZsajuSu8P5xtXOC1KtAK
	85DA+ILE8YN16LKY+GACDAIxOBLTXl7/N06tEbGQ75JOyrB6HMgEjs0eQsTc9SvcqO6m
	uT4DReFaJmAeWQkzQv71hv4D8+2hX9Qe9Vj/garXroNP96UXXLkUHZ7VX98WCPaYHOYS
	nhmw==
X-Received: by 10.70.128.14 with SMTP id nk14mr9683165pdb.79.1438366611856;
	Fri, 31 Jul 2015 11:16:51 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	bx7sm8870452pdb.82.2015.07.31.11.16.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 31 Jul 2015 11:16:50 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 11:16:46 -0700
Message-Id: <1438366606-23283-2-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1438366606-23283-1-git-send-email-kergoth@gmail.com>
References: <1438366606-23283-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] bb.parse: properly error out on filesystem errors
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
X-List-Received-Date: Fri, 31 Jul 2015 18:16:55 -0000

From: Christopher Larson <chris_larson@mentor.com>

We've had a long-standing bug where a legitimate error reading a file (IOError
or OSError) is always suppressed as though it was a 'file not found' case. As
a concrete example, if you do a `chmod 000 conf/local.conf`, it'll silently
not parse local.conf, rather than erroring to let the user know about the
problem.

Fix this by handling the ENOENT case specifically.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/parse/__init__.py             |  7 ++++---
 lib/bb/parse/parse_py/ConfHandler.py | 21 ++++++++++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 4a78e18..1becaa4 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -26,9 +26,10 @@ File parsers for the BitBake build tools.
 
 handlers = []
 
+import errno
+import logging
 import os
 import stat
-import logging
 import bb
 import bb.utils
 import bb.siggen
@@ -122,12 +123,12 @@ def resolve_file(fn, d):
         for af in attempts:
             mark_dependency(d, af)
         if not newfn:
-            raise IOError("file %s not found in %s" % (fn, bbpath))
+            raise IOError(errno.ENOENT, "file %s not found in %s" % (fn, bbpath))
         fn = newfn
 
     mark_dependency(d, fn)
     if not os.path.isfile(fn):
-        raise IOError("file %s not found" % fn)
+        raise IOError(errno.ENOENT, "file %s not found" % fn)
 
     return fn
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 250a557..fbd75b1 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -24,8 +24,9 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import re, os
-import logging
+import errno
+import re
+import os
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger, handle
 
@@ -92,11 +93,17 @@ def include(parentfn, fn, lineno, data, error_out):
         logger.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
 
     try:
-        ret = bb.parse.handle(fn, data, True)
-    except (IOError, OSError):
-        if error_out:
-            raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), parentfn, lineno)
-        logger.debug(2, "CONF file '%s' not found", fn)
+        bb.parse.handle(fn, data, True)
+    except (IOError, OSError) as exc:
+        if exc.errno == errno.ENOENT:
+            if error_out:
+                raise ParseError("Could not %s file %s" % (error_out, fn), parentfn, lineno)
+            logger.debug(2, "CONF file '%s' not found", fn)
+        else:
+            if error_out:
+                raise ParseError("Could not %s file %s: %s" % (error_out, fn, exc.strerror), parentfn, lineno)
+            else:
+                raise ParseError("Error parsing %s: %s" % (fn, exc.strerror), parentfn, lineno)
 
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
-- 
2.2.1


