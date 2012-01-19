Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RnxvE-0000sC-Lf for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 20:45:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0JJbebb010197
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2012 19:37:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09956-02 for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2012 19:37:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0JJbTxc010186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2012 19:37:30 GMT
Message-ID: <1327001849.23015.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Jan 2012 19:37:29 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] siggen: Ensure correct runtask dependency output is shown for diffsigs
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
X-List-Received-Date: Thu, 19 Jan 2012 19:45:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The actual task names are discounted for comparison of dependent tasks, only
the actual hashes are used. This updates the comparison code to account for
this change, attempting heuristic matching for more user friendly output but
falling back to showing the changed hashes directly. This avoids some confusing
output to users where it looked like tasks had changed when they had not and
actually had the same hash but a different taskname.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 22417b9..d9d0294 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -281,21 +281,27 @@ def compare_sigfiles(a, b):
             print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a = clean_basepaths(a_data['runtaskhashes'])
-        b = clean_basepaths(b_data['runtaskhashes'])
-        changed, added, removed = dict_diff(a, b)
-        if added:
-            for dep in added:
-                print "Dependency on task %s was added" % (dep)
-        if removed:
-            for dep in removed:
-                print "Dependency on task %s was removed" % (dep)
-        if changed:
-            for dep in changed:
-                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
-    elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
-        print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
-        print "changed items: %s" % a_data['runtaskdeps'].symmetric_difference(b_data['runtaskdeps'])
+        if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
+            a = clean_basepaths(a_data['runtaskhashes'])
+            b = clean_basepaths(b_data['runtaskhashes'])
+            changed, added, removed = dict_diff(a, b)
+            if added:
+                for dep in added:
+                    print "Dependency on task %s was added" % (dep)
+            if removed:
+                for dep in removed:
+                    print "Dependency on task %s was removed" % (dep)
+            if changed:
+                for dep in changed:
+                    print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
+        else:
+            for i in range(len(a_data['runtaskdeps'])):
+                aent = a_data['runtaskdeps'][i]
+                bent = b_data['runtaskdeps'][i]
+                aname = clean_basepath(aent)
+                bname = clean_basepath(bent)
+                if a_data['runtaskhashes'][aent] != b_data['runtaskhashes'][bent]:
+                    print "Task dependency hash changed from %s to %s (for %s and %s)" % (a_data['runtaskhashes'][aent], b_data['runtaskhashes'][bent], aname, bname)
 
 def dump_sigfile(a):
     p1 = pickle.Unpickler(file(a, "rb"))




