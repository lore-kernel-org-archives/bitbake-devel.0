Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 026FC77CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:54 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565858"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:04 +1200
Message-Id: <e33de2d1263b7fa882482e55f3f2187377d42f04.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 04/11] bitbake-diffsigs: drop naive logic for removing duplicate files
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:55 -0000

This logic doesn't work in practice, certainly not with current versions
where sigdata files are preserved in the stamps directory and therefore
there will often be multiple sigdata files - you can now easily get
files for the same signature from sstate and the stamps directory with the
result that bitbake-diffsigs reports nothing has changed. Instead, let's
change the find_siginfo function in OE-Core to simply not return
duplicates so we don't have to filter them out here.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index f84188d..5400e5b 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -37,12 +37,6 @@ logger = bb.msg.logger_create('bitbake-diffsigs')
 def find_compare_task(bbhandler, pn, taskname):
     """ Find the most recent signature files for the specified PN/task and compare them """
 
-    def get_hashval(siginfo):
-        if siginfo.endswith('.siginfo'):
-            return siginfo.rpartition(':')[2].partition('_')[0]
-        else:
-            return siginfo.rpartition('.')[2]
-
     if not hasattr(bb.siggen, 'find_siginfo'):
         logger.error('Metadata does not support finding signature data files')
         sys.exit(1)
@@ -59,16 +53,6 @@ def find_compare_task(bbhandler, pn, taskname):
         logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
         sys.exit(1)
     else:
-        # It's possible that latestfiles contain 3 elements and the first two have the same hash value.
-        # In this case, we delete the second element.
-        # The above case is actually the most common one. Because we may have sigdata file and siginfo
-        # file having the same hash value. Comparing such two files makes no sense.
-        if len(latestfiles) == 3:
-            hash0 = get_hashval(latestfiles[0])
-            hash1 = get_hashval(latestfiles[1])
-            if hash0 == hash1:
-                latestfiles.pop(1)
-
         # Define recursion callback
         def recursecb(key, hash1, hash2):
             hashes = [hash1, hash2]
-- 
2.9.3


