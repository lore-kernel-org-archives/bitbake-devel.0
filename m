Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2760F60CEA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Oct 2013 11:24:23 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 Oct 2013 04:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1049,1371106800"; d="scan'208";a="406537297"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2013 04:24:23 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Oct 2013 14:28:55 +0300
Message-Id: <1381145335-13742-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: replace comment added in conf files
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
X-List-Received-Date: Mon, 07 Oct 2013 11:24:24 -0000

The patch that implements removeConfigurationVar method was made before
merging the patch that replaces "added by bitbake" with "added by hob".
This patch corrects this issue.

[YOCTO #5284]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d17716d..ad36b34 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -328,7 +328,7 @@ class BBCooker:
                     begin_line = total.count("\n",0,index)
 
                     #check if the variable was saved before in the same way
-                    if contents[begin_line-1]== "#added by bitbake\n":
+                    if contents[begin_line-1]== "#added by hob\n":
                         contents[begin_line-1] = contents[begin_line] = "\n"
                     else:
                         contents[begin_line] = "\n"
-- 
1.7.9.5


