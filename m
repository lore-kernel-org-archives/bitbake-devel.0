Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TIqEx-0001m1-RY for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 02:21:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9208Zha009648
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Oct 2012 01:08:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08523-02 for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2012 01:08:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9208Htj009638
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Oct 2012 01:08:18 +0100
Message-ID: <1349136500.15753.122.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Oct 2012 01:08:20 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] utils: Add explode_dep_versions2 to replace explode_dep_versions
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
X-List-Received-Date: Tue, 02 Oct 2012 00:21:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The API for explode_dep_versions is flawed since there can only be one version 
constraint against any given dependency. This adds a new function with an API
without this limitation. explode_dep_versions() is maintained with a warning
printed when its used in a situation where information is lost.

This should allow a simple transition to the new API to fix the lost dependency
information.

join_deps() is updated to deal with data in either format.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index a537338..cef0fdd 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -138,7 +138,7 @@ def explode_deps(s):
             #r[-1] += ' ' + ' '.join(j)
     return r
 
-def explode_dep_versions(s):
+def explode_dep_versions2(s):
     """
     Take an RDEPENDS style string of format:
     "DEPEND1 (optional version) DEPEND2 (optional version) ..."
@@ -188,9 +188,9 @@ def explode_dep_versions(s):
                     lastver += " "
             if i:
                 lastver += i
-                if lastdep in r and r[lastdep] and r[lastdep] != lastver:
-                    raise ValueError("Error, item %s appeared in dependency string '%s' multiple times with different values.  explode_dep_versions cannot cope with this." % (lastdep, s))
-                r[lastdep] = lastcmp + " " + lastver
+                if lastdep not in r:
+                    r[lastdep] = []
+                r[lastdep].append(lastcmp + " " + lastver)
             continue
 
         #if not inversion:
@@ -198,8 +198,19 @@ def explode_dep_versions(s):
         lastver = ""
         lastcmp = ""
         if not (i in r and r[i]):
-            r[lastdep] = None
+            r[lastdep] = []
+
+    return r
 
+def explode_dep_versions(s):
+    r = explode_dep_versions2(s)
+    for d in r:
+        if not r[d]:
+            r[d] = None
+            continue
+        if len(r[d]) > 1:
+            bb.warn("explode_dep_versions(): Item %s appeared in dependency string '%s' multiple times with different values.  explode_dep_versions cannot cope with this." % (d, s))
+        r[d] = r[d][0]
     return r
 
 def join_deps(deps, commasep=True):
@@ -209,7 +220,11 @@ def join_deps(deps, commasep=True):
     result = []
     for dep in deps:
         if deps[dep]:
-            result.append(dep + " (" + deps[dep] + ")")
+            if isinstance(deps[dep], list):
+                for v in deps[dep]:
+                    result.append(dep + " (" + v + ")")
+            else:
+                result.append(dep + " (" + deps[dep] + ")")
         else:
             result.append(dep)
     if commasep:




