Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTH3A-0002GF-5M
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 18:56:00 +0100
Received: by opal (Postfix, from userid 111)
	id DE30F1032F; Wed, 23 Nov 2011 17:51:48 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111123175148.DE30F1032F@opal>
Date: Wed, 23 Nov 2011 17:51:48 +0000 (UTC)
From: git@git.openembedded.org
Subject: Matthew McClintock : bitbake: print out symmetric difference when comparing sigs
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
X-List-Received-Date: Wed, 23 Nov 2011 17:56:00 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: f1eb6d3dcc10c42bb09383a87bde3afa69bc6ed9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=f1eb6d3dcc10c42bb09383a87bde3afa69bc6ed9

Author: Matthew McClintock <msm@freescale.com>
Date:   Wed Nov 23 02:08:50 2011 -0600

bitbake: print out symmetric difference when comparing sigs

This is useful for really longs lists to pinpoint what has
actually changed

Signed-off-by: Matthew McClintock <msm@freescale.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 217f29b..3eed664 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -248,9 +248,11 @@ def compare_sigfiles(a, b):
 
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
+        print "changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist'])
 
     if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
         print "taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist'])
+        print "changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist'])
 
     if a_data['taskdeps'] != b_data['taskdeps']:
         print "Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
@@ -262,6 +264,7 @@ def compare_sigfiles(a, b):
     if changed:
         for dep in changed:
             print "List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep])
+            print "changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep])
     if added:
         for dep in added:
             print "Dependency on variable %s was added" % (dep)
@@ -290,6 +293,7 @@ def compare_sigfiles(a, b):
                 print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
     elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
         print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
+        print "changed items: %s" % a_data['runtaskdeps'].symmetric_difference(b_data['runtaskdeps'])
 
 def dump_sigfile(a):
     p1 = pickle.Unpickler(file(a, "rb"))



