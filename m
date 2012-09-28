Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1THeTS-0005Vg-Ul
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 19:35:39 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8SHMYV0004353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 10:22:34 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Fri, 28 Sep 2012 10:22:33 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Sep 2012 12:27:50 -0500
Message-ID: <1348853270-29676-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1348853270-29676-1-git-send-email-mark.hatle@windriver.com>
References: <1348853270-29676-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 2/2] utils.py: explode_dep_version - add ability to deal with whitespace
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
X-List-Received-Date: Fri, 28 Sep 2012 17:35:39 -0000
Content-Type: text/plain

Add the ability to deal with arbitrary whitespace.  Support the comparison
operators of: <, >, =, <=, >=, =<, =>, <<, >>, ==, and !=.

This list was generated based on behavior of deb, opkg and rpm.

Note, In OE the last six are not expected to be supported, but someone
may try to use them.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/utils.py |   56 +++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index fa5d2ab..3a18a39 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -148,24 +148,52 @@ def explode_dep_versions(s):
     l = s.replace(",", "").split()
     lastdep = None
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
-            r[lastdep] = lastver
-        elif not inversion:
-            if i in r:
-                raise ValueError("Error, item %s appeared in dependency string '%s' multiple times.  explode_dep_versions cannot cope with this." % (i, s))
-            r[i] = None
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
+                lastver = i[0:2]
+                i = i[2:]
+            elif i.startswith(('<', '>', '=')):
+                lastver = i[0:1]
+                i = i[1:]
+            else:
+                # This is an unsupported case!
+                lastver = (i or "")
+                i = ""
+            i.strip()
+            if not i:
+                continue
+
+        if inversion:
+            if i.endswith(')'):
+                i = i[:-1] or ""
+                inversion = False
+            if i:
+                lastver = lastver + " " + (i or "")
+                r[lastdep] = lastver
+            continue
+
+        #if not inversion:
+        if i in r:
+            raise ValueError("Error, item %s appeared in dependency string '%s' multiple times.  explode_dep_versions cannot cope with this." % (i, s))
+        r[i] = None
+        lastdep = i
+        lastver = ""
 
     return r
 
-- 
1.7.3.4



