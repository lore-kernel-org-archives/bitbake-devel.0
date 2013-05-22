Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 182F060984
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 14:25:29 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 22 May 2013 07:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,721,1363158000"; d="scan'208";a="338233557"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.181])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 07:25:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 15:25:11 +0100
Message-Id: <4eb7cd0f7d9c3cc7d8db602fd68e2ddba59d8b9f.1369232029.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369232029.git.paul.eggleton@linux.intel.com>
References: <cover.1369232029.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake-layers: fix for move of calc_bbfile_priority within cooker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 14:25:29 -0000

calc_bbfile_priority is now in CookerCollectFiles which can be accessed
on the collection attribute of a cooker instance.

Fixes [YOCTO #4513].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 0c4ac2d..86a17a5 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -233,7 +233,7 @@ Options:
         # We are largely guessing about PN, PV and the preferred version here,
         # but we have no choice since skipped recipes are not fully parsed
         skiplist = self.bbhandler.cooker.skiplist.keys()
-        skiplist.sort( key=lambda fileitem: self.bbhandler.cooker.calc_bbfile_priority(fileitem) )
+        skiplist.sort( key=lambda fileitem: self.bbhandler.cooker.collection.calc_bbfile_priority(fileitem) )
         skiplist.reverse()
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
-- 
1.8.1.2


