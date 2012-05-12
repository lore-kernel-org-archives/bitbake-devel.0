Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1ST0pM-000341-UX
	for bitbake-devel@lists.openembedded.org;
	Sat, 12 May 2012 03:08:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 May 2012 17:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152017243"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.13.40])
	by fmsmga001.fm.intel.com with ESMTP; 11 May 2012 17:58:59 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 May 2012 17:58:57 -0700
Message-Id: <1336784337-22053-1-git-send-email-josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
MIME-Version: 1.0
Subject: [PATCH] lib/bb/siggen: use open() rather than the file constructor
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
X-List-Received-Date: Sat, 12 May 2012 01:08:57 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Python documentation states:
 "When opening a file, it’s preferable to use open() instead of invoking
the file constructor directly." [1]

Further in Python 3 direct use of the file constructor is no longer
possible.

1. http://docs.python.org/library/functions.html#open

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/siggen.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8c79b17..ca26919 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -201,7 +201,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]
 
-        p = pickle.Pickler(file(sigfile, "wb"), -1)
+        p = pickle.Pickler(open(sigfile, "wb"), -1)
         p.dump(data)
 
     def dump_sigs(self, dataCache):
@@ -250,9 +250,9 @@ def clean_basepaths(a):
     return b
 
 def compare_sigfiles(a, b):
-    p1 = pickle.Unpickler(file(a, "rb"))
+    p1 = pickle.Unpickler(open(a, "rb"))
     a_data = p1.load()
-    p2 = pickle.Unpickler(file(b, "rb"))
+    p2 = pickle.Unpickler(open(b, "rb"))
     b_data = p2.load()
 
     def dict_diff(a, b, whitelist=set()):
@@ -331,7 +331,7 @@ def compare_sigfiles(a, b):
                 print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
 
 def dump_sigfile(a):
-    p1 = pickle.Unpickler(file(a, "rb"))
+    p1 = pickle.Unpickler(open(a, "rb"))
     a_data = p1.load()
 
     print "basewhitelist: %s" % (a_data['basewhitelist'])
-- 
1.7.7.6



