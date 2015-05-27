Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5550072D64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGblpk025117 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:37:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Sg_qL5VcZYsm for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:37:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGbXWb025075
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:37:44 +0100
Message-ID: <1432744653.404.54.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 May 2015 17:37:33 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data: Make expandKeys deterministic
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
X-List-Received-Date: Wed, 27 May 2015 16:37:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

At least in theory, the order the keys are expanded in can make
a difference, particularly if there is key overlap.

We also want to ensure that any underlying base key is processed
before any overridden version of that variable (FOO before FOO_x)
which helps the update_data removal code I've been testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 439c365..84f5355 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -159,7 +159,7 @@ def expandKeys(alterdata, readdata = None):
 
     # These two for loops are split for performance to maximise the
     # usefulness of the expand cache
-    for key in todolist:
+    for key in sorted(todolist):
         ekey = todolist[key]
         newval = alterdata.getVar(ekey, 0)
         if newval is not None:
-- 
cgit v0.10.2




