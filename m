Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 271066B678
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:20:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0KFK2Ba009478 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:20:02 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WoFop4gcQl6z for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:20:01 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0KFJoK9009455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:19:52 GMT
Message-ID: <1390231184.874.33.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 15:19:44 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Clean up srcrev_internal_helper
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
X-List-Received-Date: Mon, 20 Jan 2014 15:20:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently INVALID and None are checked as incorrect values under different
circumstances. This code standardises those checks to be consistent. We
should phase out the use of "INVALID".

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 9306323..4af089d 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -873,17 +873,24 @@ def srcrev_internal_helper(ud, d, name):
     if 'tag' in ud.parm:
         return ud.parm['tag']
 
-    rev = None
+    srcrev = None
     pn = d.getVar("PN", True)
+    attempts = []
+    if name != '' and pn:
+        attempts.append("SRCREV_%s_pn-%s" % (name, pn))
     if name != '':
-        rev = d.getVar("SRCREV_%s_pn-%s" % (name, pn), True)
-        if not rev:
-            rev = d.getVar("SRCREV_%s" % name, True)
-    if not rev:
-        rev = d.getVar("SRCREV_pn-%s" % pn, True)
-    if not rev:
-        rev = d.getVar("SRCREV", True)
-    if rev == "INVALID":
+        attempts.append("SRCREV_%s" % name)
+    if pn:
+        attempts.append("SRCREV_pn-%s" % pn)
+    attempts.append("SRCREV")
+
+    for a in attempts:
+        srcrev = d.getVar(a, True)              
+        if srcrev and srcrev != "INVALID":
+            break
+
+    rev = srcrev
+    if rev == "INVALID" or not rev:
         var = "SRCREV_pn-%s" % pn
         if name != '':
             var = "SRCREV_%s_pn-%s" % (name, pn)



