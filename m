Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RR2dm-0003O2-Im for bitbake-devel@lists.openembedded.org;
	Thu, 17 Nov 2011 15:08:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE29Yp017439
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:09 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15957-09 for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAHE20is017433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Nov 2011 14:02:01 GMT
Message-ID: <1321538526.27449.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Nov 2011 14:02:06 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] siggen.py: Fix diffsigs output for filename comparisions
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
X-List-Received-Date: Thu, 17 Nov 2011 14:08:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When comparing sig files, if the recipe locations had changed, the
dependent tasks list would show as changed even if the actual hash
had not changed. This updates the code to only compare the base part
of the pathnames.

It also tweaks some of the output to add newlines to aid comparing
two lists of variables as it makes the location of the difference
clearer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 4ccfc7d..217f29b 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -236,6 +236,16 @@ def compare_sigfiles(a, b):
         removed = sb - sa
         return changed, added, removed
 
+    def clean_basepaths(a):
+        b = {}
+        for x in a:
+            if x.startswith("virtual:"):
+                y = x.rsplit(":", 1)[0] + x.rsplit("/", 1)[1]
+            else:
+                y = x.rsplit("/", 1)[1]
+            b[y] = a[x]
+        return b
+
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
 
@@ -243,7 +253,7 @@ def compare_sigfiles(a, b):
         print "taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist'])
 
     if a_data['taskdeps'] != b_data['taskdeps']:
-        print "Task dependencies changed from %s to %s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
+        print "Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
 
     if a_data['basehash'] != b_data['basehash']:
         print "basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash'])
@@ -266,7 +276,9 @@ def compare_sigfiles(a, b):
             print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        changed, added, removed = dict_diff(a_data['runtaskhashes'], b_data['runtaskhashes'])
+        a = clean_basepaths(a_data['runtaskhashes'])
+        b = clean_basepaths(b_data['runtaskhashes'])
+        changed, added, removed = dict_diff(a, b)
         if added:
             for dep in added:
                 print "Dependency on task %s was added" % (dep)
@@ -275,7 +287,7 @@ def compare_sigfiles(a, b):
                 print "Dependency on task %s was removed" % (dep)
         if changed:
             for dep in changed:
-                print "Hash for dependent task %s changed from %s to %s" % (dep, a_data['runtaskhashes'][dep], b_data['runtaskhashes'][dep])
+                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
     elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
         print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
 




