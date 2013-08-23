Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
	by mail.openembedded.org (Postfix) with ESMTP id CB33D6B66A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 16:47:53 +0000 (UTC)
Received: by mail-ee0-f41.google.com with SMTP id d17so403776eek.28
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=LyJf1sHVJXSyylIocH7BvibrdlWFxWYtSQ6H3C2/X1c=;
	b=UARnRORSTkEpeNzaw8ggRsZS//mwc3UI6h6rEjK9T/xzf0kw3Zv5yu51awWZxTMviN
	ToeTJL7b30hGCo8WvHzdVw/jcmPry2GjgLCG7TFopve1t5B2Jb47xkLK7ouBuUprKTTs
	c2lSIzf+W4Sk5HVTrm6EJ/VYKiTf65oDhxstdEyXfGpXw+Gkb2wMMK9gnisJN0CZoyxd
	5jo6U1ub6Y7cEx8bTTD5xvTzQT8kSrciZfnMAVG+0Mo4BI47t9NixLNGkR3GcWIbjzHr
	80b+8zBEuB77Mro6D2vYV6l+hwBKTmJsBp/kYjf4+NZPo4e1sLy6jUJvBjhBf/CdK1Rl
	O/GA==
X-Received: by 10.15.52.2 with SMTP id o2mr72125eew.83.1377276473877;
	Fri, 23 Aug 2013 09:47:53 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id f49sm826954eec.7.1969.12.31.16.00.00
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 23 Aug 2013 09:47:53 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Aug 2013 18:48:58 +0200
Message-Id: <1377276538-20486-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [RFC][PATCH] parse: Return IOError when including file with absolute path
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
X-List-Received-Date: Fri, 23 Aug 2013 16:47:54 -0000

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

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/parse/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

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
 
-- 
1.8.3.2


