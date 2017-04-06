Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 549CC77CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565854"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:03 +1200
Message-Id: <01748f01da49c1a0d7ccdb114c6822b4969ff40d.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/11] bitbake-diffsigs: properly report which signature is missing
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:52 -0000

If just one of the two signatures we want to compare aren't available,
report that one rather than misleadingly claiming both are missing.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index b2ebe91..f84188d 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -75,11 +75,15 @@ def find_compare_task(bbhandler, pn, taskname):
             hashfiles = bb.siggen.find_siginfo(key, None, hashes, bbhandler.config_data)
 
             recout = []
-            if len(hashfiles) == 2:
+            if len(hashfiles) == 0:
+                recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
+            elif not hash1 in hashfiles:
+                recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
+            elif not hash2 in hashfiles:
+                recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
+            else:
                 out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
                 recout.extend(list('  ' + l for l in out2))
-            else:
-                recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
 
             return recout
 
-- 
2.9.3


