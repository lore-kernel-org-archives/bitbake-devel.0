Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T66Mo-0000sM-BJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 22:57:02 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 Aug 2012 13:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,322,1344236400"; d="scan'208";a="191985304"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.136])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2012 13:44:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2012 21:44:32 +0100
Message-Id: <a3aa543c41d2b97fe37fa3469448481387b01502.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/5] lib/bb/siggen: replace tabs with spaces
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
X-List-Received-Date: Mon, 27 Aug 2012 20:57:02 -0000

We had one section of the code mixing tabs with spaces, which is
particularly undesirable with python code.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/siggen.py |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 02a4268..b04a8bc 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -185,8 +185,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if task in dataCache.file_checksums[fn]:
             checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
-               self.file_checksum_values[k][f] = cs
-               data = data + cs
+                self.file_checksum_values[k][f] = cs
+                data = data + cs
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
@@ -372,24 +372,24 @@ def compare_sigfiles(a, b):
         changed, added, removed = dict_diff(a, b)
         if added:
             for dep in added:
-	        bdep_found = False
-	        if removed:
-		    for bdep in removed:
-		    	if a[dep] == b[bdep]:
-			   #print "Dependency on task %s was replaced by %s with same hash" % (dep, bdep)
-			   bdep_found = True
-		if not bdep_found:
+                bdep_found = False
+                if removed:
+                    for bdep in removed:
+                        if a[dep] == b[bdep]:
+                            #print "Dependency on task %s was replaced by %s with same hash" % (dep, bdep)
+                            bdep_found = True
+                if not bdep_found:
                     print "Dependency on task %s was added with hash %s" % (dep, a[dep])
         if removed:
             for dep in removed:
-	        adep_found = False
-	        if added:
-		    for adep in added:
-		    	if a[adep] == b[dep]:
-			   #print "Dependency on task %s was replaced by %s with same hash" % (adep, dep)
-			   adep_found = True
-		if not adep_found:
-                   print "Dependency on task %s was removed with hash %s" % (dep, b[dep])
+                adep_found = False
+                if added:
+                    for adep in added:
+                        if a[adep] == b[dep]:
+                            #print "Dependency on task %s was replaced by %s with same hash" % (adep, dep)
+                            adep_found = True
+                if not adep_found:
+                    print "Dependency on task %s was removed with hash %s" % (dep, b[dep])
         if changed:
             for dep in changed:
                 print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
-- 
1.7.9.5



