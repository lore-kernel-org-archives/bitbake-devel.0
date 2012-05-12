Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1ST1BV-0004pa-0J
	for bitbake-devel@lists.openembedded.org;
	Sat, 12 May 2012 03:31:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 May 2012 18:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152021995"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.13.40])
	by fmsmga001.fm.intel.com with ESMTP; 11 May 2012 18:21:52 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 May 2012 18:21:51 -0700
Message-Id: <1336785711-13353-1-git-send-email-josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 2/2] lib/bb/siggen.py: ensure dumped signatures have group R/W
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
X-List-Received-Date: Sat, 12 May 2012 01:31:49 -0000

We anticipate signatures being shared amongst peers in a group so ensure
they have rw-rw-r-- permissions to facilitate this.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/siggen.py |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ca26919..5a0b80e 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -201,8 +201,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]
 
-        p = pickle.Pickler(open(sigfile, "wb"), -1)
-        p.dump(data)
+        with open(sigfile, "wb") as f:
+            p = pickle.Pickler(f, -1)
+            p.dump(data)
+        os.chmod(sigfile, 0664)
 
     def dump_sigs(self, dataCache):
         for fn in self.taskdeps:
-- 
1.7.7.6



