Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 66C0C65C78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 10:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QAfHkc030389 for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 11:41:17 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wVw4h3FodXFV for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 11:41:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QAf2aq030368
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 11:41:14 +0100
Message-ID: <1432636862.404.1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 26 May 2015 11:41:02 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data: Clean up expandKeys None value handling
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
X-List-Received-Date: Tue, 26 May 2015 10:41:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This comparison is interesting even in the case of empty vales. Enabling
this warning actually found a bug in the metadata in avahi. Make the
code handle None specifically and also remove the dead code path in the
second if statement.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 0d9da4c..e7557aa 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -157,9 +157,9 @@ def expandKeys(alterdata, readdata = None):
             continue
         todolist[key] = ekey
         newval = alterdata.getVar(ekey, 0)
-        if newval:
+        if newval is not None:
             val = alterdata.getVar(key, 0)
-            if val is not None and newval is not None:
+            if val is not None:
                 bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
 
     # These two for loops are split for performance to maximise the



