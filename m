Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5A2D370331
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 15:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QFH1O7011559 for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:17:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oGkjTdQbwwtF for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:17:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QFGjue011551
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:16:56 +0100
Message-ID: <1432653405.404.11.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 26 May 2015 16:16:45 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data: Revert expandKeys warning move
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
X-List-Received-Date: Tue, 26 May 2015 15:17:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This was incorrect, it *must* be done next to the rename as a previous
may overlap with the current one and we need to detect this case.

I'll add a test case to better catch this problem in future.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index e7557aa..456052b 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -156,17 +156,17 @@ def expandKeys(alterdata, readdata = None):
         if key == ekey:
             continue
         todolist[key] = ekey
-        newval = alterdata.getVar(ekey, 0)
-        if newval is not None:
-            val = alterdata.getVar(key, 0)
-            if val is not None:
-                bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
 
     # These two for loops are split for performance to maximise the
     # usefulness of the expand cache
 
     for key in sorted(todolist):
         ekey = todolist[key]
+        newval = alterdata.getVar(ekey, 0)
+        if newval is not None:
+            val = alterdata.getVar(key, 0)
+            if val is not None:
+                bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
         alterdata.renameVar(key, ekey)
 
 def inheritFromOS(d, savedenv, permitted):



