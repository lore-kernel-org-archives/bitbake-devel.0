Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 926A877CFF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:45 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565830"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:01 +1200
Message-Id: <1a871d9ca16e87a8827d67f900900677ea6ff69c.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 01/11] bitbake-diffsigs: fix -t picking wrong files to compare
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:45 -0000

We weren't picking the right files to compare here - according to the
order in which the list is sorted (by mtime), we need to be taking the
last two items and not the first two.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 1e3de09..b2ebe91 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -84,9 +84,9 @@ def find_compare_task(bbhandler, pn, taskname):
             return recout
 
         # Recurse into signature comparison
-        logger.debug("Signature file (previous): %s" % latestfiles[0])
-        logger.debug("Signature file (latest): %s" % latestfiles[1])
-        output = bb.siggen.compare_sigfiles(latestfiles[0], latestfiles[1], recursecb)
+        logger.debug("Signature file (previous): %s" % latestfiles[-2])
+        logger.debug("Signature file (latest): %s" % latestfiles[-1])
+        output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb)
         if output:
             print('\n'.join(output))
     sys.exit(0)
-- 
2.9.3


