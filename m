Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 0313F6D4EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 00:36:33 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id hz1so3269873pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Oct 2013 17:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Hwk67pC/rpYmenulcY6s9IDVjN6GKO0F8Vt0Oy9GYVs=;
	b=PzOhqI3PAA+QZqa1AxnoglwQU89+0RFLZdGHcik2Mwu3jPZcV3o99pdaRTLTz2/4ZF
	ol1YMwXBcziPt6p75dgpEchYx23SMknS5RGjwAFv4GvSpd9Un48ohrkibkMzzOOIEQoA
	ifYdIRZaxn3cGReWmL+s6rtC/qXYnJKZHrPE+WLFY2gmkB2enliu6bP1V2aO/dNc5+6o
	grLWGQbMD7ACNynScKjZiJ52aCTO99zGqMN3fHw6BryL7tV/1n4HEMLx9FzSk2kHVfDp
	EBDJD+uU7FrQENwfnlRQJM5q+Y0ROuZHpDFHUyXVRxL4w65nq0Zb9ZUWyqOEDpIH0NsM
	4yzw==
X-Gm-Message-State: ALoCoQmyOIUyvjJjS6+iIldu7dM3YrdUd5vm3Glc581Mu1Z7J3eTzlAc9Oht1FgkmAbZe9MTEwmX
X-Received: by 10.68.58.137 with SMTP id r9mr416412pbq.148.1383266195783;
	Thu, 31 Oct 2013 17:36:35 -0700 (PDT)
Received: from localhost.localdomain ([63.239.94.10])
	by mx.google.com with ESMTPSA id i6sm6927404pbc.1.2013.10.31.17.36.34
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 31 Oct 2013 17:36:35 -0700 (PDT)
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Oct 2013 17:36:25 -0700
Message-Id: <1383266185-2917-1-git-send-email-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 1.8.4.2
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH RFC] fetch2/svn.py: use log instead of info to retrieve revision
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
X-List-Received-Date: Fri, 01 Nov 2013 00:36:34 -0000

We have faced a corner case situation where the 'last changed
revision' returned from svn info is wrong. It happens when the last
revision is a directory move. e.g. if we assume that the svn
repository at revA has root/x/y/z/foo/bar and it is moved to
root/a/b/c/foo/bar in revB, then svn info 'last change revision' will
return revA. As such when using AUTOREV, we are going to attempt to
retrieve root/a/b/c/foo/bar (as per SRC_URI) but at revA when it did
not exist.

So this patch changes how we retrieve the latest revision and uses
'svn log --limit 1' which gives correct result in all tested cases.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 lib/bb/fetch2/svn.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 9a779d2..123aa13 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -27,6 +27,7 @@ import os
 import sys
 import logging
 import bb
+import re
 from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
@@ -91,6 +92,8 @@ class Svn(FetchMethod):
 
         if command == "info":
             svncmd = "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
+        elif command == "log1":
+            svncmd = "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
             if ud.revision:
@@ -167,14 +170,13 @@ class Svn(FetchMethod):
         """
         Return the latest upstream revision number
         """
-        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "info"))
+        bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"))
 
-        output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "info"), d, True)
+        output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "log1"), d, True)
 
-        revision = None
-        for line in output.splitlines():
-            if "Last Changed Rev" in line:
-                revision = line.split(":")[1].strip()
+        # skip the first line, as per output of svn log
+        # then we expect the revision on the 2nd line
+        revision = re.search('^r([0-9]*)', output.splitlines()[1]).group(1)
 
         return revision
 
-- 
1.8.4.2


