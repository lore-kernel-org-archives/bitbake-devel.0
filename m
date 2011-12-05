Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RXbL9-0006R8-Bs
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 17:24:28 +0100
Received: by opal (Postfix, from userid 111)
	id 203361032F; Mon,  5 Dec 2011 16:21:24 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111205162124.203361032F@opal>
Date: Mon,  5 Dec 2011 16:21:24 +0000 (UTC)
From: git@git.openembedded.org
Subject: Matthew McClintock : siggen.py: If both sigs have a variable in it' s whitelist then don't say it's changed
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
X-List-Received-Date: Mon, 05 Dec 2011 16:24:28 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 71b53a3f0766ca464560a1f6a449f9424fbdf7ae
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=71b53a3f0766ca464560a1f6a449f9424fbdf7ae

Author: Matthew McClintock <msm@freescale.com>
Date:   Wed Nov 30 11:24:55 2011 -0600

siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed

Some BB_HASHBASE_WHITELIST variables are in the lists of variable
dependencies for signatures. Ignore those differences in lists
since this difference does not matter

Signed-off-by: Matthew McClintock <msm@freescale.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8d768ce..22417b9 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -236,13 +236,13 @@ def compare_sigfiles(a, b):
     p2 = pickle.Unpickler(file(b, "rb"))
     b_data = p2.load()
 
-    def dict_diff(a, b):
+    def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
         sb = set(b.keys())
         common = sa & sb
         changed = set()
         for i in common:
-            if a[i] != b[i]:
+            if a[i] != b[i] and i not in whitelist:
                 changed.add(i)
         added = sa - sb
         removed = sb - sa
@@ -262,7 +262,7 @@ def compare_sigfiles(a, b):
     if a_data['basehash'] != b_data['basehash']:
         print "basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash'])
 
-    changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'])
+    changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
         for dep in changed:
             print "List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep])



