Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5F59E60B60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 12:07:32 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBKC7IRT005425 for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 12:07:27 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SztCQU0R_bxN for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 12:07:27 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBKC7OjB005435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 12:07:26 GMT
Message-ID: <1387541240.6402.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 20 Dec 2013 12:07:20 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Fix reversed difference output
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
X-List-Received-Date: Fri, 20 Dec 2013 12:07:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The output when comparing siginfo files for dict_diff is reversed and shows
additions when things were removed and vice versa. This patch reverses the operation
so the changes are shown correctly and makes the output less confusing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index b33db84..16b3548 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -319,8 +319,8 @@ def compare_sigfiles(a, b, recursecb = None):
         for i in common:
             if a[i] != b[i] and i not in whitelist:
                 changed.add(i)
-        added = sa - sb
-        removed = sb - sa
+        added = sb - sa
+        removed = sa - sb
         return changed, added, removed
 
     def file_checksums_diff(a, b):
@@ -412,21 +412,21 @@ def compare_sigfiles(a, b, recursecb = None):
                 bdep_found = False
                 if removed:
                     for bdep in removed:
-                        if a[dep] == b[bdep]:
+                        if b[dep] == a[bdep]:
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
                             bdep_found = True
                 if not bdep_found:
-                    output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), a[dep]))
+                    output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), b[dep]))
         if removed:
             for dep in removed:
                 adep_found = False
                 if added:
                     for adep in added:
-                        if a[adep] == b[dep]:
+                        if b[adep] == a[dep]:
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
                             adep_found = True
                 if not adep_found:
-                    output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), b[dep]))
+                    output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), a[dep]))
         if changed:
             for dep in changed:
                 output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))



