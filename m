Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TI75y-0001dX-Lb
	for bitbake-devel@lists.openembedded.org;
	Sun, 30 Sep 2012 02:09:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8TNuJ2D025896
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Sep 2012 16:56:19 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Sat, 29 Sep 2012 16:56:18 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 29 Sep 2012 19:01:45 -0500
Message-ID: <1348963305-26122-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1348963305-26122-1-git-send-email-mark.hatle@windriver.com>
References: <1348963305-26122-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 2/2 v2] utils.py: Allow explode_dep_versions comparisons to have arbitrary whitespace
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 30 Sep 2012 00:09:19 -0000
Content-Type: text/plain

Refactor the explode_dep_versions to be more lenient on whitespace values.

The required format is:
   foo (= 1.10)
   foo (=1.10)
   foo ( = 1.10)
   foo ( =1.10)
   foo ( = 1.10 )
   foo ( =1.10 )

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/utils.py |   62 +++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d032ab2..a537338 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -147,26 +147,58 @@ def explode_dep_versions(s):
     r = {}
     l = s.replace(",", "").split()
     lastdep = None
+    lastcmp = ""
     lastver = ""
+    incmp = False
     inversion = False
     for i in l:
         if i[0] == '(':
+            incmp = True
+            i = i[1:].strip()
+            if not i:
+                continue
+
+        if incmp:
+            incmp = False
             inversion = True
-            lastver = i[1:] or ""
-            #j = []
-        elif inversion and i.endswith(')'):
-            inversion = False
-            lastver = lastver + " " + (i[:-1] or "")
-            if lastdep in r and r[lastdep] and r[lastdep] != lastver:
-                raise ValueError("Error, item %s appeared in dependency string '%s' multiple times with different values.  explode_dep_versions cannot cope with this." % (lastdep, s))
-            r[lastdep] = lastver
-        elif not inversion:
-            if not (i in r and r[i]):
-                r[i] = None
-            lastdep = i
-            lastver = ""
-        elif inversion:
-            lastver = lastver + " " + i
+            # This list is based on behavior and supported comparisons from deb, opkg and rpm.
+            #
+            # Even though =<, <<, ==, !=, =>, and >> may not be supported, 
+            # we list each possibly valid item. 
+            # The build system is responsible for validation of what it supports.
+            if i.startswith(('<=', '=<', '<<', '==', '!=', '>=', '=>', '>>')):
+                lastcmp = i[0:2]
+                i = i[2:]
+            elif i.startswith(('<', '>', '=')):
+                lastcmp = i[0:1]
+                i = i[1:]
+            else:
+                # This is an unsupported case!
+                lastcmp = (i or "")
+                i = ""
+            i.strip()
+            if not i:
+                continue
+
+        if inversion:
+            if i.endswith(')'):
+                i = i[:-1] or ""
+                inversion = False
+                if lastver and i:
+                    lastver += " "
+            if i:
+                lastver += i
+                if lastdep in r and r[lastdep] and r[lastdep] != lastver:
+                    raise ValueError("Error, item %s appeared in dependency string '%s' multiple times with different values.  explode_dep_versions cannot cope with this." % (lastdep, s))
+                r[lastdep] = lastcmp + " " + lastver
+            continue
+
+        #if not inversion:
+        lastdep = i
+        lastver = ""
+        lastcmp = ""
+        if not (i in r and r[i]):
+            r[lastdep] = None
 
     return r
 
-- 
1.7.3.4



