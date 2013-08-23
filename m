Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f182.google.com (mail-ea0-f182.google.com
	[209.85.215.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5619F6B66A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 17:05:20 +0000 (UTC)
Received: by mail-ea0-f182.google.com with SMTP id o10so416121eaj.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iLVzX4qzAl3+e3Wm0g1qSF1z4/eLxb7iSGeVFRnc6jI=;
	b=nFZDDoYHySY+KHgAzDuRcq77y/AS3Ym5WdgEeetMvQtNDAMjqNOIbgipy+2RqmOaYQ
	jTxMGvtvdkSAunBKHChcNBmFbw4zqUlKDzpoahtVRKSrKhloSixne8vrgCLKEgfO+ipI
	An9TMEwpB7Qms9NxlNznqNzYcv28sbYr9E5cvlNzZoKWIMNRxOoGJ0i1IOUBxJ2VS3VU
	B3qEiGMuGLWjHl7ISF6zSSpOeOeZaHSmESOP8PnueXNCCbd+q4ve3UQB7o1o4niDCHZU
	UCNwADuSD2IA1YzVfjQZnZ+YW3kcRKPEA9ZgPIlBOvL1vY7qAHquVPmiClD+sVdPqJTI
	82aw==
X-Received: by 10.14.224.198 with SMTP id x46mr889124eep.53.1377277520356;
	Fri, 23 Aug 2013 10:05:20 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id a6sm899192eei.10.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 23 Aug 2013 10:05:19 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Aug 2013 19:06:26 +0200
Message-Id: <1377277586-23813-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1377276538-20486-1-git-send-email-Martin.Jansa@gmail.com>
References: <1377276538-20486-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCH] parse: Return IOError when including file with absolute path
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
X-List-Received-Date: Fri, 23 Aug 2013 17:05:20 -0000

* resolve_file was behaving different when relative and absolute
  paths were passed to it

* include relative-path/non-existent-file.inc
  works correctly resolve_file throws IOError, BBHandler.py:handle()
  doesn't catch it, ConfHandler.py:include() catches IOError and shows:
  DEBUG: CONF file 'relative-path/non-existent-file.inc' not found
* include /absolute-path/non-existent-file.inc
  was failing, because resolve_file just returns fn,
  BBHandler.py:handle() calls bb.parse.mark_dependency(d, abs_fn)
  which throws:
  OSError: [Errno 2] No such file or directory: '/absolute-path/non-existent-file.inc'
  and parsing fails.
  Ad isfile() test for absolute fn and throw IOError to make
  resolve_file behavior consistent for both paths.

* I know we had some issues with -b relative-path-to-recipe.bb and
  absolute path, so consider this patch only as RFC and documentation of
  this problem

* Catch OSError too in ConfHandler.py:include() e.g. in case the file exists, but user
  cannot read it or something like that.

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/parse/__init__.py             | 3 +++
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 3f93ad2..c973f6f 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -107,6 +107,9 @@ def resolve_file(fn, d):
             raise IOError("file %s not found in %s" % (fn, bbpath))
         fn = newfn
 
+    if not os.path.isfile(fn):
+        raise IOError("file %s not found" % fn)
+
     logger.debug(2, "LOAD %s", fn)
     return fn
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 7d4a5b1..7b30c8a 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -89,7 +89,7 @@ def include(oldfn, fn, lineno, data, error_out):
     from bb.parse import handle
     try:
         ret = handle(fn, data, True)
-    except IOError:
+    except (IOError, OSError):
         if error_out:
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
-- 
1.8.3.2


