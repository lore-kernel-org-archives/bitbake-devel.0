Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 080A475637
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 07:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4P7pnHr008880 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:51:49 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UeP2Jnj4cCTn for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:51:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4P7pbHp008874
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 May 2015 08:51:48 +0100
Message-ID: <1432540297.29515.10.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 May 2015 08:51:37 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Don't crash if number of task dependencies change
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
X-List-Received-Date: Mon, 25 May 2015 07:51:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the number of task dependencies change you currently get
a traceback when using diffsigs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 2de3aff..2985272 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -419,12 +419,16 @@ def compare_sigfiles(a, b, recursecb = None):
         for f in removed:
             output.append("Dependency on checksum of file %s was removed" % (f))
 
-    changed = []
-    for idx, task in enumerate(a_data['runtaskdeps']):
-        a = a_data['runtaskdeps'][idx]
-        b = b_data['runtaskdeps'][idx]
-        if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
-            changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
+
+    if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
+        changed = ["Number of task dependencies changed"]
+    else:
+        changed = []
+        for idx, task in enumerate(a_data['runtaskdeps']):
+            a = a_data['runtaskdeps'][idx]
+            b = b_data['runtaskdeps'][idx]
+            if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
+                changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
 
     if changed:
         output.append("runtaskdeps changed from %s to %s" % (clean_basepaths_list(a_data['runtaskdeps']), clean_basepaths_list(b_data['runtaskdeps'])))



